Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5C4ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75B721479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf/ZGdwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A75B721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbeJSCDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbeJSCDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:03:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C2A205C9;
        Thu, 18 Oct 2018 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885697;
        bh=jYT9f8yOGmU9/Mc4mJmqnz5xWwvAQq5N0KLByJFpIfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qf/ZGdwrWQvWoQu/4m6LTZNTK61dn2bgfrmXiyazZ3jwMm9HB6EYSGTLKfqYWdKum
         j5RjLCBzb4XodqWGyXuu1C5jCm1Ydu5DGYcUzwnPZHvz4x2n6vQV57w+Ui/g277/p/
         Jn7p6MEmD6z6ToD905Uga5CNKrqtZsqnLI9P9Y/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Wolfgang Draxinger <wdraxinger.maillist@draxit.de>,
        Vito Caputo <vcaputo@pengaru.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        Joonas Saarinen <jza@saunalahti.fi>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 36/41] drm/i915: Nuke the LVDS lid notifier
Date:   Thu, 18 Oct 2018 19:54:51 +0200
Message-Id: <20181018175422.980996606@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.718399607@linuxfoundation.org>
References: <20181018175416.718399607@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 05c72e77ccda89ff624108b1b59a0fc43843f343 upstream.

We broke the LVDS notifier resume thing in (presumably) commit
e2c8b8701e2d ("drm/i915: Use atomic helpers for suspend, v2.") as
we no longer duplicate the current state in the LVDS notifier and
thus we never resume it properly either.

Instead of trying to fix it again let's just kill off the lid
notifier entirely. None of the machines tested thus far have
apparently needed it. Originally the lid notifier was added to
work around cases where the VBIOS was clobbering some of the
hardware state behind the driver's back, mostly on Thinkpads.
We now have a few report of Thinkpads working just fine without
the notifier. So maybe it was misdiagnosed originally, or
something else has changed (ACPI video stuff perhaps?).

If we do end up finding a machine where the VBIOS is still causing
problems I would suggest that we first try setting various bits in
the VBIOS scratch registers. There are several to choose from that
may instruct the VBIOS to steer clear.

With the notifier gone we'll also stop looking at the panel status
in ->detect().

v2: Nuke enum modeset_restore (Rodrigo)

Cc: stable@vger.kernel.org
Cc: Wolfgang Draxinger <wdraxinger.maillist@draxit.de>
Cc: Vito Caputo <vcaputo@pengaru.com>
Cc: kitsunyan <kitsunyan@airmail.cc>
Cc: Joonas Saarinen <jza@saunalahti.fi>
Tested-by: Vito Caputo <vcaputo@pengaru.com> # Thinkapd X61s
Tested-by: kitsunyan <kitsunyan@airmail.cc> # ThinkPad X200
Tested-by: Joonas Saarinen <jza@saunalahti.fi> # Fujitsu Siemens U9210
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=105902
References: https://lists.freedesktop.org/archives/intel-gfx/2018-June/169315.html
References: https://bugs.freedesktop.org/show_bug.cgi?id=21230
Fixes: e2c8b8701e2d ("drm/i915: Use atomic helpers for suspend, v2.")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180717174216.22252-1-ville.syrjala@linux.intel.com
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_drv.c   |   10 --
 drivers/gpu/drm/i915/i915_drv.h   |    8 --
 drivers/gpu/drm/i915/intel_lvds.c |  136 --------------------------------------
 3 files changed, 2 insertions(+), 152 deletions(-)

--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -878,7 +878,6 @@ static int i915_driver_init_early(struct
 
 	spin_lock_init(&dev_priv->mm.object_stat_lock);
 	mutex_init(&dev_priv->sb_lock);
-	mutex_init(&dev_priv->modeset_restore_lock);
 	mutex_init(&dev_priv->av_mutex);
 	mutex_init(&dev_priv->wm.wm_mutex);
 	mutex_init(&dev_priv->pps_mutex);
@@ -1505,11 +1504,6 @@ static int i915_drm_suspend(struct drm_d
 	pci_power_t opregion_target_state;
 	int error;
 
-	/* ignore lid events during suspend */
-	mutex_lock(&dev_priv->modeset_restore_lock);
-	dev_priv->modeset_restore = MODESET_SUSPENDED;
-	mutex_unlock(&dev_priv->modeset_restore_lock);
-
 	disable_rpm_wakeref_asserts(dev_priv);
 
 	/* We do a lot of poking in a lot of registers, make sure they work
@@ -1718,10 +1712,6 @@ static int i915_drm_resume(struct drm_de
 
 	intel_fbdev_set_suspend(dev, FBINFO_STATE_RUNNING, false);
 
-	mutex_lock(&dev_priv->modeset_restore_lock);
-	dev_priv->modeset_restore = MODESET_DONE;
-	mutex_unlock(&dev_priv->modeset_restore_lock);
-
 	intel_opregion_notify_adapter(dev_priv, PCI_D0);
 
 	intel_autoenable_gt_powersave(dev_priv);
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1614,12 +1614,6 @@ struct i915_gpu_error {
 	unsigned long test_irq_rings;
 };
 
-enum modeset_restore {
-	MODESET_ON_LID_OPEN,
-	MODESET_DONE,
-	MODESET_SUSPENDED,
-};
-
 #define DP_AUX_A 0x40
 #define DP_AUX_B 0x10
 #define DP_AUX_C 0x20
@@ -2296,8 +2290,6 @@ struct drm_i915_private {
 
 	unsigned long quirks;
 
-	enum modeset_restore modeset_restore;
-	struct mutex modeset_restore_lock;
 	struct drm_atomic_state *modeset_restore_state;
 	struct drm_modeset_acquire_ctx reset_ctx;
 
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -44,8 +44,6 @@
 /* Private structure for the integrated LVDS support */
 struct intel_lvds_connector {
 	struct intel_connector base;
-
-	struct notifier_block lid_notifier;
 };
 
 struct intel_lvds_pps {
@@ -440,26 +438,9 @@ static bool intel_lvds_compute_config(st
 	return true;
 }
 
-/**
- * Detect the LVDS connection.
- *
- * Since LVDS doesn't have hotlug, we use the lid as a proxy.  Open means
- * connected and closed means disconnected.  We also send hotplug events as
- * needed, using lid status notification from the input layer.
- */
 static enum drm_connector_status
 intel_lvds_detect(struct drm_connector *connector, bool force)
 {
-	struct drm_i915_private *dev_priv = to_i915(connector->dev);
-	enum drm_connector_status status;
-
-	DRM_DEBUG_KMS("[CONNECTOR:%d:%s]\n",
-		      connector->base.id, connector->name);
-
-	status = intel_panel_detect(dev_priv);
-	if (status != connector_status_unknown)
-		return status;
-
 	return connector_status_connected;
 }
 
@@ -484,117 +465,6 @@ static int intel_lvds_get_modes(struct d
 	return 1;
 }
 
-static int intel_no_modeset_on_lid_dmi_callback(const struct dmi_system_id *id)
-{
-	DRM_INFO("Skipping forced modeset for %s\n", id->ident);
-	return 1;
-}
-
-/* The GPU hangs up on these systems if modeset is performed on LID open */
-static const struct dmi_system_id intel_no_modeset_on_lid[] = {
-	{
-		.callback = intel_no_modeset_on_lid_dmi_callback,
-		.ident = "Toshiba Tecra A11",
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TECRA A11"),
-		},
-	},
-
-	{ }	/* terminating entry */
-};
-
-/*
- * Lid events. Note the use of 'modeset':
- *  - we set it to MODESET_ON_LID_OPEN on lid close,
- *    and set it to MODESET_DONE on open
- *  - we use it as a "only once" bit (ie we ignore
- *    duplicate events where it was already properly set)
- *  - the suspend/resume paths will set it to
- *    MODESET_SUSPENDED and ignore the lid open event,
- *    because they restore the mode ("lid open").
- */
-static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
-			    void *unused)
-{
-	struct intel_lvds_connector *lvds_connector =
-		container_of(nb, struct intel_lvds_connector, lid_notifier);
-	struct drm_connector *connector = &lvds_connector->base.base;
-	struct drm_device *dev = connector->dev;
-	struct drm_i915_private *dev_priv = to_i915(dev);
-
-	if (dev->switch_power_state != DRM_SWITCH_POWER_ON)
-		return NOTIFY_OK;
-
-	mutex_lock(&dev_priv->modeset_restore_lock);
-	if (dev_priv->modeset_restore == MODESET_SUSPENDED)
-		goto exit;
-	/*
-	 * check and update the status of LVDS connector after receiving
-	 * the LID nofication event.
-	 */
-	connector->status = connector->funcs->detect(connector, false);
-
-	/* Don't force modeset on machines where it causes a GPU lockup */
-	if (dmi_check_system(intel_no_modeset_on_lid))
-		goto exit;
-	if (!acpi_lid_open()) {
-		/* do modeset on next lid open event */
-		dev_priv->modeset_restore = MODESET_ON_LID_OPEN;
-		goto exit;
-	}
-
-	if (dev_priv->modeset_restore == MODESET_DONE)
-		goto exit;
-
-	/*
-	 * Some old platform's BIOS love to wreak havoc while the lid is closed.
-	 * We try to detect this here and undo any damage. The split for PCH
-	 * platforms is rather conservative and a bit arbitrary expect that on
-	 * those platforms VGA disabling requires actual legacy VGA I/O access,
-	 * and as part of the cleanup in the hw state restore we also redisable
-	 * the vga plane.
-	 */
-	if (!HAS_PCH_SPLIT(dev_priv))
-		intel_display_resume(dev);
-
-	dev_priv->modeset_restore = MODESET_DONE;
-
-exit:
-	mutex_unlock(&dev_priv->modeset_restore_lock);
-	return NOTIFY_OK;
-}
-
-static int
-intel_lvds_connector_register(struct drm_connector *connector)
-{
-	struct intel_lvds_connector *lvds = to_lvds_connector(connector);
-	int ret;
-
-	ret = intel_connector_register(connector);
-	if (ret)
-		return ret;
-
-	lvds->lid_notifier.notifier_call = intel_lid_notify;
-	if (acpi_lid_notifier_register(&lvds->lid_notifier)) {
-		DRM_DEBUG_KMS("lid notifier registration failed\n");
-		lvds->lid_notifier.notifier_call = NULL;
-	}
-
-	return 0;
-}
-
-static void
-intel_lvds_connector_unregister(struct drm_connector *connector)
-{
-	struct intel_lvds_connector *lvds = to_lvds_connector(connector);
-
-	if (lvds->lid_notifier.notifier_call)
-		acpi_lid_notifier_unregister(&lvds->lid_notifier);
-
-	intel_connector_unregister(connector);
-}
-
 /**
  * intel_lvds_destroy - unregister and free LVDS structures
  * @connector: connector to free
@@ -627,8 +497,8 @@ static const struct drm_connector_funcs
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.atomic_get_property = intel_digital_connector_atomic_get_property,
 	.atomic_set_property = intel_digital_connector_atomic_set_property,
-	.late_register = intel_lvds_connector_register,
-	.early_unregister = intel_lvds_connector_unregister,
+	.late_register = intel_connector_register,
+	.early_unregister = intel_connector_unregister,
 	.destroy = intel_lvds_destroy,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state = intel_digital_connector_duplicate_state,
@@ -1091,8 +961,6 @@ void intel_lvds_init(struct drm_i915_pri
 	 * 2) check for VBT data
 	 * 3) check to see if LVDS is already on
 	 *    if none of the above, no panel
-	 * 4) make sure lid is open
-	 *    if closed, act like it's not there for now
 	 */
 
 	/*


