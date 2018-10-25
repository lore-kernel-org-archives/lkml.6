Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D40CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523372084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 523372084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeJZHBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:01:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbeJZHBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:01:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EDB193091D6F;
        Thu, 25 Oct 2018 22:27:17 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0B001823B;
        Thu, 25 Oct 2018 22:27:16 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/i915: Add short HPD IRQ storm detection for non-MST systems
Date:   Thu, 25 Oct 2018 18:26:57 -0400
Message-Id: <20181025222657.9241-3-lyude@redhat.com>
In-Reply-To: <20181025222657.9241-1-lyude@redhat.com>
References: <20181025222657.9241-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 25 Oct 2018 22:27:18 +0000 (UTC)
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

So, workaround this impressively broken hardware by detecting short IRQ
storms using a separate threshold and count, one that is much higher
then the threshold for long IRQs. We default to a threshold of 50 short
pulses within the timespan of a second, which should amount to about
100ms of constant pulsing. This should be a good middle ground between
avoiding detecting false IRQ storms, while still catching short IRQ
storms quickly enough to minimize the amount of time we'll stutter every
time hotplugging gets re-enabled and immediately disabled by another
short IRQ storm.

And just to be extra safe: we don't enable this by default on systems
with MST support. There's too high of a chance of MST support triggering
storm detection, and systems that are new enough to support MST are a
lot less likely to have issues with IRQ storms anyway.

As a note: this patch was tested using a ThinkPad T450s and a Chamelium
to simulate the short IRQ storms.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c  | 89 +++++++++++++++++++++++-----
 drivers/gpu/drm/i915/i915_drv.h      | 15 +++--
 drivers/gpu/drm/i915/i915_irq.c      | 14 ++++-
 drivers/gpu/drm/i915/intel_hotplug.c | 84 ++++++++++++++++----------
 4 files changed, 150 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index b4744a68cd88..84e89fbd55fb 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -4566,21 +4566,24 @@ static const struct file_operations i915_forcewake_fops = {
 	.release = i915_forcewake_release,
 };
 
-static int i915_hpd_storm_ctl_show(struct seq_file *m, void *data)
+static int i915_hpd_storm_show(struct seq_file *m, bool long_hpd)
 {
 	struct drm_i915_private *dev_priv = m->private;
 	struct i915_hotplug *hotplug = &dev_priv->hotplug;
+	const unsigned int threshold = long_hpd ?
+		hotplug->long_hpd_storm_threshold :
+		hotplug->short_hpd_storm_threshold;
 
-	seq_printf(m, "Threshold: %d\n", hotplug->hpd_storm_threshold);
+	seq_printf(m, "Threshold: %d\n", threshold);
 	seq_printf(m, "Detected: %s\n",
 		   yesno(delayed_work_pending(&hotplug->reenable_work)));
 
 	return 0;
 }
 
-static ssize_t i915_hpd_storm_ctl_write(struct file *file,
-					const char __user *ubuf, size_t len,
-					loff_t *offp)
+static ssize_t i915_hpd_storm_write(struct file *file,
+				    const char __user *ubuf, size_t len,
+				    loff_t *offp, bool long_hpd)
 {
 	struct seq_file *m = file->private_data;
 	struct drm_i915_private *dev_priv = m->private;
@@ -4589,6 +4592,7 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
 	int i;
 	char *newline;
 	char tmp[16];
+	const char *name = long_hpd ? "long" : "short";
 
 	if (len >= sizeof(tmp))
 		return -EINVAL;
@@ -4603,22 +4607,36 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
 	if (newline)
 		*newline = '\0';
 
-	if (strcmp(tmp, "reset") == 0)
-		new_threshold = HPD_STORM_DEFAULT_THRESHOLD;
-	else if (kstrtouint(tmp, 10, &new_threshold) != 0)
+	if (strcmp(tmp, "reset") == 0) {
+		if (long_hpd)
+			new_threshold = HPD_STORM_DEFAULT_THRESHOLD_LONG;
+		else if (!HAS_DP_MST(dev_priv))
+			new_threshold = HPD_STORM_DEFAULT_THRESHOLD_SHORT;
+		else
+			new_threshold = 0;
+	} else if (kstrtouint(tmp, 10, &new_threshold) != 0) {
 		return -EINVAL;
+	}
 
 	if (new_threshold > 0)
-		DRM_DEBUG_KMS("Setting HPD storm detection threshold to %d\n",
-			      new_threshold);
+		DRM_DEBUG_KMS("Setting %s HPD storm detection threshold to %d\n",
+			      name, new_threshold);
 	else
-		DRM_DEBUG_KMS("Disabling HPD storm detection\n");
+		DRM_DEBUG_KMS("Disabling %s HPD storm detection\n", name);
 
 	spin_lock_irq(&dev_priv->irq_lock);
-	hotplug->hpd_storm_threshold = new_threshold;
+	if (long_hpd)
+		hotplug->long_hpd_storm_threshold = new_threshold;
+	else
+		hotplug->short_hpd_storm_threshold = new_threshold;
+
 	/* Reset the HPD storm stats so we don't accidentally trigger a storm */
-	for_each_hpd_pin(i)
-		hotplug->stats[i].count = 0;
+	for_each_hpd_pin(i) {
+		if (long_hpd)
+			hotplug->stats[i].long_irq.count = 0;
+		else
+			hotplug->stats[i].short_irq.count = 0;
+	}
 	spin_unlock_irq(&dev_priv->irq_lock);
 
 	/* Re-enable hpd immediately if we were in an irq storm */
@@ -4627,6 +4645,18 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
 	return len;
 }
 
+static ssize_t
+i915_hpd_storm_ctl_write(struct file *file, const char __user *ubuf,
+			 size_t len, loff_t *offp)
+{
+	return i915_hpd_storm_write(file, ubuf, len, offp, true);
+}
+
+static int i915_hpd_storm_ctl_show(struct seq_file *m, void *data)
+{
+	return i915_hpd_storm_show(m, true);
+}
+
 static int i915_hpd_storm_ctl_open(struct inode *inode, struct file *file)
 {
 	return single_open(file, i915_hpd_storm_ctl_show, inode->i_private);
@@ -4638,7 +4668,35 @@ static const struct file_operations i915_hpd_storm_ctl_fops = {
 	.read = seq_read,
 	.llseek = seq_lseek,
 	.release = single_release,
-	.write = i915_hpd_storm_ctl_write
+	.write = i915_hpd_storm_ctl_write,
+};
+
+static ssize_t
+i915_short_hpd_storm_ctl_write(struct file *file, const char __user *ubuf,
+			       size_t len, loff_t *offp)
+{
+	return i915_hpd_storm_write(file, ubuf, len, offp, false);
+}
+
+static int i915_short_hpd_storm_ctl_show(struct seq_file *m, void *data)
+{
+	return i915_hpd_storm_show(m, false);
+}
+
+static int
+i915_short_hpd_storm_ctl_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, i915_short_hpd_storm_ctl_show,
+			   inode->i_private);
+}
+
+static const struct file_operations i915_short_hpd_storm_ctl_fops = {
+	.owner = THIS_MODULE,
+	.open = i915_short_hpd_storm_ctl_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+	.write = i915_short_hpd_storm_ctl_write,
 };
 
 static int i915_drrs_ctl_set(void *data, u64 val)
@@ -4818,6 +4876,7 @@ static const struct i915_debugfs_files {
 	{"i915_guc_log_level", &i915_guc_log_level_fops},
 	{"i915_guc_log_relay", &i915_guc_log_relay_fops},
 	{"i915_hpd_storm_ctl", &i915_hpd_storm_ctl_fops},
+	{"i915_short_hpd_storm_ctl", &i915_short_hpd_storm_ctl_fops},
 	{"i915_ipc_status", &i915_ipc_status_fops},
 	{"i915_drrs_ctl", &i915_drrs_ctl_fops},
 	{"i915_edp_psr_debug", &i915_edp_psr_debug_fops}
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 808204a7ca7c..ef38baf50299 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -282,14 +282,20 @@ enum hpd_pin {
 #define for_each_hpd_pin(__pin) \
 	for ((__pin) = (HPD_NONE + 1); (__pin) < HPD_NUM_PINS; (__pin)++)
 
-#define HPD_STORM_DEFAULT_THRESHOLD 5
+#define HPD_STORM_DEFAULT_THRESHOLD_LONG	5
+#define HPD_STORM_DEFAULT_THRESHOLD_SHORT	50
+
+struct intel_hpd_irq_stats {
+	unsigned long last_jiffies;
+	int count;
+};
 
 struct i915_hotplug {
 	struct work_struct hotplug_work;
 
 	struct {
-		unsigned long last_jiffies;
-		int count;
+		struct intel_hpd_irq_stats long_irq;
+		struct intel_hpd_irq_stats short_irq;
 		enum {
 			HPD_ENABLED = 0,
 			HPD_DISABLED = 1,
@@ -306,7 +312,8 @@ struct i915_hotplug {
 	struct work_struct poll_init_work;
 	bool poll_enabled;
 
-	unsigned int hpd_storm_threshold;
+	unsigned int long_hpd_storm_threshold;
+	unsigned int short_hpd_storm_threshold;
 
 	/*
 	 * if we get a HPD irq from DP and a HPD irq from non-DP
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 10f28a2ee2e6..28a937f3e8e0 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -4842,7 +4842,19 @@ void intel_irq_init(struct drm_i915_private *dev_priv)
 	if (IS_VALLEYVIEW(dev_priv) || IS_CHERRYVIEW(dev_priv))
 		dev_priv->display_irqs_enabled = false;
 
-	dev_priv->hotplug.hpd_storm_threshold = HPD_STORM_DEFAULT_THRESHOLD;
+	dev_priv->hotplug.long_hpd_storm_threshold =
+		HPD_STORM_DEFAULT_THRESHOLD_LONG;
+
+	/* If we have MST support, we want to avoid doing short HPD IRQ storm
+	 * detection, as short HPD storms will occur as a natural part of
+	 * sideband messaging with MST.
+	 * On older platforms however, IRQ storms can occur with both long and
+	 * short pulses, as seen on some G4x systems.
+	 */
+	if (!HAS_DP_MST(dev_priv)) {
+		dev_priv->hotplug.short_hpd_storm_threshold =
+			HPD_STORM_DEFAULT_THRESHOLD_SHORT;
+	}
 
 	dev->driver->get_vblank_timestamp = drm_calc_vbltimestamp_from_scanoutpos;
 	dev->driver->get_scanout_position = i915_get_crtc_scanoutpos;
diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index 7d21aac10d16..74798c920909 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -118,41 +118,64 @@ enum hpd_pin intel_hpd_pin_default(struct drm_i915_private *dev_priv,
  * @dev_priv: private driver data pointer
  * @pin: the pin to gather stats on
  *
- * Gather stats about HPD irqs from the specified @pin, and detect irq
+ * Gather stats about HPD IRQs from the specified @pin, and detect IRQ
  * storms. Only the pin specific stats and state are changed, the caller is
  * responsible for further action.
  *
- * The number of irqs that are allowed within @HPD_STORM_DETECT_PERIOD is
- * stored in @dev_priv->hotplug.hpd_storm_threshold which defaults to
- * @HPD_STORM_DEFAULT_THRESHOLD. If this threshold is exceeded, it's
- * considered an irq storm and the irq state is set to @HPD_MARK_DISABLED.
+ * IRQ storm detection can happen for both long and short IRQs. The number of
+ * short or long IRQs that are allowed within @HPD_STORM_DETECT_PERIOD are
+ * stored in @dev_priv->hotplug.long_hpd_storm_threshold and
+ * @dev_priv->hotplug.short_hpd_storm_threshold respectively. For long IRQs,
+ * the threshold defaults to @HPD_STORM_DEFAULT_THRESHOLD_LONG on all systems.
+ * For short IRQs however, the default threshold varies. On systems that are
+ * too old to support MST, the threshold will default to
+ * @HPD_STORM_DEFAULT_THRESHOLD_SHORT. Systems which do support MST will not
+ * have short IRQ storm detection enabled by default, as doing so would likely
+ * interfere with the short IRQ bursts caused by sideband transactions.
+ * This is fine, as systems new enough to support MST are unlikely to rely on
+ * HPD storm protection as much as older systems may.
  *
- * The HPD threshold can be controlled through i915_hpd_storm_ctl in debugfs,
- * and should only be adjusted for automated hotplug testing.
+ * The HPD threshold can be controlled through i915_hpd_storm_ctl in debugfs
+ * for long IRQs, and i915_short_hpd_storm_ctl for short IRQs. This should
+ * only ever be adjusted for automated hotplug testing.
  *
  * Return true if an irq storm was detected on @pin.
  */
 static bool intel_hpd_irq_storm_detect(struct drm_i915_private *dev_priv,
-				       enum hpd_pin pin)
+				       enum hpd_pin pin, bool long_hpd)
 {
-	unsigned long start = dev_priv->hotplug.stats[pin].last_jiffies;
-	unsigned long end = start + msecs_to_jiffies(HPD_STORM_DETECT_PERIOD);
-	const int threshold = dev_priv->hotplug.hpd_storm_threshold;
+	struct intel_hpd_irq_stats *stats;
+	const char *name;
+	unsigned long start, end;
+	int threshold;
 	bool storm = false;
 
+	if (long_hpd) {
+		stats = &dev_priv->hotplug.stats[pin].long_irq;
+		threshold = dev_priv->hotplug.long_hpd_storm_threshold;
+		name = "long";
+	} else {
+		stats = &dev_priv->hotplug.stats[pin].short_irq;
+		threshold = dev_priv->hotplug.short_hpd_storm_threshold;
+		name = "short";
+	}
+	start = stats->last_jiffies;
+	end = start + msecs_to_jiffies(HPD_STORM_DETECT_PERIOD);
+
 	if (!time_in_range(jiffies, start, end)) {
-		dev_priv->hotplug.stats[pin].last_jiffies = jiffies;
-		dev_priv->hotplug.stats[pin].count = 0;
-		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: 0\n", pin);
-	} else if (dev_priv->hotplug.stats[pin].count > threshold &&
-		   threshold) {
+		stats->last_jiffies = jiffies;
+		stats->count = 0;
+		DRM_DEBUG_KMS("Received %s HPD interrupt on PIN %d - cnt: 0\n",
+			      name, pin);
+	} else if (stats->count > threshold && threshold) {
 		dev_priv->hotplug.stats[pin].state = HPD_MARK_DISABLED;
-		DRM_DEBUG_KMS("HPD interrupt storm detected on PIN %d\n", pin);
+		DRM_DEBUG_KMS("Detected %s HPD interrupt storm on PIN %d\n",
+			      name, pin);
 		storm = true;
 	} else {
-		dev_priv->hotplug.stats[pin].count++;
-		DRM_DEBUG_KMS("Received HPD interrupt on PIN %d - cnt: %d\n", pin,
-			      dev_priv->hotplug.stats[pin].count);
+		stats->count++;
+		DRM_DEBUG_KMS("Received %s HPD interrupt on PIN %d - cnt: %d\n",
+			      name, pin, stats->count);
 	}
 
 	return storm;
@@ -404,28 +427,24 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
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
@@ -448,7 +467,7 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 			queue_hp = true;
 		}
 
-		if (intel_hpd_irq_storm_detect(dev_priv, pin)) {
+		if (intel_hpd_irq_storm_detect(dev_priv, pin, long_hpd)) {
 			dev_priv->hotplug.event_bits &= ~BIT(pin);
 			storm_detected = true;
 		}
@@ -489,7 +508,8 @@ void intel_hpd_init(struct drm_i915_private *dev_priv)
 	int i;
 
 	for_each_hpd_pin(i) {
-		dev_priv->hotplug.stats[i].count = 0;
+		dev_priv->hotplug.stats[i].long_irq.count = 0;
+		dev_priv->hotplug.stats[i].short_irq.count = 0;
 		dev_priv->hotplug.stats[i].state = HPD_ENABLED;
 	}
 
-- 
2.17.2

