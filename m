Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20DC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECED12085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHlsvukW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECED12085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJIBWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:22:32 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46465 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:22:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id a2-v6so14744485wrc.13;
        Mon, 08 Oct 2018 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OcLCvmhgchBtGngq48CS0t1W3+/RSNtaxzKVH1MraY8=;
        b=iHlsvukW9SyF6Dz7gShayitB/lDo7HUji3VtFl/Hp5eyu6CmN+4CK+Y4FHfEMEjHcm
         0TTz6e8akNoWYpxURfxUpJ/nIa9aGhbgy4qSIf2q9LNNZ/ktKx5DKcY6VkNL6JeQD6Zn
         DimXXWlMQKglMEkSC1QJ/8g9UsmUB6PNN26B4BGfLaHaP/4zpQqp/8nYGYOKAlJFB6Y6
         No8KH+aJriAIQtBmRsditCBnilJIV7OjzGEk4Zb6OX4EqGG4ttZ9y3yBK28rmAGTe3pv
         i6zQOLMHkE4QYJbELD6BmdE2gE7zy5WeHL2E087IdWCIbrj1UQt4upUnSvVHnnClDE8n
         9SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OcLCvmhgchBtGngq48CS0t1W3+/RSNtaxzKVH1MraY8=;
        b=mxLWhMg2U06IFiRBHOuUWkpZ8U5fxz2TXbLooKrHF4hGREudzYrbEHn5TfqF0FAa0+
         wS73xZA6Ka8+LFE2fZmaUU7yoY7IJoicAlT63g78DQ82r3vpnUgoeTSmcaqpKEzwbXqS
         +GnHgSKPsTgkatNiq7bzBNXyCuGy3oeMMpvMaP5vOsIprF5nqWlmvt0yIkNUmnL0MaWd
         GdW1y/OL5Zt+LEzf7O1A9II5W69lrlul1433qxS7kFLQKA3j3AELQWpo30aGebZFsRur
         W+YdY9ZJKcjOiBlYlI3UGG5boegtwRvxVvSdtEDGqfgVBeUMFG6xUnnjCvc8nmBEil4C
         U7+g==
X-Gm-Message-State: ABuFfohYPptpf+o1RIM3KMZjWXk0admce2myHSXhTQiepObmFJmhDoZ0
        2IcttjEJbD/sHF6PJo2A7Mw=
X-Google-Smtp-Source: ACcGV60vcMPXu+4DOuBwyGpy4gbrQRf85OYEFByaQis6sCQuirwQN2b9yi81UHqg6/RF40w5bbx83Q==
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr17174618wrw.226.1539022173100;
        Mon, 08 Oct 2018 11:09:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id z69-v6sm10321240wmz.18.2018.10.08.11.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 11:09:32 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v4] spi: spi-ep93xx: Use dma_data_direction for ep93xx_spi_dma_{finish,prepare}
Date:   Mon,  8 Oct 2018 11:08:47 -0700
Message-Id: <20181008180846.14119-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005192508.18659-1-natechancellor@gmail.com>
References: <20181005192508.18659-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another.

drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:428:58: note: expanded from macro
'dma_map_sg'
#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
                               ~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
                dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
enumeration type 'enum dma_transfer_direction' to different enumeration
type 'enum dma_data_direction' [-Wenum-conversion]
        dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
./include/linux/dma-mapping.h:429:62: note: expanded from macro
'dma_unmap_sg'
#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
                                 ~~~~~~~~~~~~~~~~~~          ^
3 warnings generated.

dma_{,un}map_sg expect an enum of type dma_data_direction but this
driver uses dma_transfer_direction for everything. Convert the driver to
use dma_data_direction for these two functions.

There are two places that strictly require an enum of type
dma_transfer_direction: the direction member in struct dma_slave_config
and the direction parameter in dmaengine_prep_slave_sg. To avoid using
an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
to safely map between the two types because they are not 1 to 1 in
meaning.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix escaped hash symbols for '#define' lines (\# -> #).

v2 -> v3:

* Instead of changing the dir parameter in the prepare and finish
  functions, convert the driver to use dma_data_direction for everywhere
  that makes sense, thanks to review from Mika. Add a helper function to
  convert between the two types as there is still a couple of locations
  that need a transfer enum (and no such function exists).

v3 -> v4:

* Use 'conf.direction' in dmaengine_prep_slave_sg instead of the new
  function since the value was already set earlier in the function and
  never changed, thanks to review from Nick.

 drivers/spi/spi-ep93xx.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index f1526757aaf6..79fc3940245a 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -246,6 +246,19 @@ static int ep93xx_spi_read_write(struct spi_master *master)
 	return -EINPROGRESS;
 }
 
+static enum dma_transfer_direction
+ep93xx_dma_data_to_trans_dir(enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		return DMA_MEM_TO_DEV;
+	case DMA_FROM_DEVICE:
+		return DMA_DEV_TO_MEM;
+	default:
+		return DMA_TRANS_NONE;
+	}
+}
+
 /**
  * ep93xx_spi_dma_prepare() - prepares a DMA transfer
  * @master: SPI master
@@ -257,7 +270,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
  */
 static struct dma_async_tx_descriptor *
 ep93xx_spi_dma_prepare(struct spi_master *master,
-		       enum dma_transfer_direction dir)
+		       enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct spi_transfer *xfer = master->cur_msg->state;
@@ -277,9 +290,9 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 		buswidth = DMA_SLAVE_BUSWIDTH_1_BYTE;
 
 	memset(&conf, 0, sizeof(conf));
-	conf.direction = dir;
+	conf.direction = ep93xx_dma_data_to_trans_dir(dir);
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		buf = xfer->rx_buf;
 		sgt = &espi->rx_sgt;
@@ -343,7 +356,8 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
 	if (!nents)
 		return ERR_PTR(-ENOMEM);
 
-	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, dir, DMA_CTRL_ACK);
+	txd = dmaengine_prep_slave_sg(chan, sgt->sgl, nents, conf.direction,
+				      DMA_CTRL_ACK);
 	if (!txd) {
 		dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
 		return ERR_PTR(-ENOMEM);
@@ -360,13 +374,13 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
  * unmapped.
  */
 static void ep93xx_spi_dma_finish(struct spi_master *master,
-				  enum dma_transfer_direction dir)
+				  enum dma_data_direction dir)
 {
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_chan *chan;
 	struct sg_table *sgt;
 
-	if (dir == DMA_DEV_TO_MEM) {
+	if (dir == DMA_FROM_DEVICE) {
 		chan = espi->dma_rx;
 		sgt = &espi->rx_sgt;
 	} else {
@@ -381,8 +395,8 @@ static void ep93xx_spi_dma_callback(void *callback_param)
 {
 	struct spi_master *master = callback_param;
 
-	ep93xx_spi_dma_finish(master, DMA_MEM_TO_DEV);
-	ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+	ep93xx_spi_dma_finish(master, DMA_TO_DEVICE);
+	ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 
 	spi_finalize_current_transfer(master);
 }
@@ -392,15 +406,15 @@ static int ep93xx_spi_dma_transfer(struct spi_master *master)
 	struct ep93xx_spi *espi = spi_master_get_devdata(master);
 	struct dma_async_tx_descriptor *rxd, *txd;
 
-	rxd = ep93xx_spi_dma_prepare(master, DMA_DEV_TO_MEM);
+	rxd = ep93xx_spi_dma_prepare(master, DMA_FROM_DEVICE);
 	if (IS_ERR(rxd)) {
 		dev_err(&master->dev, "DMA RX failed: %ld\n", PTR_ERR(rxd));
 		return PTR_ERR(rxd);
 	}
 
-	txd = ep93xx_spi_dma_prepare(master, DMA_MEM_TO_DEV);
+	txd = ep93xx_spi_dma_prepare(master, DMA_TO_DEVICE);
 	if (IS_ERR(txd)) {
-		ep93xx_spi_dma_finish(master, DMA_DEV_TO_MEM);
+		ep93xx_spi_dma_finish(master, DMA_FROM_DEVICE);
 		dev_err(&master->dev, "DMA TX failed: %ld\n", PTR_ERR(txd));
 		return PTR_ERR(txd);
 	}
-- 
2.19.0

