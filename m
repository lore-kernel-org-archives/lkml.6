Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE87C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C2D20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbfAPJBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:01:40 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2173 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729385AbfAPJBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:01:37 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0F3E2FF9C56D09FE851F;
        Wed, 16 Jan 2019 17:01:34 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.206)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 16 Jan 2019 17:01:24
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
Subject: [PATCH 2/5] staging: erofs: localize erofs_workgroup_get
Date:   Wed, 16 Jan 2019 16:59:53 +0800
Message-ID: <20190116085956.21004-2-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20190116085956.21004-1-gaoxiang25@huawei.com>
References: <20190116085956.21004-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Staticize erofs_workgroup_get since no external user
out of utils.c directly calls erofs_workgroup_get.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/internal.h | 21 ---------------------
 drivers/staging/erofs/utils.c    | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index 80cc09ea787d..967ec1a56726 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -252,28 +252,7 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
 }
 #endif
 
-static inline int erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
-{
-	int o;
-
-repeat:
-	o = erofs_wait_on_workgroup_freezed(grp);
-
-	if (unlikely(o <= 0))
-		return -1;
-
-	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
-		goto repeat;
-
-	*ocnt = o;
-	return 0;
-}
-
-#define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
-#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
-
 extern int erofs_workgroup_put(struct erofs_workgroup *grp);
-
 extern struct erofs_workgroup *erofs_find_workgroup(
 	struct super_block *sb, pgoff_t index, bool *tag);
 
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index aed211cd5875..d24945aab133 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -31,6 +31,25 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 static atomic_long_t erofs_global_shrink_cnt;
 
 #ifdef CONFIG_EROFS_FS_ZIP
+#define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
+#define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
+
+static int erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
+{
+	int o;
+
+repeat:
+	o = erofs_wait_on_workgroup_freezed(grp);
+
+	if (unlikely(o <= 0))
+		return -1;
+
+	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
+		goto repeat;
+
+	*ocnt = o;
+	return 0;
+}
 
 struct erofs_workgroup *erofs_find_workgroup(
 	struct super_block *sb, pgoff_t index, bool *tag)
-- 
2.14.4

