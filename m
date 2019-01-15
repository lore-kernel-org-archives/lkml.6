Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E023A20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570555;
	bh=AYoKv2imIETP4hiBKlUJtNeWvnN4ESogpUnU6X+1Fjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ekzmFaVyYYzKkKQZ6JtH9+194b2pDYLtqtRiS3/LdjIER0VNZePaXoLOkNVUGzE0x
	 pMu40vEZFa0XHWRRuszQX8MlHVGyIOhcL1JDoDBZuZRrupGz49+kimgHztzZv4AoL2
	 EzT+vuCA6TQcpLq5ivrHZfL7gEE9hT3PNxBouhMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfAOQmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbfAOQmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:42:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4FE20859;
        Tue, 15 Jan 2019 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570551;
        bh=AYoKv2imIETP4hiBKlUJtNeWvnN4ESogpUnU6X+1Fjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/pANAmkuiXNjcaKaySrff2JLBh82LLUOAjJ7niXnSvWbZ/SteUvVuU1Ie/QDy+Iw
         fSpOenY2ufQtwKk3dFDlwnfmbay137Ai+oLD4nIo3pS+b7fNnrbJ4hDNqdZbJEeutW
         RUAr+kCxB98VyHhHiw4YG7AeDJZVO7bYGAcx5OK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        Matthew Auld <matthew.william.auld@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.19 34/50] drm/i915: Unwind failure on pinning the gen7 ppgtt
Date:   Tue, 15 Jan 2019 17:36:10 +0100
Message-Id: <20190115154911.875422123@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154909.933241945@linuxfoundation.org>
References: <20190115154909.933241945@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit 280d479b310298dfeb1d6f9a1617eca37beb6ce4 upstream.

If we fail to pin the ggtt vma slot for the ppgtt page tables, we need
to unwind the locals before reporting the error. Or else on subsequent
attempts to bind the page tables into the ggtt, we will already believe
that the vma has been pinned and continue on blithely. If something else
should happen to be at that location, choas ensues.

Fixes: a2bbf7148342 ("drm/i915/gtt: Only keep gen6 page directories pinned while active")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Matthew Auld <matthew.william.auld@gmail.com>
Cc: <stable@vger.kernel.org> # v4.19+
Reviewed-by: Matthew Auld <matthew.william.auld@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181222030623.21710-1-chris@chris-wilson.co.uk
(cherry picked from commit d4de753526f4d99f541f1b6ed1d963005c09700c)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_gem_gtt.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem_gtt.c
+++ b/drivers/gpu/drm/i915/i915_gem_gtt.c
@@ -2128,6 +2128,7 @@ static struct i915_vma *pd_vma_create(st
 int gen6_ppgtt_pin(struct i915_hw_ppgtt *base)
 {
 	struct gen6_hw_ppgtt *ppgtt = to_gen6_ppgtt(base);
+	int err;
 
 	/*
 	 * Workaround the limited maximum vma->pin_count and the aliasing_ppgtt
@@ -2143,9 +2144,17 @@ int gen6_ppgtt_pin(struct i915_hw_ppgtt
 	 * allocator works in address space sizes, so it's multiplied by page
 	 * size. We allocate at the top of the GTT to avoid fragmentation.
 	 */
-	return i915_vma_pin(ppgtt->vma,
-			    0, GEN6_PD_ALIGN,
-			    PIN_GLOBAL | PIN_HIGH);
+	err = i915_vma_pin(ppgtt->vma,
+			   0, GEN6_PD_ALIGN,
+			   PIN_GLOBAL | PIN_HIGH);
+	if (err)
+		goto unpin;
+
+	return 0;
+
+unpin:
+	ppgtt->pin_count = 0;
+	return err;
 }
 
 void gen6_ppgtt_unpin(struct i915_hw_ppgtt *base)


