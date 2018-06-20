Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F80CC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFC920836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IgDHnqCN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EcBtqBEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFC920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754584AbeFTEOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:14:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51362 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754373AbeFTENk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:13:40 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2714C60B69; Wed, 20 Jun 2018 04:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529468019;
        bh=YyKHY0qznaqhjvQbreep8Cj36qVntjCgCWgjcJPlmHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IgDHnqCNG+bPcBLW3cfJ5oufFhIV9DpqOI9MxzM2dTxR1B/glP9HE7E+//5pnoyuL
         2Sd48B3Jbo4sHL7WHGBGHToBQf6PG2RQ01fS23fOmb8EGMX2B1K7Vd+N/6lK3VuH+f
         QSt70mQ5nIxeyQdhy6pkG8Dd8nhFEGYIutsezoNA=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E2B460B19;
        Wed, 20 Jun 2018 04:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529468018;
        bh=YyKHY0qznaqhjvQbreep8Cj36qVntjCgCWgjcJPlmHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EcBtqBEvaax16z/ApxxYAxS3xyYkfNsQDvvzjgixvKcYirKvW6fudYVEA/z1v+jcF
         7gU/4mu2e54Zi4C4zbfd/DluFSIxkzY+an4yVLEL1n9FN9chiBTBjkcgkAeG96fI3s
         mu9dCndxW5omRIUa5BBY7WVYE872tvxsGPSolk2Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E2B460B19
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org, timur@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V2 5/5] PCI: Unify slot and bus reset API
Date:   Wed, 20 Jun 2018 00:12:58 -0400
Message-Id: <1529467995-28780-5-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
References: <1529467995-28780-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers are expected to call pci_reset_slot() or pci_reset_bus() by
querying if a system supports hotplug or not. A survey showed that most
drivers don't do this and we are leaking hotplug capability to the
user.

Hide pci_slot_reset() from drivers and embed into pci_bus_reset().
Change pci_reset_bus() parameter from struct pci_bus to struct pci_dev.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c   | 27 +++++++++++++++++++++++----
 include/linux/pci.h |  3 +--
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 79a1566..a44b948 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4798,7 +4798,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  *
  * Return 0 on success, non-zero on error.
  */
-int pci_reset_slot(struct pci_slot *slot)
+static int __pci_reset_slot(struct pci_slot *slot)
 {
 	int rc;
 
@@ -4814,7 +4814,6 @@ int pci_reset_slot(struct pci_slot *slot)
 
 	return rc;
 }
-EXPORT_SYMBOL_GPL(pci_reset_slot);
 
 /**
  * __pci_try_reset_slot - Try to reset a PCI slot
@@ -4878,7 +4877,7 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
 /**
- * pci_reset_bus - reset a PCI bus
+ * __pci_reset_bus - reset a PCI bus
  * @bus: top level PCI bus to reset
  *
  * Do a bus reset on the given bus and any subordinate buses, saving
@@ -4886,7 +4885,7 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
  *
  * Return 0 on success, non-zero on error.
  */
-int pci_reset_bus(struct pci_bus *bus)
+static int __pci_reset_bus(struct pci_bus *bus)
 {
 	int rc;
 
@@ -4902,6 +4901,26 @@ int pci_reset_bus(struct pci_bus *bus)
 
 	return rc;
 }
+
+/**
+ * pci_reset_bus - reset a PCI bus
+ * @pdev: top level PCI device to reset via slot/bus
+ *
+ * Do a slot/bus reset on the given bus and any subordinate buses, saving
+ * and restoring state of all devices.
+ *
+ * Return 0 on success, non-zero on error.
+ */
+int pci_reset_bus(struct pci_dev *pdev)
+{
+	bool slot = false;
+
+	if (!pci_probe_reset_slot(pdev->slot))
+		slot = true;
+
+	return slot ? __pci_reset_slot(pdev->slot) :
+			__pci_reset_bus(pdev->bus);
+}
 EXPORT_SYMBOL_GPL(pci_reset_bus);
 
 /**
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f5c85b6..e68ca2e 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1095,9 +1095,8 @@ int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
-int pci_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_reset_bus(struct pci_bus *bus);
+int pci_reset_bus(struct pci_dev *dev);
 int pci_try_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-- 
2.7.4

