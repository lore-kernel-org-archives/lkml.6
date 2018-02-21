Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224dU/1t1PVAIbZucjNMH2c3sRzPuojutirwF4cvtpI+L3BarKb9/MNhTWGJTYib0xTOsmTp
ARC-Seal: i=1; a=rsa-sha256; t=1519218273; cv=none;
        d=google.com; s=arc-20160816;
        b=lr+/r+xmDrem94lPESQajR5uy8fIGq6xMn7xLkGdPE59PHmINPpRuBjdDVnmolsliX
         F007idoif5Ul2+XlknUwue/FUfg/9d4fSkqEVDikX0xQuQwsEnu0/qXnrsuc6itsO9sn
         7A6E2HJh7+CPUjyA+Q/UwZtGW8UmbbTn5NBGNoIGz/E9pVbOpcFLXOA5/irZ/AA/Dk5h
         Tfn5CrjExJmkLzWzNU1BCCoasNifhxg8zk4o/IzuI8RVtNn5fu2LDbNmrtfAmJ/47Xac
         kx3THOY+dw18JKmFHaKviV2alxlVY/njezBIWfczEXdmGpf2yDaFXtGkF1xwqkFcdOjg
         GL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=58hjT/S3p6Mvf2jKmaFL7HLBlV4I8ABYSKTQ9kh7xYw=;
        b=CuInC/Cns1/HeNLqPR19dNjt4x6P4HHNoH48Upjt4PyIb1QxWiIeSj6TNdi33/1glI
         PbMIXicD4tN+H52G7pFb+QqjROWhcOieJZYBkowT3+X2Mnv6B6XbkgF02MG6oZQWDLmI
         W4X2kbMIP9WLVyAYLBn0k27BmXsDvSeDvSsMpsuK5Mv2Qgoe9eMhLkPDaVuXEsXMogNe
         THiYBBjGNgiMEoamRPVBSS0kay3DaQc93kb80/bg9Z6lTRNj4GZKAT6VLkqK7ogwSLb9
         9TY7eZTdS1JQZUcNjTdr+lw9wdTv2QMEubqVaXtYMf8U9UX8ZhCtFCEja+xhKXScsZJ4
         fYZg==
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
Subject: [PATCH 4.14 113/167] PCI: Disable MSI for HiSilicon Hip06/Hip07 only in Root Port mode
Date: Wed, 21 Feb 2018 13:48:44 +0100
Message-Id: <20180221124530.579888907@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015819879372165?=
X-GMAIL-MSGID: =?utf-8?q?1593015819879372165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
