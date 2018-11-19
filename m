Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4142BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086C32148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo5hgRI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 086C32148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbeKTDC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:02:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731835AbeKTDC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:02:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 065D7208E3;
        Mon, 19 Nov 2018 16:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645527;
        bh=WavSp8UUY/UrcyJVoCimKmEEmLX4tXGYmMp57RYXh0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zo5hgRI+LCUOwFWlg2VFP3hfe15N03D7JGRePil8N/krc8iKgQctCjhbr7dG7H2LE
         BK8TLbrAC9qOqdfHsMW1eC0Z8iN06uLZzU1JCrXKyD7wjNf9eXube1h+0PnmvU3uOG
         Li3xh0qES+/bvmO3wM7nr2NKQ45rRo7MOrV62xjc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergii Romantsov <sergii.romantsov@globallogic.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH 4.19 197/205] drm/i915: Compare users 64b GTT offset even on 32b
Date:   Mon, 19 Nov 2018 17:28:24 +0100
Message-Id: <20181119162642.422942133@linuxfoundation.org>
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

commit 085603287452fc96376ed4888bf29f8c095d2b40 upstream.

Beware mixing unsigned long constants and 64b values, as on 32b the
constant will be zero extended and discard the high 32b when used as
a mask!

Reported-by: Sergii Romantsov <sergii.romantsov@globallogic.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=108282
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181025091823.20571-2-chris@chris-wilson.co.uk
(cherry picked from commit 6fc4e48f9ed46e9adff236a0c350074aafa3b7fa)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/gvt/gtt.h             |    1 -
 drivers/gpu/drm/i915/i915_gem_execbuffer.c |    2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.h        |    2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/gvt/gtt.h
+++ b/drivers/gpu/drm/i915/gvt/gtt.h
@@ -35,7 +35,6 @@
 #define _GVT_GTT_H_
 
 #define I915_GTT_PAGE_SHIFT         12
-#define I915_GTT_PAGE_MASK		(~(I915_GTT_PAGE_SIZE - 1))
 
 struct intel_vgpu_mm;
 
--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -458,7 +458,7 @@ eb_validate_vma(struct i915_execbuffer *
 	 * any non-page-aligned or non-canonical addresses.
 	 */
 	if (unlikely(entry->flags & EXEC_OBJECT_PINNED &&
-		     entry->offset != gen8_canonical_addr(entry->offset & PAGE_MASK)))
+		     entry->offset != gen8_canonical_addr(entry->offset & I915_GTT_PAGE_MASK)))
 		return -EINVAL;
 
 	/* pad_to_size was once a reserved field, so sanitize it */
--- a/drivers/gpu/drm/i915/i915_gem_gtt.h
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.h
@@ -49,6 +49,8 @@
 #define I915_GTT_PAGE_SIZE I915_GTT_PAGE_SIZE_4K
 #define I915_GTT_MAX_PAGE_SIZE I915_GTT_PAGE_SIZE_2M
 
+#define I915_GTT_PAGE_MASK -I915_GTT_PAGE_SIZE
+
 #define I915_GTT_MIN_ALIGNMENT I915_GTT_PAGE_SIZE
 
 #define I915_FENCE_REG_NONE -1


