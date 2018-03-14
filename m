Return-Path: <poza@codeaurora.org>
X-Google-Smtp-Source: AG47ELvlN48Sr+cdnDrT776Ik4Sxgo7LzH8Nbl8TmEFExPfLekAr/QIXHu9exyltW7aO2UD5wC62
ARC-Seal: i=1; a=rsa-sha256; t=1521042692; cv=none;
        d=google.com; s=arc-20160816;
        b=NgahDwkk+bw2LiBDZ9nYEapBTbRxx7Vnk36cS1Rjgf3iysj1qTXXsUs0RIrL91jTgz
         hbvF+ylPwsE0XOrbXmhjZ3sUPlXXb6yK1c+vBmHWzuPDYGe8AinEis93XwPQ0Ua0boqH
         4NlaRQRXaWrws/1pJ0Lkpum1sadOKpCwrMjaW75Ns7l+GQclak02FQN0Gum/JKNL/ECK
         Y0G+85sa8PrN9xdjL4g5TA996515lQX/dp4SLZOtRSr8gQTmyhlzrNjjBHZLeEdJV5jX
         KBkUlhXp/9RvG+tacJ1a5ka3gs3eAU51CK5U3/Jl3aamzYoyW8xJbPn27f8X3XfPW2ey
         ipPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dmarc-filter:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=MWAXHAHjr/JMj1MWbzr6jXLoDMTqvFSsN9g7BrY+/zU=;
        b=ndWXpLH2K8xlPNHGU/gG7mvSiOFVF4GuZ4Mkev6i5i3EDbmjOuZbYJyZIMGvVqJAu0
         qQdoVtdZKmHNfQiY/hBEfo/DzccmVO6O/hgxqMmBbQhpqwmqIVCGX4Y1djBVN5eDdFj9
         82/KqFBhYxPXxckwAlaxxPfpv81NTw2W/Yz/o6o3nDUDaH7fGitVGkxxhrRdPhvcJU+W
         UR5n2MElQHD0aG1CeIhlX2gn5v393hfS4URYGkjw/98GsezmmOGp6PAYc9Yq2HSYPWz9
         FusuJFpTMbIYdRMSaBksmJvclhWkD4Zj4ebXdgSL6l1Etvq4SZgm6wtK1eIn3sCgkFbm
         crKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=A6/IwC0X;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lLg1bjgt;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=A6/IwC0X;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=lLg1bjgt;
       spf=pass (google.com: domain of poza@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=poza@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 076A060592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=poza@codeaurora.org
From: Oza Pawandeep <poza@codeaurora.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dongdong Liu <liudongdong3@huawei.com>,
	Keith Busch <keith.busch@intel.com>,
	Wei Zhang <wzhang@fb.com>,
	Sinan Kaya <okaya@codeaurora.org>,
	Timur Tabi <timur@codeaurora.org>
Cc: Oza Pawandeep <poza@codeaurora.org>
Subject: [PATCH v2] PCI/DPC: Fix PCI legacy interrupt acknowledgement
Date: Wed, 14 Mar 2018 21:20:48 +0530
Message-Id: <1521042648-20522-1-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594928862601446730?=
X-GMAIL-MSGID: =?utf-8?q?1594928862601446730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Current DPC driver acknowledges the interrupt in deferred work, which works
since MSI are edge triggered.

But when MSI is disabled (e.g. pci=nomsi boot option) port service
driver falls back to PCI legacy INT interrupt.

With current code we do not acknowledge the interrupt back in dpc_irq()
and we get dpc interrupt storm.

This patch acknowledges the interrupt in interrupt handler.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 38e40c6..9c05120 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -112,7 +112,7 @@ static void dpc_work(struct work_struct *work)
 	}
 
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
-		PCI_EXP_DPC_STATUS_TRIGGER | PCI_EXP_DPC_STATUS_INTERRUPT);
+			      PCI_EXP_DPC_STATUS_TRIGGER);
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_CTL, &ctl);
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_CTL,
@@ -222,6 +222,9 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	if (dpc->rp_extensions && reason == 3 && ext_reason == 0)
 		dpc_process_rp_pio_error(dpc);
 
+	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_INTERRUPT);
+
 	schedule_work(&dpc->work);
 
 	return IRQ_HANDLED;
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.,
a Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
