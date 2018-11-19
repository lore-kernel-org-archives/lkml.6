Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978B2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D99C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ta5ZL/W/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D99C206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732664AbeKTDDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:35838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731712AbeKTDDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:03:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9E79208E4;
        Mon, 19 Nov 2018 16:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645548;
        bh=Y+1pVrf6Z5K1cS6XMUOjM3hGRXZYSvJgeHB+AMZiYq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ta5ZL/W/LjM4w4Xbi8HrG1xkHn8Eq8Exmqxr9LmfCm0Tq4erPoccSysp5gK9BYeyH
         VK72paJK+RWVz1tzaqXUFnlagTNDYzDuEsja6uy9xL0tdaX4R+EpqWue4TC9koHb9S
         a8KiEwqWTtlZ0z/eBQNDfsdq3qPbG7emIoFoJHuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.19 204/205] drm/i915: Fix hpd handling for pins with two encoders
Date:   Mon, 19 Nov 2018 17:28:31 +0100
Message-Id: <20181119162642.910423580@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
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

commit 44a7276b30c3c15f2b7790a5729640597fb6a1df upstream.

In my haste to remove irq_port[] I accidentally changed the
way we deal with hpd pins that are shared by multiple encoders
(DP and HDMI for pre-DDI platforms). Previously we would only
handle such pins via ->hpd_pulse(), but now we queue up the
hotplug work for the HDMI encoder directly. Worse yet, we now
count each hpd twice and this increment the hpd storm count
twice as fast. This can lead to spurious storms being detected.

Go back to the old way of doing things, ie. delegate to
->hpd_pulse() for any pin which has an encoder with that hook
implemented. I don't really like the idea of adding irq_port[]
back so let's loop through the encoders first to check if we
have an encoder with ->hpd_pulse() for the pin, and then go
through all the pins and decided on the correct course of action
based on the earlier findings.

I have occasionally toyed with the idea of unifying the pre-DDI
HDMI and DP encoders into a single encoder as well. Besides the
hotplug processing it would have the other benefit of preventing
userspace from trying to enable both encoders at the same time.
That is simply illegal as they share the same clock/data pins.
We have some testcases that will attempt that and thus fail on
many older machines. But for now let's stick to fixing just the
hotplug code.

Cc: stable@vger.kernel.org # 4.19+
Cc: Lyude Paul <lyude@redhat.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Fixes: b6ca3eee18ba ("drm/i915: Nuke dev_priv->irq_port[]")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181108200424.28371-1-ville.syrjala@linux.intel.com
Reviewed-by: Lyude Paul <lyude@redhat.com>
(cherry picked from commit 5a3aeca97af1b6b3498d59a7fd4e8bb95814c108)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_hotplug.c |   66 ++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -397,37 +397,54 @@ void intel_hpd_irq_handler(struct drm_i9
 	struct intel_encoder *encoder;
 	bool storm_detected = false;
 	bool queue_dig = false, queue_hp = false;
+	u32 long_hpd_pulse_mask = 0;
+	u32 short_hpd_pulse_mask = 0;
+	enum hpd_pin pin;
 
 	if (!pin_mask)
 		return;
 
 	spin_lock(&dev_priv->irq_lock);
+
+	/*
+	 * Determine whether ->hpd_pulse() exists for each pin, and
+	 * whether we have a short or a long pulse. This is needed
+	 * as each pin may have up to two encoders (HDMI and DP) and
+	 * only the one of them (DP) will have ->hpd_pulse().
+	 */
 	for_each_intel_encoder(&dev_priv->drm, encoder) {
-		enum hpd_pin pin = encoder->hpd_pin;
 		bool has_hpd_pulse = intel_encoder_has_hpd_pulse(encoder);
+		enum port port = encoder->port;
+		bool long_hpd;
 
+		pin = encoder->hpd_pin;
 		if (!(BIT(pin) & pin_mask))
 			continue;
 
-		if (has_hpd_pulse) {
-			bool long_hpd = long_mask & BIT(pin);
-			enum port port = encoder->port;
+		if (!has_hpd_pulse)
+			continue;
 
-			DRM_DEBUG_DRIVER("digital hpd port %c - %s\n", port_name(port),
-					 long_hpd ? "long" : "short");
-			/*
-			 * For long HPD pulses we want to have the digital queue happen,
-			 * but we still want HPD storm detection to function.
-			 */
-			queue_dig = true;
-			if (long_hpd) {
-				dev_priv->hotplug.long_port_mask |= (1 << port);
-			} else {
-				/* for short HPD just trigger the digital queue */
-				dev_priv->hotplug.short_port_mask |= (1 << port);
-				continue;
-			}
+		long_hpd = long_mask & BIT(pin);
+
+		DRM_DEBUG_DRIVER("digital hpd port %c - %s\n", port_name(port),
+				 long_hpd ? "long" : "short");
+		queue_dig = true;
+
+		if (long_hpd) {
+			long_hpd_pulse_mask |= BIT(pin);
+			dev_priv->hotplug.long_port_mask |= BIT(port);
+		} else {
+			short_hpd_pulse_mask |= BIT(pin);
+			dev_priv->hotplug.short_port_mask |= BIT(port);
 		}
+	}
+
+	/* Now process each pin just once */
+	for_each_hpd_pin(pin) {
+		bool long_hpd;
+
+		if (!(BIT(pin) & pin_mask))
+			continue;
 
 		if (dev_priv->hotplug.stats[pin].state == HPD_DISABLED) {
 			/*
@@ -444,11 +461,22 @@ void intel_hpd_irq_handler(struct drm_i9
 		if (dev_priv->hotplug.stats[pin].state != HPD_ENABLED)
 			continue;
 
-		if (!has_hpd_pulse) {
+		/*
+		 * Delegate to ->hpd_pulse() if one of the encoders for this
+		 * pin has it, otherwise let the hotplug_work deal with this
+		 * pin directly.
+		 */
+		if (((short_hpd_pulse_mask | long_hpd_pulse_mask) & BIT(pin))) {
+			long_hpd = long_hpd_pulse_mask & BIT(pin);
+		} else {
 			dev_priv->hotplug.event_bits |= BIT(pin);
+			long_hpd = true;
 			queue_hp = true;
 		}
 
+		if (!long_hpd)
+			continue;
+
 		if (intel_hpd_irq_storm_detect(dev_priv, pin)) {
 			dev_priv->hotplug.event_bits &= ~BIT(pin);
 			storm_detected = true;


