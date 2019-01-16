Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76649C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDEA20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391571AbfAPJBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:01:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388848AbfAPJBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:01:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 14CA6F21561038C414EF;
        Wed, 16 Jan 2019 17:01:34 +0800 (CST)
Received: from 138.huawei.com (10.175.124.28) by smtp.huawei.com (10.3.19.206)
 with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 16 Jan 2019 17:01:26
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
Subject: [PATCH 3/5] staging: erofs: decrease the shrink count in erofs_workgroup_get
Date:   Wed, 16 Jan 2019 16:59:54 +0800
Message-ID: <20190116085956.21004-3-gaoxiang25@huawei.com>
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

It is more suitable to update in erofs_workgroup_get since
it's actually the one matched with erofs_workgroup_put.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/utils.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index d24945aab133..5695efaeb43a 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -34,29 +34,29 @@ static atomic_long_t erofs_global_shrink_cnt;
 #define __erofs_workgroup_get(grp)	atomic_inc(&(grp)->refcount)
 #define __erofs_workgroup_put(grp)	atomic_dec(&(grp)->refcount)
 
-static int erofs_workgroup_get(struct erofs_workgroup *grp, int *ocnt)
+static int erofs_workgroup_get(struct erofs_workgroup *grp)
 {
 	int o;
 
 repeat:
 	o = erofs_wait_on_workgroup_freezed(grp);
-
 	if (unlikely(o <= 0))
 		return -1;
 
 	if (unlikely(atomic_cmpxchg(&grp->refcount, o, o + 1) != o))
 		goto repeat;
 
-	*ocnt = o;
+	/* decrease refcount paired by erofs_workgroup_put */
+	if (unlikely(o == 1))
+		atomic_long_dec(&erofs_global_shrink_cnt);
 	return 0;
 }
 
-struct erofs_workgroup *erofs_find_workgroup(
-	struct super_block *sb, pgoff_t index, bool *tag)
+struct erofs_workgroup *erofs_find_workgroup(struct super_block *sb,
+					     pgoff_t index, bool *tag)
 {
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_workgroup *grp;
-	int oldcount;
 
 repeat:
 	rcu_read_lock();
@@ -65,15 +65,12 @@ struct erofs_workgroup *erofs_find_workgroup(
 		*tag = xa_pointer_tag(grp);
 		grp = xa_untag_pointer(grp);
 
-		if (erofs_workgroup_get(grp, &oldcount)) {
+		if (erofs_workgroup_get(grp)) {
 			/* prefer to relax rcu read side */
 			rcu_read_unlock();
 			goto repeat;
 		}
 
-		/* decrease refcount added by erofs_workgroup_put */
-		if (unlikely(oldcount == 1))
-			atomic_long_dec(&erofs_global_shrink_cnt);
 		DBG_BUGON(index != grp->index);
 	}
 	rcu_read_unlock();
-- 
2.14.4

