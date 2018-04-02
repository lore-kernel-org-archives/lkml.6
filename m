Return-Path: <robert.jarzmik@free.fr>
X-Google-Smtp-Source: AIpwx4/p9M4nZU/53mvGumssI9jiXJp3h3dTXQo3R+OYrpkoh9nDKqxIzMmkGtCoRa3e2NOx7DQM
ARC-Seal: i=1; a=rsa-sha256; t=1522679308; cv=none;
        d=google.com; s=arc-20160816;
        b=naPYlVxS89I8yW/aAkPm4j0daM4f0ROafQpdL9CjB0ZciUI9iVqE/TCqaTwYvZ/Bnd
         +vqtKDKfqoNJjxGYXhWgEg4AuC7/1iT/cViWbBIKsU8nwYpzXxSGJumWTmeHlFkewgns
         PWGa6yQEnyjFgJXaJDxxRImgF3hs4DyaS6qvteW87z48OOcOnlv5M4HWBncXAUmlB1if
         cEZ5FEsmfyreNs6sY5271r1or1ojydv7iI59mvMosPaNPGHO2D4JzCkjB0UcirZD2aM/
         YFNah49iibs92euAEXeglYN3wlui/k5Q7FMkQiDaNdOwusKEkMKaxKpA0XF0rhTOoNFh
         wPxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=5C8d3XEVPJw3oAhSe02klOFH8TjrqrBV3cvYNbztPXM=;
        b=lNRYxJ1c8p30ORNDnyI6nFdsGIxPY78IdRksmXPYsqOO30oGL/I4htnnXwDBDWNKE9
         UH9nlCQZjWO+0k29rTAnWUGKeQqTo6mpgqPt7oFudwHJ0HOeFh5QdaCBcxjZufRuo6rJ
         xMKyw3UyWPWBDsAGSeJd0Myh04pjNLk+qMQPDRI+zooBwPtuHkwCJ7XEzqBZJK0+k8/Y
         Ba69aMVU3au15/CSTjC/QZI+cUlz4F97Lgu4Fc6fPtVgtMOHW1UHWrBGTFGD3QKMwLJ6
         p7DJSeY2berg/yuiB+k2zgI1E2RBGMJinjmOA+9TAUduETbfPnAHEjsXvDVYS9yCpUME
         OShQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 80.12.242.128 is neither permitted nor denied by best guess record for domain of robert.jarzmik@free.fr) smtp.mailfrom=robert.jarzmik@free.fr
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 02 Apr 2018 16:28:27 +0200
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
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
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
Subject: [PATCH 12/15] dmaengine: pxa: make the filter function internal
Date: Mon,  2 Apr 2018 16:26:53 +0200
Message-Id: <20180402142656.26815-13-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180402142656.26815-1-robert.jarzmik@free.fr>
References: <20180402142656.26815-1-robert.jarzmik@free.fr>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596644978542535550?=
X-GMAIL-MSGID: =?utf-8?q?1596644978542535550?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

As the pxa architecture and all its related drivers do not rely anymore
on the filter function, thanks to the slave map conversion, make
pxad_filter_fn() static, and remove it from the global namespace.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c       |  5 ++---
 include/linux/dma/pxa-dma.h | 11 -----------
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 9505334f9c6e..a332ad1d7dfb 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -179,7 +179,7 @@ static unsigned int pxad_drcmr(unsigned int line)
 	return 0x1000 + line * 4;
 }
 
-bool pxad_filter_fn(struct dma_chan *chan, void *param);
+static bool pxad_filter_fn(struct dma_chan *chan, void *param);
 
 /*
  * Debug fs
@@ -1496,7 +1496,7 @@ static struct platform_driver pxad_driver = {
 	.remove		= pxad_remove,
 };
 
-bool pxad_filter_fn(struct dma_chan *chan, void *param)
+static bool pxad_filter_fn(struct dma_chan *chan, void *param)
 {
 	struct pxad_chan *c = to_pxad_chan(chan);
 	struct pxad_param *p = param;
@@ -1509,7 +1509,6 @@ bool pxad_filter_fn(struct dma_chan *chan, void *param)
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(pxad_filter_fn);
 
 module_platform_driver(pxad_driver);
 
diff --git a/include/linux/dma/pxa-dma.h b/include/linux/dma/pxa-dma.h
index 9fc594f69eff..fceb5df07097 100644
--- a/include/linux/dma/pxa-dma.h
+++ b/include/linux/dma/pxa-dma.h
@@ -23,15 +23,4 @@ struct pxad_param {
 	enum pxad_chan_prio prio;
 };
 
-struct dma_chan;
-
-#ifdef CONFIG_PXA_DMA
-bool pxad_filter_fn(struct dma_chan *chan, void *param);
-#else
-static inline bool pxad_filter_fn(struct dma_chan *chan, void *param)
-{
-	return false;
-}
-#endif
-
 #endif /* _PXA_DMA_H_ */
-- 
2.11.0
