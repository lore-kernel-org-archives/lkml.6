Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8672AC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF72208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF72208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936283AbeFRIYw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:24:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936091AbeFRIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:24:48 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CDDAEBAD;
        Mon, 18 Jun 2018 08:24:47 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Long, Nicholas" <nicholas.a.long@baesystems.com>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 203/279] net: aquantia: Limit number of vectors to actually allocated irqs
Date:   Mon, 18 Jun 2018 10:13:08 +0200
Message-Id: <20180618080617.297253514@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Igor Russkikh <igor.russkikh@aquantia.com>

[ Upstream commit a09bd81b5413d1b4d705c6c5303b5d311069da22 ]

Driver should use pci_alloc_irq_vectors return value to correct number
of allocated vectors and napi instances. Otherwise it'll panic later
in pci_irq_vector.

Driver also should allow more than one MSI vectors to be allocated.

Error return path from pci_alloc_irq_vectors is also fixed to revert
resources in a correct sequence when error happens.

Reported-by: Long, Nicholas <nicholas.a.long@baesystems.com>
Fixes: 23ee07a ("net: aquantia: Cleanup pci functions module")
Signed-off-by: Igor Russkikh <igor.russkikh@aquantia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c      |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_nic.h      |    1 
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c |   20 +++++++++----------
 3 files changed, 12 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -95,6 +95,7 @@ void aq_nic_cfg_start(struct aq_nic_s *s
 	/*rss rings */
 	cfg->vecs = min(cfg->aq_hw_caps->vecs, AQ_CFG_VECS_DEF);
 	cfg->vecs = min(cfg->vecs, num_online_cpus());
+	cfg->vecs = min(cfg->vecs, self->irqvecs);
 	/* cfg->vecs should be power of 2 for RSS */
 	if (cfg->vecs >= 8U)
 		cfg->vecs = 8U;
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.h
@@ -80,6 +80,7 @@ struct aq_nic_s {
 
 	struct pci_dev *pdev;
 	unsigned int msix_entry_mask;
+	u32 irqvecs;
 };
 
 static inline struct device *aq_nic_get_dev(struct aq_nic_s *self)
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -267,16 +267,16 @@ static int aq_pci_probe(struct pci_dev *
 	numvecs = min(numvecs, num_online_cpus());
 	/*enable interrupts */
 #if !AQ_CFG_FORCE_LEGACY_INT
-	err = pci_alloc_irq_vectors(self->pdev, numvecs, numvecs,
-				    PCI_IRQ_MSIX);
-
-	if (err < 0) {
-		err = pci_alloc_irq_vectors(self->pdev, 1, 1,
-					    PCI_IRQ_MSI | PCI_IRQ_LEGACY);
-		if (err < 0)
-			goto err_hwinit;
+	numvecs = pci_alloc_irq_vectors(self->pdev, 1, numvecs,
+					PCI_IRQ_MSIX | PCI_IRQ_MSI |
+					PCI_IRQ_LEGACY);
+
+	if (numvecs < 0) {
+		err = numvecs;
+		goto err_hwinit;
 	}
 #endif
+	self->irqvecs = numvecs;
 
 	/* net device init */
 	aq_nic_cfg_start(self);
@@ -298,9 +298,9 @@ err_free_aq_hw:
 	kfree(self->aq_hw);
 err_ioremap:
 	free_netdev(ndev);
-err_pci_func:
-	pci_release_regions(pdev);
 err_ndev:
+	pci_release_regions(pdev);
+err_pci_func:
 	pci_disable_device(pdev);
 	return err;
 }


