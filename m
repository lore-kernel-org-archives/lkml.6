Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx48gKoHIRmCdO/zdB8qwCddvUDEVoRQwp/3YNUfAjafLqxNaPQY/IVz7Mtljkl3GtA2FZkok
ARC-Seal: i=1; a=rsa-sha256; t=1522679244; cv=none;
        d=google.com; s=arc-20160816;
        b=GOHEZiQyrZgM5mneb1P0MpbSRlis+eddopqPfiflaQMed2aGlmnuuVHGLDj3GZrJai
         MA+oYRusp160Q3GoItsFNYXaIs+9f2tL76bG5IwCrq+RdvV+2apPkUC8oj7pL2ra51/G
         zNBKkCw4LdAGHhVJIW91aFj7UL2VlSmozPXOAkwD2p6uKRtMq+Ouj6lzTkGAcRfGDc2j
         jqZq75AYLst+ZJeecE5kn9wa3SgK35jmQUx07eB1EIf3ESgLkUEcouYv+hSpDf+RQnbe
         QMwSPlpOHikyGp8WCH2RKH/Kkjt9wUQAyMHCq/MYZzVsJpKW7pf4XvhImQ4x3Ue8e0Rr
         tkCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=R+fIo5AiLSnOjA8pHLvSCJCdg1AM/tXohm5XhgjVeGk=;
        b=PUup6W6el3Ztd3XHSl7E//g/LXmy82yqugF9Zn+EvWKmTLnp3ZNYBVjWcJKDb5EsYx
         em1sjR9vfF83t51odlTv+sy5LksynzZ4EJAB2uLsU1pijh7JnFccUvhn0sze9qwRMEnI
         Z8v2FycnudQFKr63sHjDbekLPMD7mtoHAHXg04c9P0Vz7fxEjEy/iMTzJonpgcO8ao0r
         cWMSfJToANzrOSSPRwT0Xlb0MtySbwE/gSAKDE1ExDr3cN8Rni+2JtDoPr6QjYGFkcxJ
         0kREZIm8xEwcbLHf+xrm72G4wrYxf7WcgU6RsYRyFLtcJdkcgV/FWAsgiCeMVsAVxwYW
         9AGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:27:24 +0200
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
Subject: [PATCH 01/15] dmaengine: pxa: use a dma slave map
Date: Mon,  2 Apr 2018 16:26:42 +0200
Message-Id: <20180402142656.26815-2-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644911523217790?=
X-GMAIL-MSGID: =?utf-8?q?1596644911523217790?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to remove the specific knowledge of the dma mapping from PXA
drivers, add a default slave map for pxa architectures.

This won't impact MMP architecture, but is aimed only at all PXA boards.

This is the first step, and once all drivers are converted,
pxad_filter_fn() will be made static, and the DMA resources removed from
device.c.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/pxa_dma.c                 | 10 +++++++++-
 include/linux/platform_data/mmp_dma.h |  4 ++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index b53fb618bbf6..9505334f9c6e 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -179,6 +179,8 @@ static unsigned int pxad_drcmr(unsigned int line)
 	return 0x1000 + line * 4;
 }
 
+bool pxad_filter_fn(struct dma_chan *chan, void *param);
+
 /*
  * Debug fs
  */
@@ -1396,9 +1398,10 @@ static int pxad_probe(struct platform_device *op)
 {
 	struct pxad_device *pdev;
 	const struct of_device_id *of_id;
+	const struct dma_slave_map *slave_map = NULL;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
 	struct resource *iores;
-	int ret, dma_channels = 0, nb_requestors = 0;
+	int ret, dma_channels = 0, nb_requestors = 0, slave_map_cnt = 0;
 	const enum dma_slave_buswidth widths =
 		DMA_SLAVE_BUSWIDTH_1_BYTE   | DMA_SLAVE_BUSWIDTH_2_BYTES |
 		DMA_SLAVE_BUSWIDTH_4_BYTES;
@@ -1429,6 +1432,8 @@ static int pxad_probe(struct platform_device *op)
 	} else if (pdata && pdata->dma_channels) {
 		dma_channels = pdata->dma_channels;
 		nb_requestors = pdata->nb_requestors;
+		slave_map = pdata->slave_map;
+		slave_map_cnt = pdata->slave_map_cnt;
 	} else {
 		dma_channels = 32;	/* default 32 channel */
 	}
@@ -1440,6 +1445,9 @@ static int pxad_probe(struct platform_device *op)
 	pdev->slave.device_prep_dma_memcpy = pxad_prep_memcpy;
 	pdev->slave.device_prep_slave_sg = pxad_prep_slave_sg;
 	pdev->slave.device_prep_dma_cyclic = pxad_prep_dma_cyclic;
+	pdev->slave.filter.map = slave_map;
+	pdev->slave.filter.mapcnt = slave_map_cnt;
+	pdev->slave.filter.fn = pxad_filter_fn;
 
 	pdev->slave.copy_align = PDMA_ALIGNMENT;
 	pdev->slave.src_addr_widths = widths;
diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/platform_data/mmp_dma.h
index d1397c8ed94e..6397b9c8149a 100644
--- a/include/linux/platform_data/mmp_dma.h
+++ b/include/linux/platform_data/mmp_dma.h
@@ -12,9 +12,13 @@
 #ifndef MMP_DMA_H
 #define MMP_DMA_H
 
+struct dma_slave_map;
+
 struct mmp_dma_platdata {
 	int dma_channels;
 	int nb_requestors;
+	int slave_map_cnt;
+	const struct dma_slave_map *slave_map;
 };
 
 #endif /* MMP_DMA_H */
-- 
2.11.0
