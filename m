Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02236C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7F321479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqPz/uaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7F321479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeJSB7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 21:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeJSB7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 21:59:44 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68B9421473;
        Thu, 18 Oct 2018 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885458;
        bh=OQJ8J3vVSK/s0fd1UP9WITZ3rFE16pcl54wcML7XJOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqPz/uaZzAB0DOuPwr7sXpkQSmTM6E+16UPqUr0I3jCb2mjaQvSjlhBkyUoN/NhTG
         O8Nn9GTfAowkv908u5NePLYbHTujzSaP3rJ4+9wFy4viPf6jmzjN7cTZpcruX0QzSI
         Gis/HwbQovYbFfY4xOjBYT2a1zKcDGHjYcCpYTs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 30/53] PCI: dwc: Fix scheduling while atomic issues
Date:   Thu, 18 Oct 2018 19:54:23 +0200
Message-Id: <20181018175422.066166427@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175416.561567978@linuxfoundation.org>
References: <20181018175416.561567978@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/controller/dwc/pcie-designware.c |    8 ++++----
 drivers/pci/controller/dwc/pcie-designware.h |    3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_un
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw
 		if (val & PCIE_ATU_ENABLE)
 			return;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
 }
@@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unro
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
@@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_p
 		if (val & PCIE_ATU_ENABLE)
 			return 0;
 
-		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
+		mdelay(LINK_WAIT_IATU);
 	}
 	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
 
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


