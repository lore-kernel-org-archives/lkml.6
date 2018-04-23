Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4+i70UZFgnjDKNXyyKrLBl0CQPmGFKFOB/DSfpQGt1h1E7s5GmmYcnrbH0SKePXkABOtYH7
ARC-Seal: i=1; a=rsa-sha256; t=1524496998; cv=none;
        d=google.com; s=arc-20160816;
        b=lcG4Vm7q7o/aSQ5ONXiJwjoUb2KdWULlZEsSce9Vg08t0fBsXTIGRYBBauxYgsjFly
         cB99CQfkqbphri09pptB1LuDdE226P0Aww9TURLJs4byCZuQXzzb59Cwh7K4rHG1bXyr
         OySTY2JaOEwNgCFfsCieWm738MncR4hZRNAPEGfhmHwKZnRbYs3sf5EpDnQIEd0H2kBQ
         UEOvYcZMfnjtFo1NyKll4Di9dhDehndf9CFzqoYaoVipmwP8scs1Ufx2O5HD2/dadMx/
         xTVOxC29x+Hdi547poiewrr53l5GIG+wMVKBWoI03B87B0STbbUHNBydG1jJsPJSAYWD
         /cNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CJK4nceyb2ZtpnDLV8R4aQ/MpAcAJHa2MgWqZwMRaus=;
        b=B5TXCkZZKCiNURLgMC1ywDceN+DDUVNVtETtsCAhbjXAeUSxQh6zUhixFg/9/SmWE7
         rFjLu/w+qby3S0VwUtIFmC90lt0D1sY1EoWZ152Lo5JMx+QGh7/tVF8USZE92jy/TY/c
         lJWPrNF6+v4bP6W6QwE0z47tDm9WOb5HSFf0LxPIizIQxTSVpY9SoJ8y1p9k0x9JMQvA
         bx4PLXoJnmrTuclWZvCKF768LabA49QKgl+Fa5UuwtAyqM6tHVHKcFfHd4UaD7jKpujh
         braGBn1m4TBUIyCgLZQY9vlUtKtOju/hVhK7Xst82A7abSnTAf1upD5rCirfQiNNt4Ju
         NtIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="16839220"
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
Subject: [PATCH v14 7/9] PCI/DPC: Disable ERR_NONFATAL and enable ERR_FATAL for DPC 
Date: Mon, 23 Apr 2018 11:23:11 -0400
Message-Id: <1524496993-29799-8-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550964540468841?=
X-GMAIL-MSGID: =?utf-8?q?1598550964540468841?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch disables ERR_NONFATAL trigger for DPC, so now DPC
handles only ERR_FATAL.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 6baed85..cd15862 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -283,7 +283,8 @@ static int dpc_probe(struct pcie_device *dev)
 		}
 	}
 
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN;
+	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL |
+	      PCI_EXP_DPC_CTL_INT_EN;
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 
 	dev_info(device, "DPC error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -301,7 +302,7 @@ static void dpc_remove(struct pcie_device *dev)
 	u16 ctl;
 
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_NONFATAL | PCI_EXP_DPC_CTL_INT_EN);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
 	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
 }
 
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 0c79eac..dcc3957 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -978,7 +978,8 @@
 #define  PCI_EXP_DPC_CAP_DL_ACTIVE	0x1000	/* ERR_COR signal on DL_Active supported */
 
 #define PCI_EXP_DPC_CTL			6	/* DPC control */
-#define  PCI_EXP_DPC_CTL_EN_NONFATAL 	0x0002	/* Enable trigger on ERR_NONFATAL message */
+#define  PCI_EXP_DPC_CTL_EN_FATAL	0x0001	/* Enable trigger on ERR_FATAL message */
+#define  PCI_EXP_DPC_CTL_EN_NONFATAL	0x0002	/* Enable trigger on ERR_NONFATAL message */
 #define  PCI_EXP_DPC_CTL_INT_EN 	0x0008	/* DPC Interrupt Enable */
 
 #define PCI_EXP_DPC_STATUS		8	/* DPC Status */
-- 
2.7.4
