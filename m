Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4/oQuXQHZGD6SQ60tJze8SGSRP+OcgXMgRcrlhS2BBH6BuTjcTKosU+kkA/A+SvO4kTdyEp
ARC-Seal: i=1; a=rsa-sha256; t=1523284938; cv=none;
        d=google.com; s=arc-20160816;
        b=CIwFDjgxMJ59d45iH5d9Gxd9J73GxMQfyKkl84genjnTkpZvWh2Twg9ZF5U2MrzWQW
         SzC+/ToAyMvmcdfBrhPGz7Vub36J9NF2fGNYuHDAy1DtRMKcYu3QJP13gpMJxKUOoRzF
         9uqlZcv970Vbc0N5wFpuiNWYZx9Xzx6oa6RN8xnbgKZaBbi5IHcxr3ummED8U7zsJgVy
         BTct5G8U1R9rJsDH3xsTz1Bo6HwR88EnAaD9DW/ZJCiBQMzLvJ+mf4k2/MQp1EvZQbcN
         kANRFlq8Yv7j6EjAVXJD6vLRjcv/vqOXfDrDIZv+vz3irwVQ6bvwlBRwDDQ//eeqUoy0
         yFnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=y+Gksw8IVYwHK3yiU7eNjSDMgHtdLQsvmLdgEdgan3M=;
        b=ld6lwFUTO5SzkDLRalGY1qi9fxo1FuPv7ZhCFWnXj2ZIRuqZW0efilEDhVoBdusbl2
         IiyEU1pdUEBv6ISRJIYeJ7cPvRzjyxHNZfF9qkIFE+wCBWQijHfXpg7mdKdnq0wsxo3v
         TbSulmcZWzjD3m6lafDaPOwvUwW18UrviqVHGKgNBWe53S/m4DlRX/Z41OZXLsDRVPM+
         0vGpUeJtNmzytc3nvkJWKi7nrXZzAS6yrb8wU1mkfahVk+EsxhrvnWHQpScwzi3saQBa
         flsfcHJEoo3RuhEvCbVIYjwUY4ktdsCHvLXz5rTYb30dPWqypLt4X3hIVqAPWROmU0Tk
         cs4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.254 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="334950785"
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
Subject: [PATCH v13 1/6] PCI/AER: Rename error recovery to generic PCI naming
Date: Mon,  9 Apr 2018 10:41:49 -0400
Message-Id: <1523284914-2037-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027496340053?=
X-GMAIL-MSGID: =?utf-8?q?1597280027496340053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pcie prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fcd8191..abc514e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -342,6 +342,9 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+/* PCI error reporting and recovery */
+void pcie_do_recovery(struct pci_dev *dev, int severity);
+
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index a4bfea5..aeb83a0 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -478,7 +478,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_recovery - handle nonfatal/fatal error recovery process
+ * pcie_do_recovery - handle nonfatal/fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  * @severity: error severity type
  *
@@ -486,7 +486,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_recovery(struct pci_dev *dev, int severity)
+static void pcie_do_recovery(struct pci_dev *dev, int severity)
 {
 	pci_ers_result_t status, result = PCI_ERS_RESULT_RECOVERED;
 	enum pci_channel_state state;
@@ -566,7 +566,7 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else
-		do_recovery(dev, info->severity);
+		pcie_do_recovery(dev, info->severity);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -631,7 +631,7 @@ static void aer_recover_work_func(struct work_struct *work)
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
