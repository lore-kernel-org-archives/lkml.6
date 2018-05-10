Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757378AbeEJMwJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 08:52:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47656 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757217AbeEJMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 08:52:08 -0400
From: Colin King <colin.king@canonical.com>
To: "David S . Miller" <davem@davemloft.net>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        Pavel Belous <pavel.belous@aquantia.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: aquantia: fix unsigned numvecs comparison with less than zero
Date: Thu, 10 May 2018 13:52:01 +0100
Message-Id: <20180510125201.19707-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison of numvecs < 0 is always false because numvecs is a u32
and hence the error return from a failed call to pci_alloc_irq_vectores
is never detected.  Fix this by using the signed int ret to handle the
error return and assign numvecs to err.

Detected by CoverityScan, CID#1468650 ("Unsigned compared against 0")

Fixes: a09bd81b5413 ("net: aquantia: Limit number of vectors to actually allocated irqs")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index a50e08bb4748..750007513f9d 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -267,14 +267,13 @@ static int aq_pci_probe(struct pci_dev *pdev,
 	numvecs = min(numvecs, num_online_cpus());
 	/*enable interrupts */
 #if !AQ_CFG_FORCE_LEGACY_INT
-	numvecs = pci_alloc_irq_vectors(self->pdev, 1, numvecs,
-					PCI_IRQ_MSIX | PCI_IRQ_MSI |
-					PCI_IRQ_LEGACY);
+	err = pci_alloc_irq_vectors(self->pdev, 1, numvecs,
+				    PCI_IRQ_MSIX | PCI_IRQ_MSI |
+				    PCI_IRQ_LEGACY);
 
-	if (numvecs < 0) {
-		err = numvecs;
+	if (err < 0)
 		goto err_hwinit;
-	}
+	numvecs = err;
 #endif
 	self->irqvecs = numvecs;
 
-- 
2.17.0
