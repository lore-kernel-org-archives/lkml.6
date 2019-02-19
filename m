Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5514C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B906E21903
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfBSIH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:07:26 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:33342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfBSIH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:07:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7150BA00AEF47FEC08D9;
        Tue, 19 Feb 2019 16:07:22 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.408.0; Tue, 19 Feb 2019
 16:07:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ralf@linux-mips.org>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-hams@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: rose: add missing dev_put() on error in rose_bind
Date:   Tue, 19 Feb 2019 16:06:22 +0800
Message-ID: <20190219080622.17312-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when capable check failed, dev_put should
be call before return -EACCES.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/rose/af_rose.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index d00a0ef..c96f63f 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -689,8 +689,10 @@ static int rose_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		rose->source_call = user->call;
 		ax25_uid_put(user);
 	} else {
-		if (ax25_uid_policy && !capable(CAP_NET_BIND_SERVICE))
+		if (ax25_uid_policy && !capable(CAP_NET_BIND_SERVICE)) {
+			dev_put(dev);
 			return -EACCES;
+		}
 		rose->source_call   = *source;
 	}
 
-- 
2.7.0


