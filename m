Return-Path: <dev@g0hl1n.net>
X-Google-Smtp-Source: AG47ELvEArW06aczDTFILuf1n+0ZcMF2lu23B/hjDgoyQSXqFR7ZcF9Tz5Q9GUrelT0qR09sUaqK
ARC-Seal: i=1; a=rsa-sha256; t=1521023391; cv=none;
        d=google.com; s=arc-20160816;
        b=yIL1NsAO0aLHqt1dt6cOUGT6SXmc4J19fY+Ekb+CtnrDazqvWebm0GtOzXuqRqVcsf
         buRMl2HfhGZJJ3s2Bu0V0iysXvw4TblovA8RImuiRwE8vEZAopKZC5gyfbQcOmiuO7ty
         uiREZNkS/q7/aIB9FYDtLrRp929PnJJISlPnprd52J7SVaVgiGgKlSGPRX4LN8N6M8pf
         3Ulql7ObA+k4jLxfTpVko36xzKOR4tzBqzfsltawcZP9pbYqk7hscw8fAl9JAGoIgCgm
         nvUptsl4zcUBAkGWCyRaNZCAw4LvehA2qZr5KhCuFcNCZ/FGbFAyUrDAqGFuySFdbyy+
         AL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=knXs2BB1BrdB9x498dN9hhrSMRLKV8Wv3F9MmIqTp/I=;
        b=DnYZBadEA6FE9pFyjkaqDNI991gR9ERzKwIIKx0qG4uKMHbqy26RUIZa51VmmhiPlU
         yAv9a14jMYxscZFUzDQOTitk/RlH5dvlbzGbf7th9mxuWqIfOl3N7obkcFu3BnU3+NhM
         Bt6MSuz7qlFfmX/b8gYT0/MCUDaaPU5NYqFEXmaRnNhBOiOefi7CpD74mNlb9haaFnkD
         Dmh+UqL7ggR3BP8elV8FV6c0ViY7sLUqfcV5vNuoihx7DstRiiXucUqV2MkEwd9svyF7
         0jPCaUcXBAf7lWHaDsSqu798RtYEhnDBCvOw9Qt1QL1S7lt5GSQQ/Or08a+y3fMpzNj9
         X4wA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 109.237.142.228 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 109.237.142.228 is neither permitted nor denied by best guess record for domain of dev@g0hl1n.net) smtp.mailfrom=dev@g0hl1n.net
X-Spam-DCC: : 
From: Richard Leitner <dev@g0hl1n.net>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	mathias.nyman@intel.com,
	bhelgaas@google.com,
	richard.leitner@skidata.com
Subject: [PATCH 1/3] usb: host: pci: use existing Intel PCI ID macros
Date: Wed, 14 Mar 2018 11:29:31 +0100
Message-Id: <20180314102933.21367-2-dev@g0hl1n.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180314102933.21367-1-dev@g0hl1n.net>
References: <20180314102933.21367-1-dev@g0hl1n.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908623933686483?=
X-GMAIL-MSGID: =?utf-8?q?1594908623933686483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Richard Leitner <richard.leitner@skidata.com>

Instead of the hardcoded hexadecimal PCI IDs use the existing macros
from pci_ids.h for Intel IDs.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
 drivers/usb/host/pci-quirks.c | 10 +++++-----
 drivers/usb/host/xhci-pci.c   |  3 ++-
 include/linux/pci_ids.h       |  1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/pci-quirks.c b/drivers/usb/host/pci-quirks.c
index 67ad4bb6919a..4f4a9f36a68e 100644
--- a/drivers/usb/host/pci-quirks.c
+++ b/drivers/usb/host/pci-quirks.c
@@ -858,8 +858,8 @@ static void ehci_bios_handoff(struct pci_dev *pdev,
 	 *
 	 * The HASEE E200 hangs when the semaphore is set (bugzilla #77021).
 	 */
-	if (pdev->vendor == 0x8086 && (pdev->device == 0x283a ||
-			pdev->device == 0x27cc)) {
+	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&
+	    (pdev->device == 0x283a || pdev->device == 0x27cc)) {
 		if (dmi_check_system(ehci_dmi_nohandoff_table))
 			try_handoff = 0;
 	}
@@ -1168,9 +1168,9 @@ static void quirk_usb_handoff_xhci(struct pci_dev *pdev)
 	val = readl(base + ext_cap_offset);
 
 	/* Auto handoff never worked for these devices. Force it and continue */
-	if ((pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241) ||
-			(pdev->vendor == PCI_VENDOR_ID_RENESAS
-			 && pdev->device == 0x0014)) {
+	if ((pdev->vendor == PCI_VENDOR_ID_TI &&
+	     pdev->device == PCI_DEVICE_ID_TI_TUSB73X0) ||
+	    (pdev->vendor == PCI_VENDOR_ID_RENESAS && pdev->device == 0x0014)) {
 		val = (val | XHCI_HC_OS_OWNED) & ~XHCI_HC_BIOS_OWNED;
 		writel(val, base + ext_cap_offset);
 	}
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 5262fa571a5d..a5bfd890190c 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -213,7 +213,8 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_ASMEDIA_MODIFY_FLOWCONTROL;
 
-	if (pdev->vendor == PCI_VENDOR_ID_TI && pdev->device == 0x8241)
+	if (pdev->vendor == PCI_VENDOR_ID_TI &&
+	    pdev->device == PCI_DEVICE_ID_TI_TUSB73X0)
 		xhci->quirks |= XHCI_LIMIT_ENDPOINT_INTERVAL_7;
 
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index a6b30667a331..e8d1af82a688 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -838,6 +838,7 @@
 #define PCI_DEVICE_ID_TI_XX12		0x8039
 #define PCI_DEVICE_ID_TI_XX12_FM	0x803b
 #define PCI_DEVICE_ID_TI_XIO2000A	0x8231
+#define PCI_DEVICE_ID_TI_TUSB73X0	0x8241
 #define PCI_DEVICE_ID_TI_1130		0xac12
 #define PCI_DEVICE_ID_TI_1031		0xac13
 #define PCI_DEVICE_ID_TI_1131		0xac15
-- 
2.11.0
