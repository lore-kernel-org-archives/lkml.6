Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF761C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15BB20855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J6knWjID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfAREXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:23:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33719 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfAREXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:23:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so5939321pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 20:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gd0kst7cuRr2aJzLZ1SyEXPC1v7Rd0v/exoBmWBr5Lk=;
        b=J6knWjIDQCLGBYyOXOnhUuv743heQ74vXvmaqSmUkO1oZX5huX+onum4NfQtdxgpbb
         Ft0MKPck9Y6biFY4zI0ebMMZISj8MEh5yqmF1yIMZ3Me+iY5+Jf4OkalnKyPQVsYn7XK
         YZb1KjhuP0EExGOcK1VRuEJD9k9drzCx6CF7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gd0kst7cuRr2aJzLZ1SyEXPC1v7Rd0v/exoBmWBr5Lk=;
        b=UdGBsJSk/FrzAkIfsFdy1sC77k/swiNKjS1xMvNKh05sL9G4bD38YDVQo9WTPJSOes
         aO+WYronbBg5lObEOvLtVt0y04iLyjH9pD46+jMS0+xOEyUH2NblaGnJxJ9S9KUN11ai
         0yltFwvAntkpMadHhJLs87V5TEEdZPPypXKo4SnuJ7UJdu4juD3HeFiMcyUMdMgi9DF/
         zUzUYEE9/ah801wj55snfuXk2Pgvse9C5IVZ18KlReCVRjlYpaILOOiSNP75dPJfPozw
         PrRNqeYAVm0aTksFvIzA2YdzNy4p2ADf12iuZRzCIVrLbGyQAJAPL3Ep8swUPrtChhI8
         xNeg==
X-Gm-Message-State: AJcUukfEwcRHIlivwwQa/gtdXFZCQcgHxYO+SzSIQOn0kyT7nXzrzL6v
        Q2hXgj5OIRo1nXE8BoFTFTDxJw==
X-Google-Smtp-Source: ALg8bN4xUhsQZmsQKGkIZWSEBZvlmxLxy7BOBQ1tFZqVPkqp9bzI+oflrZWZ611rODzPAe0rCfzdHg==
X-Received: by 2002:a63:ab08:: with SMTP id p8mr15772500pgf.87.1547785425262;
        Thu, 17 Jan 2019 20:23:45 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l19sm7339642pfi.71.2019.01.17.20.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 20:23:44 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Abhishek Shah <abhishek.shah@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 3/3] PCI: iproc: Add PCIe 32bit outbound memory configuration
Date:   Fri, 18 Jan 2019 09:53:23 +0530
Message-Id: <1547785403-32268-4-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
References: <1547785403-32268-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPROC PCIe RC supports outbound memory mapping with SOC address inside
4GB address boundary, which is 32 bit AXI address.
This patch add the support.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Abhishek Shah <abhishek.shah@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Vikram Prakash <vikram.prakash@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index ee89d56..4d0e63b 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -982,8 +982,25 @@ static int iproc_pcie_setup_ob(struct iproc_pcie *pcie, u64 axi_addr,
 			resource_size_t window_size =
 				ob_map->window_sizes[size_idx] * SZ_1M;
 
-			if (size < window_size)
-				continue;
+			/*
+			 * Keep iterating until we reach the last window and
+			 * with the minimal window size at index zero. In this
+			 * case, we take a compromise by mapping it using the
+			 * minimum window size that can be supported
+			 */
+			if (size < window_size) {
+				if (size_idx > 0 || window_idx > 0)
+					continue;
+
+				/*
+				 * For the corner case of reaching the minimal
+				 * window size that can be supported on the
+				 * last window
+				 */
+				axi_addr = ALIGN_DOWN(axi_addr, window_size);
+				pci_addr = ALIGN_DOWN(pci_addr, window_size);
+				size = window_size;
+			}
 
 			if (!IS_ALIGNED(axi_addr, window_size) ||
 			    !IS_ALIGNED(pci_addr, window_size)) {
-- 
2.7.4

