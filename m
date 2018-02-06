Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbeBFURX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 15:17:23 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:26056 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeBFURW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 15:17:22 -0500
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 06 Feb 2018 21:17:20 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: ganeshgr@chelsio.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] cxgb4: Fix error handling path in 'init_one()'
Date: Tue,  6 Feb 2018 21:17:17 +0100
Message-Id: <20180206201717.27412-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit baf5086840ab1 ("cxgb4: restructure VF mgmt code") has reordered
some code but an error handling label has not been updated accordingly.
So fix it and free 'adapter' if 't4_wait_dev_ready()' fails.

Fixes: baf5086840ab1 ("cxgb4: restructure VF mgmt code")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 725643b4a8ab..79bffaa3c1af 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -5125,7 +5125,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	adapter->regs = regs;
 	err = t4_wait_dev_ready(regs);
 	if (err < 0)
-		goto out_unmap_bar0;
+		goto out_free_adapter;
 
 	/* We control everything through one PF */
 	whoami = readl(regs + PL_WHOAMI_A);
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
