Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC126C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADF2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADF2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbeH2Wcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:32:51 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43056 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeH2Wcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:32:51 -0400
Received: by mail-oi0-f68.google.com with SMTP id b15-v6so10894265oib.10;
        Wed, 29 Aug 2018 11:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WHy2gdBP0IbsgdikDUaQhQTdeioIxS32HWEbVhPmNBE=;
        b=EaP4ZMOGF44wbRfJ88jS0vQS7ZclSRUbeDo5GxOsjzgBSN8XsWDS2jztZ1XNxkL09A
         Ya42xqV3LhVCsdhkjB+nPwj9tdu3f8/8alaucRYDVKDGqXGSrfyP9heS7SAUmwpfkgAV
         sQFpN2me5AGNK4qpxU0PRdhd/lIs9XvaZCHTRHS7xELuaKsZKu5V/1zCWZNXoUio9PVv
         HDYgI58csGc/R0GTrRvBfNqsK14frq4EShyN5u20rzEKSP4NANUiffhez60meQEu33U6
         JQwfXUeswV4L1ZOYE2kJKfvdWCTawU+AsO7N05arKt1a3yGV7M6cuJQqeNlTwIceshM5
         gfkg==
X-Gm-Message-State: APzg51Aamz2iBYruuUtdgNEnuH5vGKD66mMMqvag6p9UWax7adPyjjmN
        9qvY7SJAIFMR+GOzDM/TzQ==
X-Google-Smtp-Source: ANB0VdYGq3ZUdwilTCockyVYHVB2mUg+pTdq7B9kqastZ1So/mWXD+SkGCDcgrlOmPuVY0c4oVfX/A==
X-Received: by 2002:aca:894:: with SMTP id 142-v6mr4073467oii.125.1535567681354;
        Wed, 29 Aug 2018 11:34:41 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 16-v6sm2392026oin.5.2018.08.29.11.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:34:40 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Douglas <adouglas@cadence.com>,
        Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] PCI: remove unnecessary check of device_type == pci
Date:   Wed, 29 Aug 2018 13:34:40 -0500
Message-Id: <20180829183440.13601-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI host drivers have already matched on compatible strings, so checking
device_type is redundant. Also, device_type is considered deprecated for
FDT though we've still been requiring it for PCI hosts as it is useful
for finding PCI buses.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alan Douglas <adouglas@cadence.com>
Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/pci-host-common.c   | 8 --------
 drivers/pci/controller/pcie-cadence-host.c | 7 -------
 drivers/pci/controller/pcie-mobiveil.c     | 7 -------
 drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
 drivers/pci/controller/pcie-xilinx.c       | 7 -------
 5 files changed, 38 deletions(-)

diff --git a/drivers/pci/controller/pci-host-common.c b/drivers/pci/controller/pci-host-common.c
index d8f10451f273..c742881b5061 100644
--- a/drivers/pci/controller/pci-host-common.c
+++ b/drivers/pci/controller/pci-host-common.c
@@ -58,9 +58,7 @@ static struct pci_config_window *gen_pci_init(struct device *dev,
 int pci_host_common_probe(struct platform_device *pdev,
 			  struct pci_ecam_ops *ops)
 {
-	const char *type;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct pci_config_window *cfg;
 	struct list_head resources;
@@ -70,12 +68,6 @@ int pci_host_common_probe(struct platform_device *pdev,
 	if (!bridge)
 		return -ENOMEM;
 
-	type = of_get_property(np, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	of_pci_check_probe_only();
 
 	/* Parse and map our Configuration Space windows */
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index ec394f6a19c8..97e251090b4f 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -235,7 +235,6 @@ static int cdns_pcie_host_init(struct device *dev,
 
 static int cdns_pcie_host_probe(struct platform_device *pdev)
 {
-	const char *type;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
@@ -268,12 +267,6 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 	rc->device_id = 0xffff;
 	of_property_read_u16(np, "device-id", &rc->device_id);
 
-	type = of_get_property(np, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
 	pcie->reg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->reg_base)) {
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index a939e8d31735..77052a0712d0 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -301,13 +301,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	struct platform_device *pdev = pcie->pdev;
 	struct device_node *node = dev->of_node;
 	struct resource *res;
-	const char *type;
-
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
 
 	/* map config resource */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index fb32840ce8e6..81538d77f790 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -777,16 +777,7 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 			     struct platform_device *pdev)
 {
 	struct device *dev = pcie->dev;
-	struct device_node *node = dev->of_node;
 	struct resource *res;
-	const char *type;
-
-	/* Check for device type */
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "breg");
 	pcie->breg_base = devm_ioremap_resource(dev, res);
diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
index 7b1389d8e2a5..9bd1a35cd5d8 100644
--- a/drivers/pci/controller/pcie-xilinx.c
+++ b/drivers/pci/controller/pcie-xilinx.c
@@ -574,15 +574,8 @@ static int xilinx_pcie_parse_dt(struct xilinx_pcie_port *port)
 	struct device *dev = port->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
-	const char *type;
 	int err;
 
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci")) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	err = of_address_to_resource(node, 0, &regs);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
-- 
2.17.1

