Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D4C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57A1B206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A1B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbeJBURr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:17:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbeJBURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:17:46 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44F81BF0;
        Tue,  2 Oct 2018 13:34:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.14 110/137] drm/i915: Remove vma from object on destroy, not close
Date:   Tue,  2 Oct 2018 06:25:11 -0700
Message-Id: <20181002132506.221912813@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132458.446916963@linuxfoundation.org>
References: <20181002132458.446916963@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 010e3e68cd9cb65ea50c0af605e966cda333cb2a upstream.

Originally we translated from the object to the vma by walking
obj->vma_list to find the matching vm (for user lookups). Now we process
user lookups using the rbtree, and we only use obj->vma_list itself for
maintaining state (e.g. ensuring that all vma are flushed or rebound).
As such maintenance needs to go on beyond the user's awareness of the
vma, defer removal of the vma from the obj->vma_list from i915_vma_close()
to i915_vma_destroy()

Fixes: 5888fc9eac3c ("drm/i915: Flush pending GTT writes before unbinding")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=104155
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171206124914.19960-1-chris@chris-wilson.co.uk
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem.c |    3 ++-
 drivers/gpu/drm/i915/i915_vma.c |    4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -3608,7 +3608,8 @@ restart:
 			return -EBUSY;
 		}
 
-		if (i915_gem_valid_gtt_space(vma, cache_level))
+		if (!i915_vma_is_closed(vma) &&
+		    i915_gem_valid_gtt_space(vma, cache_level))
 			continue;
 
 		ret = i915_vma_unbind(vma);
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -430,6 +430,7 @@ i915_vma_insert(struct i915_vma *vma, u6
 	u64 start, end;
 	int ret;
 
+	GEM_BUG_ON(i915_vma_is_closed(vma));
 	GEM_BUG_ON(vma->flags & (I915_VMA_GLOBAL_BIND | I915_VMA_LOCAL_BIND));
 	GEM_BUG_ON(drm_mm_node_allocated(&vma->node));
 
@@ -590,7 +591,9 @@ static void i915_vma_destroy(struct i915
 		GEM_BUG_ON(i915_gem_active_isset(&vma->last_read[i]));
 	GEM_BUG_ON(i915_gem_active_isset(&vma->last_fence));
 
+	list_del(&vma->obj_link);
 	list_del(&vma->vm_link);
+
 	if (!i915_vma_is_ggtt(vma))
 		i915_ppgtt_put(i915_vm_to_ppgtt(vma->vm));
 
@@ -602,7 +605,6 @@ void i915_vma_close(struct i915_vma *vma
 	GEM_BUG_ON(i915_vma_is_closed(vma));
 	vma->flags |= I915_VMA_CLOSED;
 
-	list_del(&vma->obj_link);
 	rb_erase(&vma->obj_node, &vma->obj->vma_tree);
 
 	if (!i915_vma_is_active(vma) && !i915_vma_is_pinned(vma))


