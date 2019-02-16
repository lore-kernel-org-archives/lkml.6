Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CFBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE7222D7
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbfBPIsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:48:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729871AbfBPIsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:48:40 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DD8ACC8457ABC5F6F014;
        Sat, 16 Feb 2019 16:48:36 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.202)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 16 Feb 2019 16:48:30
 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] staging: erofs: remove rcu_read_lock() in erofs_try_to_free_cached_page
Date:   Sat, 16 Feb 2019 16:46:50 +0800
Message-ID: <20190216084650.33841-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_private(page) cannot be changed if page lock is taken.

Besides, the corresponding workgroup won't be freed
if the page is already protected by page lock, therefore
no need to take rcu read lock.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 2b5951f233db..a127d8db76d8 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -238,14 +238,9 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 {
 	struct erofs_sb_info *const sbi = EROFS_SB(mapping->host->i_sb);
 	const unsigned int clusterpages = erofs_clusterpages(sbi);
-
-	struct z_erofs_vle_workgroup *grp;
+	struct z_erofs_vle_workgroup *const grp = (void *)page_private(page);
 	int ret = 0;	/* 0 - busy */
 
-	/* prevent the workgroup from being freed */
-	rcu_read_lock();
-	grp = (void *)page_private(page);
-
 	if (erofs_workgroup_try_to_freeze(&grp->obj, 1)) {
 		unsigned int i;
 
@@ -257,12 +252,11 @@ int erofs_try_to_free_cached_page(struct address_space *mapping,
 			}
 		}
 		erofs_workgroup_unfreeze(&grp->obj, 1);
-	}
-	rcu_read_unlock();
 
-	if (ret) {
-		ClearPagePrivate(page);
-		put_page(page);
+		if (ret) {
+			ClearPagePrivate(page);
+			put_page(page);
+		}
 	}
 	return ret;
 }
-- 
2.14.4

