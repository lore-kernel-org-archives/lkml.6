Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeDJJIz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 05:08:55 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52914 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbeDJJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 05:06:26 -0400
X-Google-Smtp-Source: AIpwx4825aYAcguLJOcY7uI375pUn/59ATzz+/2tW4+qLtMLP9ywPIY0NdZD0cBHbh5ioS3q3Gq+gg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] spi: spi-topcliff-pch: Replace GFP_ATOMIC with GFP_KERNEL in pch_spi_handle_dma
Date: Tue, 10 Apr 2018 17:06:16 +0800
Message-Id: <1523351176-29741-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pch_spi_handle_dma() is never called in atomic context.
This function is only called by pch_spi_process_messages().
pch_spi_process_messages() is only set as a parameter of INIT_WORK() in
pch_spi_pd_probe().

Despite never getting called from atomic context,
pch_spi_handle_dma() calls kcalloc() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d1375..dc93ca9 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1007,7 +1007,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 	spin_unlock_irqrestore(&data->lock, flags);
 
 	/* RX */
-	dma->sg_rx_p = kcalloc(num, sizeof(*dma->sg_rx_p), GFP_ATOMIC);
+	dma->sg_rx_p = kcalloc(num, sizeof(*dma->sg_rx_p), GFP_KERNEL);
 	sg_init_table(dma->sg_rx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_rx_p;
@@ -1067,7 +1067,7 @@ static void pch_spi_handle_dma(struct pch_spi_data *data, int *bpw)
 		head = 0;
 	}
 
-	dma->sg_tx_p = kcalloc(num, sizeof(*dma->sg_tx_p), GFP_ATOMIC);
+	dma->sg_tx_p = kcalloc(num, sizeof(*dma->sg_tx_p), GFP_KERNEL);
 	sg_init_table(dma->sg_tx_p, num); /* Initialize SG table */
 	/* offset, length setting */
 	sg = dma->sg_tx_p;
-- 
1.9.1
