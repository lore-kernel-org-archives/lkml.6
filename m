Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B41C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2869D2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2869D2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeKNQDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:03:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:14660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbeKNQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:03:41 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 30E42E554F7A5;
        Wed, 14 Nov 2018 14:01:30 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.408.0; Wed, 14 Nov 2018 14:01:22 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] i3c: master: Remove set but not used variable 'old_i3c_scl_lim'
Date:   Wed, 14 Nov 2018 06:10:47 +0000
Message-ID: <1542175847-49517-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/i3c/master/i3c-master-cdns.c: In function 'cdns_i3c_master_do_daa':
drivers/i3c/master/i3c-master-cdns.c:1137:16: warning:
 variable 'old_i3c_scl_lim' set but not used [-Wunused-but-set-variable]

It never used since introdution in commit
  acfab7d324b2 ("i3c: master: Add driver for Cadence IP")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/i3c/master/i3c-master-cdns.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index ad40162..e828921 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -1133,7 +1133,6 @@ static void cdns_i3c_master_upd_i3c_scl_lim(struct cdns_i3c_master *master)
 static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 {
 	struct cdns_i3c_master *master = to_cdns_i3c_master(m);
-	unsigned long old_i3c_scl_lim;
 	u32 olddevs, newdevs;
 	int ret, slot;
 	u8 addrs[MAX_DEVS] = { };
@@ -1165,9 +1164,6 @@ static int cdns_i3c_master_do_daa(struct i3c_master_controller *m)
 	newdevs = readl(master->regs + DEVS_CTRL) & DEVS_CTRL_DEVS_ACTIVE_MASK;
 	newdevs &= ~olddevs;
 
-	/* Save the old limitation before add devices. */
-	old_i3c_scl_lim = master->i3c_scl_lim;
-
 	/*
 	 * Clear all retaining registers filled during DAA. We already
 	 * have the addressed assigned to them in the addrs array.



