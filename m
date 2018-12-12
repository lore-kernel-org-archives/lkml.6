Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D099DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9307B20811
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 05:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QlIG4Ltx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9307B20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeLLFqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 00:46:53 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42694 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbeLLFqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 00:46:51 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so16339477wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 21:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o9zOKa7UZo6O1oSXPaMqPu6Fib6WbxYaMCsnJYZwlo8=;
        b=QlIG4Ltxek1NO4qTDSHC89YHHCe0sh1RmxOpdVMF0Otf8WCvUKyW9zfoBCzj5jJy1Z
         aRmRd7aLNA5vekwKNUtlK0IaM9Yv/gj9MEwrtjTg+JdtdrFOaDTMLbeauVSbxDKj1Syb
         HMgN+e8vXZT0sbLe38HQRH5SZ36vVljbjYyMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o9zOKa7UZo6O1oSXPaMqPu6Fib6WbxYaMCsnJYZwlo8=;
        b=oV2X69sZG4DD/Xx3MGTz+WicVjmBTzHobmDFqmN2DdDPMq0QACBihukmJV58aYb66s
         FL3//ZkXUAq6s4EF8P02eykPDtsH6AiIlkRYLhMQRybAHWkHnLmONoJT9dB2zSPTgxm0
         ylsWpMJhcYiLOtVK34KaHQbLTIMQkr1getiLHwBlB92XHjQcwoCASOS1v5DwXMjWzihq
         zgIYc8/0lyeQAjcdTECUAhktU7UgUSR+ZkscVqpmD5D6NB0vzNPFlDjLtuGZjBF3b6JK
         N3R7WBoi3djyUaizwkenmccXug+B13Qy+koiCMzAtJyc6cEuiQXjZi2kKhcwDNzTVCpK
         Uefw==
X-Gm-Message-State: AA+aEWbUtcXKYsRlh3CWMgTB4Q/TLWNM+tUg27FmRnaVPPm4xsZOY4co
        yjkqW1ZOriB0w9LvUpY7RRZ8uw==
X-Google-Smtp-Source: AFSGD/W5fvf+7cGlVD1coGF/72gVx5nYO/sHP4U40r0vjs5KfAPR1WO+tTEdFzJ7o4gqCxb6UJXG6g==
X-Received: by 2002:adf:ae41:: with SMTP id u1mr15101050wrd.20.1544593608138;
        Tue, 11 Dec 2018 21:46:48 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z206sm2015947wmc.18.2018.12.11.21.46.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 21:46:47 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [RFC PATCH 3/3] PCI: iproc: Add dma reserve resources to host
Date:   Wed, 12 Dec 2018 11:16:09 +0530
Message-Id: <1544593569-8923-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPROC host has the limitation that it can use
only those address ranges given by dma-ranges
property as inbound address.
So that the memory address holes in dma-ranges
should be reserved to allocate as DMA address.

All such reserved addresses are created as resource
entries and add to dma_resv list of pci host bridge.

These dma reserve resources created by parsing
dma-ranges parameter.

Ex:
dma-ranges = < \
  0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
  0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
  0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>

In the above example of dma-ranges, memory address from
0x0 - 0x80000000,
0x100000000 - 0x800000000,
0x1000000000 - 0x8000000000 and
0x10000000000 - 0xffffffffffffffff.
are not allowed to use as inbound addresses.
So that we need to add these address range to dma_resv
list to reserve their IOVA address ranges.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 3160e93..43e465a 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1154,25 +1154,74 @@ static int iproc_pcie_setup_ib(struct iproc_pcie *pcie,
 	return ret;
 }
 
+static int
+iproc_pcie_add_dma_resv_range(struct device *dev, struct list_head *resources,
+			      uint64_t start, uint64_t end)
+{
+	struct resource *res;
+
+	res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->start = (resource_size_t)start;
+	res->end = (resource_size_t)end;
+	pci_add_resource_offset(resources, res, 0);
+
+	return 0;
+}
+
 static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct of_pci_range range;
 	struct of_pci_range_parser parser;
 	int ret;
+	uint64_t start, end;
+	LIST_HEAD(resources);
 
 	/* Get the dma-ranges from DT */
 	ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
 	if (ret)
 		return ret;
 
+	start = 0;
 	for_each_of_pci_range(&parser, &range) {
+		end = range.pci_addr;
+		/* dma-ranges list expected in sorted order */
+		if (end < start) {
+			ret = -EINVAL;
+			goto out;
+		}
 		/* Each range entry corresponds to an inbound mapping region */
 		ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
 		if (ret)
 			return ret;
+
+		if (end - start) {
+			ret = iproc_pcie_add_dma_resv_range(pcie->dev,
+							    &resources,
+							    start, end);
+			if (ret)
+				goto out;
+		}
+		start = range.pci_addr + range.size;
 	}
 
+	end = ~0;
+	if (end - start) {
+		ret = iproc_pcie_add_dma_resv_range(pcie->dev, &resources,
+						    start, end);
+		if (ret)
+			goto out;
+	}
+
+	list_splice_init(&resources, &host->dma_resv);
+
 	return 0;
+out:
+	pci_free_resource_list(&resources);
+	return ret;
 }
 
 static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
-- 
2.7.4

