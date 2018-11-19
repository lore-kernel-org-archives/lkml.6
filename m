Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12DBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBBB214C4
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfYufWQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFBBB214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbeKTDKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:46402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388013AbeKTDKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:10:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA672214C4;
        Mon, 19 Nov 2018 16:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645995;
        bh=4vmFF3PhL7RLOoV6fEM4MBJqlX/jeD4vEx60K01Xq9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dfYufWQV3Fv455zc9j2srEWM28Kf7EowEm6UqabHBYdXrq31Ri7G/axxRFNpCaQf0
         mzp7dgPXkiCIDlFVjZffkcHoSzHUpTppb2ILDIAYkdDtF1q9B5eb3Ow/EHRTBBJN2R
         58nGXm1ebj+w7iRkTmnLbUUyGJR6Z0YXlIFHV5Dc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.18 168/171] drm/i915/ringbuffer: Delay after EMIT_INVALIDATE for gen4/gen5
Date:   Mon, 19 Nov 2018 17:29:24 +0100
Message-Id: <20181119162641.154691055@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162618.909354448@linuxfoundation.org>
References: <20181119162618.909354448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>

commit fb5bbae9b1333d44023713946fdd28db0cd85751 upstream.

Exercising the gpu reloc path strenuously revealed an issue where the
updated relocations (from MI_STORE_DWORD_IMM) were not being observed
upon execution. After some experiments with adding pipecontrols (a lot
of pipecontrols (32) as gen4/5 do not have a bit to wait on earlier pipe
controls or even the current on), it was discovered that we merely
needed to delay the EMIT_INVALIDATE by several flushes. It is important
to note that it is the EMIT_INVALIDATE as opposed to the EMIT_FLUSH that
needs the delay as opposed to what one might first expect -- that the
delay is required for the TLB invalidation to take effect (one presumes
to purge any CS buffers) as opposed to a delay after flushing to ensure
the writes have landed before triggering invalidation.

Testcase: igt/gem_tiled_fence_blits
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: stable@vger.kernel.org
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181105094305.5767-1-chris@chris-wilson.co.uk
(cherry picked from commit 55f99bf2a9c331838c981694bc872cd1ec4070b2)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_ringbuffer.c |   38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_ringbuffer.c
+++ b/drivers/gpu/drm/i915/intel_ringbuffer.c
@@ -91,6 +91,7 @@ static int
 gen4_render_ring_flush(struct i915_request *rq, u32 mode)
 {
 	u32 cmd, *cs;
+	int i;
 
 	/*
 	 * read/write caches:
@@ -127,12 +128,45 @@ gen4_render_ring_flush(struct i915_reque
 			cmd |= MI_INVALIDATE_ISP;
 	}
 
-	cs = intel_ring_begin(rq, 2);
+	i = 2;
+	if (mode & EMIT_INVALIDATE)
+		i += 20;
+
+	cs = intel_ring_begin(rq, i);
 	if (IS_ERR(cs))
 		return PTR_ERR(cs);
 
 	*cs++ = cmd;
-	*cs++ = MI_NOOP;
+
+	/*
+	 * A random delay to let the CS invalidate take effect? Without this
+	 * delay, the GPU relocation path fails as the CS does not see
+	 * the updated contents. Just as important, if we apply the flushes
+	 * to the EMIT_FLUSH branch (i.e. immediately after the relocation
+	 * write and before the invalidate on the next batch), the relocations
+	 * still fail. This implies that is a delay following invalidation
+	 * that is required to reset the caches as opposed to a delay to
+	 * ensure the memory is written.
+	 */
+	if (mode & EMIT_INVALIDATE) {
+		*cs++ = GFX_OP_PIPE_CONTROL(4) | PIPE_CONTROL_QW_WRITE;
+		*cs++ = i915_ggtt_offset(rq->engine->scratch) |
+			PIPE_CONTROL_GLOBAL_GTT;
+		*cs++ = 0;
+		*cs++ = 0;
+
+		for (i = 0; i < 12; i++)
+			*cs++ = MI_FLUSH;
+
+		*cs++ = GFX_OP_PIPE_CONTROL(4) | PIPE_CONTROL_QW_WRITE;
+		*cs++ = i915_ggtt_offset(rq->engine->scratch) |
+			PIPE_CONTROL_GLOBAL_GTT;
+		*cs++ = 0;
+		*cs++ = 0;
+	}
+
+	*cs++ = cmd;
+
 	intel_ring_advance(rq, cs);
 
 	return 0;


