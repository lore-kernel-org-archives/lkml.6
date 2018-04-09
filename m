Return-Path: <poza@qualcomm.com>
X-Google-Smtp-Source: AIpwx4/8Nhwvvs8dXyiQyIYHBb4qjO7YinX04BpXT75WJoQeCN0jjkViXHeokBzRxcyAygBzv2rh
ARC-Seal: i=1; a=rsa-sha256; t=1523284938; cv=none;
        d=google.com; s=arc-20160816;
        b=YDvI3oOR0OWcjNgQO5fnP/QnFNYaCVD3ZLUTi4mdpozwINnQLryPG/4hoOh2LNE3H0
         pQNdq2nQHHrJ/wHVHvXiIkCnrQGXQmHbch7a2HgczDm4r4MLqbt48iSEGm2AbdVlk3uV
         Ce1SMFv4ODZu2B8xMUKRPRInbwZUWfctDJQuQX7Y49eWGOgp5+hLF0AxLj4r6aHzxaGj
         mv5U9e6451+Js4fcq4V11PO2CeCx7AqawAC4o+GOEzhVZ+meAig8tBNmMIueY9CdafGn
         g21b/BiXrLwQTogc6pV7oUXN26soSG8Rnbn5KboM+ktkgmFH2H8dwt0DZ8ez8JhnsTtw
         scng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uPr7Im1DNJs8CBDuzFBLhEq1Vii2kE0uxfvCG5yIrMQ=;
        b=kjUU4q/7PfWNgWg6yXcTt5SjjFzvahV/nO/dEmhNpxJxEWB2W8CLzdXjxWTRQaJ16m
         zteiPeupIAbTgoJpVc4Oj5aVfLi8c3AFBMECa0U4g3CvlXbHnWGiNePhXLUstmCdZZoA
         KsRyxeKctSDoPH6OdxjWvkekxwqJbvt4t2tRlowIBzeF9hf/LQgb8l/UIoDa6voUrvR/
         WUrk7LPlYnKe3DrUKeZkaTWmsxinR0AupZqyC40Dh5E2J2g+prWzJPnmPlPCjpsIxug+
         OzafLjNsbDbB1mIc+HsAhbZKcgdb27+fmkOrIyQQipXilT5zH8FBfw5XqeInvtyHzl/v
         msow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of poza@qualcomm.com designates 199.106.114.38 as permitted sender) smtp.mailfrom=poza@qualcomm.com
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
Subject: [PATCH v13 6/6] PCI/DPC: Do not do recovery for hotplug enabled system
Date: Mon,  9 Apr 2018 10:41:54 -0400
Message-Id: <1523284914-2037-7-git-send-email-poza@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
References: <1523284914-2037-1-git-send-email-poza@codeaurora.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597280027488013564?=
X-GMAIL-MSGID: =?utf-8?q?1597280027488013564?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

DPC and AER should attempt recovery in the same way, except the
cases where system is with hotplug enabled.

Signed-off-by: Oza Pawandeep <poza@codeaurora.org>

diff --git a/drivers/pci/pcie/pcie-dpc.c b/drivers/pci/pcie/pcie-dpc.c
index 8e1553b..6d9a841 100644
--- a/drivers/pci/pcie/pcie-dpc.c
+++ b/drivers/pci/pcie/pcie-dpc.c
@@ -108,8 +108,6 @@ static void dpc_wait_link_inactive(struct dpc_dev *dpc)
  */
 static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
-	struct pci_bus *parent = pdev->subordinate;
-	struct pci_dev *dev, *temp;
 	struct dpc_dev *dpc;
 	struct pcie_device *pciedev;
 	struct device *devdpc;
@@ -120,19 +118,6 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	dpc = get_service_data(pciedev);
 	cap = dpc->cap_pos;
 
-	pci_lock_rescan_remove();
-	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
-					 bus_list) {
-		pci_dev_get(dev);
-		pci_dev_set_disconnected(dev, NULL);
-		if (pci_has_subordinate(dev))
-			pci_walk_bus(dev->subordinate,
-				     pci_dev_set_disconnected, NULL);
-		pci_stop_and_remove_bus_device(dev);
-		pci_dev_put(dev);
-	}
-	pci_unlock_rescan_remove();
-
 	dpc_wait_link_inactive(dpc);
 	if (dpc->rp_extensions && dpc_wait_rp_inactive(dpc))
 		return PCI_ERS_RESULT_DISCONNECT;
@@ -152,13 +137,37 @@ static pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
+static void dpc_reset_link_remove_dev(struct pci_dev *pdev)
+{
+	struct pci_bus *parent = pdev->subordinate;
+	struct pci_dev *dev, *temp;
+
+	pci_lock_rescan_remove();
+	list_for_each_entry_safe_reverse(dev, temp, &parent->devices,
+					 bus_list) {
+		pci_dev_get(dev);
+		pci_dev_set_disconnected(dev, NULL);
+		if (pci_has_subordinate(dev))
+			pci_walk_bus(dev->subordinate,
+				     pci_dev_set_disconnected, NULL);
+		pci_stop_and_remove_bus_device(dev);
+		pci_dev_put(dev);
+	}
+	pci_unlock_rescan_remove();
+
+	dpc_reset_link(pdev);
+}
+
 static void dpc_work(struct work_struct *work)
 {
 	struct dpc_dev *dpc = container_of(work, struct dpc_dev, work);
 	struct pci_dev *pdev = dpc->dev->port;
 
 	/* From DPC point of view error is always FATAL. */
-	pcie_do_recovery(pdev, DPC_FATAL);
+	if (!pdev->is_hotplug_bridge)
+		pcie_do_recovery(pdev, DPC_FATAL);
+	else
+		dpc_reset_link_remove_dev(pdev);
 }
 static void dpc_process_rp_pio_error(struct dpc_dev *dpc)
 {
-- 
2.7.4
