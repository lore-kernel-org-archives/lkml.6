Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C88CF20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPGrqFrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88CF20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbeKLIxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390575AbeKLIWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6BD6223CA;
        Sun, 11 Nov 2018 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975548;
        bh=VsVEdV1nPKYy8HdGF9eaop3TvIPTLHO7wQG9rcTVMrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPGrqFrtBTI7qZe1yrIRzKNMFnXpBW6tfs7w0oZnbR+oTo629RwT/OHsOxmHzzWHG
         A2z23mrgcJh+Czq9WCuhwlxQ9CihKHK2S7Rk2mVkbZKFG6f2mmAcTaCwxmPX7F7yeG
         sE4NdZIuMFnapDa8Bv9PbpYJ/DkXmIRLVDGHqcsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Honghui Zhang <honghui.zhang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 085/222] PCI: mediatek: Fix mtk_pcie_find_port() endpoint/port matching logic
Date:   Sun, 11 Nov 2018 14:23:02 -0800
Message-Id: <20181111221655.611452995@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/host/pcie-mediatek.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/pci/host/pcie-mediatek.c
+++ b/drivers/pci/host/pcie-mediatek.c
@@ -333,6 +333,17 @@ static struct mtk_pcie_port *mtk_pcie_fi
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


