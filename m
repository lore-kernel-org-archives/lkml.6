Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E3BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90FA120672
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xx+hsh6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90FA120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeKZSqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41002 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeKZSqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:50 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rV4s043548;
        Mon, 26 Nov 2018 01:53:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218811;
        bh=1dl5WEIh4iUs6D5X2DHWt3fI5pURc1Vm6uPh8ctE+44=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Xx+hsh6GjXci6Sr84n+/7yowT3JhcopdMvAHVnSW3lxikphjdY9HyCVyIr+l2g9s+
         9og1BqA82Iu88CGfxi0MqtdQUTXtHwkS6a3A8Wd022HotFRMuULag5PbteCAQC0wbd
         tjv5IJy8Z3+D11r9DfyjtukGRtuYNA+J07HH5B+0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rVHv083954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:31 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:30 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:31 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rUlb009133;
        Mon, 26 Nov 2018 01:53:30 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1N024490;
        Mon, 26 Nov 2018 01:53:27 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 09/16] remoteproc/pru: add APIs to get and put the PRU cores
Date:   Mon, 26 Nov 2018 09:52:42 +0200
Message-ID: <1543218769-5507-10-git-send-email-rogerq@ti.com>
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

From: Tero Kristo <t-kristo@ti.com>

Add two new APIs, pru_rproc_get() and pru_rproc_put(), to the PRU
driver to allow client drivers to acquire and release the remoteproc
device associated with a PRU core. The PRU cores are treated as
resources with only one client owning it at a time.

The pru_rproc_get() function returns the rproc handle corresponding
to a PRU core identified by the device tree "prus" property under
the client node. The pru_rproc_put() is the complementary function
to pru_rproc_get().

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: improve error checking, various fixes and cleanups]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 112 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pruss.h          |   9 ++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index fa3559b..2aa05b0 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -57,6 +57,7 @@ enum pru_mem {
  * @id: id of the PRU core within the PRUSS
  * @pruss: back-reference to parent PRUSS structure
  * @rproc: remoteproc pointer for this PRU core
+ * @client_np: client device node
  * @mbox: mailbox channel handle used for vring signalling with MPU
  * @client: mailbox client to request the mailbox channel
  * @irq_ring: IRQ number to use for processing vring buffers
@@ -71,6 +72,7 @@ enum pru_mem {
  * @sdram_da: device address of secondary Data RAM for this PRU
  * @shrdram_da: device address of shared Data RAM
  * @fw_name: name of firmware image used during loading
+ * @lock: mutex to protect client usage
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
  */
@@ -78,6 +80,7 @@ struct pru_rproc {
 	int id;
 	struct pruss *pruss;
 	struct rproc *rproc;
+	struct device_node *client_np;
 	struct mbox_chan *mbox;
 	struct mbox_client client;
 	int irq_vring;
@@ -92,6 +95,7 @@ struct pru_rproc {
 	u32 sdram_da;
 	u32 shrdram_da;
 	const char *fw_name;
+	struct mutex lock; /* client access lock */
 	u32 dbg_single_step;
 	u32 dbg_continuous;
 };
@@ -126,6 +130,113 @@ void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
 	spin_unlock_irqrestore(&pru->rmw_lock, flags);
 }
 
+static struct rproc *__pru_rproc_get(struct device_node *np, int index)
+{
+	struct device_node *rproc_np = NULL;
+	struct platform_device *pdev;
+	struct rproc *rproc;
+
+	rproc_np = of_parse_phandle(np, "prus", index);
+	if (!rproc_np || !of_device_is_available(rproc_np))
+		return ERR_PTR(-ENODEV);
+
+	pdev = of_find_device_by_node(rproc_np);
+	of_node_put(rproc_np);
+
+	if (!pdev)
+		/* probably PRU not yet probed */
+		return ERR_PTR(-EPROBE_DEFER);
+
+	/* TODO: replace the crude string based check to make sure it is PRU */
+	if (!strstr(dev_name(&pdev->dev), "pru")) {
+		put_device(&pdev->dev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	rproc = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
+	if (!rproc)
+		return ERR_PTR(-EPROBE_DEFER);
+
+	get_device(&rproc->dev);
+
+	return rproc;
+}
+
+/**
+ * pru_rproc_get() - get the PRU rproc instance from a device node
+ * @np: the user/client device node
+ * @index: index to use for the prus property
+ *
+ * This function looks through a client device node's "prus" property at index
+ * @index and returns the rproc handle for a valid PRU remote processor if
+ * found. The function allows only one user to own the PRU rproc resource at
+ * a time. Caller must call pru_rproc_put() when done with using the rproc,
+ * not required if the function returns a failure.
+ *
+ * Returns the rproc handle on success, and an ERR_PTR on failure using one
+ * of the following error values
+ *    -ENODEV if device is not found
+ *    -EBUSY if PRU is already acquired by anyone
+ *    -EPROBE_DEFER is PRU device is not probed yet
+ */
+struct rproc *pru_rproc_get(struct device_node *np, int index)
+{
+	struct rproc *rproc;
+	struct pru_rproc *pru;
+
+	rproc = __pru_rproc_get(np, index);
+	if (IS_ERR(rproc))
+		return rproc;
+
+	pru = rproc->priv;
+
+	mutex_lock(&pru->lock);
+
+	if (pru->client_np) {
+		mutex_unlock(&pru->lock);
+		put_device(&rproc->dev);
+		return ERR_PTR(-EBUSY);
+	}
+
+	pru->client_np = np;
+
+	mutex_unlock(&pru->lock);
+
+	return rproc;
+}
+EXPORT_SYMBOL_GPL(pru_rproc_get);
+
+/**
+ * pru_rproc_put() - release the PRU rproc resource
+ * @rproc: the rproc resource to release
+ *
+ * Releases the PRU rproc resource and makes it available to other
+ * users.
+ */
+void pru_rproc_put(struct rproc *rproc)
+{
+	struct pru_rproc *pru;
+
+	if (IS_ERR_OR_NULL(rproc))
+		return;
+
+	/* TODO: replace the crude string based check to make sure it is PRU */
+	if (!strstr(dev_name(rproc->dev.parent), "pru"))
+		return;
+
+	pru = rproc->priv;
+	if (!pru->client_np)
+		return;
+
+	mutex_lock(&pru->lock);
+	pru->client_np = NULL;
+	mutex_unlock(&pru->lock);
+
+	put_device(&rproc->dev);
+}
+EXPORT_SYMBOL_GPL(pru_rproc_put);
+
 /**
  * pru_rproc_set_ctable() - set the constant table index for the PRU
  * @rproc: the rproc instance of the PRU
@@ -588,6 +699,7 @@ static int pru_rproc_probe(struct platform_device *pdev)
 	pru->rproc = rproc;
 	pru->fw_name = fw_name;
 	spin_lock_init(&pru->rmw_lock);
+	mutex_init(&pru->lock);
 
 	ret = pruss_request_mem_region(pru->pruss, PRUSS_MEM_DRAM0,
 				       &pru->dram0);
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index af04a1c..405039a 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -249,10 +249,19 @@ int pruss_intc_unconfigure(struct pruss *pruss,
 
 #if IS_ENABLED(CONFIG_PRUSS_REMOTEPROC)
 
+struct rproc *pru_rproc_get(struct device_node *node, int index);
+void pru_rproc_put(struct rproc *rproc);
 int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
 
 #else
 
+static inline struct rproc *pru_rproc_get(struct device_node *node, int index)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+static inline void pru_rproc_put(struct rproc *rproc) { }
+
 static inline int pru_rproc_set_ctable(struct rproc *rproc,
 				       enum pru_ctable_idx c, u32 addr)
 {
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

