Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C161FC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BE620892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790795;
	bh=uJzYK72j4aco5hje6jb9Tar7Qx0D99JDKt27C27JmBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJHMMFsikx3ZKxUrNzcqOU1R1E+h7iVLvppeQDwWkY/4jDzRblb+Di4EHcz96tzvF
	 /o+Rq1ArpntYJdhknJa9IpFJakoYYFTDhCNRRGE+TS+oEJPn+rmlunKqaLrzS8s5dB
	 16gD12vMbHmHxrDJK2xvMNkrop/94jJq6oHIE/1Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87BE620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbeLNMIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:08:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730483AbeLNMId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:08:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9D42147D;
        Fri, 14 Dec 2018 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789312;
        bh=uJzYK72j4aco5hje6jb9Tar7Qx0D99JDKt27C27JmBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tXdSP2MMFzz9J3xVD53KDwqedH5y2ziMS4iQkhuWzjOIftGIQ3ii35J1j1AKbSGDJ
         rQVCgXyGb0IM9VYkOfhIbrMow/vGbvBKVS77+73KHYMahovWa53sF5CvmFcHLa3SkI
         FEC2AdgnpEkxNJixClhLjS9a3XQO1Kdf/EoQduqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Trent Piepho <tpiepho@impinj.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 34/89] PCI: imx6: Fix link training status detection in link up check
Date:   Fri, 14 Dec 2018 12:59:47 +0100
Message-Id: <20181214115731.377184829@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 68bc10bf992180f269816ff3d22eb30383138577 ]

This bug was introduced in the interaction for two commits on either
branch of the merge commit 562df5c8521e ("Merge branch
'pci/host-designware' into next").

Commit 4d107d3b5a68 ("PCI: imx6: Move link up check into
imx6_pcie_wait_for_link()"), changed imx6_pcie_wait_for_link() to poll
the link status register directly, checking for link up and not
training, and made imx6_pcie_link_up() only check the link up bit (once,
not a polling loop).

While commit 886bc5ceb5cc ("PCI: designware: Add generic
dw_pcie_wait_for_link()"), replaced the loop in
imx6_pcie_wait_for_link() with a call to a new dwc core function, which
polled imx6_pcie_link_up(), which still checked both link up and not
training in a loop.

When these two commits were merged, the version of
imx6_pcie_wait_for_link() from 886bc5ceb5cc was kept, which eliminated
the link training check placed there by 4d107d3b5a68. However, the
version of imx6_pcie_link_up() from 4d107d3b5a68 was kept, which
eliminated the link training check that had been there and was moved to
imx6_pcie_wait_for_link().

The result was the link training check got lost for the imx6 driver.

Eliminate imx6_pcie_link_up() so that the default handler,
dw_pcie_link_up(), is used instead. The default handler has the correct
code, which checks for link up and also that it still is not training,
fixing the regression.

Fixes: 562df5c8521e ("Merge branch 'pci/host-designware' into next")
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
[lorenzo.pieralisi@arm.com: rewrote the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/dwc/pci-imx6.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/pci/dwc/pci-imx6.c b/drivers/pci/dwc/pci-imx6.c
index b73483534a5b..1f1069b70e45 100644
--- a/drivers/pci/dwc/pci-imx6.c
+++ b/drivers/pci/dwc/pci-imx6.c
@@ -83,8 +83,6 @@ struct imx6_pcie {
 #define PCIE_PL_PFLR_FORCE_LINK			(1 << 15)
 #define PCIE_PHY_DEBUG_R0 (PL_OFFSET + 0x28)
 #define PCIE_PHY_DEBUG_R1 (PL_OFFSET + 0x2c)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_IN_TRAINING	(1 << 29)
-#define PCIE_PHY_DEBUG_R1_XMLH_LINK_UP		(1 << 4)
 
 #define PCIE_PHY_CTRL (PL_OFFSET + 0x114)
 #define PCIE_PHY_CTRL_DATA_LOC 0
@@ -653,12 +651,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int imx6_pcie_link_up(struct dw_pcie *pci)
-{
-	return dw_pcie_readl_dbi(pci, PCIE_PHY_DEBUG_R1) &
-			PCIE_PHY_DEBUG_R1_XMLH_LINK_UP;
-}
-
 static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 	.host_init = imx6_pcie_host_init,
 };
@@ -701,7 +693,7 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 }
 
 static const struct dw_pcie_ops dw_pcie_ops = {
-	.link_up = imx6_pcie_link_up,
+	/* No special ops needed, but pcie-designware still expects this struct */
 };
 
 static int imx6_pcie_probe(struct platform_device *pdev)
-- 
2.19.1



