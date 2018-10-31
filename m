Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716C0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C5C20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="STwUlD4s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C5C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbeKAIJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728959AbeKAIJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:09:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0985F2081B;
        Wed, 31 Oct 2018 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027355;
        bh=GZvI6+ZUhrjC2GF5Z5vETFphxwnIvDDokVS7VhFE/Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=STwUlD4s1CI6JCqtXUFQzUkj6uFIGXtlG0qZ5UWNtZ7U/M8PkzHQHz1/wHt00cZon
         cuDyHNQ0QgwKo1Iun9WP3WqyRxfiBsjBoswVArwfBGKKz8AsJuuxIe6Kj913f6QZyy
         kOCZyadCCsmnpvpurN3J2Sc4CLSrjup4/z47uUDg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Honghui Zhang <honghui.zhang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 089/126] PCI: mediatek: Fix mtk_pcie_find_port() endpoint/port matching logic
Date:   Wed, 31 Oct 2018 19:07:17 -0400
Message-Id: <20181031230754.29029-89-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230754.29029-1-sashal@kernel.org>
References: <20181031230754.29029-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

[ Upstream commit 074d6f32689ce05a084b6fa3db38445745bf11cc ]

The Mediatek's host controller has two slots, each with its own control
registers. The host driver needs to identify what slot is connected to
what port in order to access the device's configuration space.

Current code retrieving slot connected to a given endpoint device.

Assuming each slot is connected to one endpoint device as below:

                host bridge
  bus 0 --> __________|_______
           |                  |
           |                  |
         slot 0             slot 1
  bus 1 -->|        bus 2 --> |
           |                  |
         EP 0               EP 1

During PCI enumeration, system software will scan all the PCI devices on
every bus starting from devfn 0. Using PCI_SLOT(devfn) for matching an
endpoint to its slot is erroneous in that the devfn does not contain the
hierarchical bus numbering in it. In order to match an endpoint with its
slot (and related port), the PCI tree must be walked up to the root bus
(where the root ports are situated) and then the PCI_SLOT(devfn)
matching logic can be correctly applied for matching.

This patch fixes the mtk_pcie_find_port() slot matching logic by adding
appropriate PCI tree walking code to retrieve the slot/port a given
endpoint is connected to.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 861dda69f366..c5ff6ca65eab 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -337,6 +337,17 @@ static struct mtk_pcie_port *mtk_pcie_find_port(struct pci_bus *bus,
 {
 	struct mtk_pcie *pcie = bus->sysdata;
 	struct mtk_pcie_port *port;
+	struct pci_dev *dev = NULL;
+
+	/*
+	 * Walk the bus hierarchy to get the devfn value
+	 * of the port in the root bus.
+	 */
+	while (bus && bus->number) {
+		dev = bus->self;
+		bus = dev->bus;
+		devfn = dev->devfn;
+	}
 
 	list_for_each_entry(port, &pcie->ports, list)
 		if (port->slot == PCI_SLOT(devfn))
-- 
2.17.1

