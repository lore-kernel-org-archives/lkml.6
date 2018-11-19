Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828D2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E6D20831
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7WB9xKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49E6D20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbeKTDCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731835AbeKTDCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE46208E3;
        Mon, 19 Nov 2018 16:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645519;
        bh=4fyc9u0/7ANmefmwIYnyL0MGNa6Z0fNTfM/dkjR+h4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7WB9xKD4u9rBw2tjvFNCKDY4YGo6gHmc8cuELzcgMMf6Ncd4NkZgIpUDlW+uyN6/
         jhyh+X9AnXMTZ3tCtQRGzg9RjfkZvNmG6YSUzfKU3eihO9+QqSchO87jDGEA83cLcu
         4YkGvt+IRvtvG8hKPBAwpO/rfEhVjho4NApsjJlw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergii Romantsov <sergii.romantsov@globallogic.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 4.19 194/205] drm/i915: Mark up GTT sizes as u64
Date:   Mon, 19 Nov 2018 17:28:21 +0100
Message-Id: <20181119162642.210949895@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit c58281056a8b26d5d9dc15c19859a7880835ef44 upstream.

Since we use a 64b virtual GTT irrespective of the system, we want to
ensure that the GTT computations remains 64b even on 32b systems,
including treatment of huge virtual pages.

No code generation changes on 64b:

Reported-by: Sergii Romantsov <sergii.romantsov@globallogic.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108282
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181025091823.20571-1-chris@chris-wilson.co.uk
(cherry picked from commit 9125963a9494253fa5a29cc1b4169885d2be7042)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_gtt.c           |    2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h           |    6 +++---
 drivers/gpu/drm/i915/selftests/huge_pages.c   |    2 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |    6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -1768,7 +1768,7 @@ static void gen6_dump_ppgtt(struct i915_
 			if (i == 4)
 				continue;
 
-			seq_printf(m, "\t\t(%03d, %04d) %08lx: ",
+			seq_printf(m, "\t\t(%03d, %04d) %08llx: ",
 				   pde, pte,
 				   (pde * GEN6_PTES + pte) * PAGE_SIZE);
 			for (i = 0; i < 4; i++) {
--- a/drivers/gpu/drm/i915/i915_gem_gtt.h
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.h
@@ -42,9 +42,9 @@
 #include "i915_selftest.h"
 #include "i915_timeline.h"
 
-#define I915_GTT_PAGE_SIZE_4K BIT(12)
-#define I915_GTT_PAGE_SIZE_64K BIT(16)
-#define I915_GTT_PAGE_SIZE_2M BIT(21)
+#define I915_GTT_PAGE_SIZE_4K	BIT_ULL(12)
+#define I915_GTT_PAGE_SIZE_64K	BIT_ULL(16)
+#define I915_GTT_PAGE_SIZE_2M	BIT_ULL(21)
 
 #define I915_GTT_PAGE_SIZE I915_GTT_PAGE_SIZE_4K
 #define I915_GTT_MAX_PAGE_SIZE I915_GTT_PAGE_SIZE_2M
--- a/drivers/gpu/drm/i915/selftests/huge_pages.c
+++ b/drivers/gpu/drm/i915/selftests/huge_pages.c
@@ -549,7 +549,7 @@ static int igt_mock_ppgtt_misaligned_dma
 			err = igt_check_page_sizes(vma);
 
 			if (vma->page_sizes.gtt != I915_GTT_PAGE_SIZE_4K) {
-				pr_err("page_sizes.gtt=%u, expected %lu\n",
+				pr_err("page_sizes.gtt=%u, expected %llu\n",
 				       vma->page_sizes.gtt, I915_GTT_PAGE_SIZE_4K);
 				err = -EINVAL;
 			}
--- a/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/selftests/i915_gem_gtt.c
@@ -1337,7 +1337,7 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %lx)\n",
+			pr_err("i915_gem_gtt_reserve (pass 1) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
 			       vma->node.start, vma->node.size,
 			       total, 2*I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
@@ -1386,7 +1386,7 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != total ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %lx)\n",
+			pr_err("i915_gem_gtt_reserve (pass 2) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
 			       vma->node.start, vma->node.size,
 			       total, 2*I915_GTT_PAGE_SIZE);
 			err = -EINVAL;
@@ -1430,7 +1430,7 @@ static int igt_gtt_reserve(void *arg)
 		GEM_BUG_ON(!drm_mm_node_allocated(&vma->node));
 		if (vma->node.start != offset ||
 		    vma->node.size != 2*I915_GTT_PAGE_SIZE) {
-			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %lx)\n",
+			pr_err("i915_gem_gtt_reserve (pass 3) placement failed, found (%llx + %llx), expected (%llx + %llx)\n",
 			       vma->node.start, vma->node.size,
 			       offset, 2*I915_GTT_PAGE_SIZE);
 			err = -EINVAL;


