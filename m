Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510CAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B18725187
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EdLwoRZq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EdLwoRZq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B18725187
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932893AbeGBXBP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:01:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40400 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeGBW7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:59:38 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EEC4B60BDF; Mon,  2 Jul 2018 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572377;
        bh=/CwhFzxLYmmAaaQaeolNwwjV9InhM14JUwx93HfdBLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdLwoRZq6PlkpPll+tfcb/zZJ/HSdXj/zRSFtYJPbUcrfD4uCW7IXnXz48LR+RD19
         9UV2JNIz/5scz/L1h2DR2cEFMkNKrkTjA8eJ5vn9vebf4B+XwWfpRXSHe4EPbucTVB
         uOcrZkgXyng2hr38izGA0+oE5WUSLGy+pKoIuNHU=
Received: from drakthul.qualcomm.com (global_nat1_iad_fw.qualcomm.com [129.46.232.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55D4360B26;
        Mon,  2 Jul 2018 22:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530572377;
        bh=/CwhFzxLYmmAaaQaeolNwwjV9InhM14JUwx93HfdBLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdLwoRZq6PlkpPll+tfcb/zZJ/HSdXj/zRSFtYJPbUcrfD4uCW7IXnXz48LR+RD19
         9UV2JNIz/5scz/L1h2DR2cEFMkNKrkTjA8eJ5vn9vebf4B+XwWfpRXSHe4EPbucTVB
         uOcrZkgXyng2hr38izGA0+oE5WUSLGy+pKoIuNHU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55D4360B26
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
From:   Sinan Kaya <okaya@codeaurora.org>
To:     linux-pci@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH V5 5/6] PCI: Deprecate pci_reset_bus() and pci_reset_slot() functions
Date:   Mon,  2 Jul 2018 18:58:54 -0400
Message-Id: <1530572336-20296-6-git-send-email-okaya@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
References: <1530572336-20296-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_reset_bus() and pci_reset_slot() functions are not being used by
any code. Remove them from the kernel in favor of pci_try_reset_bus()
and pci_try_reset_slot() functions.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/pci/pci.c   | 55 ++---------------------------------------------------
 include/linux/pci.h |  2 --
 2 files changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a31e6db..7e3f2e9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4784,9 +4784,9 @@ int pci_probe_reset_slot(struct pci_slot *slot)
 EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
 
 /**
- * pci_reset_slot - reset a PCI slot
+ * __pci_try_reset_slot - Try to reset a PCI slot
  * @slot: PCI slot to reset
- *
+ *`
  * A PCI bus may host multiple slots, each slot may support a reset mechanism
  * independent of other slots.  For instance, some slots may support slot power
  * control.  In the case of a 1:1 bus to slot architecture, this function may
@@ -4796,30 +4796,6 @@ EXPORT_SYMBOL_GPL(pci_probe_reset_slot);
  * through this function.  PCI config space of all devices in the slot and
  * behind the slot is saved before and restored after reset.
  *
- * Return 0 on success, non-zero on error.
- */
-int pci_reset_slot(struct pci_slot *slot)
-{
-	int rc;
-
-	rc = pci_slot_reset(slot, 1);
-	if (rc)
-		return rc;
-
-	pci_slot_save_and_disable(slot);
-
-	rc = pci_slot_reset(slot, 0);
-
-	pci_slot_restore(slot);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_reset_slot);
-
-/**
- * __pci_try_reset_slot - Try to reset a PCI slot
- * @slot: PCI slot to reset
- *
  * Same as above except return -EAGAIN if the slot cannot be locked
  */
 static int __pci_try_reset_slot(struct pci_slot *slot)
@@ -4878,33 +4854,6 @@ int pci_probe_reset_bus(struct pci_bus *bus)
 EXPORT_SYMBOL_GPL(pci_probe_reset_bus);
 
 /**
- * pci_reset_bus - reset a PCI bus
- * @bus: top level PCI bus to reset
- *
- * Do a bus reset on the given bus and any subordinate buses, saving
- * and restoring state of all devices.
- *
- * Return 0 on success, non-zero on error.
- */
-int pci_reset_bus(struct pci_bus *bus)
-{
-	int rc;
-
-	rc = pci_bus_reset(bus, 1);
-	if (rc)
-		return rc;
-
-	pci_bus_save_and_disable(bus);
-
-	rc = pci_bus_reset(bus, 0);
-
-	pci_bus_restore(bus);
-
-	return rc;
-}
-EXPORT_SYMBOL_GPL(pci_reset_bus);
-
-/**
  * __pci_try_reset_bus - Try to reset a PCI bus
  * @bus: top level PCI bus to reset
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f5c85b6..ad0c89a 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1095,9 +1095,7 @@ int pci_reset_function(struct pci_dev *dev);
 int pci_reset_function_locked(struct pci_dev *dev);
 int pci_try_reset_function(struct pci_dev *dev);
 int pci_probe_reset_slot(struct pci_slot *slot);
-int pci_reset_slot(struct pci_slot *slot);
 int pci_probe_reset_bus(struct pci_bus *bus);
-int pci_reset_bus(struct pci_bus *bus);
 int pci_try_reset_bus(struct pci_dev *dev);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-- 
2.7.4

