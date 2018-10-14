Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9261C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFD820645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFD820645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeJNXeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:34:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37449 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727875AbeJNXeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:34:05 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiM3-0004cD-9P; Sun, 14 Oct 2018 16:30:55 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLS-0000KD-7Q; Sun, 14 Oct 2018 16:30:18 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Maarten Lankhorst" <maarten.lankhorst@canonical.com>,
        "Andreas Boll" <andreas.boll.dev@gmail.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.25677261@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 136/366] drm/radeon: make MacBook Pro d3_delay quirk
 more generic
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bjorn Helgaas <bhelgaas@google.com>

commit 5938628c51a711ae2169d68b2e3a4f7d93d4dbea upstream.

The PCI Power Management Spec, r1.2, sec 5.6.1, requires a 10 millisecond
delay when powering on a device, i.e., transitioning from state D3hot to
D0.

Apparently some devices require more time, and d1f9809ed131 ("drm/radeon:
add quirk for d3 delay during switcheroo poweron for apple macbooks") added
an additional delay for the Radeon device in a MacBook Pro.  4807c5a8a0c8
("drm/radeon: add a PX quirk list") made the affected device more explicit.

Add a generic PCI quirk to increase the d3_delay.  This means we will use
the additional delay for *all* wakeups from D3, not just those initiated by
radeon_switcheroo_set_state().

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andreas Boll <andreas.boll.dev@gmail.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
CC: Maarten Lankhorst <maarten.lankhorst@canonical.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/radeon/radeon_device.c | 11 -----------
 drivers/pci/quirks.c                   | 13 +++++++++++++
 2 files changed, 13 insertions(+), 11 deletions(-)

--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -105,7 +105,6 @@ static const char radeon_family_name[][1
 };
 
 #define RADEON_PX_QUIRK_DISABLE_PX  (1 << 0)
-#define RADEON_PX_QUIRK_LONG_WAKEUP (1 << 1)
 
 struct radeon_px_quirk {
 	u32 chip_vendor;
@@ -132,8 +131,6 @@ static struct radeon_px_quirk radeon_px_
 	 * https://bugs.freedesktop.org/show_bug.cgi?id=101491
 	 */
 	{ PCI_VENDOR_ID_ATI, 0x6741, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
-	/* macbook pro 8.2 */
-	{ PCI_VENDOR_ID_ATI, 0x6741, PCI_VENDOR_ID_APPLE, 0x00e2, RADEON_PX_QUIRK_LONG_WAKEUP },
 	{ 0, 0, 0, 0, 0 },
 };
 
@@ -1180,25 +1177,17 @@ static void radeon_check_arguments(struc
 static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
-	struct radeon_device *rdev = dev->dev_private;
 
 	if (radeon_is_px(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
-		unsigned d3_delay = dev->pdev->d3_delay;
-
 		printk(KERN_INFO "radeon: switched on\n");
 		/* don't suspend or resume card normally */
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
-		if (d3_delay < 20 && (rdev->px_quirk_flags & RADEON_PX_QUIRK_LONG_WAKEUP))
-			dev->pdev->d3_delay = 20;
-
 		radeon_resume_kms(dev, true, true);
 
-		dev->pdev->d3_delay = d3_delay;
-
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
 		drm_kms_helper_poll_enable(dev);
 	} else {
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1648,6 +1648,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
 
+static void quirk_radeon_pm(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
+	    dev->subsystem_device == 0x00e2) {
+		if (dev->d3_delay < 20) {
+			dev->d3_delay = 20;
+			dev_info(&dev->dev, "extending delay after power-on from D3 to %d msec\n",
+				 dev->d3_delay);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
+
 #ifdef CONFIG_X86_IO_APIC
 static int dmi_disable_ioapicreroute(const struct dmi_system_id *d)
 {

