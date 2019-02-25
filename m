Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C56EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DB620C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130009;
	bh=9kpyAS/u0//BGkJYaWqVEHLfIx3+ONR1mzO2+U4I20U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cs8mnZShLUP0GJdrSLla60h/PpUHCVLLOvyVU436d7mU6cGykE3owbME7sC09Ch7s
	 7w8nkxQ5K4bwNhfPgvQ6bJ7JH1+vcgIzy/LQXd0bfZoWQI+XP1nFXbxFLpDITmvwFi
	 0WWE4+gaipi6e7m6xsv9thvr+ml4L2w9t8rC8fe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbfBYV0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:26:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbfBYV0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:26:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23F3213A2;
        Mon, 25 Feb 2019 21:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130004;
        bh=9kpyAS/u0//BGkJYaWqVEHLfIx3+ONR1mzO2+U4I20U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pf8XzVzdoFstiwaom/KzdAELdYAuEkHptCEdfW2UDRt7I+7PVHfKYs+GVNL+aa2o8
         BU7e4/WQT3x4182JkqJbuZf29mzk4jATgotKmjlptnsDhZembUUUtE0grTEtDrf796
         VCRi8WPvIdIIyzBmilYTGTDYrUniw2C+7FmyNOX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yucxhao0@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 4.19 135/152] staging: erofs: complete error handing of z_erofs_do_read_page
Date:   Mon, 25 Feb 2019 22:12:07 +0100
Message-Id: <20190225195053.035779342@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 1e05ff36e6921ca61bdbf779f81a602863569ee3 upstream.

This patch completes error handing code of z_erofs_do_read_page.
PG_error will be set when some read error happens, therefore
z_erofs_onlinepage_endio will unlock this page without setting
PG_uptodate.

Reviewed-by: Chao Yu <yucxhao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -606,7 +606,7 @@ static int z_erofs_do_read_page(struct z
 
 	enum z_erofs_page_type page_type;
 	unsigned cur, end, spiltted, index;
-	int err;
+	int err = 0;
 
 	/* register locked file pages as online pages in pack */
 	z_erofs_onlinepage_init(page);
@@ -633,12 +633,11 @@ repeat:
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
@@ -683,7 +682,7 @@ retry:
 
 		err = z_erofs_vle_work_add_page(builder,
 			newpage, Z_EROFS_PAGE_TYPE_EXCLUSIVE);
-		if (!err)
+		if (likely(!err))
 			goto retry;
 	}
 
@@ -694,9 +693,10 @@ retry:
 
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
@@ -706,16 +706,18 @@ next_part:
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


