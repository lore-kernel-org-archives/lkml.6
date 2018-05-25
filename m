Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968168AbeEYT5p (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:57:45 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:21937 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967859AbeEYT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:57:43 -0400
X-ME-Helo: belgarion.home
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Fri, 25 May 2018 21:57:42 +0200
X-ME-IP: 90.55.202.35
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Vinod Koul <vinod.koul@intel.com>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dmaengine: pxa: add a default requestor policy
Date: Fri, 25 May 2018 21:56:47 +0200
Message-Id: <20180525195647.30968-1-robert.jarzmik@free.fr>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As what former drcmr -1 value meant, add a this as a default to each
channel, ie. that by default no requestor line is used.

This is specifically used for network drivers smc91x and smc911x, and
needed for their port to slave maps.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/dma/pxa_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index 9505334f9c6e..4edc8f927641 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
 	dma_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
 
+	chan->drcmr = (u32)-1;
+	chan->prio = PXAD_PRIO_LOWEST;
 }
 
 static void pxad_free_desc(struct virt_dma_desc *vd)
@@ -1386,6 +1388,8 @@ static int pxad_init_dmadev(struct platform_device *op,
 		c = devm_kzalloc(&op->dev, sizeof(*c), GFP_KERNEL);
 		if (!c)
 			return -ENOMEM;
+		c->drcmr = (u32)-1;
+		c->prio = PXAD_PRIO_LOWEST;
 		c->vc.desc_free = pxad_free_desc;
 		vchan_init(&c->vc, &pdev->slave);
 		init_waitqueue_head(&c->wq_state);
-- 
2.11.0
