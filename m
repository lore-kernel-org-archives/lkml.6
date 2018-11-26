Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B901C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C37520663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="woKj9aDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C37520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeKZSqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40974 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeKZSqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:43 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rNf7043501;
        Mon, 26 Nov 2018 01:53:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218803;
        bh=K+9OIo+WoGSA6CXrJCWmEtG9/Mc7G+cne17UP/YTkdw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=woKj9aDodaw3zQMssEqwS1YEVKBAbpyDGu8K5xim5POS7AMg0wSfIpon8hMAV9QtP
         vVWOWVy3/butnIvxCh6yLX9HWtqDQJgsCWRNMLhJA5nCpJOBdzCFodiPuSC84hoyH5
         waQNNZoadvccPjkrt6QWdQLzfHLb2tgzfxI6Isko=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rNFQ059580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:23 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:22 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:22 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rMoP019905;
        Mon, 26 Nov 2018 01:53:22 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1L024490;
        Mon, 26 Nov 2018 01:53:19 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 07/16] remoteproc/pru: Add support for virtio rpmsg stack
Date:   Mon, 26 Nov 2018 09:52:40 +0200
Message-ID: <1543218769-5507-8-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543218769-5507-1-git-send-email-rogerq@ti.com>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The PRU remoteproc driver has been enhanced to support the optional
rpmsg stack using the virtio-ring based communication transport
between MPU and a PRU core. This provides support to any firmware
images supporting the virtio devices.

The virtio-ring signalling support is provided either through a OMAP
mailbox or through two PRU system events on OMAP-architecture based
SoCs - one event used in each direction for kicking from one processor
and receiving notification on the other processor. The virtio rpmsg
signalling is enabled only using using PRU system events for interrupts
on the Keystone-architecture based 66AK2G SoCs (it is possible to
implement using an alternate Keystone specific IPCGR registers as well).
The driver supports both signalling options, though the PRU events based
signalling is the recommended option as it avoids an external peripheral
access from the PRU side. It also provides a uniform solution across
both the OMAP, Keystone and Davinci architectures. The PRU events based
signalling takes precedence if both options are mentioned. Either of the
options would require the corresponding firmware support though. A build
dependency against MAILBOX is also added. Note that the OMAP Mailbox
IP is not present on 66AK2G and Davinci SoCs, so it is only selected
for OMAP-based SoCs.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/Kconfig     |   2 +
 drivers/remoteproc/pru_rproc.c | 169 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 333666e..b89acb0 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -200,6 +200,8 @@ config ST_SLIM_REMOTEPROC
 config PRUSS_REMOTEPROC
 	tristate "TI PRUSS remoteproc support"
 	depends on TI_PRUSS
+	select MAILBOX
+	select OMAP2PLUS_MBOX if ARCH_OMAP2PLUS
 	default n
 	help
 	  Support for TI PRU-ICSS remote processors via the remote processor
diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 73a7f13..e0554b3 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -10,6 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/debugfs.h>
 #include <linux/interrupt.h>
+#include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/remoteproc.h>
@@ -56,6 +57,10 @@ enum pru_mem {
  * @id: id of the PRU core within the PRUSS
  * @pruss: back-reference to parent PRUSS structure
  * @rproc: remoteproc pointer for this PRU core
+ * @mbox: mailbox channel handle used for vring signalling with MPU
+ * @client: mailbox client to request the mailbox channel
+ * @irq_ring: IRQ number to use for processing vring buffers
+ * @irq_kick: IRQ number to use to perform virtio kick
  * @mem_regions: data for each of the PRU memory regions
  * @dram0: PRUSS DRAM0 region
  * @dram1: PRUSS DRAM1 region
@@ -72,6 +77,10 @@ struct pru_rproc {
 	int id;
 	struct pruss *pruss;
 	struct rproc *rproc;
+	struct mbox_chan *mbox;
+	struct mbox_client client;
+	int irq_vring;
+	int irq_kick;
 	struct pruss_mem_region mem_regions[PRU_MEM_MAX];
 	struct pruss_mem_region dram0;
 	struct pruss_mem_region dram1;
@@ -233,22 +242,124 @@ static void pru_rproc_create_debug_entries(struct rproc *rproc)
 			    rproc, &pru_rproc_debug_ss_fops);
 }
 
+/**
+ * pru_rproc_mbox_callback() - inbound mailbox message handler
+ * @client: mailbox client pointer used for requesting the mailbox channel
+ * @data: mailbox payload
+ *
+ * This handler is invoked by omap's mailbox driver whenever a mailbox
+ * message is received. Usually, the mailbox payload simply contains
+ * the index of the virtqueue that is kicked by the PRU remote processor,
+ * and we let remoteproc core handle it.
+ *
+ * In addition to virtqueue indices, we might also have some out-of-band
+ * values that indicates different events. Those values are deliberately
+ * very big so they don't coincide with virtqueue indices.
+ */
+static void pru_rproc_mbox_callback(struct mbox_client *client, void *data)
+{
+	struct pru_rproc *pru = container_of(client, struct pru_rproc, client);
+	struct device *dev = &pru->rproc->dev;
+	u32 msg = (u32)data;
+
+	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
+
+	/* msg contains the index of the triggered vring */
+	if (rproc_vq_interrupt(pru->rproc, msg) == IRQ_NONE)
+		dev_dbg(dev, "no message was found in vqid %d\n", msg);
+}
+
+/**
+ * pru_rproc_vring_interrupt() - interrupt handler for processing vrings
+ * @irq: irq number associated with the PRU event MPU is listening on
+ * @data: interrupt handler data, will be a PRU rproc structure
+ *
+ * This handler is used by the PRU remoteproc driver when using PRU system
+ * events for processing the virtqueues. Unlike the mailbox IP, there is
+ * no payload associated with an interrupt, so either a unique event is
+ * used for each virtqueue kick, or a both virtqueues are processed on
+ * a single event. The latter is chosen to conserve the usable PRU system
+ * events.
+ */
+static irqreturn_t pru_rproc_vring_interrupt(int irq, void *data)
+{
+	struct pru_rproc *pru = data;
+
+	dev_dbg(&pru->rproc->dev, "got vring irq\n");
+
+	/* process incoming buffers on both the Rx and Tx vrings */
+	rproc_vq_interrupt(pru->rproc, 0);
+	rproc_vq_interrupt(pru->rproc, 1);
+
+	return IRQ_HANDLED;
+}
+
+/* kick a virtqueue */
+static void pru_rproc_kick(struct rproc *rproc, int vq_id)
+{
+	struct device *dev = &rproc->dev;
+	struct pru_rproc *pru = rproc->priv;
+	int ret;
+
+	dev_dbg(dev, "kicking vqid %d on PRU%d\n", vq_id, pru->id);
+
+	if (pru->irq_kick > 0) {
+		ret = pruss_intc_trigger(pru->irq_kick);
+		if (ret < 0)
+			dev_err(dev, "pruss_intc_trigger failed: %d\n", ret);
+	} else if (pru->mbox) {
+		/*
+		 * send the index of the triggered virtqueue in the mailbox
+		 * payload
+		 */
+		ret = mbox_send_message(pru->mbox, (void *)vq_id);
+		if (ret < 0)
+			dev_err(dev, "mbox_send_message failed: %d\n", ret);
+	}
+}
+
 /* start a PRU core */
 static int pru_rproc_start(struct rproc *rproc)
 {
 	struct device *dev = &rproc->dev;
 	struct pru_rproc *pru = rproc->priv;
 	u32 val;
+	int ret;
 
 	dev_dbg(dev, "starting PRU%d: entry-point = 0x%x\n",
 		pru->id, (rproc->bootaddr >> 2));
 
+	/* TODO: INTC setup */
+
+	if (!list_empty(&pru->rproc->rvdevs)) {
+		if (!pru->mbox && (pru->irq_vring <= 0 || pru->irq_kick <= 0)) {
+			dev_err(dev, "virtio vring interrupt mechanisms are not provided\n");
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		if (!pru->mbox && pru->irq_vring > 0) {
+			ret = request_threaded_irq(pru->irq_vring, NULL,
+						   pru_rproc_vring_interrupt,
+						   IRQF_ONESHOT, dev_name(dev),
+						   pru);
+			if (ret) {
+				dev_err(dev, "failed to enable vring interrupt, ret = %d\n",
+					ret);
+				goto fail;
+			}
+		}
+	}
+
 	val = CTRL_CTRL_EN | ((rproc->bootaddr >> 2) << 16);
 	pru_control_write_reg(pru, PRU_CTRL_CTRL, val);
 
-	/* TODO: INTC setup */
-
 	return 0;
+
+fail:
+	/* TODO: INTC cleanup */
+
+	return ret;
 }
 
 /* stop/disable a PRU core */
@@ -264,6 +375,10 @@ static int pru_rproc_stop(struct rproc *rproc)
 	val &= ~CTRL_CTRL_EN;
 	pru_control_write_reg(pru, PRU_CTRL_CTRL, val);
 
+	if (!list_empty(&pru->rproc->rvdevs) &&
+	    !pru->mbox && pru->irq_vring > 0)
+		free_irq(pru->irq_vring, pru);
+
 	/* TODO: INTC cleanup */
 
 	return 0;
@@ -356,6 +471,7 @@ static void *pru_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 static struct rproc_ops pru_rproc_ops = {
 	.start			= pru_rproc_start,
 	.stop			= pru_rproc_stop,
+	.kick			= pru_rproc_kick,
 	.da_to_va		= pru_da_to_va,
 };
 
@@ -383,6 +499,7 @@ static int pru_rproc_probe(struct platform_device *pdev)
 	struct pru_rproc *pru;
 	const char *fw_name;
 	struct rproc *rproc = NULL;
+	struct mbox_client *client;
 	struct resource *res;
 	int i, ret;
 	const char *mem_names[PRU_MEM_MAX] = { "iram", "control", "debug" };
@@ -475,10 +592,51 @@ static int pru_rproc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rproc);
 
+	/* get optional vring and kick interrupts for supporting virtio rpmsg */
+	pru->irq_vring = platform_get_irq_byname(pdev, "vring");
+	if (pru->irq_vring <= 0) {
+		ret = pru->irq_vring;
+		if (ret == -EPROBE_DEFER)
+			goto free_rproc;
+		dev_dbg(dev, "unable to get vring interrupt, status = %d\n",
+			ret);
+	}
+
+	pru->irq_kick = platform_get_irq_byname(pdev, "kick");
+	if (pru->irq_kick <= 0) {
+		ret = pru->irq_kick;
+		if (ret == -EPROBE_DEFER)
+			goto free_rproc;
+		dev_dbg(dev, "unable to get kick interrupt, status = %d\n",
+			ret);
+	}
+
+	/*
+	 * get optional mailbox for virtio rpmsg signalling if vring and kick
+	 * interrupts are not specified for OMAP architecture based SoCs
+	 */
+	if (pru->irq_vring <= 0 && pru->irq_kick <= 0 &&
+	    !of_device_is_compatible(np, "ti,k2g-pru") &&
+	    !of_device_is_compatible(np, "ti,da850-pru")) {
+		client = &pru->client;
+		client->dev = dev;
+		client->tx_done = NULL;
+		client->rx_callback = pru_rproc_mbox_callback;
+		client->tx_block = false;
+		client->knows_txdone = false;
+		pru->mbox = mbox_request_channel(client, 0);
+		if (IS_ERR(pru->mbox)) {
+			ret = PTR_ERR(pru->mbox);
+			pru->mbox = NULL;
+			dev_dbg(dev, "unable to get mailbox channel, status = %d\n",
+				ret);
+		}
+	}
+
 	ret = rproc_add(pru->rproc);
 	if (ret) {
 		dev_err(dev, "rproc_add failed: %d\n", ret);
-		goto free_rproc;
+		goto put_mbox;
 	}
 
 	pru_rproc_create_debug_entries(rproc);
@@ -487,6 +645,8 @@ static int pru_rproc_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_mbox:
+	mbox_free_channel(pru->mbox);
 free_rproc:
 	rproc_free(rproc);
 	return ret;
@@ -496,9 +656,12 @@ static int pru_rproc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rproc *rproc = platform_get_drvdata(pdev);
+	struct pru_rproc *pru = rproc->priv;
 
 	dev_info(dev, "%s: removing rproc %s\n", __func__, rproc->name);
 
+	mbox_free_channel(pru->mbox);
+
 	rproc_del(rproc);
 	rproc_free(rproc);
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

