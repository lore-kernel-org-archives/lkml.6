Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B7ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBB821528
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KWht7aTR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BBB821528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeJQQxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:53:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36279 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbeJQQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:53:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so12873697pfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 01:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uD+DH1P0SFFdY+Fa3qAgij6eAcAFeaVCmZBUuVfGQX4=;
        b=KWht7aTRlkiKCBtRfVeJNsP4i4VUhahGY5ijojCW63jtUpOs4tO1YQPPfBRq28ztKf
         pwbjKA+NcHMq8buohff8sKTcAm83Kq4FsjvkNQ8NruvsG8+UC9EEZTm1B4i1M1GZzYKV
         /TGgaHI/3co+Gf+NZmGh6yKSrf0Lb5Ptunwso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uD+DH1P0SFFdY+Fa3qAgij6eAcAFeaVCmZBUuVfGQX4=;
        b=a7kYSUbkXi/Ev5Sz4Xd+Nbwn6C+TRIAksg+uhZEtXYlEHQJx+VMxbmzy//ZEMaWIsH
         SHf9ahJvLocuBwi32YMIRzHLOO6Ds27GaxuKMQX9aJ90n4M1ZBvsvMdqFjEXrEoWB2gf
         QN8WZMZVgC0BGLcD/H5SyLEAJO/1ir5IpHXuAw/+Z1LHRyTBhBju2iM77LaknVjBQ8vy
         vsT6YA7VMci5IlO44YRLSsZYh6vBxYP2ZiAvGsx5GZPWL59TeTbxe745pTBWi24fBjlC
         pPz9OrLVJkt4Hdiab1eHCPOKIPlgBl4WRYc/Nd30FS7IrMuTEe28GrG8VIPx5hHe29p8
         VVQA==
X-Gm-Message-State: ABuFfogQUGOTGztErFLpRcc+50gLyY8oqieKhBVBXcwlwng5QiUao9CX
        ImDzBxnstHfNumtjYdjn8bB/
X-Google-Smtp-Source: ACcGV60qBnultztrjkNHwdH05ny71X4T7UVJPkAsnQ7nnm6Q6mWRPLq2U4LFEdHzL+DnQc8fyM1B6g==
X-Received: by 2002:a63:5c1f:: with SMTP id q31-v6mr23803403pgb.452.1539766734448;
        Wed, 17 Oct 2018 01:58:54 -0700 (PDT)
Received: from vovoy-z840.tpe.corp.google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id 84-v6sm28477983pfs.108.2018.10.17.01.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 01:58:53 -0700 (PDT)
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     vovoy@chromium.org
Cc:     akpm@linux-foundation.org, chris@chris-wilson.co.uk,
        corbet@lwn.net, dave.hansen@intel.com, hoegsberg@chromium.org,
        hughd@google.com, intel-gfx@lists.freedesktop.org,
        joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, marcheu@chromium.org, mhocko@suse.com,
        peterz@infradead.org
Subject: [PATCH v2] shmem, drm/i915: mark pinned shmemfs pages as unevictable
Date:   Wed, 17 Oct 2018 16:58:01 +0800
Message-Id: <20181017085801.220742-1-vovoy@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181016174300.197906-1-vovoy@chromium.org>
References: <20181016174300.197906-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i915 driver uses shmemfs to allocate backing storage for gem
objects. These shmemfs pages can be pinned (increased ref count) by
shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
wastes a lot of time scanning these pinned pages. In some extreme case,
all pages in the inactive anon lru are pinned, and only the inactive
anon lru is scanned due to inactive_ratio, the system cannot swap and
invokes the oom-killer. Mark these pinned pages as unevictable to speed
up vmscan.

By exporting shmem_unlock_mapping, drivers can: 1. mark a shmemfs
address space as unevictable with mapping_set_unevictable(), pages in
the address space will be moved to unevictable list in vmscan. 2. mark
an address space as evictable with mapping_clear_unevictable(), and move
these pages back to evictable list with shmem_unlock_mapping().

This patch was inspired by Chris Wilson's change [1].

[1]: https://patchwork.kernel.org/patch/9768741/

Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
---
Changes for v2:
 Squashed the two patches.

 Documentation/vm/unevictable-lru.rst | 4 +++-
 drivers/gpu/drm/i915/i915_gem.c      | 8 ++++++++
 mm/shmem.c                           | 2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/vm/unevictable-lru.rst b/Documentation/vm/unevictable-lru.rst
index fdd84cb8d511..a812fb55136d 100644
--- a/Documentation/vm/unevictable-lru.rst
+++ b/Documentation/vm/unevictable-lru.rst
@@ -143,7 +143,7 @@ using a number of wrapper functions:
 	Query the address space, and return true if it is completely
 	unevictable.
 
-These are currently used in two places in the kernel:
+These are currently used in three places in the kernel:
 
  (1) By ramfs to mark the address spaces of its inodes when they are created,
      and this mark remains for the life of the inode.
@@ -154,6 +154,8 @@ These are currently used in two places in the kernel:
      swapped out; the application must touch the pages manually if it wants to
      ensure they're in memory.
 
+ (3) By the i915 driver to mark pinned address space until it's unpinned.
+
 
 Detecting Unevictable Pages
 ---------------------------
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index fcc73a6ab503..e0ff5b736128 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -2390,6 +2390,7 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
 {
 	struct sgt_iter sgt_iter;
 	struct page *page;
+	struct address_space *mapping;
 
 	__i915_gem_object_release_shmem(obj, pages, true);
 
@@ -2409,6 +2410,10 @@ i915_gem_object_put_pages_gtt(struct drm_i915_gem_object *obj,
 	}
 	obj->mm.dirty = false;
 
+	mapping = file_inode(obj->base.filp)->i_mapping;
+	mapping_clear_unevictable(mapping);
+	shmem_unlock_mapping(mapping);
+
 	sg_free_table(pages);
 	kfree(pages);
 }
@@ -2551,6 +2556,7 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
 	 * Fail silently without starting the shrinker
 	 */
 	mapping = obj->base.filp->f_mapping;
+	mapping_set_unevictable(mapping);
 	noreclaim = mapping_gfp_constraint(mapping, ~__GFP_RECLAIM);
 	noreclaim |= __GFP_NORETRY | __GFP_NOWARN;
 
@@ -2664,6 +2670,8 @@ static int i915_gem_object_get_pages_gtt(struct drm_i915_gem_object *obj)
 err_pages:
 	for_each_sgt_page(page, sgt_iter, st)
 		put_page(page);
+	mapping_clear_unevictable(mapping);
+	shmem_unlock_mapping(mapping);
 	sg_free_table(st);
 	kfree(st);
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 446942677cd4..d1ce34c09df6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -786,6 +786,7 @@ void shmem_unlock_mapping(struct address_space *mapping)
 		cond_resched();
 	}
 }
+EXPORT_SYMBOL_GPL(shmem_unlock_mapping);
 
 /*
  * Remove range of pages and swap entries from radix tree, and free them.
@@ -3874,6 +3875,7 @@ int shmem_lock(struct file *file, int lock, struct user_struct *user)
 void shmem_unlock_mapping(struct address_space *mapping)
 {
 }
+EXPORT_SYMBOL_GPL(shmem_unlock_mapping);
 
 #ifdef CONFIG_MMU
 unsigned long shmem_get_unmapped_area(struct file *file,
-- 
2.19.1.331.ge82ca0e54c-goog

