Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZq6KcVCTvWR1Xe0YuGLZnQXLj9sIvQj3ljoX9C7ppzt7/v8s2UZAMkp8i3fLyECJ+A/wQOG
ARC-Seal: i=1; a=rsa-sha256; t=1525323847; cv=none;
        d=google.com; s=arc-20160816;
        b=0NMeQtbHK/6qzu1qJP+P//6QdZhCxEWjnkwJIoYkJszw7mevi9nIw4xl9ZUG7eStxj
         tBJ92EUvpnt2jdjb6tpN1B2tYuR683wnZK1f3yFoaswZWGoEk/5gVkNhe3t+9iv5gKUz
         dQLytg409wglnrfx+gpdrGW/CN8427lREAWYTKXaQdsSezYwnp024BeAmQBzFJVFwkvX
         Th3zUai5W+NpanLqCj8GTEUvROBWqOnsQvtg+zd2YdCRk5oDc2MkfA5RnQmIXj/vCokf
         0v4eGPGMmNNV5xC4hNRMSDjPPZ3ZVxdUvOU2ZKIHNaoctLI7SDp+MKpY1fBjNsppvwrr
         A02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Yh/2EHBJsENWBe2qArUC3sNAAx82Q2jm9hqqSSD3Kkg=;
        b=JZArSpZ1PlFp5AV1ZDgaGFlA+oxaS0NnjkDzBKzJMUsVSX0JTuMdGW6GJa1zTkpIv4
         uYH9Q5pvAGizf6umiOnbCUPds6n1agPWOmch3lugjlozBr9S7a53lnu5CNXeTGDc3aGq
         49sR89wQTdR85WbYKNVd7DQ0xHuyXP7Mz6NxiWyBsCQ2HE88yCDxDGeTZpYWNjQDQ/zI
         ryuF3LtySsyE0vuu5XG4yMEt2ByjWwfHhg9kuUnPXNlnEJvi9z7nW9nT3SkkkpmaoEMJ
         yoOsIA8Xb2ewv/19ZAa5dTPhtxdlxEKQfeOYf0CbZAYI4r9wYgVhZVWy89JTR7bfu1IY
         cJvw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 65.197.215.72 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="126361302"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="182707668"
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
Subject: [PATCH v15 9/9] PCI/DPC: Disable ERR_NONFATAL and enable ERR_FATAL for DPC
Date: Thu,  3 May 2018 01:03:58 -0400
Message-Id: <1525323838-1735-10-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417977949532596?=
X-GMAIL-MSGID: =?utf-8?q?1599417977949532596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch disables ERR_NONFATAL trigger for DPC, so now DPC
handles only ERR_FATAL.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index aed7c9f..6966e00 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -263,7 +263,7 @@ static int dpc_probe(struct pcie_device *dev)
 		}
 	}
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -281,7 +281,7 @@ static void dpc_remove(struct pcie_device *dev)
 	u16 ctl;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 }
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 103ba79..86f1cc2 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -981,6 +981,7 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
+#define	 PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
 #define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
 
-- 
2.7.4
