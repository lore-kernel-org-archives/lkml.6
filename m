Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186AEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE2720894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n42ibjvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE2720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeGaBNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:13:33 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:32946 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbeGaBNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:13:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id 8-v6so339761oip.0;
        Mon, 30 Jul 2018 16:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ltkQqegy0Fc/tAhLa+Gw7TTmZJzwriJz9ro/MYRE/9c=;
        b=n42ibjvkzEwj/FxsUZlLmWVDu/oIq36cA4o/iqPUp7Sj477UxaLW1KG1KkyHRFwckB
         VsbteSQlkO00Djhltkzt3awa/jiWANV2/hwpjpgYCVyUP3i48ak5rSYAbP3uyfvaDnWu
         F8cZT5e7IQ4GDuRw2o7R8HTUUBVbihx3jmghSiIZQ8gcDGh4nYWXlf3FOVfIWQkRyWkU
         Xlhcak49VKB2/oF3CC1sTK2zb9c0nymQmN9O2xL0XZoLjW6WsIOc4ELdxsySS+Bv7MXG
         FkKg2c/BF3Fkdl4woVQjEgdQn9L71uvIGVF0OMYO4VICx35+hOewHmPC3pBA7qyQaCQb
         rYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ltkQqegy0Fc/tAhLa+Gw7TTmZJzwriJz9ro/MYRE/9c=;
        b=ArFufOLw4iAx7oB+ktDRSXVw3aS4IGe4ZbnP9/LtpbFSK3yR+eVDe4maT3H+bZz4ZN
         oeW3pWRBTOltW6ugZEbE49Qj65J1SPhcU6LMHMHI+CsYdlR8ly2XO/PD1z78zO+A9/ac
         ZZQ+CbZ+eNUd1YzCak8CFjQGuaKsW4UPhGYGZNtNKj/uTIHrGrF2lMg+LC4SANi9DV/d
         dEs8/1lkQFzjU31+11+KlwDYrgKoFwhqau6oG4EBqoz6f2Fde7aAj+wGJvs7Ld9AgwR4
         v9RzgCDtigz6h8XFll/iEZ9aLtR8fLjTTfovfnE1sB7jSOfn1aLZL4mleugM42Eq1py0
         /o2w==
X-Gm-Message-State: AOUpUlFO8aSjlnudULtmOOfksKXb+2aLoCuo70qJDsprOl76DPdZDUeG
        GPxkCShIYNgISLXj07zFfm86BsBJLME=
X-Google-Smtp-Source: AAOMgpeeBFUWokA2ecnMOZWI6NoydXTyz8dhKJpJYU3EiLP4f7mpGXYupM0BBDztyBi0PEsxsf6mbw==
X-Received: by 2002:aca:4a49:: with SMTP id x70-v6mr18106364oia.11.1532993771438;
        Mon, 30 Jul 2018 16:36:11 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id p132-v6sm13065959oia.31.2018.07.30.16.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 16:36:10 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/AER: Do not clear AER bits if we don't own AER
Date:   Mon, 30 Jul 2018 18:35:31 -0500
Message-Id: <20180730233547.1238-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
References: <3d05f662-2c29-90cd-9c74-6456939a0e6b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we don't own AER, we shouldn't touch the AER error bits. Clearing
error bits willy-nilly might cause firmware to miss some errors. In
theory, these bits get cleared by FFS, or via ACPI _HPX method. These
mechanisms are not subject to the problem.

This race is mostly of theoretical significance, since I can't
reasonably demonstrate this race in the lab.

On a side-note, pcie_aer_is_kernel_first() is created to alleviate the
need for two checks: aer_cap and get_firmware_first().

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

Changes since v2:
  - Added missing negation in pci_cleanup_aer_error_status_regs()

 drivers/pci/pcie/aer.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..40e5c86271d1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -307,6 +307,12 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 		aer_set_firmware_first(dev);
 	return dev->__aer_firmware_first;
 }
+
+static bool pcie_aer_is_kernel_first(struct pci_dev *dev)
+{
+	return !!dev->aer_cap && !pcie_aer_get_firmware_first(dev);
+}
+
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
 				 PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE)
 
@@ -337,10 +343,7 @@ bool aer_acpi_firmware_first(void)
 
 int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
-	if (!dev->aer_cap)
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
@@ -349,7 +352,7 @@ EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
 
 int pci_disable_pcie_error_reporting(struct pci_dev *dev)
 {
-	if (pcie_aer_get_firmware_first(dev))
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
 	return pcie_capability_clear_word(dev, PCI_EXP_DEVCTL,
@@ -383,10 +386,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pci_is_pcie(dev))
 		return -ENODEV;
 
-	pos = dev->aer_cap;
-	if (!pos)
+	if (!pcie_aer_is_kernel_first(dev))
 		return -EIO;
 
+	pos = dev->aer_cap;
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
-- 
2.17.1

