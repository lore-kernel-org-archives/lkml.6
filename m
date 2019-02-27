Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AC6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2EA2184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfB0PAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:00:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45726 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728651AbfB0PAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:00:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7043A9809AAA7C53D830;
        Wed, 27 Feb 2019 23:00:53 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Feb 2019
 23:00:44 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <joe@perches.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] appletalk: use remove_proc_subtree to simplify procfs code
Date:   Wed, 27 Feb 2019 23:00:23 +0800
Message-ID: <20190227150023.28420-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Use remove_proc_subtree to remove the whole subtree
on cleanup.Also do some cleanup.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/appletalk/atalk_proc.c | 56 ++++++++++++++--------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/net/appletalk/atalk_proc.c b/net/appletalk/atalk_proc.c
index 8006295..398b767 100644
--- a/net/appletalk/atalk_proc.c
+++ b/net/appletalk/atalk_proc.c
@@ -210,56 +210,34 @@ static const struct seq_operations atalk_seq_socket_ops = {
 	.show   = atalk_seq_socket_show,
 };
 
-static struct proc_dir_entry *atalk_proc_dir;
-
 int __init atalk_proc_init(void)
 {
-	struct proc_dir_entry *p;
-	int rc = -ENOMEM;
+	if (!proc_mkdir("atalk", init_net.proc_net))
+		return -ENOMEM;
 
-	atalk_proc_dir = proc_mkdir("atalk", init_net.proc_net);
-	if (!atalk_proc_dir)
+	if (!proc_create_seq("atalk/interface", 0444, init_net.proc_net,
+			    &atalk_seq_interface_ops));
 		goto out;
 
-	p = proc_create_seq("interface", 0444, atalk_proc_dir,
-			&atalk_seq_interface_ops);
-	if (!p)
-		goto out_interface;
-
-	p = proc_create_seq("route", 0444, atalk_proc_dir,
-			&atalk_seq_route_ops);
-	if (!p)
-		goto out_route;
+	if (!proc_create_seq("atalk/route", 0444, init_net.proc_net,
+			    &atalk_seq_route_ops));
+		goto out;
 
-	p = proc_create_seq("socket", 0444, atalk_proc_dir,
-			&atalk_seq_socket_ops);
-	if (!p)
-		goto out_socket;
+	if (!proc_create_seq("atalk/socket", 0444, init_net.proc_net,
+			    &atalk_seq_socket_ops));
+		goto out;
 
-	p = proc_create_seq_private("arp", 0444, atalk_proc_dir, &aarp_seq_ops,
-			sizeof(struct aarp_iter_state), NULL);
-	if (!p)
-		goto out_arp;
+	if (!proc_create_seq_private("atalk/arp", 0444, init_net.proc_net,
+				     &aarp_seq_ops,
+				     sizeof(struct aarp_iter_state), NULL));
+		goto out;
 
-	rc = 0;
 out:
-	return rc;
-out_arp:
-	remove_proc_entry("socket", atalk_proc_dir);
-out_socket:
-	remove_proc_entry("route", atalk_proc_dir);
-out_route:
-	remove_proc_entry("interface", atalk_proc_dir);
-out_interface:
-	remove_proc_entry("atalk", init_net.proc_net);
-	goto out;
+	remove_proc_subtree("atalk", init_net.proc_net);
+	return -ENOMEM;
 }
 
 void __exit atalk_proc_exit(void)
 {
-	remove_proc_entry("interface", atalk_proc_dir);
-	remove_proc_entry("route", atalk_proc_dir);
-	remove_proc_entry("socket", atalk_proc_dir);
-	remove_proc_entry("arp", atalk_proc_dir);
-	remove_proc_entry("atalk", init_net.proc_net);
+	remove_proc_subtree("atalk", init_net.proc_net);
 }
-- 
2.7.0


