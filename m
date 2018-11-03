Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6FC65C22
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6552081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 00:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6552081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeKCJ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 05:28:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbeKCJ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 05:28:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E9E0394D20;
        Sat,  3 Nov 2018 00:19:23 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968D15D9CD;
        Sat,  3 Nov 2018 00:19:22 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] drm/i915: Add short HPD IRQ storm detection for non-MST systems
Date:   Fri,  2 Nov 2018 20:19:08 -0400
Message-Id: <20181103001909.23645-6-lyude@redhat.com>
In-Reply-To: <20181103001909.23645-1-lyude@redhat.com>
References: <20181103001909.23645-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Sat, 03 Nov 2018 00:19:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfortunately, it seems that the HPD IRQ storm problem from the early
days of Intel GPUs was never entirely solved, only mostly. Within the
last couple of days, I got a bug report from one of our customers who
had been having issues with their machine suddenly booting up very
slowly after having updated. The amount of time it took to boot went
from around 30 seconds, to over 6 minutes consistently.

After some investigation, I discovered that i915 was reporting massive
amounts of short HPD IRQ spam on this system from the DisplayPort port,
despite there not being anything actually connected. The symptoms would
start with one "long" HPD IRQ being detected at boot:

[    1.891398] [drm:intel_get_hpd_pins [i915]] hotplug event received, stat 0x00440000, dig 0x00440000, pins 0x000000a0
[    1.891436] [drm:intel_hpd_irq_handler [i915]] digital hpd port B - long
[    1.891472] [drm:intel_hpd_irq_handler [i915]] Received HPD interrupt on PIN 5 - cnt: 0
[    1.891508] [drm:intel_hpd_irq_handler [i915]] digital hpd port D - long
[    1.891544] [drm:intel_hpd_irq_handler [i915]] Received HPD interrupt on PIN 7 - cnt: 0
[    1.891592] [drm:intel_dp_hpd_pulse [i915]] got hpd irq on port B - long
[    1.891628] [drm:intel_dp_hpd_pulse [i915]] got hpd irq on port D - long
…

followed by constant short IRQs afterwards:

[    1.895091] [drm:intel_encoder_hotplug [i915]] [CONNECTOR:66:DP-1] status updated from unknown to disconnected
[    1.895129] [drm:i915_hotplug_work_func [i915]] Connector DP-3 (pin 7) received hotplug event.
[    1.895165] [drm:intel_dp_detect [i915]] [CONNECTOR:72:DP-3]
[    1.895275] [drm:intel_get_hpd_pins [i915]] hotplug event received, stat 0x00200000, dig 0x00200000, pins 0x00000080
[    1.895312] [drm:intel_hpd_irq_handler [i915]] digital hpd port D - short
[    1.895762] [drm:intel_get_hpd_pins [i915]] hotplug event received, stat 0x00200000, dig 0x00200000, pins 0x00000080
[    1.895799] [drm:intel_hpd_irq_handler [i915]] digital hpd port D - short
[    1.896239] [drm:intel_dp_aux_xfer [i915]] dp_aux_ch timeout status 0x71450085
[    1.896293] [drm:intel_get_hpd_pins [i915]] hotplug event received, stat 0x00200000, dig 0x00200000, pins 0x00000080
[    1.896330] [drm:intel_hpd_irq_handler [i915]] digital hpd port D - short
[    1.896781] [drm:intel_get_hpd_pins [i915]] hotplug event received, stat 0x00200000, dig 0x00200000, pins 0x00000080
[    1.896817] [drm:intel_hpd_irq_handler [i915]] digital hpd port D - short
[    1.897275] [drm:intel_get_hpd_pins [i915]] hotplug event received, stat 0x00200000, dig 0x00200000, pins 0x00000080

The customer's system in question has a GM45 GPU, which is apparently
well known for hotplugging storms.

So, workaround this impressively broken hardware by changing the default
HPD storm threshold from 5 to 50. Then, make long IRQs count for 10, and
short IRQs count for 1. This makes it so that 5 long IRQs will trigger
an HPD storm, and on systems with short HPD storm detection 50 short
IRQs will trigger an HPD storm. 50 short IRQs amounts to 100ms of
constant pulsing, which seems like a good middleground between being too
sensitive and not being sensitive enough (which would cause visible
stutters in userspace every time a storm occurs).

And just to be extra safe: we don't enable this by default on systems
with MST support. There's too high of a chance of MST support triggering
storm detection, and systems that are new enough to support MST are a
lot less likely to have issues with IRQ storms anyway.

As a note: this patch was tested using a ThinkPad T450s and a Chamelium
to simulate the short IRQ storms.

Changes since v1:
- Don't use two separate thresholds, just make long IRQs count for 10
  each and short IRQs count for 1. This simplifies the code a bit
  - Ville Syrjälä
Changes since v2:
- Document @long_hpd in intel_hpd_irq_storm_detect, no functional
  changes

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c  | 74 ++++++++++++++++++++++++++++
 drivers/gpu/drm/i915/i915_drv.h      |  5 +-
 drivers/gpu/drm/i915/i915_irq.c      |  7 +++
 drivers/gpu/drm/i915/intel_hotplug.c | 49 ++++++++++--------
 4 files changed, 114 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 1a4d9d996fda..b9d6e1be6052 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -4658,6 +4658,79 @@ static const struct file_operations i915_hpd_storm_ctl_fops = {
 	.write = i915_hpd_storm_ctl_write
 };
 
+static int i915_hpd_short_storm_ctl_show(struct seq_file *m, void *data)
+{
+	struct drm_i915_private *dev_priv = m->private;
+
+	seq_printf(m, "Enabled: %s\n",
+		   yesno(dev_priv->hotplug.hpd_short_storm_enabled));
+
+	return 0;
+}
+
+static int
+i915_hpd_short_storm_ctl_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, i915_hpd_short_storm_ctl_show,
+			   inode->i_private);
+}
+
+static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
+					      const char __user *ubuf,
+					      size_t len, loff_t *offp)
+{
+	struct seq_file *m = file->private_data;
+	struct drm_i915_private *dev_priv = m->private;
+	struct i915_hotplug *hotplug = &dev_priv->hotplug;
+	char *newline;
+	char tmp[16];
+	int i;
+	bool new_state;
+
+	if (len >= sizeof(tmp))
+		return -EINVAL;
+
+	if (copy_from_user(tmp, ubuf, len))
+		return -EFAULT;
+
+	tmp[len] = '\0';
+
+	/* Strip newline, if any */
+	newline = strchr(tmp, '\n');
+	if (newline)
+		*newline = '\0';
+
+	/* Reset to the "default" state for this system */
+	if (strcmp(tmp, "reset") == 0)
+		new_state = !HAS_DP_MST(dev_priv);
+	else if (kstrtobool(tmp, &new_state) != 0)
+		return -EINVAL;
+
+	DRM_DEBUG_KMS("%sabling HPD short storm detection\n",
+		      new_state ? "En" : "Dis");
+
+	spin_lock_irq(&dev_priv->irq_lock);
+	hotplug->hpd_short_storm_enabled = new_state;
+	/* Reset the HPD storm stats so we don't accidentally trigger a storm */
+	for_each_hpd_pin(i)
+		hotplug->stats[i].count = 0;
+	spin_unlock_irq(&dev_priv->irq_lock);
+
+	/* Re-enable hpd immediately if we were in an irq storm */
+	flush_delayed_work(&dev_priv->hotplug.reenable_work);
+
+	return len;
+}
+
+static const struct file_operations i915_hpd_short_storm_ctl_fops = {
+	.owner = THIS_MODULE,
+	.open = i915_hpd_short_storm_ctl_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.write = i915_hpd_short_storm_ctl_write,
+};
+
 static int i915_drrs_ctl_set(void *data, u64 val)
 {
 	struct drm_i915_private *dev_priv = data;
@@ -4865,6 +4938,7 @@ static const struct i915_debugfs_files {
 	{"i915_guc_log_level", &i915_guc_log_level_fops},
 	{"i915_guc_log_relay", &i915_guc_log_relay_fops},
 	{"i915_hpd_storm_ctl", &i915_hpd_storm_ctl_fops},
+	{"i915_hpd_short_storm_ctl", &i915_hpd_short_storm_ctl_fops},
 	{"i915_ipc_status", &i915_ipc_status_fops},
 	{"i915_drrs_ctl", &i915_drrs_ctl_fops},
 	{"i915_edp_psr_debug", &i915_edp_psr_debug_fops}
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 2a88a7eb871b..0c8438de3c1b 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -283,7 +283,8 @@ enum hpd_pin {
 #define for_each_hpd_pin(__pin) \
 	for ((__pin) = (HPD_NONE + 1); (__pin) < HPD_NUM_PINS; (__pin)++)
 
-#define HPD_STORM_DEFAULT_THRESHOLD 5
+/* Threshold == 5 for long IRQs, 50 for short */
+#define HPD_STORM_DEFAULT_THRESHOLD 50
 
 struct i915_hotplug {
 	struct work_struct hotplug_work;
@@ -308,6 +309,8 @@ struct i915_hotplug {
 	bool poll_enabled;
 
 	unsigned int hpd_storm_threshold;
+	/* Whether or not to count short HPD IRQs in HPD storms */
+	u8 hpd_short_storm_enabled;
 
 	/*
 	 * if we get a HPD irq from DP and a HPD irq from non-DP
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 5d1f53723388..d7e47d6082de 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -4863,6 +4863,13 @@ void intel_irq_init(struct drm_i915_private *dev_priv)
 		dev_priv->display_irqs_enabled = false;
 
 	dev_priv->hotplug.hpd_storm_threshold = HPD_STORM_DEFAULT_THRESHOLD;
+	/* If we have MST support, we want to avoid doing short HPD IRQ storm
+	 * detection, as short HPD storms will occur as a natural part of
+	 * sideband messaging with MST.
+	 * On older platforms however, IRQ storms can occur with both long and
+	 * short pulses, as seen on some G4x systems.
+	 */
+	dev_priv->hotplug.hpd_short_storm_enabled = !HAS_DP_MST(dev_priv);
 
 	dev->driver->get_vblank_timestamp = drm_calc_vbltimestamp_from_scanoutpos;
 	dev->driver->get_scanout_position = i915_get_crtc_scanoutpos;
diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index e5e3eeb7e482..3039257ec2c5 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -114,34 +114,46 @@ enum hpd_pin intel_hpd_pin_default(struct drm_i915_private *dev_priv,
 #define HPD_STORM_REENABLE_DELAY	(2 * 60 * 1000)
 
 /**
- * intel_hpd_irq_storm_detect - gather stats and detect HPD irq storm on a pin
+ * intel_hpd_irq_storm_detect - gather stats and detect HPD IRQ storm on a pin
  * @dev_priv: private driver data pointer
  * @pin: the pin to gather stats on
+ * @long_hpd: whether the HPD IRQ was long or short
  *
- * Gather stats about HPD irqs from the specified @pin, and detect irq
+ * Gather stats about HPD IRQs from the specified @pin, and detect IRQ
  * storms. Only the pin specific stats and state are changed, the caller is
  * responsible for further action.
  *
- * The number of irqs that are allowed within @HPD_STORM_DETECT_PERIOD is
+ * The number of IRQs that are allowed within @HPD_STORM_DETECT_PERIOD is
  * stored in @dev_priv->hotplug.hpd_storm_threshold which defaults to
- * @HPD_STORM_DEFAULT_THRESHOLD. If this threshold is exceeded, it's
- * considered an irq storm and the irq state is set to @HPD_MARK_DISABLED.
+ * @HPD_STORM_DEFAULT_THRESHOLD. Long IRQs count as +10 to this threshold, and
+ * short IRQs count as +1. If this threshold is exceeded, it's considered an
+ * IRQ storm and the IRQ state is set to @HPD_MARK_DISABLED.
+ *
+ * By default, most systems will only count long IRQs towards
+ * &dev_priv->hotplug.hpd_storm_threshold. However, some older systems also
+ * suffer from short IRQ storms and must also track these. Because short IRQ
+ * storms are naturally caused by sideband interactions with DP MST devices,
+ * short IRQ detection is only enabled for systems without DP MST support.
+ * Systems which are new enough to support DP MST are far less likely to
+ * suffer from IRQ storms at all, so this is fine.
  *
  * The HPD threshold can be controlled through i915_hpd_storm_ctl in debugfs,
  * and should only be adjusted for automated hotplug testing.
  *
- * Return true if an irq storm was detected on @pin.
+ * Return true if an IRQ storm was detected on @pin.
  */
 static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
-				       enum hpd_pin pin)
+				       enum hpd_pin pin, bool long_hpd)
 {
 	struct i915_hotplug *hpd = &dev_priv->hotplug;
 	unsigned long start = hpd->stats[pin].last_jiffies;
 	unsigned long end = start + msecs_to_jiffies(HPD_STORM_DETECT_PERIOD);
+	const int increment = long_hpd ? 10 : 1;
 	const int threshold = hpd->hpd_storm_threshold;
 	bool storm = false;
 
-	if (!threshold)
+	if (!threshold ||
+	    (!long_hpd && !dev_priv->hotplug.hpd_short_storm_enabled))
 		return false;
 
 	if (!time_in_range(jiffies, start, end)) {
@@ -149,7 +161,8 @@ static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
 		hpd->stats[pin].count = 0;
 	}
 
-	if (++hpd->stats[pin].count > threshold) {
+	hpd->stats[pin].count += increment;
+	if (hpd->stats[pin].count > threshold) {
 		hpd->stats[pin].state = HPD_MARK_DISABLED;
 		DRM_DEBUG_KMS("HPD interrupt storm detected on PIN %d\n", pin);
 		storm = true;
@@ -408,28 +421,24 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 	for_each_intel_encoder(&dev_priv->drm, encoder) {
 		enum hpd_pin pin = encoder->hpd_pin;
 		bool has_hpd_pulse = intel_encoder_has_hpd_pulse(encoder);
+		bool long_hpd = true;
 
 		if (!(BIT(pin) & pin_mask))
 			continue;
 
 		if (has_hpd_pulse) {
-			bool long_hpd = long_mask & BIT(pin);
 			enum port port = encoder->port;
 
+			long_hpd = !!(long_mask & BIT(pin));
+
 			DRM_DEBUG_DRIVER("digital hpd port %c - %s\n", port_name(port),
 					 long_hpd ? "long" : "short");
-			/*
-			 * For long HPD pulses we want to have the digital queue happen,
-			 * but we still want HPD storm detection to function.
-			 */
 			queue_dig = true;
-			if (long_hpd) {
+			if (long_hpd)
 				dev_priv->hotplug.long_port_mask |= (1 << port);
-			} else {
-				/* for short HPD just trigger the digital queue */
+			else
 				dev_priv->hotplug.short_port_mask |= (1 << port);
-				continue;
-			}
+
 		}
 
 		if (dev_priv->hotplug.stats[pin].state == HPD_DISABLED) {
@@ -452,7 +461,7 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 			queue_hp = true;
 		}
 
-		if (intel_hpd_irq_storm_detect(dev_priv, pin)) {
+		if (intel_hpd_irq_storm_detect(dev_priv, pin, long_hpd)) {
 			dev_priv->hotplug.event_bits &= ~BIT(pin);
 			storm_detected = true;
 		}
-- 
2.19.1

