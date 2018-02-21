Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225omlKpjGhYbijdfjzdHqHvr3O5s6XuohIlJIgTI8YLvjTSnGUr4T7LFT2xT7qHc7WLWGro
ARC-Seal: i=1; a=rsa-sha256; t=1519218672; cv=none;
        d=google.com; s=arc-20160816;
        b=jKKWQu4xB9/H+HoavexRWkqNlqfgiabz3I+NIxM1REsHQ1SIUyAE2omWU6SduXNskY
         XqOQ9AyQwXFhG/64eD5R7adTo8DW5VsWLbet13lhCf9RlzflidHdzA3TPhXonRSquS6M
         84WKdR+pPrT/Dw8hdyhrDO3MrIdJhtMUF+80bisAN1kPdeft/jQgLNrdGPUwOkzrgM9K
         xh5ipLcrgfdeWkC6SDFTiRvovbLCr5i7Yh8Mt40KZDz2lAu69hsDt+jUFoh/cbSqZYUw
         UBxUZLICOXL3rNZcNKMR1AVKTIslVSWptFi0QbuCFaLhwnN0oAFsJ29b1T2e2s4T4iL3
         eIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZzfLXp5GeQRMgQN9wH7IC/FiwiXpMzZvsoSSJU1UwnI=;
        b=TrUW78p6tY5VhMEF0e6rsOp345rvr1rd5OKlPJ5dgenAd8hFEtYrN1QkTd26vYLNNz
         9YvgbEc1uXaBe27mpruTFDgtIIz0/+tysf9QRLtn/8MNFKF/o7tQIw+EnaY9x/d8v0Jn
         0lugy05drmC0Qr4ge2TimVdu94JLfmSSkDl4Jj1ZoDcgnWYE/6XcVLwmiGLidMMTuim+
         3ovMgVm9xG0kkKGJajlz69pbFq2mPFYVikXeTTIvY3UZt6WZrHjEYifoI1vTeHm+WG+J
         9TM8i/AiT/pyZV+bZxPn7tCjwsdKKbdgO9Jnk/U7UUWn1TvQgEMjtEswEseRGBOQ+38x
         7eKg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 4.15 115/163] PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode
Date: Wed, 21 Feb 2018 13:49:04 +0100
Message-Id: <20180221124536.501956276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015819879372165?=
X-GMAIL-MSGID: =?utf-8?q?1593016238814053998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dongdong Liu <liudongdong3@huawei.com>

commit deb86999323661c019ef2740eb9d479d1e526b5c upstream.

HiSilicon Hip06/Hip07 can operate as either a Root Port or an Endpoint.  It
always advertises an MSI capability, but it can only generate MSIs when in
Endpoint mode.

The device has the same Vendor and Device IDs in both modes, so check the
Class Code and disable MSI only when operating as a Root Port.

[bhelgaas: changelog]
Fixes: 72f2ff0deb87 ("PCI: Disable MSI for HiSilicon Hip06/Hip07 Root Ports")
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Cc: stable@vger.kernel.org	# v4.11+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1636,8 +1636,8 @@ static void quirk_pcie_mch(struct pci_de
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7520_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch);
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI,	0x1610,	quirk_pcie_mch);
 
+DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_HUAWEI, 0x1610, PCI_CLASS_BRIDGE_PCI, 8, quirk_pcie_mch);
 
 /*
  * It's possible for the MSI to get corrupted if shpc and acpi
