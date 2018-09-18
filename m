Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC74CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8F02146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:27:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B8F02146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeIRUAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:00:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727228AbeIRUAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:00:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B120B032BB3D;
        Tue, 18 Sep 2018 22:27:46 +0800 (CST)
Received: from szvp000100637.huawei.com (10.162.55.131) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.399.0; Tue, 18 Sep
 2018 22:27:38 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 5/8] staging: erofs: complete error handing of z_erofs_do_read_page
Date:   Tue, 18 Sep 2018 22:27:25 +0800
Message-ID: <1537280848-122331-1-git-send-email-gaoxiang25@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
References: <1537280740-122019-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.162.55.131]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch completes error handing code of z_erofs_do_read_page.
PG_error will be set when some read error happens, therefore
z_erofs_onlinepage_endio will unlock this page without setting
PG_uptodate.

Reviewed-by: Chao Yu <yucxhao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/unzip_vle.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 3296538..08c424c 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -611,7 +611,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 
 	enum z_erofs_page_type page_type;
 	unsigned int cur, end, spiltted, index;
-	int err;
+	int err = 0;
 
 	/* register locked file pages as online pages in pack */
 	z_erofs_onlinepage_init(page);
@@ -638,12 +638,11 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	if (unlikely(err))
 		goto err_out;
 
-	/* deal with hole (FIXME! broken now) */
 	if (unlikely(!(map->m_flags & EROFS_MAP_MAPPED)))
 		goto hitted;
 
 	DBG_BUGON(map->m_plen != 1 << sbi->clusterbits);
-	BUG_ON(erofs_blkoff(map->m_pa));
+	DBG_BUGON(erofs_blkoff(map->m_pa));
 
 	err = z_erofs_vle_work_iter_begin(builder, sb, map, &fe->owned_head);
 	if (unlikely(err))
@@ -688,7 +687,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 
 		err = z_erofs_vle_work_add_page(builder,
 			newpage, Z_EROFS_PAGE_TYPE_EXCLUSIVE);
-		if (!err)
+		if (likely(!err))
 			goto retry;
 	}
 
@@ -699,9 +698,10 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 
 	/* FIXME! avoid the last relundant fixup & endio */
 	z_erofs_onlinepage_fixup(page, index, true);
-	++spiltted;
 
-	/* also update nr_pages and increase queued_pages */
+	/* bump up the number of spiltted parts of a page */
+	++spiltted;
+	/* also update nr_pages */
 	work->nr_pages = max_t(pgoff_t, work->nr_pages, index + 1);
 next_part:
 	/* can be used for verification */
@@ -711,16 +711,18 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	if (end > 0)
 		goto repeat;
 
+out:
 	/* FIXME! avoid the last relundant fixup & endio */
 	z_erofs_onlinepage_endio(page);
 
 	debugln("%s, finish page: %pK spiltted: %u map->m_llen %llu",
 		__func__, page, spiltted, map->m_llen);
-	return 0;
+	return err;
 
+	/* if some error occurred while processing this page */
 err_out:
-	/* TODO: the missing error handing cases */
-	return err;
+	SetPageError(page);
+	goto out;
 }
 
 static void z_erofs_vle_unzip_kickoff(void *ptr, int bios)
-- 
1.9.1

