Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E583CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBA121736
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550500722;
	bh=zocM1cHJfFUYoJZswMYq0A23vrhfouBPCinwcXXdNbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y2og7b61T4gyFt3xfi9KrQ3tfqigF26DoXspjW5Pu2IgHDRG+Xd+yj3OzT+MhGIO1
	 /F/3eqXrfr8IZktlRBQPg2KJ6fCDIfOTbgCFVYWl7BXphcBJZdaKqCEUWWfPPX1iY6
	 VWoTX+hA1qduLYNq6ZSCIL3y5OHNm5tUT0f9ayyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbfBROil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:38:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:33946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733103AbfBRNyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:54:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 655BF2077B;
        Mon, 18 Feb 2019 13:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498044;
        bh=zocM1cHJfFUYoJZswMYq0A23vrhfouBPCinwcXXdNbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SfVXZu8J1EenjzDAIbHw6v7Ju4q0gen7tvH9X+e0k2UETX9xz0DvQf/Z7DfXgNQQB
         BV8VwNZBGupOce2LBUum5anNsmS7SgZmZaoD6VXktrpe7MI2djx/En3LL+g9t1osbq
         iHhD34yH1XjEWrNp6w/h7XFC6Gj09qGw+scW4Q1A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Todd Previte <tprevite@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.19 83/85] drm/i915: Block fbdev HPD processing during suspend
Date:   Mon, 18 Feb 2019 14:43:49 +0100
Message-Id: <20190218133507.978524940@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133459.758004711@linuxfoundation.org>
References: <20190218133459.758004711@linuxfoundation.org>
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

From: Lyude Paul <lyude@redhat.com>

commit e8a8fedd57fdcebf0e4f24ef0fc7e29323df8e66 upstream.

When resuming, we check whether or not any previously connected
MST topologies are still present and if so, attempt to resume them. If
this fails, we disable said MST topologies and fire off a hotplug event
so that userspace knows to reprobe.

However, sending a hotplug event involves calling
drm_fb_helper_hotplug_event(), which in turn results in fbcon doing a
connector reprobe in the caller's thread - something we can't do at the
point in which i915 calls drm_dp_mst_topology_mgr_resume() since
hotplugging hasn't been fully initialized yet.

This currently causes some rather subtle but fatal issues. For example,
on my T480s the laptop dock connected to it usually disappears during a
suspend cycle, and comes back up a short while after the system has been
resumed. This guarantees pretty much every suspend and resume cycle,
drm_dp_mst_topology_mgr_set_mst(mgr, false); will be caused and in turn,
a connector hotplug will occur. Now it's Rute Goldberg time: when the
connector hotplug occurs, i915 reprobes /all/ of the connectors,
including eDP. However, eDP probing requires that we power on the panel
VDD which in turn, grabs a wakeref to the appropriate power domain on
the GPU (on my T480s, this is the PORT_DDI_A_IO domain). This is where
things start breaking, since this all happens before
intel_power_domains_enable() is called we end up leaking the wakeref
that was acquired and never releasing it later. Come next suspend/resume
cycle, this causes us to fail to shut down the GPU properly, which
causes it not to resume properly and die a horrible complicated death.

(as a note: this only happens when there's both an eDP panel and MST
topology connected which is removed mid-suspend. One or the other seems
to always be OK).

We could try to fix the VDD wakeref leak, but this doesn't seem like
it's worth it at all since we aren't able to handle hotplug detection
while resuming anyway. So, let's go with a more robust solution inspired
by nouveau: block fbdev from handling hotplug events until we resume
fbdev. This allows us to still send sysfs hotplug events to be handled
later by user space while we're resuming, while also preventing us from
actually processing any hotplug events we receive until it's safe.

This fixes the wakeref leak observed on the T480s and as such, also
fixes suspend/resume with MST topologies connected on this machine.

Changes since v2:
* Don't call drm_fb_helper_hotplug_event() under lock, do it after lock
  (Chris Wilson)
* Don't call drm_fb_helper_hotplug_event() in
  intel_fbdev_output_poll_changed() under lock (Chris Wilson)
* Always set ifbdev->hpd_waiting (Chris Wilson)

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 0e32b39ceed6 ("drm/i915: add DP 1.2 MST support (v0.7)")
Cc: Todd Previte <tprevite@gmail.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: intel-gfx@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.17+
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20190129191001.442-2-lyude@redhat.com
(cherry picked from commit fe5ec65668cdaa4348631d8ce1766eed43b33c10)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_drv.h   |   10 ++++++++++
 drivers/gpu/drm/i915/intel_fbdev.c |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_drv.h
+++ b/drivers/gpu/drm/i915/intel_drv.h
@@ -209,6 +209,16 @@ struct intel_fbdev {
 	unsigned long vma_flags;
 	async_cookie_t cookie;
 	int preferred_bpp;
+
+	/* Whether or not fbdev hpd processing is temporarily suspended */
+	bool hpd_suspended : 1;
+	/* Set when a hotplug was received while HPD processing was
+	 * suspended
+	 */
+	bool hpd_waiting : 1;
+
+	/* Protects hpd_suspended */
+	struct mutex hpd_lock;
 };
 
 struct intel_encoder {
--- a/drivers/gpu/drm/i915/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/intel_fbdev.c
@@ -677,6 +677,7 @@ int intel_fbdev_init(struct drm_device *
 	if (ifbdev == NULL)
 		return -ENOMEM;
 
+	mutex_init(&ifbdev->hpd_lock);
 	drm_fb_helper_prepare(dev, &ifbdev->helper, &intel_fb_helper_funcs);
 
 	if (!intel_fbdev_init_bios(dev, ifbdev))
@@ -750,6 +751,26 @@ void intel_fbdev_fini(struct drm_i915_pr
 	intel_fbdev_destroy(ifbdev);
 }
 
+/* Suspends/resumes fbdev processing of incoming HPD events. When resuming HPD
+ * processing, fbdev will perform a full connector reprobe if a hotplug event
+ * was received while HPD was suspended.
+ */
+static void intel_fbdev_hpd_set_suspend(struct intel_fbdev *ifbdev, int state)
+{
+	bool send_hpd = false;
+
+	mutex_lock(&ifbdev->hpd_lock);
+	ifbdev->hpd_suspended = state == FBINFO_STATE_SUSPENDED;
+	send_hpd = !ifbdev->hpd_suspended && ifbdev->hpd_waiting;
+	ifbdev->hpd_waiting = false;
+	mutex_unlock(&ifbdev->hpd_lock);
+
+	if (send_hpd) {
+		DRM_DEBUG_KMS("Handling delayed fbcon HPD event\n");
+		drm_fb_helper_hotplug_event(&ifbdev->helper);
+	}
+}
+
 void intel_fbdev_set_suspend(struct drm_device *dev, int state, bool synchronous)
 {
 	struct drm_i915_private *dev_priv = to_i915(dev);
@@ -771,6 +792,7 @@ void intel_fbdev_set_suspend(struct drm_
 		 */
 		if (state != FBINFO_STATE_RUNNING)
 			flush_work(&dev_priv->fbdev_suspend_work);
+
 		console_lock();
 	} else {
 		/*
@@ -798,17 +820,26 @@ void intel_fbdev_set_suspend(struct drm_
 
 	drm_fb_helper_set_suspend(&ifbdev->helper, state);
 	console_unlock();
+
+	intel_fbdev_hpd_set_suspend(ifbdev, state);
 }
 
 void intel_fbdev_output_poll_changed(struct drm_device *dev)
 {
 	struct intel_fbdev *ifbdev = to_i915(dev)->fbdev;
+	bool send_hpd;
 
 	if (!ifbdev)
 		return;
 
 	intel_fbdev_sync(ifbdev);
-	if (ifbdev->vma || ifbdev->helper.deferred_setup)
+
+	mutex_lock(&ifbdev->hpd_lock);
+	send_hpd = !ifbdev->hpd_suspended;
+	ifbdev->hpd_waiting = true;
+	mutex_unlock(&ifbdev->hpd_lock);
+
+	if (send_hpd && (ifbdev->vma || ifbdev->helper.deferred_setup))
 		drm_fb_helper_hotplug_event(&ifbdev->helper);
 }
 


