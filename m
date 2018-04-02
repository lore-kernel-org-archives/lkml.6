Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4+dooOMoI0EwwgSFBfE2I9jYCnafmBO/Yo0s1bGEszGujknnLeX37XGGjs6/f+zjCEQGdD3
ARC-Seal: i=1; a=rsa-sha256; t=1522679252; cv=none;
        d=google.com; s=arc-20160816;
        b=zaM2c/WyZtzQbT3JhaQkIq+th8IySoOnosgOoJLIJ4vqannJ1JS5QzFkdUd1F0uujV
         CtystYrNYt4aXJBaP8Y4EAiDn+67oPnykQz60WHGNdAM/i59CSgtF8G4WiOFxeFj3rvK
         wlZgyjosDquYWePc5Z1ggOPfjvmmrxxg3K6txarZAz72iNx5BvrTu6cvRDBt+OZ+J6Kv
         ocyM9KpweEPXzLUJcj1JtalRCu6Z0yAN7mKelABVdJS3dr9WoH6dHzKN241Z0NKIXX0L
         gAcnzjF3VLk9PXFNjopL8WP2/+/OXUW8nFPqLpCCRGAEeA02lTnLnSAwsyJvUtumPP8b
         NJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QSE4x+Mn0Rg6czmeVAG+5Q0deMIPQNl8KkJneAPnKTM=;
        b=TNnjFPQSe6CMwMs2NCn+RVWbEtGE8//kWY8r3OC3qIYb4/cA5fBfAwjHMgDnMV5QRg
         NtCIjTjgXrWc7vO+Yhj1AaJWGAkAhqOskC0zv6in+5xOdXx6iKoJsz/jZ7IMaQ4RoCBv
         SPn+x//pA4rhJIV/nm5MWeyq26yM+WBTcfnt9I9EH0lqUt7uT8yMdfmM/iZ2BEYKMDi5
         S6zk/4br5vJae8XVNU2lNW+lmxfIEE1JPEUmonDzAMSgGGEEE+k/DaHIvU7kTXJYcreq
         mBm0Vp6KJp8du2r2FUEcAv02dpJwjiEKzWgCAz32ViK20cGJ5/0W0L7T2rRKelHd3xM2
         UgwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:27:32 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Tejun Heo <tj@kernel.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Marek Vasut <marek.vasut@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
	Nicolas Pitre <nico@fluxnic.net>,
	Samuel Ortiz <samuel@sortiz.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	netdev@vger.kernel.org,
	devel@driverdev.osuosl.org,
	alsa-devel@alsa-project.org
Subject: [PATCH 03/15] mmc: pxamci: remove the dmaengine compat need
Date: Mon,  2 Apr 2018 16:26:44 +0200
Message-Id: <20180402142656.26815-4-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644920313214274?=
X-GMAIL-MSGID: =?utf-8?q?1596644920313214274?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/mmc/host/pxamci.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index c763b404510f..6c94474e36f4 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -24,7 +24,6 @@
 #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma/pxa-dma.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/mmc/host.h>
@@ -637,10 +636,8 @@ static int pxamci_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
 	struct pxamci_host *host = NULL;
-	struct resource *r, *dmarx, *dmatx;
-	struct pxad_param param_rx, param_tx;
+	struct resource *r;
 	int ret, irq, gpio_cd = -1, gpio_ro = -1, gpio_power = -1;
-	dma_cap_mask_t mask;
 
 	ret = pxamci_of_init(pdev);
 	if (ret)
@@ -739,34 +736,14 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mmc);
 
-	if (!pdev->dev.of_node) {
-		dmarx = platform_get_resource(pdev, IORESOURCE_DMA, 0);
-		dmatx = platform_get_resource(pdev, IORESOURCE_DMA, 1);
-		if (!dmarx || !dmatx) {
-			ret = -ENXIO;
-			goto out;
-		}
-		param_rx.prio = PXAD_PRIO_LOWEST;
-		param_rx.drcmr = dmarx->start;
-		param_tx.prio = PXAD_PRIO_LOWEST;
-		param_tx.drcmr = dmatx->start;
-	}
-
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-
-	host->dma_chan_rx =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param_rx, &pdev->dev, "rx");
+	host->dma_chan_rx = dma_request_slave_channel(&pdev->dev, "rx");
 	if (host->dma_chan_rx == NULL) {
 		dev_err(&pdev->dev, "unable to request rx dma channel\n");
 		ret = -ENODEV;
 		goto out;
 	}
 
-	host->dma_chan_tx =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param_tx,  &pdev->dev, "tx");
+	host->dma_chan_tx = dma_request_slave_channel(&pdev->dev, "tx");
 	if (host->dma_chan_tx == NULL) {
 		dev_err(&pdev->dev, "unable to request tx dma channel\n");
 		ret = -ENODEV;
-- 
2.11.0
