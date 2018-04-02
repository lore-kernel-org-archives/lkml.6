Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx48MQP9903B6SqTSc7MUGLpL18Q1ziB+eaeVqUKtY3oSV2fh1pgamyKyO/tpC/zdbDD6i9re
ARC-Seal: i=1; a=rsa-sha256; t=1522679247; cv=none;
        d=google.com; s=arc-20160816;
        b=LOQ9wg4p7V/OqnoyLnOfHE0WFVXDoIy5SqaanwL7TwK0UC0OLsR8uDMp35H0XqO0Au
         +NVthL63jfKic2M6vXFVGUltwtFZ4GE/anOxUTxxw9/wyUdfMjTyy2+2PiLWcFiB+gvf
         b1NsFa0l4Id07Pb5I3vmM5KVfJLtlsGtmhw5lgs5gOpu32XGQAs8qZxBfU5HYB+DEdCj
         Qi91I6hWXSYUvhiyoDjEF5NUS1XxfnI63QB7XV+gqMO+dSp/8RYq1YOZNjTV5ZYpTAC7
         G9ILiEUNNW1oq8k3Q86LbJIsXlhE8emfEcD/YbK/9esG7YVKJqSZ63r2DMonaNEMDllu
         ADEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BSGLX/W0/VRROKua6WdOuqR+gTgh7J7bMEDV20QGU/Q=;
        b=RONqucWSGhn2PqQu46zPhyOIX6nmQ73r+y+rv0mJ2NZ2GUikH92GbNQiIlBqDkBIIW
         xHkDih8BM/P92a1mDIKtnCoFmca9dbzbPr0qhdMorkc74yz89VgvMSD7LpdoJGK730or
         nbAYrA0pw0R89Yx3DOCQ0VGZlft3uQTVuaxlSL+lXBywdQnmqugJwmfjEfu6d6t7TcfQ
         2iyYj59+rnuJDyTXG7vWUNS3wTw/eYIyw3JCC8YgZ1fSFP2XXawDkVFD+EoGgUBl44WF
         0HcjpZwIox6joxhydgaFN4ckrWZZb6LduJoK+KPPzG5nvk/0eHop55oPIT1zQ3S4mCA0
         PC6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:27:26 +0200
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
	Russell King <linux@armlinux.org.uk>
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
Subject: [PATCH 02/15] ARM: pxa: add dma slave map
Date: Mon,  2 Apr 2018 16:26:43 +0200
Message-Id: <20180402142656.26815-3-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644914413609039?=
X-GMAIL-MSGID: =?utf-8?q?1596644914413609039?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In order to remove the specific knowledge of the dma mapping from PXA
drivers, add a default slave map for pxa architectures.

This is the first step, and once all drivers are converted,
pxad_filter_fn() will be made static, and the DMA resources removed from
device.c.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Reported-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/devices.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index d7c9a8476d57..da67ebe9a7d5 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -4,6 +4,8 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/pxa-dma.h>
+#include <linux/dmaengine.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/platform_data/i2c-pxa.h>
 
@@ -1202,9 +1204,62 @@ void __init pxa2xx_set_spi_info(unsigned id, struct pxa2xx_spi_master *info)
 	platform_device_add(pd);
 }
 
+#define PDMA_FILTER_PARAM(_prio, _requestor) (&(struct pxad_param) { \
+	.prio = PXAD_PRIO_##_prio, .drcmr = _requestor })
+
+static const struct dma_slave_map pxa_slave_map[] = {
+	/* PXA25x, PXA27x and PXA3xx common entries */
+	{ "pxa-pcm-audio", "ac97_mic_mono", PDMA_FILTER_PARAM(LOWEST, 8) },
+	{ "pxa-pcm-audio", "ac97_aux_mono_in", PDMA_FILTER_PARAM(LOWEST, 9) },
+	{ "pxa-pcm-audio", "ac97_aux_mono_out", PDMA_FILTER_PARAM(LOWEST, 10) },
+	{ "pxa-pcm-audio", "ac97_stereo_in", PDMA_FILTER_PARAM(LOWEST, 11) },
+	{ "pxa-pcm-audio", "ac97_stereo_out", PDMA_FILTER_PARAM(LOWEST, 12) },
+	{ "pxa-pcm-audio", "ssp1_rx", PDMA_FILTER_PARAM(LOWEST, 13) },
+	{ "pxa-pcm-audio", "ssp1_tx", PDMA_FILTER_PARAM(LOWEST, 14) },
+	{ "pxa-pcm-audio", "ssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
+	{ "pxa-pcm-audio", "ssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
+	{ "pxa2xx-ir", "rx", PDMA_FILTER_PARAM(LOWEST, 17) },
+	{ "pxa2xx-ir", "tx", PDMA_FILTER_PARAM(LOWEST, 18) },
+	{ "pxa2xx-mci.0", "rx", PDMA_FILTER_PARAM(LOWEST, 21) },
+	{ "pxa2xx-mci.0", "tx", PDMA_FILTER_PARAM(LOWEST, 22) },
+	{ "smc911x.0", "rx", PDMA_FILTER_PARAM(LOWEST, -1) },
+	{ "smc911x.0", "tx", PDMA_FILTER_PARAM(LOWEST, -1) },
+	{ "smc91x.0", "data", PDMA_FILTER_PARAM(LOWEST, -1) },
+
+	/* PXA25x specific map */
+	{ "pxa25x-ssp.0", "rx", PDMA_FILTER_PARAM(LOWEST, 13) },
+	{ "pxa25x-ssp.0", "tx", PDMA_FILTER_PARAM(LOWEST, 14) },
+	{ "pxa25x-nssp.1", "rx", PDMA_FILTER_PARAM(LOWEST, 15) },
+	{ "pxa25x-nssp.1", "tx", PDMA_FILTER_PARAM(LOWEST, 16) },
+	{ "pxa25x-nssp.2", "rx", PDMA_FILTER_PARAM(LOWEST, 23) },
+	{ "pxa25x-nssp.2", "tx", PDMA_FILTER_PARAM(LOWEST, 24) },
+	{ "pxa-pcm-audio", "nssp2_rx", PDMA_FILTER_PARAM(LOWEST, 15) },
+	{ "pxa-pcm-audio", "nssp2_tx", PDMA_FILTER_PARAM(LOWEST, 16) },
+	{ "pxa-pcm-audio", "nssp3_rx", PDMA_FILTER_PARAM(LOWEST, 23) },
+	{ "pxa-pcm-audio", "nssp3_tx", PDMA_FILTER_PARAM(LOWEST, 24) },
+
+	/* PXA27x specific map */
+	{ "pxa-pcm-audio", "ssp3_rx", PDMA_FILTER_PARAM(LOWEST, 66) },
+	{ "pxa-pcm-audio", "ssp3_tx", PDMA_FILTER_PARAM(LOWEST, 67) },
+	{ "pxa27x-camera.0", "CI_Y", PDMA_FILTER_PARAM(HIGHEST, 68) },
+	{ "pxa27x-camera.0", "CI_U", PDMA_FILTER_PARAM(HIGHEST, 69) },
+	{ "pxa27x-camera.0", "CI_V", PDMA_FILTER_PARAM(HIGHEST, 70) },
+
+	/* PXA3xx specific map */
+	{ "pxa-pcm-audio", "ssp4_rx", PDMA_FILTER_PARAM(LOWEST, 2) },
+	{ "pxa-pcm-audio", "ssp4_tx", PDMA_FILTER_PARAM(LOWEST, 3) },
+	{ "pxa2xx-mci.1", "rx", PDMA_FILTER_PARAM(LOWEST, 93) },
+	{ "pxa2xx-mci.1", "tx", PDMA_FILTER_PARAM(LOWEST, 94) },
+	{ "pxa3xx-nand", "data", PDMA_FILTER_PARAM(LOWEST, 97) },
+	{ "pxa2xx-mci.2", "rx", PDMA_FILTER_PARAM(LOWEST, 100) },
+	{ "pxa2xx-mci.2", "tx", PDMA_FILTER_PARAM(LOWEST, 101) },
+};
+
 static struct mmp_dma_platdata pxa_dma_pdata = {
 	.dma_channels	= 0,
 	.nb_requestors	= 0,
+	.slave_map	= pxa_slave_map,
+	.slave_map_cnt	= ARRAY_SIZE(pxa_slave_map),
 };
 
 static struct resource pxa_dma_resource[] = {
-- 
2.11.0
