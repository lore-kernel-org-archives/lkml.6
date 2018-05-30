Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbeE3L3Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:29:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60893 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752330AbeE3LHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:04 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Alex Deucher" <alexander.deucher@amd.com>,
        "Ben Crocker" <bcrocker@redhat.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.641674187@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 105/153] drm/radeon: insist on 32-bit DMA for Cedar on
 PPC64/PPC64LE
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Crocker <bcrocker@redhat.com>

commit 2c83029cda55a5e7665c7c6326909427d6a01350 upstream.

In radeon_device_init, set the need_dma32 flag for Cedar chips
(e.g. FirePro 2270).  This fixes, or at least works around, a bug
on PowerPC exposed by last year's commits

8e3f1b1d8255105f31556aacf8aeb6071b00d469 (Russell Currey)

and

253fd51e2f533552ae35a0c661705da6c4842c1b (Alistair Popple)

which enabled the 64-bit DMA iommu bypass.

This caused the device to freeze, in some cases unrecoverably, and is
the subject of several bug reports internal to Red Hat.

Signed-off-by: Ben Crocker <bcrocker@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/radeon/radeon_device.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -784,6 +784,10 @@ int radeon_device_init(struct radeon_dev
 	if ((rdev->flags & RADEON_IS_PCI) &&
 	    (rdev->family <= CHIP_RS740))
 		rdev->need_dma32 = true;
+#ifdef CONFIG_PPC64
+	if (rdev->family == CHIP_CEDAR)
+		rdev->need_dma32 = true;
+#endif
 
 	dma_bits = rdev->need_dma32 ? 32 : 40;
 	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
