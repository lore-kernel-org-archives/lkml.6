Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020C4C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BBA219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BBA219C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeHHQeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:34:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727109AbeHHQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:34:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F05B79A3434A6;
        Wed,  8 Aug 2018 22:14:34 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.399.0; Wed, 8 Aug 2018 22:14:30 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <ericvh@gmail.com>, <rminnich@sandia.gov>, <lucho@ionkov.net>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] net:9p: change the p9_error_init and p9_trans_fd_init to be void function
Date:   Wed, 8 Aug 2018 22:02:48 +0800
Message-ID: <1533736968-9365-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two functions has return value, but any of the callees do not handle the
return value. So we get out of the return value and make the function to be
void function. 

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 include/net/9p/9p.h | 4 ++--
 net/9p/error.c      | 4 +---
 net/9p/trans_fd.c   | 4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index b8eb51a..0a9577d 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -571,7 +571,7 @@ struct p9_fcall {
 void p9_idpool_put(int id, struct p9_idpool *p);
 int p9_idpool_check(int id, struct p9_idpool *p);
 
-int p9_error_init(void);
-int p9_trans_fd_init(void);
+void p9_error_init(void);
+void p9_trans_fd_init(void);
 void p9_trans_fd_exit(void);
 #endif /* NET_9P_H */
diff --git a/net/9p/error.c b/net/9p/error.c
index 126fd0d..458e038 100644
--- a/net/9p/error.c
+++ b/net/9p/error.c
@@ -190,7 +190,7 @@ struct errormap {
  *
  */
 
-int p9_error_init(void)
+void p9_error_init(void)
 {
 	struct errormap *c;
 	int bucket;
@@ -206,8 +206,6 @@ int p9_error_init(void)
 		INIT_HLIST_NODE(&c->list);
 		hlist_add_head(&c->list, &hash_errmap[bucket]);
 	}
-
-	return 1;
 }
 EXPORT_SYMBOL(p9_error_init);
 
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index e2ef3c7..e0f36c9 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -1121,13 +1121,11 @@ static void p9_poll_workfn(struct work_struct *work)
 	p9_debug(P9_DEBUG_TRANS, "finish\n");
 }
 
-int p9_trans_fd_init(void)
+void p9_trans_fd_init(void)
 {
 	v9fs_register_trans(&p9_tcp_trans);
 	v9fs_register_trans(&p9_unix_trans);
 	v9fs_register_trans(&p9_fd_trans);
-
-	return 0;
 }
 
 void p9_trans_fd_exit(void)
-- 
1.7.12.4

