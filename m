Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AB8JxZoAra6+3JjkysmHiZTPiOzhgBI2vXzgmOAtt/kU8ymcGbnTESP7b+FHbfBAB81Mko04GYGk
ARC-Seal: i=1; a=rsa-sha256; t=1526035413; cv=none;
        d=google.com; s=arc-20160816;
        b=t4YhgUR9/k/uYMnLO988rZxCGF9eEiTcGyxwU1GcIfv2J0I+Q7RlUFcVl4oFjmLSJ3
         oBIcXmILea/0oNR75Mo/naCukoLP4hbPiLJl7XU9MPA6Okki+yhJPPsd1W8Ojp7dYQhM
         pH7H8EpKn7/NJDHoz5vkBKXzMF0ZMFRKzPkJF4qb2RPo3+2k53KXEm9EU5T9KuJJOZ+v
         bn1SCcjgiAOuIMtkb5AnKHqjwQiv5CfukiGUjUFlRvrsYrxed+xCMHKMPD6C8JkZ1N8u
         lQm+smvO6j/kdSBNebsjZxxbcCIld+t5AFDPvHqVTRS5ek6cEXMp9eC81iSCVldXLNT1
         2crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=9Ud8h/H89iHBmA3ArVkx6qabq85aQq3lEJ6z3kZb/c8=;
        b=joqOaZy/9vfyEq1t+CsMHfuutlikM6xLZkXvea3I5t3saw9AzsIUQ28Nmqa54XeuXP
         k+YbxOw1QJQNHEneY2CpCciNood6fmnIBQsNqaEb0mRri5xHWPx8oyGZ37dsdE5VHOA5
         m0Kayq7K0yqQzbAu85KoHVKL9h0Nl3awTSqTY/SU1nphBXCexw4vxjse/zyAnnEwLPsT
         m74LNjIFG1oZnA90swTZH0MRB7yiniWiJLW+4vfIjjTuC2RruyMRtybOpl2aznsmzWI+
         Ldq/f1Q8wgw85oyiBs4ketxaHhNL4N62dLAo9WcmzVkWed3E9KQRguXnThgZxxVbaa4m
         Hmzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.251 as permitted sender) smtp.mailfrom=poza@qualcomm.com
X-IronPort-AV: E=Sophos;i="5.49,388,1520924400";
   d="scan'208";a="435728388"
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
Subject: [PATCH v16 4/9] PCI/AER: Rename error recovery to generic PCI naming
Date: Fri, 11 May 2018 06:43:23 -0400
Message-Id: <1526035408-31328-5-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
References: <1526035408-31328-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600164110103973001?=
X-GMAIL-MSGID: =?utf-8?q?1600164110103973001?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch renames error recovery to generic name with pcie prefix

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>
Reviewed-by: Keith Busch <keith.busch@intel.com>

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cec9d8c..5e8857a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -353,6 +353,10 @@ static inline resource_size_t pci_resource_alignment(struct pci_dev *dev,
 
 void pci_enable_acs(struct pci_dev *dev);
 
+/* PCI error reporting and recovery */
+void pcie_do_fatal_recovery(struct pci_dev *dev);
+void pcie_do_nonfatal_recovery(struct pci_dev *dev);
+
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
 void pcie_aspm_init_link_state(struct pci_dev *pdev);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
index 649dd1f..4444aa4 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -476,7 +476,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
 }
 
 /**
- * do_fatal_recovery - handle fatal error recovery process
+ * pcie_do_fatal_recovery - handle fatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  *
  * Invoked when an error is fatal. Once being invoked, removes the devices
@@ -484,7 +484,7 @@ static pci_ers_result_t reset_link(struct pci_dev *dev)
  * followed by re-enumeration of devices.
  */
 
-static void do_fatal_recovery(struct pci_dev *dev)
+void pcie_do_fatal_recovery(struct pci_dev *dev)
 {
 	struct pci_dev *udev;
 	struct pci_bus *parent;
@@ -535,14 +535,14 @@ static void do_fatal_recovery(struct pci_dev *dev)
 }
 
 /**
- * do_nonfatal_recovery - handle nonfatal error recovery process
+ * pcie_do_nonfatal_recovery - handle nonfatal error recovery process
  * @dev: pointer to a pci_dev data structure of agent detecting an error
  *
  * Invoked when an error is nonfatal/fatal. Once being invoked, broadcast
  * error detected message to all downstream drivers within a hierarchy in
  * question and return the returned code.
  */
-static void do_nonfatal_recovery(struct pci_dev *dev)
+void pcie_do_nonfatal_recovery(struct pci_dev *dev)
 {
 	pci_ers_result_t status;
 	enum pci_channel_state state;
@@ -613,9 +613,9 @@ static void handle_error_source(struct pcie_device *aerdev,
 			pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS,
 					info->status);
 	} else if (info->severity == AER_NONFATAL)
-		do_nonfatal_recovery(dev);
+		pcie_do_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-		do_fatal_recovery(dev);
+		pcie_do_fatal_recovery(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -680,9 +680,9 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
-			do_nonfatal_recovery(pdev);
+			pcie_do_nonfatal_recovery(pdev);
 		else if (entry.severity == AER_FATAL)
-			do_fatal_recovery(pdev);
+			pcie_do_fatal_recovery(pdev);
 		pci_dev_put(pdev);
 	}
 }
-- 
2.7.4
