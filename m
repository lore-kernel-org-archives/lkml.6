Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2C8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4060B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4060B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeKZSrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:47:15 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36600 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKZSrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:47:14 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rtaN102596;
        Mon, 26 Nov 2018 01:53:55 -0600
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rt8F038728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:55 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:55 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:55 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rtmx009392;
        Mon, 26 Nov 2018 01:53:55 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1T024490;
        Mon, 26 Nov 2018 01:53:51 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 15/16] remoteproc/pru: add support for parsing pru interrupt mapping from DT
Date:   Mon, 26 Nov 2018 09:52:48 +0200
Message-ID: <1543218769-5507-16-git-send-email-rogerq@ti.com>
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

PRU interrupt mapping can now be parsed from devicetree also, from
ti,pru-interrupt-map property. This is an alternative configuration
method in addition to the legacy resource table config. If both are
provided, the config in DT takes precedence.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: various fixes and cleanups]
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 109 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 106 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 84f006b..540cce3 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -63,6 +63,7 @@ enum pru_mem {
  * @irq_ring: IRQ number to use for processing vring buffers
  * @irq_kick: IRQ number to use to perform virtio kick
  * @mem_regions: data for each of the PRU memory regions
+ * @intc_config: PRU INTC configuration data
  * @dram0: PRUSS DRAM0 region
  * @dram1: PRUSS DRAM1 region
  * @shrdram: PRUSS SHARED RAM region
@@ -73,6 +74,7 @@ enum pru_mem {
  * @shrdram_da: device address of shared Data RAM
  * @fw_name: name of firmware image used during loading
  * @gpmux_save: saved value for gpmux config
+ * @dt_irqs: number of irqs configured from DT
  * @lock: mutex to protect client usage
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
@@ -87,6 +89,7 @@ struct pru_rproc {
 	int irq_vring;
 	int irq_kick;
 	struct pruss_mem_region mem_regions[PRU_MEM_MAX];
+	struct pruss_intc_config intc_config;
 	struct pruss_mem_region dram0;
 	struct pruss_mem_region dram1;
 	struct pruss_mem_region shrdram;
@@ -97,6 +100,7 @@ struct pru_rproc {
 	u32 shrdram_da;
 	const char *fw_name;
 	u8 gpmux_save;
+	int dt_irqs;
 	struct mutex lock; /* client access lock */
 	u32 dbg_single_step;
 	u32 dbg_continuous;
@@ -180,6 +184,87 @@ static struct rproc *__pru_rproc_get(struct device_node *np, int index)
 	return rproc;
 }
 
+static int pru_get_intc_dt_config(struct device *dev, const char *propname,
+				  int index,
+				  struct pruss_intc_config *intc_config)
+{
+	struct device_node *np = dev->of_node;
+	struct property *prop;
+	int ret = 0, entries, i;
+	int dt_irqs = 0;
+	u32 *arr;
+	int max_system_events, max_pru_channels, max_pru_host_ints;
+
+	max_system_events = MAX_PRU_SYS_EVENTS;
+	max_pru_channels = MAX_PRU_CHANNELS;
+	max_pru_host_ints = MAX_PRU_CHANNELS;
+
+	prop = of_find_property(np, propname, NULL);
+	if (!prop)
+		return 0;
+
+	entries = of_property_count_u32_elems(np, propname);
+	if (entries <= 0 || entries % 4)
+		return -EINVAL;
+
+	arr = kmalloc_array(entries, sizeof(u32), GFP_KERNEL);
+	if (!arr)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, propname, arr, entries);
+	if (ret)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(intc_config->sysev_to_ch); i++)
+		intc_config->sysev_to_ch[i] = -1;
+
+	for (i = 0; i < ARRAY_SIZE(intc_config->ch_to_host); i++)
+		intc_config->ch_to_host[i] = -1;
+
+	for (i = 0; i < entries; i += 4) {
+		if (arr[i] != index)
+			continue;
+
+		if (arr[i + 1] < 0 ||
+		    arr[i + 1] >= max_system_events) {
+			dev_dbg(dev, "bad sys event %d\n", arr[i + 1]);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (arr[i + 2] < 0 ||
+		    arr[i + 2] >= max_pru_channels) {
+			dev_dbg(dev, "bad channel %d\n", arr[i + 2]);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (arr[i + 3] < 0 ||
+		    arr[i + 3] >= max_pru_host_ints) {
+			dev_dbg(dev, "bad irq %d\n", arr[i + 3]);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		intc_config->sysev_to_ch[arr[i + 1]] = arr[i + 2];
+		dev_dbg(dev, "sysevt-to-ch[%d] -> %d\n", arr[i + 1],
+			arr[i + 2]);
+
+		intc_config->ch_to_host[arr[i + 2]] = arr[i + 3];
+		dev_dbg(dev, "chnl-to-host[%d] -> %d\n", arr[i + 2],
+			arr[i + 3]);
+
+		dt_irqs++;
+	}
+
+	kfree(arr);
+	return dt_irqs;
+
+err:
+	kfree(arr);
+	return ret;
+}
+
 /**
  * pru_rproc_get() - get the PRU rproc instance from a device node
  * @np: the user/client device node
@@ -251,6 +336,15 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
 		}
 	}
 
+	ret = pru_get_intc_dt_config(dev, "ti,pru-interrupt-map",
+				     index, &pru->intc_config);
+	if (ret < 0) {
+		dev_err(dev, "error getting DT interrupt map: %d\n", ret);
+		goto err;
+	}
+
+	pru->dt_irqs = ret;
+
 	return rproc;
 
 err:
@@ -568,7 +662,13 @@ static int pru_rproc_start(struct rproc *rproc)
 	dev_dbg(dev, "starting PRU%d: entry-point = 0x%x\n",
 		pru->id, (rproc->bootaddr >> 2));
 
-	/* TODO: INTC setup */
+	if (pru->dt_irqs) {
+		ret = pruss_intc_configure(pru->pruss, &pru->intc_config);
+		if (ret) {
+			dev_err(dev, "failed to configure intc %d\n", ret);
+			return ret;
+		}
+	}
 
 	if (!list_empty(&pru->rproc->rvdevs)) {
 		if (!pru->mbox && (pru->irq_vring <= 0 || pru->irq_kick <= 0)) {
@@ -596,7 +696,8 @@ static int pru_rproc_start(struct rproc *rproc)
 	return 0;
 
 fail:
-	/* TODO: INTC cleanup */
+	if (pru->dt_irqs)
+		pruss_intc_unconfigure(pru->pruss, &pru->intc_config);
 
 	return ret;
 }
@@ -618,7 +719,9 @@ static int pru_rproc_stop(struct rproc *rproc)
 	    !pru->mbox && pru->irq_vring > 0)
 		free_irq(pru->irq_vring, pru);
 
-	/* TODO: INTC cleanup */
+	/* undo INTC config */
+	if (pru->dt_irqs)
+		pruss_intc_unconfigure(pru->pruss, &pru->intc_config);
 
 	return 0;
 }
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

