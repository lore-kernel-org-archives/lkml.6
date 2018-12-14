Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C0C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797F7214C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789842;
	bh=/zYAUydvZCGxS2JI+zBkTFGexjL3wehh2gDCEUjyzOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=abcaosz27C1+yyDem650uOhPG5Rz2yGZFdA7h2JQJR9dB7LMRelAQ+CglEwEaGisX
	 v0moEBX4Nm/qQ2MOrF4/V82WT8LXpnrxuOrQ+wqC2DQIOLh7rFQcV8jNPjzSsQF2Oe
	 pjyeJu2MDQzVgXud7OQc8NMGttgCVLb4CIg833O4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797F7214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbeLNMRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:37654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732895AbeLNMRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:17:18 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10187214DB;
        Fri, 14 Dec 2018 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789837;
        bh=/zYAUydvZCGxS2JI+zBkTFGexjL3wehh2gDCEUjyzOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E2K6l2fmSZUGFpRjsIEWC8/fH8MgCX9Z225LQ0oh9rtyAFneysptAONRK84BGNEDU
         h0oSa5xLXwsK87bjXAQw7MLcXch48oFOAHRdhFHKOe/fIOLAFa/UE8F33aht5T8Qww
         l7ulIX6g+H+HGJhdA5O9P2W4ZActWqLIXIBppqYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 78/88] mm: replace get_vaddr_frames() write/force parameters with gup_flags
Date:   Fri, 14 Dec 2018 13:00:52 +0100
Message-Id: <20181214115708.555102118@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115702.151309521@linuxfoundation.org>
References: <20181214115702.151309521@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lstoakes@gmail.com>

commit 7f23b3504a0df63b724180262c5f3f117f21bcae upstream.

This removes the 'write' and 'force' from get_vaddr_frames() and
replaces them with 'gup_flags' to make the use of FOLL_FORCE explicit in
callers as use of this flag can result in surprising behaviour (and
hence bugs) within the mm subsystem.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c    |    3 ++-
 drivers/media/platform/omap/omap_vout.c    |    2 +-
 drivers/media/v4l2-core/videobuf2-memops.c |    6 +++++-
 include/linux/mm.h                         |    2 +-
 mm/frame_vector.c                          |   13 ++-----------
 5 files changed, 11 insertions(+), 15 deletions(-)

--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -471,7 +471,8 @@ static dma_addr_t *g2d_userptr_get_dma_a
 		goto err_free;
 	}
 
-	ret = get_vaddr_frames(start, npages, true, true, g2d_userptr->vec);
+	ret = get_vaddr_frames(start, npages, FOLL_FORCE | FOLL_WRITE,
+		g2d_userptr->vec);
 	if (ret != npages) {
 		DRM_ERROR("failed to get user pages from userptr.\n");
 		if (ret < 0)
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -214,7 +214,7 @@ static int omap_vout_get_userptr(struct
 	if (!vec)
 		return -ENOMEM;
 
-	ret = get_vaddr_frames(virtp, 1, true, false, vec);
+	ret = get_vaddr_frames(virtp, 1, FOLL_WRITE, vec);
 	if (ret != 1) {
 		frame_vector_destroy(vec);
 		return -EINVAL;
--- a/drivers/media/v4l2-core/videobuf2-memops.c
+++ b/drivers/media/v4l2-core/videobuf2-memops.c
@@ -42,6 +42,10 @@ struct frame_vector *vb2_create_framevec
 	unsigned long first, last;
 	unsigned long nr;
 	struct frame_vector *vec;
+	unsigned int flags = FOLL_FORCE;
+
+	if (write)
+		flags |= FOLL_WRITE;
 
 	first = start >> PAGE_SHIFT;
 	last = (start + length - 1) >> PAGE_SHIFT;
@@ -49,7 +53,7 @@ struct frame_vector *vb2_create_framevec
 	vec = frame_vector_create(nr);
 	if (!vec)
 		return ERR_PTR(-ENOMEM);
-	ret = get_vaddr_frames(start & PAGE_MASK, nr, write, true, vec);
+	ret = get_vaddr_frames(start & PAGE_MASK, nr, flags, vec);
 	if (ret < 0)
 		goto out_destroy;
 	/* We accept only complete set of PFNs */
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1227,7 +1227,7 @@ struct frame_vector {
 struct frame_vector *frame_vector_create(unsigned int nr_frames);
 void frame_vector_destroy(struct frame_vector *vec);
 int get_vaddr_frames(unsigned long start, unsigned int nr_pfns,
-		     bool write, bool force, struct frame_vector *vec);
+		     unsigned int gup_flags, struct frame_vector *vec);
 void put_vaddr_frames(struct frame_vector *vec);
 int frame_vector_to_pages(struct frame_vector *vec);
 void frame_vector_to_pfns(struct frame_vector *vec);
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -11,10 +11,7 @@
  * get_vaddr_frames() - map virtual addresses to pfns
  * @start:	starting user address
  * @nr_frames:	number of pages / pfns from start to map
- * @write:	whether pages will be written to by the caller
- * @force:	whether to force write access even if user mapping is
- *		readonly. See description of the same argument of
-		get_user_pages().
+ * @gup_flags:	flags modifying lookup behaviour
  * @vec:	structure which receives pages / pfns of the addresses mapped.
  *		It should have space for at least nr_frames entries.
  *
@@ -34,23 +31,17 @@
  * This function takes care of grabbing mmap_sem as necessary.
  */
 int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
-		     bool write, bool force, struct frame_vector *vec)
+		     unsigned int gup_flags, struct frame_vector *vec)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int ret = 0;
 	int err;
 	int locked;
-	unsigned int gup_flags = 0;
 
 	if (nr_frames == 0)
 		return 0;
 
-	if (write)
-		gup_flags |= FOLL_WRITE;
-	if (force)
-		gup_flags |= FOLL_FORCE;
-
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames = vec->nr_allocated;
 


