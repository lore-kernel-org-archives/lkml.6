Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75FCC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE4F2084A
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbfBCOVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55764 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730433AbfBCOVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:18 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe5-0006Pr-4S; Sun, 03 Feb 2019 14:21:17 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007Ob-Fv; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Nehal Shah" <Nehal-bakulchandra.Shah@amd.com>,
        "Sandeep Singh" <Sandeep.Singh@amd.com>,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
        "Sandeep Singh" <sandeep.singh@amd.com>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.251790181@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 268/305] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
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

From: Sandeep Singh <sandeep.singh@amd.com>

commit a7d57abcc8a5bdeb53bbf8e87558e8e0a2c2a29d upstream.

Occasionally AMD SNPS 3.0 xHC does not respond to
CSS when set, also it does not flag anything on SRE and HCE
to point the internal xHC errors on USBSTS register. This stalls
the entire system wide suspend and there is no point in stalling
just because of xHC CSS is not responding.

To work around this problem, if the xHC does not flag
anything on SRE and HCE, we can skip the CSS
timeout and allow the system to continue the suspend. Once the
system resume happens we can internally reset the controller
using XHCI_RESET_ON_RESUME quirk

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Sandeep Singh <Sandeep.Singh@amd.com>
cc: Nehal Shah <Nehal-bakulchandra.Shah@amd.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Use next available quirk bit
 - Fold in commit 2419f30a4a4f "USB: xhci: fix 'broken_suspend' placement ..."
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-pci.c |  4 ++++
 drivers/usb/host/xhci.c     | 26 ++++++++++++++++++++++----
 drivers/usb/host/xhci.h     |  3 +++
 3 files changed, 29 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -130,6 +130,10 @@ static void xhci_pci_quirks(struct devic
 		 pdev->device == 0x43bb))
 		xhci->quirks |= XHCI_SUSPEND_DELAY;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+	    (pdev->device == 0x15e0 || pdev->device == 0x15e1))
+		xhci->quirks |= XHCI_SNPS_BROKEN_SUSPEND;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -908,6 +908,7 @@ int xhci_suspend(struct xhci_hcd *xhci,
 	unsigned int		delay = XHCI_MAX_HALT_USEC;
 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
 	u32			command;
+	u32			res;
 
 	if (hcd->state != HC_STATE_SUSPENDED ||
 			xhci->shared_hcd->state != HC_STATE_SUSPENDED)
@@ -954,11 +955,28 @@ int xhci_suspend(struct xhci_hcd *xhci,
 	command = readl(&xhci->op_regs->command);
 	command |= CMD_CSS;
 	writel(command, &xhci->op_regs->command);
+	xhci->broken_suspend = 0;
 	if (xhci_handshake(xhci, &xhci->op_regs->status,
 				STS_SAVE, 0, 10 * 1000)) {
-		xhci_warn(xhci, "WARN: xHC save state timeout\n");
-		spin_unlock_irq(&xhci->lock);
-		return -ETIMEDOUT;
+	/*
+	 * AMD SNPS xHC 3.0 occasionally does not clear the
+	 * SSS bit of USBSTS and when driver tries to poll
+	 * to see if the xHC clears BIT(8) which never happens
+	 * and driver assumes that controller is not responding
+	 * and times out. To workaround this, its good to check
+	 * if SRE and HCE bits are not set (as per xhci
+	 * Section 5.4.2) and bypass the timeout.
+	 */
+		res = readl(&xhci->op_regs->status);
+		if ((xhci->quirks & XHCI_SNPS_BROKEN_SUSPEND) &&
+		    (((res & STS_SRE) == 0) &&
+				((res & STS_HCE) == 0))) {
+			xhci->broken_suspend = 1;
+		} else {
+			xhci_warn(xhci, "WARN: xHC save state timeout\n");
+			spin_unlock_irq(&xhci->lock);
+			return -ETIMEDOUT;
+		}
 	}
 	spin_unlock_irq(&xhci->lock);
 
@@ -1007,7 +1025,7 @@ int xhci_resume(struct xhci_hcd *xhci, b
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
 
 	spin_lock_irq(&xhci->lock);
-	if (xhci->quirks & XHCI_RESET_ON_RESUME)
+	if ((xhci->quirks & XHCI_RESET_ON_RESUME) || xhci->broken_suspend)
 		hibernated = true;
 
 	if (!hibernated) {
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1572,6 +1572,7 @@ struct xhci_hcd {
 #define XHCI_U2_DISABLE_WAKE	(1 << 27)
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_SUSPEND_DELAY	(1 << 30)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT(31)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
@@ -1588,6 +1589,8 @@ struct xhci_hcd {
 	unsigned		sw_lpm_support:1;
 	/* support xHCI 1.0 spec USB2 hardware LPM */
 	unsigned		hw_lpm_support:1;
+	/* Broken Suspend flag for SNPS Suspend resume issue */
+	unsigned		broken_suspend:1;
 	/* cached usb2 extened protocol capabilites */
 	u32                     *ext_caps;
 	unsigned int            num_ext_caps;

