Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754712AbeDMLZq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:25:46 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41830 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754568AbeDMLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:25:45 -0400
From: Mark Brown <broonie@kernel.org>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spi-topcliff-pch: Replace GFP_ATOMIC with GFP_KERNEL in pch_spi_handle_dma" to the spi tree
In-Reply-To: <1523351176-29741-1-git-send-email-baijiaju1990@gmail.com>
Message-Id: <E1f6wpr-0000VC-1j@debutante>
Date: Fri, 13 Apr 2018 12:25:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-topcliff-pch: Replace GFP_ATOMIC with GFP_KERNEL in pch_spi_handle_dma

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From d16cd3eb8e5c62cd349987f57e3511b59cbe0198 Mon Sep 17 00:00:00 2001
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Tue, 10 Apr 2018 17:06:16 +0800
Subject: [PATCH] spi: spi-topcliff-pch: Replace GFP_ATOMIC with GFP_KERNEL in
 pch_spi_handle_dma

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
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 97d137591b18..dc93ca9e001c 100644
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
2.17.0
