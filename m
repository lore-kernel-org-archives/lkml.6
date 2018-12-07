Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD5C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D6B2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D6B2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbeLGQFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:05:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:15658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726200AbeLGQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:05:30 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A405FD3C2C641;
        Sat,  8 Dec 2018 00:05:26 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 8 Dec 2018
 00:05:20 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 6/7] staging: erofs: redefine where `owned_workgrp_t' points
Date:   Sat, 8 Dec 2018 00:19:17 +0800
Message-ID: <20181207161918.20747-7-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181207161918.20747-1-gaoxiang25@huawei.com>
References: <20181207161918.20747-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By design, workgroups are queued in the form of linked lists.

Previously, it points to the next `z_erofs_vle_workgroup',
which isn't flexible enough to simplify `z_erofs_vle_submit_all'.

Let's fix it by pointing to the next `owned_workgrp_t' and use
container_of to get its coresponding `z_erofs_vle_workgroup'.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 12 +++++++-----
 drivers/staging/erofs/unzip_vle.h |  4 ++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 2b494f29e2c2..a8cf324f0b9c 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -333,7 +333,7 @@ static inline bool try_to_claim_workgroup(
 			    *owned_head) != Z_EROFS_VLE_WORKGRP_NIL)
 			goto retry;
 
-		*owned_head = grp;
+		*owned_head = &grp->next;
 		*hosted = true;
 	} else if (grp->next == Z_EROFS_VLE_WORKGRP_TAIL) {
 		/*
@@ -488,7 +488,8 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 		}
 	}
 
-	*f->owned_head = *f->grp_ret = grp;
+	*f->owned_head = &grp->next;
+	*f->grp_ret = grp;
 	return work;
 }
 
@@ -1084,7 +1085,7 @@ static void z_erofs_vle_unzip_all(struct super_block *sb,
 		/* no possible that 'owned' equals NULL */
 		DBG_BUGON(owned == Z_EROFS_VLE_WORKGRP_NIL);
 
-		grp = owned;
+		grp = container_of(owned, struct z_erofs_vle_workgroup, next);
 		owned = READ_ONCE(grp->next);
 
 		z_erofs_vle_unzip(sb, grp, page_pool);
@@ -1325,7 +1326,8 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		DBG_BUGON(owned_head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
 		DBG_BUGON(owned_head == Z_EROFS_VLE_WORKGRP_NIL);
 
-		grp = owned_head;
+		grp = container_of(owned_head,
+				   struct z_erofs_vle_workgroup, next);
 
 		/* close the main owned chain at first */
 		owned_head = cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_TAIL,
@@ -1382,7 +1384,7 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 				WRITE_ONCE(lstgrp_io->next, iogrp_next);
 
 			if (!lstgrp_noio)
-				ios[0]->head = grp;
+				ios[0]->head = &grp->next;
 			else
 				WRITE_ONCE(lstgrp_noio->next, grp);
 
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 3316bc36965d..5a4e1b62c0d1 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -67,13 +67,13 @@ struct z_erofs_vle_work {
 #define Z_EROFS_VLE_WORKGRP_FMT_LZ4          1
 #define Z_EROFS_VLE_WORKGRP_FMT_MASK         1
 
-typedef struct z_erofs_vle_workgroup *z_erofs_vle_owned_workgrp_t;
+typedef void *z_erofs_vle_owned_workgrp_t;
 
 struct z_erofs_vle_workgroup {
 	struct erofs_workgroup obj;
 	struct z_erofs_vle_work work;
 
-	/* next owned workgroup */
+	/* point to next owned_workgrp_t */
 	z_erofs_vle_owned_workgrp_t next;
 
 	/* compressed pages (including multi-usage pages) */
-- 
2.14.4

