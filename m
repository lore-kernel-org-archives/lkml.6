Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754175AbeEHFob (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 01:44:31 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:39725 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754070AbeEHFoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 01:44:30 -0400
X-ME-Helo: ubuntu-CJ.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 08 May 2018 07:44:27 +0200
X-ME-IP: 86.244.116.1
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: swise@chelsio.com, dledford@redhat.com, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iw_cxgb4: Fix an error handling path in 'c4iw_get_dma_mr()'
Date: Tue,  8 May 2018 07:44:27 +0200
Message-Id: <20180508054427.10697-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling path of 'c4iw_get_dma_mr()' does not free resources
in the correct order.
If an error occures, it can leak 'mhp->wr_waitp'.

Fixes: a3f12da0e99a ("iw_cxgb4: allocate wait object for each memory object")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/infiniband/hw/cxgb4/mem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
index e90f2fd8dc16..1445918e3239 100644
--- a/drivers/infiniband/hw/cxgb4/mem.c
+++ b/drivers/infiniband/hw/cxgb4/mem.c
@@ -489,10 +489,10 @@ struct ib_mr *c4iw_get_dma_mr(struct ib_pd *pd, int acc)
 err_dereg_mem:
 	dereg_mem(&rhp->rdev, mhp->attr.stag, mhp->attr.pbl_size,
 		  mhp->attr.pbl_addr, mhp->dereg_skb, mhp->wr_waitp);
-err_free_wr_wait:
-	c4iw_put_wr_wait(mhp->wr_waitp);
 err_free_skb:
 	kfree_skb(mhp->dereg_skb);
+err_free_wr_wait:
+	c4iw_put_wr_wait(mhp->wr_waitp);
 err_free_mhp:
 	kfree(mhp);
 	return ERR_PTR(ret);
-- 
2.17.0
