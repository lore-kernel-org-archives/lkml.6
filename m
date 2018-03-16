Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtIPtmKdvQ2WakED2LeuiCmeqCz28Y0LSyrH2iy0IQNX1WiaZf5Ljcr8TQ/S7XaF1DS78uC
ARC-Seal: i=1; a=rsa-sha256; t=1521214511; cv=none;
        d=google.com; s=arc-20160816;
        b=HQpAZId5c+MBAn64DP9+6spgFumdVeR6/ez9ot89eV+F8+CrgJ/4KJ4NVYhEwyiBYE
         p7NqEy5uoU8TJy7lnrj0RyNxExu5PoSM5GttYVKCWRFvqeXU6lV5/6qzMN7uo+TPqrTP
         vxlILOra0Sea3OqruSp5vIhEZhvgF+xpqCxF6v7XAg6gwrKOsGGMFzbi+2/j6N4h64/o
         qx4dYUffnvb2jHSOfSOo/GfmDNsgFVMPW0O9HryJkUKdsMQhuzceEWqe0dGciBe7z6eZ
         vwdrPt2VrWNUW+K9Bmf5OQqq1gYc8jgg2KmXjFo7MfZr7iq0+zfcQzfZidbL1+JBahf4
         Iqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Yxpap60CwzPJsSSXFlsenjZFmSOrqH09U03rjVfUAl4=;
        b=uoQrJTJPal7yMZErB0YvgHnvcBHAxNuEM7/hDvnBL06ytQLn8mF8lvA9xB81kcsWEU
         EIbUlmpFhZ68m8lcSRQfC1uKTp+PH2Oqz34xJZ015dt0rDLzKcdTch7w3c23W2Ok9pe0
         Mfbu/jMykzNn0Da5YBBJu9Q8AsS1CPt+hwDpNTI8AA5OH7R/t3JfiH/YFsz4/VoluVGk
         O4BSKv7cozr4WMhDUO/cYFUg7wot22ad7pNZ0WRsu9djN8u9EUS8WGi/rNTqgf+afgjI
         LX7JMdese69ZXG1t7786O/rG3oQ0G0SiJ/x2aD57lSbLaskLXVxclmM3OIVzs7xN9uzS
         BD1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.14 009/109] xhci: Fix front USB ports on ASUS PRIME B350M-A
Date: Fri, 16 Mar 2018 16:22:38 +0100
Message-Id: <20180316152330.341561997@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109027503736277?=
X-GMAIL-MSGID: =?utf-8?q?1595109027503736277?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 191edc5e2e515aab1075a3f0ef23599e80be5f59 upstream.

When a USB device gets plugged on ASUS PRIME B350M-A's front ports, the
xHC stops working:
[  549.114587] xhci_hcd 0000:02:00.0: WARN: xHC CMD_RUN timeout
[  549.114608] suspend_common(): xhci_pci_suspend+0x0/0xc0 returns -110
[  549.114638] xhci_hcd 0000:02:00.0: can't suspend (hcd_pci_runtime_suspend returned -110)

Delay before running xHC command CMD_RUN can workaround the issue.

Use a new quirk to make the delay only targets to the affected xHC.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    3 +++
 drivers/usb/host/xhci.c     |    3 +++
 drivers/usb/host/xhci.h     |    1 +
 3 files changed, 7 insertions(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -134,6 +134,9 @@ static void xhci_pci_quirks(struct devic
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
+		xhci->quirks |= XHCI_SUSPEND_DELAY;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -887,6 +887,9 @@ int xhci_suspend(struct xhci_hcd *xhci,
 	clear_bit(HCD_FLAG_POLL_RH, &xhci->shared_hcd->flags);
 	del_timer_sync(&xhci->shared_hcd->rh_timer);
 
+	if (xhci->quirks & XHCI_SUSPEND_DELAY)
+		usleep_range(1000, 1500);
+
 	spin_lock_irq(&xhci->lock);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1830,6 +1830,7 @@ struct xhci_hcd {
 #define XHCI_LIMIT_ENDPOINT_INTERVAL_7	(1 << 26)
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
+#define XHCI_SUSPEND_DELAY	(1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
