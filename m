Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A294214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 11:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeLZLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 06:52:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:53229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbeLZLwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 06:52:08 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09BD4196F8B7B;
        Wed, 26 Dec 2018 19:52:02 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Wed, 26 Dec 2018 19:51:54 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>
CC:     <f.fainelli@gmail.com>, <keescook@chromium.org>,
        <wang6495@umn.edu>, <jakub.kicinski@netronome.com>,
        <ilyal@mellanox.com>, <ecree@solarflare.com>, <mkubecek@suse.cz>,
        <ynorov@caviumnetworks.com>, <stephen@networkplumber.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH net] ethtool: check the return value of get_regs_len
Date:   Wed, 26 Dec 2018 19:51:46 +0800
Message-ID: <1545825106-103343-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return type for get_regs_len in struct ethtool_ops is int,
the hns3 driver may return error when failing to get the regs
len by sending cmd to firmware.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
Note: There is not Fixes tags for this becuase the ops is added
before the git is used.
---
 net/core/ethtool.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/core/ethtool.c b/net/core/ethtool.c
index d054028..158264f 100644
--- a/net/core/ethtool.c
+++ b/net/core/ethtool.c
@@ -793,8 +793,13 @@ static noinline_for_stack int ethtool_get_drvinfo(struct net_device *dev,
 		if (rc >= 0)
 			info.n_priv_flags = rc;
 	}
-	if (ops->get_regs_len)
-		info.regdump_len = ops->get_regs_len(dev);
+	if (ops->get_regs_len) {
+		int ret = ops->get_regs_len(dev);
+
+		if (ret > 0)
+			info.regdump_len = ret;
+	}
+
 	if (ops->get_eeprom_len)
 		info.eedump_len = ops->get_eeprom_len(dev);
 
@@ -1337,6 +1342,9 @@ static int ethtool_get_regs(struct net_device *dev, char __user *useraddr)
 		return -EFAULT;
 
 	reglen = ops->get_regs_len(dev);
+	if (reglen <= 0)
+		return reglen;
+
 	if (regs.len > reglen)
 		regs.len = reglen;
 
-- 
2.8.1

