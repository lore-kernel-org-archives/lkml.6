Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29104C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED67520873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570303;
	bh=TXPJLmLLL5CQmATLvnS3rYdpYZrlKBEOLix+mo6tivo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fh1v9Zlmw+6z11Esx+zI1ceLKrbDpGJxPMdWqgIkrtW7vsEuZbgRSS/3aP0eC5uux
	 Tw/lVdSVymtkNIWyBN90PPmZbubG59QSXYh0p7kbgVmHbeqnBCK5tCFxOKqp3QECLx
	 0PxI9xd/ciEG3g+IZ28yntjACj1p2VojGpoUKxSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfAOQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732051AbfAOQiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6820B20859;
        Tue, 15 Jan 2019 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570296;
        bh=TXPJLmLLL5CQmATLvnS3rYdpYZrlKBEOLix+mo6tivo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRK2/ZNy7HoIw1pLIaxXq0XbJwd+VR6o1gp+S6cA1lyswIbtPDbuTJNrZng67L+EB
         QXsDCkPbEj/gpUiuG0cBJA594dnOCXxd9H08ndKI2ZP2oqM9kAKZmtyFA3PYcxej35
         gjtzu3BDp85wmVtypeayUp08WIYSVdcShYEPU5ro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 40/51] PCI: altera: Fix altera_pcie_link_is_up()
Date:   Tue, 15 Jan 2019 17:35:36 +0100
Message-Id: <20190115154853.050447253@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ley Foon Tan <lftan@altera.com>

commit eff31f4002c4e25b9b8c39d0a3a551c6c64c77e8 upstream.

Originally altera_pcie_link_is_up() decided the link was up if any of the
low four bits of the LTSSM register were set.  But the link is only up if
the LTSSM state is L0, so check for that exact value.

[bhelgaas: changelog]
Signed-off-by: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -40,6 +40,7 @@
 #define P2A_INT_ENABLE			0x3070
 #define P2A_INT_ENA_ALL			0xf
 #define RP_LTSSM			0x3c64
+#define RP_LTSSM_MASK			0x1f
 #define LTSSM_L0			0xf
 
 /* TLP configuration type 0 and 1 */
@@ -140,7 +141,7 @@ static void tlp_write_tx(struct altera_p
 
 static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
 {
-	return !!(cra_readl(pcie, RP_LTSSM) & LTSSM_L0);
+	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
 }
 
 static bool altera_pcie_valid_config(struct altera_pcie *pcie,


