Return-Path: <dev@g0hl1n.net>
X-Google-Smtp-Source: AG47ELv3Zj7isGcYkl2pZ60BM2A7CQY+qfGYp8cKSQxz4EuFWAkJsUIr4MTgTNXqJLanNxdbrRm6
ARC-Seal: i=1; a=rsa-sha256; t=1521023398; cv=none;
        d=google.com; s=arc-20160816;
        b=I9zEc5XzMvxUF1VTPP485JyYk3ypCZME5s5UNKT1nOggYsR4+XTEKxJrxfSmd2hXIK
         KyIVWAgpBsm9bRbuuNmgbBUu0sYfuHRN5mdJebRKqpZ8otwKWpix9/1d2f7FfOdljWaY
         pi4JtsrnzxpFtMk1Jy54Smgyp6TZPYrbREQSLh1CGe6n84yRjB2olV+1PhavOJflRE3p
         LbaGp4ByxQwTZ5kSfCC2/ZtJGdwD6SzQR2b+jAMpTCLZRY4U7yrj6i8/bmU7++OXdPDl
         b3J+piBfZ8KcU1Aqus08blLtiQDgcfz6L3KBYrbi734g5rSW90WgTVsH5V1F0cmy7FCy
         585g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XX5qrnja7q32g4MtAzLuKah7aRupCwOxUm4yzZnYMYo=;
        b=uEi3kyJhwh12HlYijO6Y7Cj+73H8OILBSRqqfuY0EAWg8qytcDIS0Fl58RoNXcnyx2
         fKvcd5vcT6Lg1tLFEk8sFsGudH3c3+wXfJDBmnvPWEGY//Vi8WR/ZCgq1SInVNFd9G4W
         Uq/wGZw6RDyHsfbPEiorv5I7WCrSA3rLeQiuAWmVTJKwE4wjyfnFdLjGSTaC6CA7fnwY
         z9S1Mq0Bivp2Bx4eF2jdjkk8/m00OM9DOtg+/jPiljcZyUbKE90WHeKDcnnZNv+0E//Q
         pUFLbJDThHn85+uaf5oZvljiqAbfqpfU98vwDv5OI3Ykvu4uOW67C8jN0azhbbKQ0A/+
         2E3g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.237.142.231 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.237.142.231 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
X-Spam-DCC: : 
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com,
	bhelgaas@google.com,
	richard.leitner@skidata.com
Subject: [PATCH 3/3] usb: host: pci: replace hardcoded renesas PCI IDs
Date: Wed, 14 Mar 2018 11:29:33 +0100
Message-Id: <20180314102933.21367-4-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180314102933.21367-1-dev@g0hl1n.net>
References: <20180314102933.21367-1-dev@g0hl1n.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908630617691660?=
X-GMAIL-MSGID: =?utf-8?q?1594908630617691660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

Introduce Renesas uPD72020{1,2} PCI device IDs in pci_ids.h and replace
the harcoded values with them.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/usb/host/pci-quirks.c | 6 ++++--
 drivers/usb/host/xhci-pci.c   | 4 ++--
 include/linux/pci_ids.h       | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 39d163729b89..5e1ad523622e 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -1170,7 +1170,8 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	/* Auto handoff never worked for these devices. Force it and continue */
 	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
 	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||
-	    (pdev->vendor == PCI_VENDOR_ID_RENESAS && pdev->device == 0x0014)) {
+	    (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
+	     pdev->device == PCI_DEVICE_ID_RENESAS_UPD720201)) {
 		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
 		writel(val, base + ext_cap_offset);
 	}
@@ -1282,7 +1283,8 @@ bool usb_xhci_needs_pci_reset(struct pci_dev *pdev)
 	 * quirk, or the system will be in a rather bad state.
 	 */
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-	    (pdev->device == 0x0014 || pdev->device == 0x0015))
+	    (pdev->device == PCI_DEVICE_ID_RENESAS_UPD720201 ||
+	     pdev->device == PCI_DEVICE_ID_RENESAS_UPD720202))
 		return true;
 
 	return false;
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index a5bfd890190c..a453e4c35ac7 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -189,10 +189,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-			pdev->device == 0x0014)
+			pdev->device == PCI_DEVICE_ID_RENESAS_UPD720201)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
-			pdev->device == 0x0015)
+			pdev->device == PCI_DEVICE_ID_RENESAS_UPD720202)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
 	if (pdev->vendor == PCI_VENDOR_ID_VIA)
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index d23a97868dee..eb52f0e9b651 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2427,6 +2427,8 @@
 #define PCI_DEVICE_ID_RENESAS_SH7763	0x0004
 #define PCI_DEVICE_ID_RENESAS_SH7785	0x0007
 #define PCI_DEVICE_ID_RENESAS_SH7786	0x0010
+#define PCI_DEVICE_ID_RENESAS_UPD720201	0x0014
+#define PCI_DEVICE_ID_RENESAS_UPD720202	0x0015
 
 #define PCI_VENDOR_ID_SOLARFLARE	0x1924
 #define PCI_DEVICE_ID_SOLARFLARE_SFC4000A_0	0x0703
-- 
2.11.0
