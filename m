Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx48Dq1nDQgHpmsxGAI2TP1JSAbWrHXpC5xnv7V3WD2hZwmqWb9+OymRiqgVaWspks2hDMaem
ARC-Seal: i=1; a=rsa-sha256; t=1522679294; cv=none;
        d=google.com; s=arc-20160816;
        b=miB0dnVktYMQhBsyQil32pjC/VD61ADfx7Yo80nderQayKE8igVeRzisH3Bd89Lo4D
         XO178LM7alsMJiKejGKRFoUdXVn2MgCQ+YZ7keZf/CFZAol0Z5lw/uX/OACUeRvPXcq1
         E86NwRPVMTJPHopPVcle4hDh2RnGb8NB8sXV9B5jSU12YNgv5hYN8JcFlwm7x5VeDRFi
         8oSm7m73FQ9KdvyVXtT14dfwnPC3xWBFRv23b3ubC0iYf1p+Cqhy+93LBUDBdGjN+bhw
         Q2Ruu/l2xokpXCjfBPTGCmJb/rtq6cSDHAXwcsCH2PMMRWa11m/SxBlnye9zzovZgvSz
         ghZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=saCh87uoAmJqoBHIbF7+lRXWCGb/Zig8J3MZGeR+uzQ=;
        b=OBkx1+C0l9y4oAQvY2inRuGtQZ+nVyJ1/HjJRV6YSWgfhvyLtx86wRAeoaeoesTjqb
         R9ymxw11eCRUPuzbt2TBUjpPPfKTPv1Nr4ods7MKRSIAtY8hbcvRHOIhZ1iwjZ2+qunU
         Di1MZq8f6IyjfWa0XXcIo8Lc+DVooyZAE8B95bCldZMf4uhNVoNxIyasL1JCGO9jFCJT
         1LoI+pEQkMiegRq+XVUaZMToOry0u3e34HwgMrmxlDipMa54kXLb2zJcs+FQxJTb1s0t
         Ie6jajpS0tmhuvyejltKRfXrc9GFvV8SJNXm7o4nr61bq0EP4ei553/dHYlVbucpWlOs
         0Qkg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:28:14 +0200
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
	"David S. Miller" <davem@davemloft.net>,
	Pravin Shedge <pravin.shedge4linux@gmail.com>
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
Subject: [PATCH 09/15] net: irda: pxaficp_ir: remove the dmaengine compat need
Date: Mon,  2 Apr 2018 16:26:50 +0200
Message-Id: <20180402142656.26815-10-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644963928082724?=
X-GMAIL-MSGID: =?utf-8?q?1596644963928082724?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the pxa architecture switched towards the dmaengine slave map, the
old compatibility mechanism to acquire the dma requestor line number and
priority are not needed anymore.

This patch simplifies the dma resource acquisition, using the more
generic function dma_request_slave_channel().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/staging/irda/drivers/pxaficp_ir.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/irda/drivers/pxaficp_ir.c b/drivers/staging/irda/drivers/pxaficp_ir.c
index 2ea00a6531f9..9dd6e21dc11e 100644
--- a/drivers/staging/irda/drivers/pxaficp_ir.c
+++ b/drivers/staging/irda/drivers/pxaficp_ir.c
@@ -20,7 +20,6 @@
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/dma/pxa-dma.h>
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/sched/clock.h>
@@ -735,9 +734,7 @@ static void pxa_irda_shutdown(struct pxa_irda *si)
 static int pxa_irda_start(struct net_device *dev)
 {
 	struct pxa_irda *si = netdev_priv(dev);
-	dma_cap_mask_t mask;
 	struct dma_slave_config	config;
-	struct pxad_param param;
 	int err;
 
 	si->speed = 9600;
@@ -757,9 +754,6 @@ static int pxa_irda_start(struct net_device *dev)
 	disable_irq(si->icp_irq);
 
 	err = -EBUSY;
-	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
-	param.prio = PXAD_PRIO_LOWEST;
 
 	memset(&config, 0, sizeof(config));
 	config.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
@@ -769,15 +763,11 @@ static int pxa_irda_start(struct net_device *dev)
 	config.src_maxburst = 32;
 	config.dst_maxburst = 32;
 
-	param.drcmr = si->drcmr_rx;
-	si->rxdma = dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						     &param, &dev->dev, "rx");
+	si->rxdma = dma_request_slave_channel(&dev->dev, "rx");
 	if (!si->rxdma)
 		goto err_rx_dma;
 
-	param.drcmr = si->drcmr_tx;
-	si->txdma = dma_request_slave_channel_compat(mask, pxad_filter_fn,
-						     &param, &dev->dev, "tx");
+	si->txdma = dma_request_slave_channel(&dev->dev, "tx");
 	if (!si->txdma)
 		goto err_tx_dma;
 
-- 
2.11.0
