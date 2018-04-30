Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqhbzL5M5FJt9b49kv8CC+xz63DpnMhe8qhIyV/mZx4WMn4XYhT2Yq8GWyjTEu6OYYApxL5
ARC-Seal: i=1; a=rsa-sha256; t=1525116476; cv=none;
        d=google.com; s=arc-20160816;
        b=ITx6f2oFjre6dLE5CgFlD2jjpfZVYKFKUJfX4rrE8pcAtkP6lkBqWRrFaAJ0H9C0M2
         bJTvX4Wm1baDdrpI3/kdvlpyV4kQVovak19puvFFs/AMVwht6YVzU/QijWAyRYRhyZFk
         p7bsAA6uuDy3zqp9K8uxgeLrfRAHpD4I1H6SKTGgkBSEI1TFIx2EBVWTVRnkTgoN8iOH
         pZIbhiT+Vfj/yxyaTx8aCiTo9XZuJ20Z/wjHs/zufUwR/uiaSrbkIL+bEn3m/Isv4PAw
         ou8uMVcT0jweD1Jn4MK+FQ3oWenHhXXe162/Sh8tgeYaFjfyK52sjTXhauinWDbGMO4T
         d1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=UzoO5x2cPHlbYi/ixCihoJCZiZotHTgslF9f2QcyoAI=;
        b=p2xI495Q3pvGt8Vaf70fYBc2UO9YGn8bVMVAsAQevMtLNuAQR+ifWh/uJyge7rPDHl
         GIJEF069zRasip9iqbTI6aB9I8taoaSiikZazogGoDYtyvOfnRmbuXzfn/8NO7OLuw5h
         ma9u8J5ObTtHLIGtyVQurYTgWdmz/Y3dQzZg0n6qzrOPqRIcyKfInrzDNH9vYJ/etXRu
         aUUYa+Q3Ysq1CFIZ7uUjEIGM1MxTZe44Q+hGuuqFYo2cN5/l5cTNa6CDt0ScR7hS8Vlg
         4ShKDjvqbEt87McOJi1iKRoOFvM7JH6alpN6xIhLvyFU7hfAFe4/f7beyVXg7NKXoUhi
         rLvQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0597E22DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.16 015/113] xhci: Fix USB ports for Dell Inspiron 5775
Date: Mon, 30 Apr 2018 12:23:46 -0700
Message-Id: <20180430184015.719439043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200473674705652?=
X-GMAIL-MSGID: =?utf-8?q?1599200534759444716?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 621faf4f6a181b6e012c1d1865213f36f4159b7f upstream.

The Dell Inspiron 5775 is a Raven Ridge. The Enable Slot command timed
out when a USB device gets plugged:
[ 212.156326] xhci_hcd 0000:03:00.3: Error while assigning device slot ID
[ 212.156340] xhci_hcd 0000:03:00.3: Max number of devices this xHCI host supports is 64.
[ 212.156348] usb usb2-port3: couldn't allocate usb_device

AMD suggests that a delay before xHC suspends can fix the issue.

I can confirm it fixes the issue, so use the suspend delay quirk for
Raven Ridge's xHC.

Cc: stable@vger.kernel.org
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -126,7 +126,10 @@ static void xhci_pci_quirks(struct devic
 	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |= XHCI_AMD_PLL_FIX;
 
-	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
+	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
+		(pdev->device == 0x15e0 ||
+		 pdev->device == 0x15e1 ||
+		 pdev->device == 0x43bb))
 		xhci->quirks |= XHCI_SUSPEND_DELAY;
 
 	if (pdev->vendor == PCI_VENDOR_ID_AMD)
