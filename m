Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE81C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29BA206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29BA206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbeKUAvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:51:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40552 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726916AbeKUAvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:51:20 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EF78E54F76CEB;
        Tue, 20 Nov 2018 22:21:55 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 20 Nov
 2018 22:21:50 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 08/10] staging: erofs: locked before registering for all new workgroups
Date:   Tue, 20 Nov 2018 22:34:23 +0800
Message-ID: <20181120143425.43637-9-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181120143425.43637-1-gaoxiang25@huawei.com>
References: <20181120143425.43637-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make sure that the one registering a workgroup will also
take the primary work lock at first for two reasons:
  1) There's no need to introduce such a race window (and consequently
     overhead) between registering and locking, other tasks could break
     in by chance, and the race seems unnecessary (no benefit at all);

  2) It's better to take the primary work when a workgroup
     is registered to apply the cache managed policy, for example,
     if some other tasks break in, it could turn into the in-place
     decompression rather than use as the cached decompression.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 4e5843e8ee35..a1376f3c6065 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -420,18 +420,22 @@ z_erofs_vle_work_register(const struct z_erofs_vle_work_finder *f,
 	work = z_erofs_vle_grab_primary_work(grp);
 	work->pageofs = f->pageofs;
 
+	/* lock all primary followed works before visible to others */
+	if (unlikely(!mutex_trylock(&work->lock)))
+		/* for a new workgroup, try_lock *never* fails */
+		DBG_BUGON(1);
+
 	if (gnew) {
 		int err = erofs_register_workgroup(f->sb, &grp->obj, 0);
 
 		if (err) {
+			mutex_unlock(&work->lock);
 			kmem_cache_free(z_erofs_workgroup_cachep, grp);
 			return ERR_PTR(-EAGAIN);
 		}
 	}
 
 	*f->owned_head = *f->grp_ret = grp;
-
-	mutex_lock(&work->lock);
 	return work;
 }
 
-- 
2.14.4

