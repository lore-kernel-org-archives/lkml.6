Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754397AbeEHGuu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 02:50:50 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:18705 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754201AbeEHGus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 02:50:48 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 08 May 2018 08:50:47 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: davem@davemloft.net, igor.russkikh@aquantia.com,
        pavel.belous@aquantia.com, weiyongjun1@huawei.com,
        dan.carpenter@oracle.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net: aquantia: Fix an error handling path in 'aq_pci_probe()'
Date: Tue,  8 May 2018 08:39:47 +0200
Message-Id: <20180508063947.11317-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The position of 2 labels should be swapped in order to release resources
in the correct order and avoid leaks.

Fixes: 23ee07ad3c2f ("net: aquantia: Cleanup pci functions module")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The order of 'pci_release_regions()' and 'free_netdev()' is in reverse
order in the 'aq_pci_remove()' function.
I don't know if done on purpose and/or needed, so I've left it as-is.
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index ecc6306f940f..b7f6b5a68b33 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -298,9 +298,9 @@ static int aq_pci_probe(struct pci_dev *pdev,
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
-- 
2.17.0
