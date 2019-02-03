Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91FDC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF449218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfBCN44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:56:56 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53940 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727930AbfBCNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:50:03 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9q-0003tr-2L; Sun, 03 Feb 2019 13:50:02 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9i-0007EY-Nf; Sun, 03 Feb 2019 14:49:54 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=" 
        <ville.syrjala@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Chris Wilson" <chris@chris-wilson.co.uk>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.895934488@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 212/305] drm/i915: Disable LP3 watermarks on all SNB
 machines
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

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

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Acked-by: Chris Wilson <chris@chris-wilson.co.uk>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=101269
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=103713
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181114173440.6730-1-ville.syrjala@linux.intel.com
(cherry picked from commit 03981c6ebec4fc7056b9b45f847393aeac90d060)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[bwh: Backported to 3.16:
 - Pass drm_device pointer, rather than drm_i915_private pointer, to
   snb_wm_lp3_irq_quirk() and intel_print_wm_latency()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/i915/intel_pm.c | 41 ++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -1749,6 +1749,9 @@ static uint32_t ilk_compute_pri_wm(const
 {
 	uint32_t method1, method2;
 
+	if (mem_value == 0)
+		return U32_MAX;
+
 	if (!params->active || !params->pri.enabled)
 		return 0;
 
@@ -1777,6 +1780,9 @@ static uint32_t ilk_compute_spr_wm(const
 {
 	uint32_t method1, method2;
 
+	if (mem_value == 0)
+		return U32_MAX;
+
 	if (!params->active || !params->spr.enabled)
 		return 0;
 
@@ -1798,6 +1804,9 @@ static uint32_t ilk_compute_spr_wm(const
 static uint32_t ilk_compute_cur_wm(const struct ilk_pipe_wm_parameters *params,
 				   uint32_t mem_value)
 {
+	if (mem_value == 0)
+		return U32_MAX;
+
 	if (!params->active || !params->cur.enabled)
 		return 0;
 
@@ -2149,6 +2158,36 @@ static void snb_wm_latency_quirk(struct
 	intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_latency);
 }
 
+static void snb_wm_lp3_irq_quirk(struct drm_device *dev)
+{
+	struct drm_i915_private *dev_priv = dev->dev_private;
+
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
+	intel_print_wm_latency(dev, "Primary", dev_priv->wm.pri_latency);
+	intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_latency);
+	intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_latency);
+}
+
 static void ilk_setup_wm_latency(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
@@ -2167,8 +2206,10 @@ static void ilk_setup_wm_latency(struct
 	intel_print_wm_latency(dev, "Sprite", dev_priv->wm.spr_latency);
 	intel_print_wm_latency(dev, "Cursor", dev_priv->wm.cur_latency);
 
-	if (IS_GEN6(dev))
+	if (IS_GEN6(dev)) {
 		snb_wm_latency_quirk(dev);
+		snb_wm_lp3_irq_quirk(dev);
+	}
 }
 
 static void ilk_compute_wm_parameters(struct drm_crtc *crtc,

