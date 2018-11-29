Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF27921479
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="O28+w70M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF27921479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbeK3Bf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbeK3Bf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:35:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 957752145D;
        Thu, 29 Nov 2018 14:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501796;
        bh=BKBUAREijECTQyRnWI54gMvCzRGZSXjsw/sT6noM+AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O28+w70Mpsh5av7NrViVGG3M1Yt5azWevrj+JfzADaW9Uhd/LpOeEtpecKjT4GCGz
         glF+uD8RhJYg05slrQpivfA8whdUvj+ZEmc6PJ5hH5TTTZtmtEUsfZNHNu3kgBsa+c
         ZCL+B60wy9/ZNPyz1V5/oqnn4DBgBVQw+WJ0bcG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 044/110] drm/i915: Disable LP3 watermarks on all SNB machines
Date:   Thu, 29 Nov 2018 15:12:15 +0100
Message-Id: <20181129135923.048859299@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129135921.231283053@linuxfoundation.org>
References: <20181129135921.231283053@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 21556350ade3cb5d7afecc8b3544e56431d21695 upstream.

I have a Thinkpad X220 Tablet in my hands that is losing vblank
interrupts whenever LP3 watermarks are used.

If I nudge the latency value written to the WM3 register just
by one in either direction the problem disappears. That to me
suggests that the punit will not enter the corrsponding
powersave mode (MPLL shutdown IIRC) unless the latency value
in the register matches exactly what we read from SSKPD. Ie.
it's not really a latency value but rather just a cookie
by which the punit can identify the desired power saving state.
On HSW/BDW this was changed such that we actually just write
the WM level number into those bits, which makes much more
sense given the observed behaviour.

We could try to handle this by disallowing LP3 watermarks
only when vblank interrupts are enabled but we'd first have
to prove that only vblank interrupts are affected, which
seems unlikely. Also we can't grab the wm mutex from the
vblank enable/disable hooks because those are called with
various spinlocks held. Thus we'd have to redesigne the
watermark locking. So to play it safe and keep the code
simple we simply disable LP3 watermarks on all SNB machines.

To do that we simply zero out the latency values for
watermark level 3, and we adjust the watermark computation
to check for that. The behaviour now matches that of the
g4x/vlv/skl wm code in the presence of a zeroed latency
value.

v2: s/USHRT_MAX/U32_MAX/ for consistency with the types (Chris)

Cc: stable@vger.kernel.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=101269
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103713
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181114173440.6730-1-ville.syrjala@linux.intel.com
(cherry picked from commit 03981c6ebec4fc7056b9b45f847393aeac90d060)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_pm.c |   41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -2492,6 +2492,9 @@ static uint32_t ilk_compute_pri_wm(const
 	uint32_t method1, method2;
 	int cpp;
 
+	if (mem_value == 0)
+		return U32_MAX;
+
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
@@ -2521,6 +2524,9 @@ static uint32_t ilk_compute_spr_wm(const
 	uint32_t method1, method2;
 	int cpp;
 
+	if (mem_value == 0)
+		return U32_MAX;
+
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
@@ -2544,6 +2550,9 @@ static uint32_t ilk_compute_cur_wm(const
 {
 	int cpp;
 
+	if (mem_value == 0)
+		return U32_MAX;
+
 	if (!intel_wm_plane_visible(cstate, pstate))
 		return 0;
 
@@ -2998,6 +3007,34 @@ static void snb_wm_latency_quirk(struct
 	intel_print_wm_latency(dev_priv, "Cursor", dev_priv->wm.cur_latency);
 }
 
+static void snb_wm_lp3_irq_quirk(struct drm_i915_private *dev_priv)
+{
+	/*
+	 * On some SNB machines (Thinkpad X220 Tablet at least)
+	 * LP3 usage can cause vblank interrupts to be lost.
+	 * The DEIIR bit will go high but it looks like the CPU
+	 * never gets interrupted.
+	 *
+	 * It's not clear whether other interrupt source could
+	 * be affected or if this is somehow limited to vblank
+	 * interrupts only. To play it safe we disable LP3
+	 * watermarks entirely.
+	 */
+	if (dev_priv->wm.pri_latency[3] == 0 &&
+	    dev_priv->wm.spr_latency[3] == 0 &&
+	    dev_priv->wm.cur_latency[3] == 0)
+		return;
+
+	dev_priv->wm.pri_latency[3] = 0;
+	dev_priv->wm.spr_latency[3] = 0;
+	dev_priv->wm.cur_latency[3] = 0;
+
+	DRM_DEBUG_KMS("LP3 watermarks disabled due to potential for lost interrupts\n");
+	intel_print_wm_latency(dev_priv, "Primary", dev_priv->wm.pri_latency);
+	intel_print_wm_latency(dev_priv, "Sprite", dev_priv->wm.spr_latency);
+	intel_print_wm_latency(dev_priv, "Cursor", dev_priv->wm.cur_latency);
+}
+
 static void ilk_setup_wm_latency(struct drm_i915_private *dev_priv)
 {
 	intel_read_wm_latency(dev_priv, dev_priv->wm.pri_latency);
@@ -3014,8 +3051,10 @@ static void ilk_setup_wm_latency(struct
 	intel_print_wm_latency(dev_priv, "Sprite", dev_priv->wm.spr_latency);
 	intel_print_wm_latency(dev_priv, "Cursor", dev_priv->wm.cur_latency);
 
-	if (IS_GEN6(dev_priv))
+	if (IS_GEN6(dev_priv)) {
 		snb_wm_latency_quirk(dev_priv);
+		snb_wm_lp3_irq_quirk(dev_priv);
+	}
 }
 
 static void skl_setup_wm_latency(struct drm_i915_private *dev_priv)


