Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851B2C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5340F20868
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570308;
	bh=986fwwQFIti0dS7mkWuxz+ljNWAdN7OG1jsZpfP65Ck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xoVFiRnjOTa1WrwRTjWaRU8ZBDupZiwawfaEdL2NUwqhYyEdU0GcJrwkDaT2m1lgm
	 SnOdKY4+4B80eIxONAFRERbx1yhJbnhox4h4fnhvYwc7I/epEEI2zduh8Gb9T9Hfqs
	 Yond02zyXuCa9UfhWewb09uWi6FeN+w8qnKQB4as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbfAOQi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732066AbfAOQiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:38:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11E9820675;
        Tue, 15 Jan 2019 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570299;
        bh=986fwwQFIti0dS7mkWuxz+ljNWAdN7OG1jsZpfP65Ck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kZ14TCsB/PxZ6lVEedM8teY3Jhu/vhnXSxYYo+tQVPRKytHJVeSDx12UmTCrgujpa
         iKNYhOAGPPWr1ojRVKyOmD0gWtK5GptHC25QjzFlN/fH87zIWYi+3heLWsLqOLZj9O
         d7TLz3Cufsjijj+d0Kwn5gQj4luhfRXIaml+jra4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Claudius Heine <claudius.heine.ext@siemens.com>
Subject: [PATCH 4.4 41/51] PCI: altera: Reorder read/write functions
Date:   Tue, 15 Jan 2019 17:35:37 +0100
Message-Id: <20190115154853.167769469@linuxfoundation.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>

commit f8be11ae3d2c9a1338da37ff91ff4c65922d21be upstream.

Move cra_writel(), cra_readl(), and altera_pcie_link_is_up() so a future
patch can use them in altera_pcie_retrain().  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Claudius Heine <claudius.heine.ext@siemens.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/host/pcie-altera.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -81,6 +81,22 @@ struct tlp_rp_regpair_t {
 	u32 reg1;
 };
 
+static inline void cra_writel(struct altera_pcie *pcie, const u32 value,
+			      const u32 reg)
+{
+	writel_relaxed(value, pcie->cra_base + reg);
+}
+
+static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
+{
+	return readl_relaxed(pcie->cra_base + reg);
+}
+
+static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
+{
+	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
+}
+
 static void altera_pcie_retrain(struct pci_dev *dev)
 {
 	u16 linkcap, linkstat;
@@ -120,17 +136,6 @@ static bool altera_pcie_hide_rc_bar(stru
 	return false;
 }
 
-static inline void cra_writel(struct altera_pcie *pcie, const u32 value,
-			      const u32 reg)
-{
-	writel_relaxed(value, pcie->cra_base + reg);
-}
-
-static inline u32 cra_readl(struct altera_pcie *pcie, const u32 reg)
-{
-	return readl_relaxed(pcie->cra_base + reg);
-}
-
 static void tlp_write_tx(struct altera_pcie *pcie,
 			 struct tlp_rp_regpair_t *tlp_rp_regdata)
 {
@@ -139,11 +144,6 @@ static void tlp_write_tx(struct altera_p
 	cra_writel(pcie, tlp_rp_regdata->ctrl, RP_TX_CNTRL);
 }
 
-static bool altera_pcie_link_is_up(struct altera_pcie *pcie)
-{
-	return !!((cra_readl(pcie, RP_LTSSM) & RP_LTSSM_MASK) == LTSSM_L0);
-}
-
 static bool altera_pcie_valid_config(struct altera_pcie *pcie,
 				     struct pci_bus *bus, int dev)
 {


