Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4+8QOMet2+MTP+VWgFUngIynr+D0ht98PZxQE6qfQ7LmATH8WyWhwTD1SLkHCIMoardpFO9
ARC-Seal: i=1; a=rsa-sha256; t=1522679297; cv=none;
        d=google.com; s=arc-20160816;
        b=vsDseC61zwE/r5cYMvpwYwlOzkqd5OKn1mF9XlvoKK9LIV2Vh+OUYxmgUfSAcoUo23
         n53DO4708VC8/Vda2wgKH8AQAloGySrNHHH81UDrGOKqaH87XajhGDXaCeSFSBmXTsBV
         3THm8D06/QTyiBhTYti53YpOZwUiJKH5zhiejvxvccJbbbxZJRUBtR4Bm+r0TN2vBwfp
         l15lA92+zKrZfreBfVTFqnuqJHb5TcWYsxK3TIs6yNyqPmukZI3AhfI4KAWuuK8o76mu
         NOWD6FNH3xQZ7DtPCOOLO8lW5BpBBbVf6OnWDXvm/r3WByhCQd2kDiLnE8SxMQC+XLEU
         +22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QNBe81X9irmTc/L9iZQW7p8+073qjbv8t8rjrN3AAeg=;
        b=n7hz97fqbbVvFInqFA4NWxAI6T0Ws4bnkcCdyj0MLfddKxyNb+qLpiG0B9kxZsgkZ8
         47sm81AocTzRdwzscbVPAn/SrTGZp3NqmO/dQSW/tRY9+STx6YlYE9nNYPBrPmElODEF
         vcwaJyk18ALn6yNFzm0MY2tlN+MsKUZtgLtWzvkiMo74426kEVEMo8b+emaiS3nocYyq
         F2Ga2zSZV3t/xWbLbGyonkefhs7InL54nXcioRRRxCgIWty6i26ZYS9ELXxh9wMtAtd9
         BOuuGkk0PDiv3xkc8WCl5mhY4snKRIJ+GLG0KvGUjU1Vpp9LlbaGFNwbu4sOp0LZC4cx
         LmsA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:28:16 +0200
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
	Arnd Bergmann <arnd@arndb.de>
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
Subject: [PATCH 10/15] ata: pata_pxa: remove the dmaengine compat need
Date: Mon,  2 Apr 2018 16:26:51 +0200
Message-Id: <20180402142656.26815-11-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644967070217620?=
X-GMAIL-MSGID: =?utf-8?q?1596644967070217620?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/ata/pata_pxa.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/ata/pata_pxa.c b/drivers/ata/pata_pxa.c
index f6c46e9a4dc0..e8b6a2e464c9 100644
--- a/drivers/ata/pata_pxa.c
+++ b/drivers/ata/pata_pxa.c
@@ -25,7 +25,6 @@
 #include <linux/libata.h>
 #include <linux/platform_device.h>
 #include <linux/dmaengine.h>
-#include <linux/dma/pxa-dma.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
@@ -180,8 +179,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	struct resource *irq_res;
 	struct pata_pxa_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct dma_slave_config	config;
-	dma_cap_mask_t mask;
-	struct pxad_param param;
 	int ret = 0;
 
 	/*
@@ -278,10 +275,6 @@ static int pxa_ata_probe(struct platform_device *pdev)
 
 	ap->private_data = data;
 
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	param.prio = PXAD_PRIO_LOWEST;
-	param.drcmr = pdata->dma_dreq;
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 	config.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -294,8 +287,7 @@ static int pxa_ata_probe(struct platform_device *pdev)
 	 * Request the DMA channel
 	 */
 	data->dma_chan =
-		dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						 &param, &pdev->dev, "data");
+		dma_request_slave_channel(&pdev->dev, "data");
 	if (!data->dma_chan)
 		return -EBUSY;
 	ret = dmaengine_slave_config(data->dma_chan, &config);
-- 
2.11.0
