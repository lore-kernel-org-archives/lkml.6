Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16746C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D311720851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+WKv+Kv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D311720851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbeKTDQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:16:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbeKTDQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:16:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01EF8208E3;
        Mon, 19 Nov 2018 16:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646323;
        bh=EX+MYJ570fFAxuX2q0W4O6oFwisbYv0WkVNQFh4/9Sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+WKv+KvWr+73+Cv/ZoryyQLxvLsovYxISWLD7X3MSQAg7YJXwV/lMnjRWPcVDTEX
         o7dcujd9O/Fe4Ty7uHFkOcSM4HsvU97o6ShvIDOj3h58j91z57twbRIoPmKzqCbycq
         mHscEAHIA22QsbLbJHfp817hBRhIU/kZyi0IivcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.14 115/124] drm/i915: Large page offsets for pread/pwrite
Date:   Mon, 19 Nov 2018 17:29:29 +0100
Message-Id: <20181119162633.213709771@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
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

commit ab0d6a141843e0b4b2709dfd37b53468b5452c3a upstream.

Handle integer overflow when computing the sub-page length for shmem
backed pread/pwrite.

Reported-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181012140228.29783-1-chris@chris-wilson.co.uk
(cherry picked from commit a5e856a5348f6cd50889d125c40bbeec7328e466)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem.c |   12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -980,11 +980,7 @@ i915_gem_shmem_pread(struct drm_i915_gem
 	offset = offset_in_page(args->offset);
 	for (idx = args->offset >> PAGE_SHIFT; remain; idx++) {
 		struct page *page = i915_gem_object_get_page(obj, idx);
-		int length;
-
-		length = remain;
-		if (offset + length > PAGE_SIZE)
-			length = PAGE_SIZE - offset;
+		unsigned int length = min_t(u64, remain, PAGE_SIZE - offset);
 
 		ret = shmem_pread(page, offset, length, user_data,
 				  page_to_phys(page) & obj_do_bit17_swizzling,
@@ -1406,11 +1402,7 @@ i915_gem_shmem_pwrite(struct drm_i915_ge
 	offset = offset_in_page(args->offset);
 	for (idx = args->offset >> PAGE_SHIFT; remain; idx++) {
 		struct page *page = i915_gem_object_get_page(obj, idx);
-		int length;
-
-		length = remain;
-		if (offset + length > PAGE_SIZE)
-			length = PAGE_SIZE - offset;
+		unsigned int length = min_t(u64, remain, PAGE_SIZE - offset);
 
 		ret = shmem_pwrite(page, offset, length, user_data,
 				   page_to_phys(page) & obj_do_bit17_swizzling,


