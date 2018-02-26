Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227+VsDrDH9Kvsf5Nn9B6vMB4Wg4GRwgXe0xSUOlhPzcvlbu8hU97d0AIp0BuvjsYxVJ3Vda
ARC-Seal: i=1; a=rsa-sha256; t=1519676666; cv=none;
        d=google.com; s=arc-20160816;
        b=RSZJp74RsrQ2Z1F4UjJ81OIEHp+2vWmk6t5wWursWsH8NTiV7sNts162pEERfHnTAZ
         jWv3oUfYjhS5wrkl/Do8U/4y6hXydIKJkj9e6ljaKOdnOgSZOafoUbrPze5WjesTm2ZM
         a64Sb8amIzGVKsl2b3BAn23fC4hkU5VLpkWijXEocv5qNLME/B7wDN2zHNuWzpVhByOS
         aQxWInwZy6zbekNo/TbegXO/aMTqMO2eQZvhAQsMoSsOap7+iWfGu4Wznr2dohq+13lO
         9wghjJweWdmyaMBqpyBwWWN3RJZ/ZXAIj82RZTlruJnoRFIzqUD73XyExxn1oOgMbQDK
         RqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=NKNsAPgMiZx96GwIJ9jsBcoAAj+lm5YSXm1zQHVdvdg=;
        b=vmvYgGYq86APwtsUtF2khi1ofRkOj7ZVMuZZ0pgfsCSPZ4q1s7oVvCKqGC0K7/hKe9
         KfFPMOjxTAxLQblWB8sntQrcoGp0LWnwOuRJwIGfvG2GLcHqH+5eGqDwoj416A/fV/tG
         33+ETyodpcVcIiJN+zxoUFRRRJo1DZiPDlHZARadJutwTNLWUafcUH8mETHteWpgz6Uw
         +xR5KPQJjk1Y6uF4aYM2NpvFOgGLpN9tgR/JrQekNGigiUOhoSLMmDnTnlK98KjSY4lL
         u08k1AtQvxqDGUPA4qmSf5TnrM+giTlGNQr5MFepR2RCk8OEUvALAfVIDoeZ7iGJhLSg
         Dvbg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Casey Leedom <leedom@chelsio.com>,
	Arjun Vynipadath <arjun@chelsio.com>,
	Ganesh Goudar <ganeshgr@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 30/54] PCI/cxgb4: Extend T3 PCI quirk to T4+ devices
Date: Mon, 26 Feb 2018 21:22:07 +0100
Message-Id: <20180226202145.900045822@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496284533740690?=
X-GMAIL-MSGID: =?utf-8?q?1593496479943895275?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Casey Leedom <leedom@chelsio.com>

commit 7dcf688d4c78a18ba9538b2bf1b11dc7a43fe9be upstream.

We've run into a problem where our device is attached
to a Virtual Machine and the use of the new pci_set_vpd_size()
API doesn't help.  The VM kernel has been informed that
the accesses are okay, but all of the actual VPD Capability
Accesses are trapped down into the KVM Hypervisor where it
goes ahead and imposes the silent denials.

The right idea is to follow the kernel.org
commit 1c7de2b4ff88 ("PCI: Enable access to non-standard VPD for
Chelsio devices (cxgb3)") which Alexey Kardashevskiy authored
to establish a PCI Quirk for our T3-based adapters. This commit
extends that PCI Quirk to cover Chelsio T4 devices and later.

The advantage of this approach is that the VPD Size gets set early
in the Base OS/Hypervisor Boot and doesn't require that the cxgb4
driver even be available in the Base OS/Hypervisor.  Thus PF4 can
be exported to a Virtual Machine and everything should work.

Fixes: 67e658794ca1 ("cxgb4: Set VPD size so we can read both VPD structures")
Cc: <stable@vger.kernel.org>  # v4.9+
Signed-off-by: Casey Leedom <leedom@chelsio.com>
Signed-off-by: Arjun Vynipadath <arjun@chelsio.com>
Signed-off-by: Ganesh Goudar <ganeshgr@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c |   10 --------
 drivers/pci/quirks.c                       |   35 +++++++++++++++++------------
 2 files changed, 21 insertions(+), 24 deletions(-)

--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -2632,7 +2632,6 @@ void t4_get_regs(struct adapter *adap, v
 }
 
 #define EEPROM_STAT_ADDR   0x7bfc
-#define VPD_SIZE           0x800
 #define VPD_BASE           0x400
 #define VPD_BASE_OLD       0
 #define VPD_LEN            1024
@@ -2670,15 +2669,6 @@ int t4_get_raw_vpd_params(struct adapter
 	if (!vpd)
 		return -ENOMEM;
 
-	/* We have two VPD data structures stored in the adapter VPD area.
-	 * By default, Linux calculates the size of the VPD area by traversing
-	 * the first VPD area at offset 0x0, so we need to tell the OS what
-	 * our real VPD size is.
-	 */
-	ret = pci_set_vpd_size(adapter->pdev, VPD_SIZE);
-	if (ret < 0)
-		goto out;
-
 	/* Card information normally starts at VPD_BASE but early cards had
 	 * it at 0.
 	 */
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3412,22 +3412,29 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_IN
 
 static void quirk_chelsio_extend_vpd(struct pci_dev *dev)
 {
-	pci_set_vpd_size(dev, 8192);
+	int chip = (dev->device & 0xf000) >> 12;
+	int func = (dev->device & 0x0f00) >>  8;
+	int prod = (dev->device & 0x00ff) >>  0;
+
+	/*
+	 * If this is a T3-based adapter, there's a 1KB VPD area at offset
+	 * 0xc00 which contains the preferred VPD values.  If this is a T4 or
+	 * later based adapter, the special VPD is at offset 0x400 for the
+	 * Physical Functions (the SR-IOV Virtual Functions have no VPD
+	 * Capabilities).  The PCI VPD Access core routines will normally
+	 * compute the size of the VPD by parsing the VPD Data Structure at
+	 * offset 0x000.  This will result in silent failures when attempting
+	 * to accesses these other VPD areas which are beyond those computed
+	 * limits.
+	 */
+	if (chip == 0x0 && prod >= 0x20)
+		pci_set_vpd_size(dev, 8192);
+	else if (chip >= 0x4 && func < 0x8)
+		pci_set_vpd_size(dev, 2048);
 }
 
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x20, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x21, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x22, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x23, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x24, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x25, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x26, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x30, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x31, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x32, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x35, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x36, quirk_chelsio_extend_vpd);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, 0x37, quirk_chelsio_extend_vpd);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
+			quirk_chelsio_extend_vpd);
 
 #ifdef CONFIG_ACPI
 /*
