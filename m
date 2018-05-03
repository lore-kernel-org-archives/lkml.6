Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZqkztemi32Nk2kNzim3MsxZude8XxPZaLGBmysvtFTuRPNdoHLlLeYNwTOgVGV2hC87fPP7
ARC-Seal: i=1; a=rsa-sha256; t=1525323844; cv=none;
        d=google.com; s=arc-20160816;
        b=DRyMG5CmO9f3E6vn9/lt6H6xaf9nN6UD29sh9jt69or5EerYLQ1hToft2S4E4GuZa9
         dBi7R7KRbaQ78FDbGcODxVRapGotpkzoZIAN6xJ64B9ryCKaesXbWiGacPemZzuz1lQz
         MrRask+JGJD5dGSppVqOga/JtYXTOQ6L/xP5Wq03KIaMj1d3GrSnQLbIUkQZyvFp5lhA
         mNFM7q8FrZn3rquHz/lbXYQS+wBKEbwReK5LWcx1CcHLELnn6CrxxVLoTWYwTdiy2oTA
         N5RWDLND3rCtsAgAQkp0fYEaYf89ygAUEUlc21HziEtIwLN34cGrDBzFQZQ3VvTmpC7W
         t2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dfM8WENALZ/j4fnGw+U7fw68kx1Hxgo2f7PBlgdlzkQ=;
        b=ZjMv2hH2PvMsfGKQCcBdLkxlKobyxOWaJ33Syfrli2pkvs/pGZWw5qkWCrsQFedVW1
         ZA+Tou6zT5ZzPsJRzf9KVrWT0CsTj/Bk7LZH2cU9xZdOg0/GEi0RjtT8IRwiQlIYiqbQ
         O662jtbOxpsE60xUhVYNzLb+wXo1tTAo3Dgf8Fsz2Zh2zGroeFr0xQNokmp5irFg30g3
         Oz+icrbLB6NKgHsB8xF8MELkz3UQAdOIulCWY9NqalzYRSaoQDVhFIFQpyAgYPzf7gC4
         9zidv2d4Bw36njTzzf3ps4XbBp4bhjjHcTvWhfzrd3vUoKfUAqfX1kvP46vD3Kp2KNOi
         Dk9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,356,1520924400";
   d="scan'208";a="434431840"
X-IronPort-AV: E=McAfee;i="5900,7806,8881"; a="76178774"
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
Subject: [PATCH v15 4/9] PCI/AER: Rename error recovery to generic PCI naming
Date: Thu,  3 May 2018 01:03:53 -0400
Message-Id: <1525323838-1735-5-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
References: <1525323838-1735-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599417976033110998?=
X-GMAIL-MSGID: =?utf-8?q?1599417976033110998?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pcie prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cec9d8c..22a9589 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -353,6 +353,9 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+/* PCI error reporting and recovery */
+void pcie_do_recovery(struct pci_dev *dev, int severity);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 655d4e8..be4ee3b 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -475,7 +475,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 	return status;
 }
 
-static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
+static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev, int severity)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
@@ -514,7 +514,7 @@ static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pcie_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -522,13 +522,13 @@ static pci_ers_result_t do_fatal_recovery(struct pci_dev *dev, int severity)
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+void pcie_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status;
 	enum pci_channel_state state;
 
 	if (severity == AER_FATAL) {
-		status = do_fatal_recovery(dev, severity);
+		status = pcie_do_fatal_recovery(dev, severity);
 		if (status != PCI_ERS_RESULT_RECOVERED)
 			goto failed;
 		return;
@@ -600,7 +600,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pcie_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -665,7 +665,7 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity != AER_CORRECTABLE)
-			do_recovery(pdev, entry.severity);
+			pcie_do_recovery(pdev, entry.severity);
 		pci_dev_put(pdev);
 	}
 }
-- 
2.7.4
