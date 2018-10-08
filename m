Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CD3C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9FE20652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcdCIzFs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B9FE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeJHWsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbeJHWiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:38:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDCBF2075E;
        Mon,  8 Oct 2018 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539012362;
        bh=Af4eNb0epPJ8qDTYgjFPsgb0MSgMaQDHVrpRQG/Fhyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hcdCIzFszoCJCO6DbUfYqmOYPlo7u/wer4J4Sm00oqZqnmeo+p1r2CaSN5VRMAZx0
         SyjcMAnUZQN5WjiYmYGjZO8eGAzFMuVzkkpCNi4/7Am7ZNfuhEr4BJittznxAiswIZ
         LcddwxXDNafBiesQKyJh7KfvlVpMeGbgvwKuKVbo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 37/58] PCI: dwc: Fix scheduling while atomic issues
Date:   Mon,  8 Oct 2018 11:25:02 -0400
Message-Id: <20181008152523.70705-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181008152523.70705-1-sashal@kernel.org>
References: <20181008152523.70705-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

[ Upstream commit 9024143e700f89d74b8cdaf316a3499d74fc56fe ]

When programming the inbound/outbound ATUs, we call usleep_range() after
each checking PCIE_ATU_ENABLE bit. Unfortunately, the ATU programming
can be executed in atomic context:

inbound ATU programming could be called through
pci_epc_write_header()
  =>dw_pcie_ep_write_header()
    =>dw_pcie_prog_inbound_atu()

outbound ATU programming could be called through
pci_bus_read_config_dword()
  =>dw_pcie_rd_conf()
    =>dw_pcie_prog_outbound_atu()

Fix this issue by calling mdelay() instead.

Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
[lorenzo.pieralisi@arm.com: commit log update]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 778c4f76a884..2153956a0b20 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
@@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index bee4e2535a61..b99d1d72dd12 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -26,8 +26,7 @@
 
 /* Parameters for the waiting for iATU enabled routine */
 #define LINK_WAIT_MAX_IATU_RETRIES	5
-#define LINK_WAIT_IATU_MIN		9000
-#define LINK_WAIT_IATU_MAX		10000
+#define LINK_WAIT_IATU			9
 
 /* Synopsys-specific PCIe configuration registers */
 #define PCIE_PORT_LINK_CONTROL		0x710
-- 
2.17.1

