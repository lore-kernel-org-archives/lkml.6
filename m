Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D496AECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2D0208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2D0208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbeISL0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 07:26:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60057 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbeISL0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 07:26:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B9A9A19484957;
        Wed, 19 Sep 2018 13:49:42 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.399.0; Wed, 19 Sep
 2018 13:49:37 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Miao Xie" <miaoxie@huawei.com>,
        Du Wei <weidu.du@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/6] staging: erofs: fold in `__update_workgrp_llen'
Date:   Wed, 19 Sep 2018 13:49:06 +0800
Message-ID: <1537336150-90604-2-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
References: <1537336150-90604-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is the only one user to use `__update_workgrp_llen'.
Fold it in `z_erofs_vle_work_iter_begin' and cleanup related code.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 2b9b313..e820490 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -422,18 +422,6 @@ struct z_erofs_vle_work_finder {
 	return work;
 }
 
-static inline void __update_workgrp_llen(struct z_erofs_vle_workgroup *grp,
-					 unsigned int llen)
-{
-	while (1) {
-		unsigned int orig_llen = grp->llen;
-
-		if (orig_llen >= llen || orig_llen ==
-			cmpxchg(&grp->llen, orig_llen, llen))
-			break;
-	}
-}
-
 #define builder_is_followed(builder) \
 	((builder)->role >= Z_EROFS_VLE_WORK_PRIMARY_FOLLOWED)
 
@@ -466,7 +454,13 @@ static int z_erofs_vle_work_iter_begin(struct z_erofs_vle_work_builder *builder,
 repeat:
 	work = z_erofs_vle_work_lookup(&finder);
 	if (work != NULL) {
-		__update_workgrp_llen(grp, map->m_llen);
+		unsigned int orig_llen;
+
+		/* increase workgroup `llen' if needed */
+		while ((orig_llen = READ_ONCE(grp->llen)) < map->m_llen &&
+		       orig_llen != cmpxchg_relaxed(&grp->llen,
+						    orig_llen, map->m_llen))
+			cpu_relax();
 		goto got_it;
 	}
 
-- 
1.9.1

