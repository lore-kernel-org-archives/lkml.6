Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ADBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D9622BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yfnY71vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1D9622BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754209AbeGFVJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753652AbeGFVJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:09:08 -0400
Received: from localhost (unknown [104.132.1.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F1BF22BEB;
        Fri,  6 Jul 2018 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530911347;
        bh=nj47Os2exG379q6JsUC9RLMjMFM5sD/oXllLJzviTWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfnY71viue4ZEJCuJP4ZNLfmkRYmkXssYqo1oSxlDXIjPw6MdbLn0kG8ZlPAZWoo4
         vFQ4wL5jJEohiS4WYqD+ryV7x7V4IVnoR66OJPt6n31LesycTrXE6kM3MNVM7pC9ex
         4KapXXhi0HSzPe6vrfZ9cFRC4DuD56vHkHuQenZM=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: should check the type of end_io after pullback by fscrypto
Date:   Fri,  6 Jul 2018 14:09:03 -0700
Message-Id: <20180706210903.77887-4-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <20180706210903.77887-1-jaegeuk@kernel.org>
References: <20180706210903.77887-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes to get the page type after pullback by fscrypto, since the original
page is bounce page but we should need to get control page which is what we
originally submitted.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c3f9b9baf140..9a0fcec53d0e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -152,7 +152,6 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	bio_for_each_segment_all(bvec, bio, i) {
 		struct page *page = bvec->bv_page;
-		enum count_type type = WB_DATA_TYPE(page);
 
 		if (IS_DUMMY_WRITTEN_PAGE(page)) {
 			set_page_private(page, (unsigned long)NULL);
@@ -169,14 +168,14 @@ static void f2fs_write_end_io(struct bio *bio)
 
 		if (unlikely(bio->bi_status)) {
 			mapping_set_error(page->mapping, -EIO);
-			if (type == F2FS_WB_CP_DATA)
+			if (WB_DATA_TYPE(page) == F2FS_WB_CP_DATA)
 				f2fs_stop_checkpoint(sbi, true);
 		}
 
 		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
 					page->index != nid_of_node(page));
 
-		dec_page_count(sbi, type);
+		dec_page_count(sbi, WB_DATA_TYPE(page));
 		clear_cold_data(page);
 		end_page_writeback(page);
 	}
-- 
2.17.0.441.gb46fe60e1d-goog

