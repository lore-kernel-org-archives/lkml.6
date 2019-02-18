Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D412C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B3B21916
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498216;
	bh=ntYefK9ARmAhYbTXMksCfI1UGCm12Snrj/FV6pd278k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uZbc5u7kEF2WB4xxdkMG+o1j4Hfbg+DYU0DxTk2UnNK0WD2vZ4ioJbOmHRqMZgdDI
	 /PUFNiYGKynwFboKMv+8YuLB6el5EPDBLeZPBgr8+7bxMoZQpfVyMlIMaDwjS2tF+O
	 t9pXXrcU/sHrmFMNMM57bP7cxOGK4n6Odnm6Zghs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387932AbfBRN4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387912AbfBRN4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:56:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A3B2217D9;
        Mon, 18 Feb 2019 13:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498210;
        bh=ntYefK9ARmAhYbTXMksCfI1UGCm12Snrj/FV6pd278k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ObVKVyAJvtOwhj4M4Q+3Z/6dOiJ/v29Y0u6k1V2AT7ZoZmFzJ+UAYwTL5WhGrhibF
         EPGagwTebCjBRKM+lEsvbwRtivTUxKJ8dA6qQ7uo7/hpM/ru6Qh2F5TkHfoH5/DBHc
         mom313LHbD+zJlAMzA5OgF2pN1KtqSrlRlASq4AE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Zabrocki <adamza@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Akash Goel <akash.goel@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 4.14 59/62] drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set
Date:   Mon, 18 Feb 2019 14:44:05 +0100
Message-Id: <20190218133510.823296615@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133505.801423074@linuxfoundation.org>
References: <20190218133505.801423074@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

commit 2e7bd10e05afb866b5fb13eda25095c35d7a27cc upstream.

Make sure the underlying VMA in the process address space is the
same as it was during vm_mmap to avoid applying WC to wrong VMA.

A more long-term solution would be to have vm_mmap_locked variant
in linux/mmap.h for when caller wants to hold mmap_sem for an
extended duration.

v2:
- Refactor the compare function

Fixes: 1816f9236303 ("drm/i915: Support creation of unbound wc user mappings for objects")
Reported-by: Adam Zabrocki <adamza@microsoft.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: <stable@vger.kernel.org> # v4.0+
Cc: Akash Goel <akash.goel@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc: Adam Zabrocki <adamza@microsoft.com>
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com> #v1
Link: https://patchwork.freedesktop.org/patch/msgid/20190207085454.10598-1-joonas.lahtinen@linux.intel.com
(cherry picked from commit 5c4604e757ba9b193b09768d75a7d2105a5b883f)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1633,6 +1633,16 @@ i915_gem_sw_finish_ioctl(struct drm_devi
 	return 0;
 }
 
+static inline bool
+__vma_matches(struct vm_area_struct *vma, struct file *filp,
+	      unsigned long addr, unsigned long size)
+{
+	if (vma->vm_file != filp)
+		return false;
+
+	return vma->vm_start == addr && (vma->vm_end - vma->vm_start) == size;
+}
+
 /**
  * i915_gem_mmap_ioctl - Maps the contents of an object, returning the address
  *			 it is mapped to.
@@ -1691,7 +1701,7 @@ i915_gem_mmap_ioctl(struct drm_device *d
 			return -EINTR;
 		}
 		vma = find_vma(mm, addr);
-		if (vma)
+		if (vma && __vma_matches(vma, obj->base.filp, addr, args->size))
 			vma->vm_page_prot =
 				pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
 		else


