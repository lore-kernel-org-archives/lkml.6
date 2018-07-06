Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FCCC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127B520877
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127B520877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933342AbeGFFtC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:49:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60156 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGFFtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:49:00 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E6098BA2;
        Fri,  6 Jul 2018 05:48:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kenneth Graunke <kenneth@whitecape.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.17 40/46] drm/i915: Enable provoking vertex fix on Gen9 systems.
Date:   Fri,  6 Jul 2018 07:47:01 +0200
Message-Id: <20180706054526.495218065@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054524.595521988@linuxfoundation.org>
References: <20180706054524.595521988@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kenneth Graunke <kenneth@whitecape.org>

commit 7a3727f385dc64773db1c144f6b15c1e9d4735bb upstream.

The SF and clipper units mishandle the provoking vertex in some cases,
which can cause misrendering with shaders that use flat shaded inputs.

There are chicken bits in 3D_CHICKEN3 (for SF) and FF_SLICE_CHICKEN
(for the clipper) that work around the issue.  These registers are
unfortunately not part of the logical context (even the power context),
and so we must reload them every time we start executing in a context.

Bugzilla: https://bugs.freedesktop.org/103047
Signed-off-by: Kenneth Graunke <kenneth@whitecape.org>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180615190605.16238-1-chris@chris-wilson.co.uk
Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: stable@vger.kernel.org
(cherry picked from commit b77422f80337d363eed60c8c48db9cb6e33085c9)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h  |    5 +++++
 drivers/gpu/drm/i915/intel_lrc.c |   12 +++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -2565,12 +2565,17 @@ enum i915_power_well_id {
 #define _3D_CHICKEN	_MMIO(0x2084)
 #define  _3D_CHICKEN_HIZ_PLANE_DISABLE_MSAA_4X_SNB	(1 << 10)
 #define _3D_CHICKEN2	_MMIO(0x208c)
+
+#define FF_SLICE_CHICKEN	_MMIO(0x2088)
+#define  FF_SLICE_CHICKEN_CL_PROVOKING_VERTEX_FIX	(1 << 1)
+
 /* Disables pipelining of read flushes past the SF-WIZ interface.
  * Required on all Ironlake steppings according to the B-Spec, but the
  * particular danger of not doing so is not specified.
  */
 # define _3D_CHICKEN2_WM_READ_PIPELINED			(1 << 14)
 #define _3D_CHICKEN3	_MMIO(0x2090)
+#define  _3D_CHICKEN_SF_PROVOKING_VERTEX_FIX		(1 << 12)
 #define  _3D_CHICKEN_SF_DISABLE_OBJEND_CULL		(1 << 10)
 #define  _3D_CHICKEN3_AA_LINE_QUALITY_FIX_ENABLE	(1 << 5)
 #define  _3D_CHICKEN3_SF_DISABLE_FASTCLIP_CULL		(1 << 5)
--- a/drivers/gpu/drm/i915/intel_lrc.c
+++ b/drivers/gpu/drm/i915/intel_lrc.c
@@ -1386,11 +1386,21 @@ static u32 *gen9_init_indirectctx_bb(str
 	/* WaFlushCoherentL3CacheLinesAtContextSwitch:skl,bxt,glk */
 	batch = gen8_emit_flush_coherentl3_wa(engine, batch);
 
+	*batch++ = MI_LOAD_REGISTER_IMM(3);
+
 	/* WaDisableGatherAtSetShaderCommonSlice:skl,bxt,kbl,glk */
-	*batch++ = MI_LOAD_REGISTER_IMM(1);
 	*batch++ = i915_mmio_reg_offset(COMMON_SLICE_CHICKEN2);
 	*batch++ = _MASKED_BIT_DISABLE(
 			GEN9_DISABLE_GATHER_AT_SET_SHADER_COMMON_SLICE);
+
+	/* BSpec: 11391 */
+	*batch++ = i915_mmio_reg_offset(FF_SLICE_CHICKEN);
+	*batch++ = _MASKED_BIT_ENABLE(FF_SLICE_CHICKEN_CL_PROVOKING_VERTEX_FIX);
+
+	/* BSpec: 11299 */
+	*batch++ = i915_mmio_reg_offset(_3D_CHICKEN3);
+	*batch++ = _MASKED_BIT_ENABLE(_3D_CHICKEN_SF_PROVOKING_VERTEX_FIX);
+
 	*batch++ = MI_NOOP;
 
 	/* WaClearSlmSpaceAtContextSwitch:kbl */


