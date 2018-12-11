Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D1B21104
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543856;
	bh=lx6RTWUKK5VsOnnKWd5cvd3Oa34c+DI9/E8unXLkBTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lyEKwd2OKlNa3yTShvngyElhU72G9vn1S9mrRSZf7SlTmMR47wnDrxwWbHCTERLm9
	 bGY7sMuVefQMNnDiQ/d6w2V2OFYInyNX2+JYVo0QShlNit9H3x3mzfJssFhKmCKhXG
	 amgnNvF6jIRssitUmMGa3H4XqtQao1/5p8NM4SZU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D1B21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbeLKP5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730816AbeLKP5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:57:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D80B20855;
        Tue, 11 Dec 2018 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543850;
        bh=lx6RTWUKK5VsOnnKWd5cvd3Oa34c+DI9/E8unXLkBTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uu0GaL+aXuW/3GC45NXRKYsCIcc2DFMk/8Kqy1r0vchAcpgIVFG5dMghVzfxbDmCf
         KdPt9IIOBvlq7NQ3eTXjVza9c/uL6FT9CCAS/k6iN4hJ+QtsNxPZT3gftuW7PjBneN
         a+yDXq6emr1AIghqSsVVR4nqqSudbVnKQbYSkknU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Sandeep Singh <Sandeep.Singh@amd.com>,
        Nehal Shah <Nehal-bakulchandra.Shah@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 089/118] xhci: workaround CSS timeout on AMD SNPS 3.0 xHC
Date:   Tue, 11 Dec 2018 16:41:48 +0100
Message-Id: <20181211151647.860189496@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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
Cc: <stable@vger.kernel.org>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    4 ++++
 drivers/usb/host/xhci.c     |   26 ++++++++++++++++++++++----
 drivers/usb/host/xhci.h     |    3 +++
 3 files changed, 29 insertions(+), 4 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -132,6 +132,10 @@ static void xhci_pci_quirks(struct devic
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
@@ -968,6 +968,7 @@ int xhci_suspend(struct xhci_hcd *xhci,
 	unsigned int		delay = XHCI_MAX_HALT_USEC;
 	struct usb_hcd		*hcd = xhci_to_hcd(xhci);
 	u32			command;
+	u32			res;
 
 	if (!hcd->state)
 		return 0;
@@ -1021,11 +1022,28 @@ int xhci_suspend(struct xhci_hcd *xhci,
 	command = readl(&xhci->op_regs->command);
 	command |= CMD_CSS;
 	writel(command, &xhci->op_regs->command);
+	xhci->broken_suspend = 0;
 	if (xhci_handshake(&xhci->op_regs->status,
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
 
@@ -1078,7 +1096,7 @@ int xhci_resume(struct xhci_hcd *xhci, b
 	set_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
 
 	spin_lock_irq(&xhci->lock);
-	if (xhci->quirks & XHCI_RESET_ON_RESUME)
+	if ((xhci->quirks & XHCI_RESET_ON_RESUME) || xhci->broken_suspend)
 		hibernated = true;
 
 	if (!hibernated) {
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1847,6 +1847,7 @@ struct xhci_hcd {
 #define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
 #define XHCI_ZERO_64B_REGS	BIT_ULL(32)
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1876,6 +1877,8 @@ struct xhci_hcd {
 	void			*dbc;
 	/* platform-specific data -- must come last */
 	unsigned long		priv[0] __aligned(sizeof(s64));
+	/* Broken Suspend flag for SNPS Suspend resume issue */
+	u8			broken_suspend;
 };
 
 /* Platform specific overrides to generic XHCI hc_driver ops */


