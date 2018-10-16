Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF3920645
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VZZhVILC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFF3920645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJQBfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:35:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45577 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbeJQBfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:35:53 -0400
Received: by mail-lf1-f68.google.com with SMTP id v22-v6so5847668lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 10:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzoh24FV/7+GlpJwWqjLaXQi/cwzbPAc9pGvjk3V9fU=;
        b=VZZhVILCqYnAIQ0Py1aB7+7AmPOkaeE42RVE8Jhj5JjdVWhdRtXT5WK3yofvwHmQVn
         PGP0OpMO7hf88Xvqbfs4AHKY8iJ2C67Wy3FUjpwdP8boe7g6qsahf16u9vpsP4Wzskb2
         eD+ckhpDdC0AbactZRmfpNBMf2wOQArMz1fbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzoh24FV/7+GlpJwWqjLaXQi/cwzbPAc9pGvjk3V9fU=;
        b=N9pZTHueF1RjZaQ40BMNQZ6zLc8X0ZoErmCUWduJ6ocv99XF+p/+jB8cnOfZWIPmnp
         w536+HWqApf7L30hHGzfB81JNtTKoS22pEHZYPz9vFjsMtkJPccAINlyjv/uiijJj11W
         E/WHaKMoEvUSZJqa54L04SZVn/27Dl/J7F8H3JIiblRnzriNw3TFc2lR3Cjlugp9pXX+
         KdhDm8qV9qy7ch+senX8JvHQQWahFabkI00bNpXdQ0K50pbHGiUFnXOSCoRYXN0ltLix
         UL7V55PtCk3znThE6ujkna/W6viy45WI6QC/xM4dTmUtsxkWOHHtlxODWb3z15PHX/Dt
         QBEQ==
X-Gm-Message-State: ABuFfogMiDczUFyiCzJ+Bw/herYi9UvlUsN+Xj0NRe95Xc/i8CtZ3S7b
        vVyZy70uCwGNl60O04VTM9SkBx00+Fj6
X-Google-Smtp-Source: ACcGV62NYrZwT28IR8MFmwZZbGFLRCdcvOqrPlbCNvCo/CrBJwnz8ZmnbPe9xxOhhusMsEOHtDlhMQ==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr1747685lfk.151.1539711859597;
        Tue, 16 Oct 2018 10:44:19 -0700 (PDT)
Received: from vovoy-z840.tpe.corp.google.com ([2401:fa00:1:b:d89e:cfa6:3c8:e61b])
        by smtp.gmail.com with ESMTPSA id r4-v6sm3358752ljg.12.2018.10.16.10.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 10:44:19 -0700 (PDT)
From:   Kuo-Hsin Yang <vovoy@chromium.org>
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     mhocko@suse.com, akpm@linux-foundation.org,
        chris@chris-wilson.co.uk, peterz@infradead.org,
        dave.hansen@intel.com, corbet@lwn.net, hughd@google.com,
        joonas.lahtinen@linux.intel.com, marcheu@chromium.org,
        hoegsberg@chromium.org, Kuo-Hsin Yang <vovoy@chromium.org>
Subject: [PATCH 2/2] drm/i915: Mark pinned shmemfs pages as unevictable
Date:   Wed, 17 Oct 2018 01:43:00 +0800
Message-Id: <20181016174300.197906-3-vovoy@chromium.org>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
In-Reply-To: <20181016174300.197906-1-vovoy@chromium.org>
References: <20181016174300.197906-1-vovoy@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i915 driver use shmemfs to allocate backing storage for gem objects.
These shmemfs pages can be pinned (increased ref count) by
shmem_read_mapping_page_gfp(). When a lot of pages are pinned, vmscan
wastes a lot of time scanning these pinned pages. Mark these pinned
pages as unevictable to speed up vmscan.

Signed-off-by: Kuo-Hsin Yang <vovoy@chromium.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
 
-- 
2.19.1.331.ge82ca0e54c-goog

