Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m5m+MaVGGVtjOAAAmS7hNA
	; Thu, 07 Jun 2018 14:52:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B86C0608BA; Thu,  7 Jun 2018 14:52:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49A13601C3;
	Thu,  7 Jun 2018 14:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49A13601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935194AbeFGOwR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:52:17 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40905 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbeFGOwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:52:15 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zq-H5; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-000372-GL; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ben Crocker" <bcrocker@redhat.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.665890176@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 278/410] drm/radeon: insist on 32-bit DMA for Cedar
 on PPC64/PPC64LE
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
@@ -1339,6 +1339,10 @@ int radeon_device_init(struct radeon_dev
 	if ((rdev->flags & RADEON_IS_PCI) &&
 	    (rdev->family <= CHIP_RS740))
 		rdev->need_dma32 = true;
+#ifdef CONFIG_PPC64
+	if (rdev->family == CHIP_CEDAR)
+		rdev->need_dma32 = true;
+#endif
 
 	dma_bits = rdev->need_dma32 ? 32 : 40;
 	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
