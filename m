Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0204C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE6218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfBCNuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53018 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbfBCNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0003wG-9c; Sun, 03 Feb 2019 13:49:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0006xg-5Y; Sun, 03 Feb 2019 14:49:44 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Tvrtko Ursulin" <tvrtko.ursulin@intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.357299674@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 098/305] drm/i915: Large page offsets for pread/pwrite
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit ab0d6a141843e0b4b2709dfd37b53468b5452c3a upstream.

Handle integer overflow when computing the sub-page length for shmem
backed pread/pwrite.

Reported-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181012140228.29783-1-chris@chris-wilson.co.uk
(cherry picked from commit a5e856a5348f6cd50889d125c40bbeec7328e466)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[bwh: Backported to 3.16:
 - Length variable is page_length, not length
 - Page-offset variable is shmem_page_offset, not offset]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -573,7 +573,7 @@ i915_gem_shmem_pread(struct drm_device *
 	char __user *user_data;
 	ssize_t remain;
 	loff_t offset;
-	int shmem_page_offset, page_length, ret = 0;
+	int shmem_page_offset, ret = 0;
 	int obj_do_bit17_swizzling, page_do_bit17_swizzling;
 	int prefaulted = 0;
 	int needs_clflush = 0;
@@ -593,6 +593,7 @@ i915_gem_shmem_pread(struct drm_device *
 	for_each_sg_page(obj->pages->sgl, &sg_iter, obj->pages->nents,
 			 offset >> PAGE_SHIFT) {
 		struct page *page = sg_page_iter_page(&sg_iter);
+		unsigned int page_length;
 
 		if (remain <= 0)
 			break;
@@ -603,9 +604,7 @@ i915_gem_shmem_pread(struct drm_device *
 		 * page_length = bytes to copy for this page
 		 */
 		shmem_page_offset = offset_in_page(offset);
-		page_length = remain;
-		if ((shmem_page_offset + page_length) > PAGE_SIZE)
-			page_length = PAGE_SIZE - shmem_page_offset;
+		page_length = min_t(u64, remain, PAGE_SIZE - shmem_page_offset);
 
 		page_do_bit17_swizzling = obj_do_bit17_swizzling &&
 			(page_to_phys(page) & (1 << 17)) != 0;
@@ -870,7 +869,7 @@ i915_gem_shmem_pwrite(struct drm_device
 	ssize_t remain;
 	loff_t offset;
 	char __user *user_data;
-	int shmem_page_offset, page_length, ret = 0;
+	int shmem_page_offset, ret = 0;
 	int obj_do_bit17_swizzling, page_do_bit17_swizzling;
 	int hit_slowpath = 0;
 	int needs_clflush_after = 0;
@@ -913,6 +912,7 @@ i915_gem_shmem_pwrite(struct drm_device
 			 offset >> PAGE_SHIFT) {
 		struct page *page = sg_page_iter_page(&sg_iter);
 		int partial_cacheline_write;
+		unsigned int page_length;
 
 		if (remain <= 0)
 			break;
@@ -923,10 +923,7 @@ i915_gem_shmem_pwrite(struct drm_device
 		 * page_length = bytes to copy for this page
 		 */
 		shmem_page_offset = offset_in_page(offset);
-
-		page_length = remain;
-		if ((shmem_page_offset + page_length) > PAGE_SIZE)
-			page_length = PAGE_SIZE - shmem_page_offset;
+		page_length = min_t(u64, remain, PAGE_SIZE - shmem_page_offset);
 
 		/* If we don't overwrite a cacheline completely we need to be
 		 * careful to have up-to-date data by first clflushing. Don't

