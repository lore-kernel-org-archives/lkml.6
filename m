Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A8F1FC004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3B52089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 00:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Db1mMYmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3B52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934741AbeFLAVk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 20:21:40 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45691 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934706AbeFLAVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 20:21:35 -0400
Received: by mail-qk0-f195.google.com with SMTP id c198-v6so14068595qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 17:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VJ35+cAr60ktcS2YiCU2iAyS1vrhpyJ/SpYlzj64g9M=;
        b=Db1mMYmV6mPFNUXlDaxUvhSCETY3G1f+VY0d7nz4bKym6epQK0g2pZTCHAmQQ/hf6d
         i4Z9iKs6dHH2xs4AGzmcl66g3UbGxS6wE+E+Im7c0meXJLWNaI0r75V3Dg9TT5pg5xVG
         mfS3cXvoAx3NeR+GBa9Majb60TNBJ24MWUABA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VJ35+cAr60ktcS2YiCU2iAyS1vrhpyJ/SpYlzj64g9M=;
        b=dZfPrAFVksux1v0D9N2i0T5+XoCPKmlwolI+RRdft/QulU/EUoPEtWohweSijwi5h8
         17uAmTh9ra14vbmoLjMXQBsNZn+JkXdGSl+W8z0Rt5dC/CDJgFfGYK0i9v/HGcrOgljl
         iRpeyEAk66H/GZZdG72ej/+7A6BUvPwJL94HNuCDDtI2yhZXNGuA2/kVhFxlgRf0dNLn
         vymuQn/nKESs1I75eSeWm7onrCEfQb1EObztOzX1wNspZrk10AqmddyGucTX82LQ0/FK
         +BBjxdL3I8LrVgX3VLHtjyZYLlmeyon9AHbcZTTgCYkhhZGsSVDRBN2dBrhxWxWl6Alo
         DbXQ==
X-Gm-Message-State: APt69E2PwOSZCEmpn3k+8tRYx7tPjHOHUrYGHwWq/graLw1/b4/grLmM
        GYjZHPajyonx5yvMcRjdU4IpnlNlaks=
X-Google-Smtp-Source: ADUXVKIjAmTo0YMULLmGaV2+Zp/6fnBlQrpVIHexVr66ZzT8uvMYRDTx1a5oCEhFRU3NiGpX4gOziQ==
X-Received: by 2002:a37:7dc2:: with SMTP id y185-v6mr1315923qkc.232.1528762894967;
        Mon, 11 Jun 2018 17:21:34 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v26-v6sm31470299qtc.12.2018.06.11.17.21.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 17:21:34 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v2 5/5] PCI: iproc: Reduce inbound/outbound mapping print level
Date:   Mon, 11 Jun 2018 17:21:07 -0700
Message-Id: <1528762867-16823-6-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
References: <1528762867-16823-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce inbound/outbound mapping print level from dev_info to
dev_dbg. This reduces the console logs during Linux boot process

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 59be1e0..3160e93 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -880,14 +880,14 @@ static inline int iproc_pcie_ob_write(struct iproc_pcie *pcie, int window_idx,
 	writel(lower_32_bits(pci_addr), pcie->base + omap_offset);
 	writel(upper_32_bits(pci_addr), pcie->base + omap_offset + 4);
 
-	dev_info(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
-		 window_idx, oarr_offset, &axi_addr, &pci_addr);
-	dev_info(dev, "oarr lo 0x%x oarr hi 0x%x\n",
-		 readl(pcie->base + oarr_offset),
-		 readl(pcie->base + oarr_offset + 4));
-	dev_info(dev, "omap lo 0x%x omap hi 0x%x\n",
-		 readl(pcie->base + omap_offset),
-		 readl(pcie->base + omap_offset + 4));
+	dev_dbg(dev, "ob window [%d]: offset 0x%x axi %pap pci %pap\n",
+		window_idx, oarr_offset, &axi_addr, &pci_addr);
+	dev_dbg(dev, "oarr lo 0x%x oarr hi 0x%x\n",
+		readl(pcie->base + oarr_offset),
+		readl(pcie->base + oarr_offset + 4));
+	dev_dbg(dev, "omap lo 0x%x omap hi 0x%x\n",
+		readl(pcie->base + omap_offset),
+		readl(pcie->base + omap_offset + 4));
 
 	return 0;
 }
@@ -1054,8 +1054,8 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 	    iproc_pcie_reg_is_invalid(imap_offset))
 		return -EINVAL;
 
-	dev_info(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
-		 region_idx, iarr_offset, &axi_addr, &pci_addr);
+	dev_dbg(dev, "ib region [%d]: offset 0x%x axi %pap pci %pap\n",
+		region_idx, iarr_offset, &axi_addr, &pci_addr);
 
 	/*
 	 * Program the IARR registers.  The upper 32-bit IARR register is
@@ -1065,9 +1065,9 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 	       pcie->base + iarr_offset);
 	writel(upper_32_bits(pci_addr), pcie->base + iarr_offset + 4);
 
-	dev_info(dev, "iarr lo 0x%x iarr hi 0x%x\n",
-		 readl(pcie->base + iarr_offset),
-		 readl(pcie->base + iarr_offset + 4));
+	dev_dbg(dev, "iarr lo 0x%x iarr hi 0x%x\n",
+		readl(pcie->base + iarr_offset),
+		readl(pcie->base + iarr_offset + 4));
 
 	/*
 	 * Now program the IMAP registers.  Each IARR region may have one or
@@ -1081,10 +1081,10 @@ static int iproc_pcie_ib_write(struct iproc_pcie *pcie, int region_idx,
 		writel(upper_32_bits(axi_addr),
 		       pcie->base + imap_offset + ib_map->imap_addr_offset);
 
-		dev_info(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
-			 window_idx, readl(pcie->base + imap_offset),
-			 readl(pcie->base + imap_offset +
-			       ib_map->imap_addr_offset));
+		dev_dbg(dev, "imap window [%d] lo 0x%x hi 0x%x\n",
+			window_idx, readl(pcie->base + imap_offset),
+			readl(pcie->base + imap_offset +
+			      ib_map->imap_addr_offset));
 
 		imap_offset += ib_map->imap_window_offset;
 		axi_addr += size;
-- 
2.1.4

