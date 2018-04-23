Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4/FSWJ/uMT3XGBrPDAUDG6jP26/eaY6zenINSEAW7O3daYXxIiKHdq7rwWlX3AlbXyb3yZk
ARC-Seal: i=1; a=rsa-sha256; t=1524496996; cv=none;
        d=google.com; s=arc-20160816;
        b=hfA8dk76kgr9cfGQjKXvETG2Zc8ADrdj8Frye7Kf1pIbNy/oGawOwIPaUA7Bncp8ng
         UqjEHZ7vpRRqlNXQGVOPSFCI8Q2o0zXFoEylN5kkkoy6QjB6VhLFth4dddSlmhE6EFma
         bxZvmUgmmqg6h9ka4NuRwWj1WpXzAnmII2GcviY4tw86NIohrW7jUr355tRclZXIfyjj
         Urq9dZrpxatu6Ct4rFqxZCN38cH0xUwmd4yLioejZZFYSmZWdyZ4zcuijpQ3oZ9gO+t6
         J5hF6sB6YEAizyNk7wwVLvWT6uxEWnfVhFtMudDdVxsAmdgXKSXwDbpl8TftBI0lpkMp
         ITPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=0oKoVXHf3uE8TCwcjX2aNVSH4359RDkul73jz029QHM=;
        b=Oy3SghHhg+VCleYOXSulR+NJPLqVjAAyGwbtutaaHa5gBIn3XjVY0Ac8sb2rFK9Iov
         8VumO+Cp800YXQH9fs/ttgIuq24P7rIVQonje4GnE0fxDc6PF+Ghk2rMld08QuW9cR6h
         sMZyiWIuzas3U15qJqQgwPMWaHeNUSX3/ADuhfQ/oP60jOUKZ5BgamEgUV5hhXOk16DX
         8ay/D4xry8fm6dltgCAQyzGFSiaxjPow2yUmJkG2PhPSpbKxKAw9uofXAiAjjYzaEZpy
         bmcqCvdXzZ/6wlKrr3lgIhUhp+nbnDKIru3tIskc8KWAIMjLFFe3qBd5ArCNbIndKJlo
         Ephg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 129.46.98.28 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,318,1520924400";
   d="scan'208";a="16839212"
X-IronPort-AV: E=McAfee;i="5900,7806,8871"; a="173875855"
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
Subject: [PATCH v14 1/9] PCI/AER: Rename error recovery to generic PCI naming
Date: Mon, 23 Apr 2018 11:23:05 -0400
Message-Id: <1524496993-29799-2-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
References: <1524496993-29799-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598550963190148080?=
X-GMAIL-MSGID: =?utf-8?q?1598550963190148080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pcie prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

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
