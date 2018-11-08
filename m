Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C287BC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8982A2086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8982A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=80x24.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeKHJgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 04:36:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:38132 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727695AbeKHJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 04:36:22 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CE3261F453;
        Thu,  8 Nov 2018 00:03:35 +0000 (UTC)
Date:   Thu, 8 Nov 2018 00:03:35 +0000
From:   Eric Wong <e@80x24.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Subject: Re: radeon vs radeonfb Mobility quirks (Thinkpad X32)
Message-ID: <20181108000335.a7usqftcmxvu7ywk@untitled>
References: <20181104042328.jzavn47y2wloprbs@untitled>
 <365d8b24f1c6a28c32998924a95b6a2a74655526.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <365d8b24f1c6a28c32998924a95b6a2a74655526.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> There's a whole pile of power management stuff for ancient laptops that
> never quite made it from radeonfb to the radeon DRM driver... sadly it
> also prevents sleep on old PowerBooks but I haven't had many complaints
> so...

Thanks for the confirmation that stuff is missing from the DRM driver.

> The code for D2 and D3 on those old things is reasonably self
> contained, it shouldn't be that hard to move it over I suppose.

I started working on the following (dirty) patch for my X32,
but hasn't made a difference with just PCI_D2:

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 59c8a6647ff2..acc587b18ad2 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1548,6 +1548,23 @@ void radeon_device_fini(struct radeon_device *rdev)
 		radeon_doorbell_fini(rdev);
 }
 
+/* XXX copy of radeonfb_whack_power_state */
+static void radeon_whack_power_state(struct pci_dev *pdev, pci_power_t state)
+{
+	u16 pwr_cmd;
+
+	for (;;) {
+		pci_read_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL,
+				     &pwr_cmd);
+		if (pwr_cmd & state)
+			break;
+		pwr_cmd = (pwr_cmd & ~PCI_PM_CTRL_STATE_MASK) | state;
+		pci_write_config_word(pdev, pdev->pm_cap + PCI_PM_CTRL,
+				      pwr_cmd);
+		msleep(500);
+	}
+	pdev->current_state = state;
+}
 
 /*
  * Suspend & resume.
@@ -1596,6 +1613,7 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 
 		if (radeon_crtc->cursor_bo) {
 			struct radeon_bo *robj = gem_to_radeon_bo(radeon_crtc->cursor_bo);
+
 			r = radeon_bo_reserve(robj, false);
 			if (r == 0) {
 				radeon_bo_unpin(robj);
@@ -1647,7 +1665,13 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 	} else if (suspend) {
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
-		pci_set_power_state(dev->pdev, PCI_D3hot);
+
+		if ("X32") {
+			radeon_whack_power_state(dev->pdev, PCI_D2);
+			__pci_complete_power_transition(dev->pdev, PCI_D2);
+		} else {
+			pci_set_power_state(dev->pdev, PCI_D3hot);
+		}
 	}
 
 	if (fbcon) {


I suppose some of the mobility stuff from
drivers/video/fbdev/aty/radeon_pm.c is necessary, but I haven't
figured it out for the DRM driver.  Not sure when/if I'll have
time to figure it out, or if I'll stick to the radeonfb driver
for now.

		/* Prepare mobility chips for suspend.
		 */
		if (rinfo->is_mobility) {
			/* Program V2CLK */
			radeon_pm_program_v2clk(rinfo);
		
			/* Disable IO PADs */
			radeon_pm_disable_iopad(rinfo);

			/* Set low current */
			radeon_pm_low_current(rinfo);

			/* Prepare chip for power management */
			radeon_pm_setup_for_suspend(rinfo);
