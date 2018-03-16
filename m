Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsD6G2q3YiPo1HwWsKWzBRQZyjdaqltM+hrYiL3dFGGUNluHeeN/hullryGwvAV07O83mJ3
ARC-Seal: i=1; a=rsa-sha256; t=1521214853; cv=none;
        d=google.com; s=arc-20160816;
        b=u7HeF/0+DlYUYQRU9kv6+WX2QfKhHvPKIYH4jpBgtmfr6ERFNWgGACtgTMK06Ks7Ku
         QL87u8NiZMpftwbqwLHSFt1vtrQWAVmdfdk/wrL8ot/Mkg/jOe+FDN9tBFJTr8HZWXTt
         dxvobv/Rw4MromKp+2x7+ztduZIKyhuMVyZgB6mxq+7bicTOxe3NDy3RsS1MLrXdC77H
         Ye/x1IOHWkRhbv53rLR6eHQnaEwS1npqbKo/XCEpfbzx/7eLSpZ1zQ0O77m7EMPCxgf1
         H/JWrJZn8ROQzCAiMp1NpRPaz5xNI1UC4Xl6rAgWkSEpcaam2qHV3V4t3Hzx5dqtDC+S
         Kd2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TFQxyXjg3YjXEU5vW0tIgtk/ELyGvELga/P+B+N3Uv0=;
        b=o7AcUYTlapOXwId0CTVKPGSZ8d6M8oWUR1KhLDdDPNokoQnU15yBvn+yjPe8GLP36u
         hmwzlWh538mpH69CYfmbgf6wFSrIBFH2o2DUifY1IsUwqPu7LvA2zHx2yLWyFuvvAECE
         qxEaFNQ28O0/LBw5sM05kFwnx2IszQqArTpejDCTJNHAr1zHbHAPqqq0GHLxWfwooZpQ
         iQP6TNrmoCIqiTKu0P5jjhPKgdogniLmvyKhkqCqSFu+R0DC/IGZ3nbqcv8ZbAH7foa8
         SghpYpR04bHmqiZYk7KzfMuvjMn1Pgy+RLueBx4i5oBlowo04cWRO9BFLynVA+Nb3Egm
         Zrog==
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
Subject: [PATCH 4.15 007/128] xhci: Fix front USB ports on ASUS PRIME B350M-A
Date: Fri, 16 Mar 2018 16:22:28 +0100
Message-Id: <20180316152336.578509710@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109027503736277?=
X-GMAIL-MSGID: =?utf-8?q?1595109385799333819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -122,6 +122,9 @@ static void xhci_pci_quirks(struct devic
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
+	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
+		xhci->quirks |= XHCI_SUSPEND_DELAY;
+
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -880,6 +880,9 @@ int xhci_suspend(struct xhci_hcd *xhci,
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
@@ -1823,6 +1823,7 @@ struct xhci_hcd {
 /* Reserved. It was XHCI_U2_DISABLE_WAKE */
 #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
 #define XHCI_HW_LPM_DISABLE	(1 << 29)
+#define XHCI_SUSPEND_DELAY	(1 << 30)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
