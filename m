Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAAFC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2FE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZRh+cplV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B2FE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeKZSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:47:21 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49600 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKZSrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:47:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rx4C116063;
        Mon, 26 Nov 2018 01:53:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218839;
        bh=e7Kt614Hb305Va7Jkr2pFVKsfcKezvJJ/+gFDtyC3Fo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZRh+cplVXn0ZcFNUFhYT2bKdXHRr8fiz0VV96nQ/Vp3hY1O+wF4yfUHv8r/J+vnnL
         qaHQhX2by13msSFOi1Kf+/1prbJ4Z0DuNV/A6fMzrkMF/fQ/M/M77sppQ2b9gi7bfj
         Pgoldsa6CQUvD8aIeDYmWEOP4LkenWY2ur+3wVzo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rxl6103927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:59 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:59 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:59 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rxIG009440;
        Mon, 26 Nov 2018 01:53:59 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1U024490;
        Mon, 26 Nov 2018 01:53:55 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 16/16] remoteproc/pru: Add support for INTC Interrupt map resource
Date:   Mon, 26 Nov 2018 09:52:49 +0200
Message-ID: <1543218769-5507-17-git-send-email-rogerq@ti.com>
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

Use the vendor specific resource mechanism to get the
INTC mapping details from firmware.

pru-software-support-package [1] has been historically using
version 0 for this. However, the data structure is not scaleable
and is not self sufficient.
1) it hard codes number of channel to host mappings so is not
scaleable to newer SoCs than have more of these.
2) it does not contain the event to channel mappings within
itself but relies on a pointer to point to another section
in data memory. This causes a weird complication that the
respective data section must be loaded before we can really
use the INTC map.

With this patch we drop support for version 0 and support
version 1 which is a more robust and scalable data structure.
It should be able to support a sufficiently large number (255) of
sysevents, channels and host interrupts and is self contained
so it can be used without dependency on order of loading sections.

[1]  git://git.ti.com/pru-software-support-package/pru-software-support-package.git

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 110 +++++++++++++++++++++++++++++++++++++++--
 drivers/remoteproc/pru_rproc.h |  48 +++++++-----------
 2 files changed, 126 insertions(+), 32 deletions(-)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 540cce3..9e22c70 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -75,6 +75,7 @@ enum pru_mem {
  * @fw_name: name of firmware image used during loading
  * @gpmux_save: saved value for gpmux config
  * @dt_irqs: number of irqs configured from DT
+ * @fw_irqs: number of irqs configured from FW
  * @lock: mutex to protect client usage
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
@@ -101,6 +102,7 @@ struct pru_rproc {
 	const char *fw_name;
 	u8 gpmux_save;
 	int dt_irqs;
+	int fw_irqs;
 	struct mutex lock; /* client access lock */
 	u32 dbg_single_step;
 	u32 dbg_continuous;
@@ -651,6 +653,107 @@ static void pru_rproc_kick(struct rproc *rproc, int vq_id)
 	}
 }
 
+/*
+ * parse the custom interrupt map resource and save the intc_config
+ * for use when booting the processor.
+ */
+static int pru_handle_vendor_intrmap(struct rproc *rproc,
+				     struct fw_rsc_pruss_intrmap *rsc)
+{
+	int fw_irqs = 0, i, ret = 0;
+	u8 *arr;
+	struct device *dev = &rproc->dev;
+	struct pru_rproc *pru = rproc->priv;
+
+	dev_dbg(dev, "vendor rsc intc: version %d\n", rsc->version);
+
+	/*
+	 * 0 was prototyping version. Not supported.
+	 * 1 is currently supported version.
+	 */
+	if (rsc->version == 0 || rsc->version > 1) {
+		dev_err(dev, "Unsupported version %d\n", rsc->version);
+		return -EINVAL;
+	}
+
+	/* DT provided INTC config takes precedence */
+	if (pru->dt_irqs) {
+		dev_info(dev, "INTC config in DT and FW. Using DT config.\n");
+		return 0;
+	}
+
+	arr = rsc->data;
+
+	for (i = 0; i < ARRAY_SIZE(pru->intc_config.sysev_to_ch); i++)
+		pru->intc_config.sysev_to_ch[i] = -1;
+
+	for (i = 0; i < ARRAY_SIZE(pru->intc_config.ch_to_host); i++)
+		pru->intc_config.ch_to_host[i] = -1;
+
+	for (i = 0; i < rsc->num_maps * 3; i += 3) {
+		if (arr[i] < 0 ||
+		    arr[i] >= MAX_PRU_SYS_EVENTS) {
+			dev_err(dev, "bad sys event %d\n", arr[i]);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (arr[i + 1] < 0 ||
+		    arr[i + 1] >= MAX_PRU_CHANNELS) {
+			dev_err(dev, "bad channel %d\n", arr[i + 1]);
+			ret = -EINVAL;
+			goto err;
+		}
+
+		if (arr[i + 2] < 0 ||
+		    arr[i + 2] >= MAX_PRU_CHANNELS) {
+			dev_err(dev, "bad host irq %d\n", arr[i + 2]);
+				ret = -EINVAL;
+			goto err;
+		}
+
+		pru->intc_config.sysev_to_ch[arr[i]] = arr[i + 1];
+		dev_dbg(dev, "sysevt-to-ch[%d] -> %d\n", arr[i],
+			arr[i + 1]);
+
+		pru->intc_config.ch_to_host[arr[i + 1]] = arr[i + 2];
+		dev_dbg(dev, "chnl-to-host[%d] -> %d\n", arr[i + 1],
+			arr[i + 2]);
+
+		fw_irqs++;
+	}
+
+	pru->fw_irqs = fw_irqs;
+	return 0;
+
+err:
+	pru->fw_irqs = 0;
+	return ret;
+}
+
+/* PRU-specific vendor resource handler */
+static int pru_rproc_handle_vendor_rsc(struct rproc *rproc,
+				       struct fw_rsc_vendor *ven_rsc)
+{
+	struct device *dev = rproc->dev.parent;
+	int ret = -EINVAL;
+
+	struct fw_rsc_pruss_intrmap *rsc;
+
+	rsc = (struct fw_rsc_pruss_intrmap *)ven_rsc->data;
+
+	switch (rsc->type) {
+	case PRUSS_RSC_INTRS:
+		ret = pru_handle_vendor_intrmap(rproc, rsc);
+		break;
+	default:
+		dev_err(dev, "%s: cannot handle unknown type %d\n", __func__,
+			rsc->type);
+	}
+
+	return ret;
+}
+
 /* start a PRU core */
 static int pru_rproc_start(struct rproc *rproc)
 {
@@ -662,7 +765,7 @@ static int pru_rproc_start(struct rproc *rproc)
 	dev_dbg(dev, "starting PRU%d: entry-point = 0x%x\n",
 		pru->id, (rproc->bootaddr >> 2));
 
-	if (pru->dt_irqs) {
+	if (pru->dt_irqs || pru->fw_irqs) {
 		ret = pruss_intc_configure(pru->pruss, &pru->intc_config);
 		if (ret) {
 			dev_err(dev, "failed to configure intc %d\n", ret);
@@ -696,7 +799,7 @@ static int pru_rproc_start(struct rproc *rproc)
 	return 0;
 
 fail:
-	if (pru->dt_irqs)
+	if (pru->dt_irqs || pru->fw_irqs)
 		pruss_intc_unconfigure(pru->pruss, &pru->intc_config);
 
 	return ret;
@@ -720,7 +823,7 @@ static int pru_rproc_stop(struct rproc *rproc)
 		free_irq(pru->irq_vring, pru);
 
 	/* undo INTC config */
-	if (pru->dt_irqs)
+	if (pru->dt_irqs || pru->fw_irqs)
 		pruss_intc_unconfigure(pru->pruss, &pru->intc_config);
 
 	return 0;
@@ -815,6 +918,7 @@ static struct rproc_ops pru_rproc_ops = {
 	.stop			= pru_rproc_stop,
 	.kick			= pru_rproc_kick,
 	.da_to_va		= pru_da_to_va,
+	.handle_vendor_rsc	= pru_rproc_handle_vendor_rsc,
 };
 
 static int pru_rproc_set_id(struct pru_rproc *pru)
diff --git a/drivers/remoteproc/pru_rproc.h b/drivers/remoteproc/pru_rproc.h
index 35240e9..a9413f6 100644
--- a/drivers/remoteproc/pru_rproc.h
+++ b/drivers/remoteproc/pru_rproc.h
@@ -23,43 +23,33 @@ enum pruss_rsc_types {
 	PRUSS_RSC_MAX	= 2,
 };
 
-/**
- * struct pruss_event_chnl - PRU system events _to_ channel mapping
- * @event: number of the system event
- * @chnl: channel number assigned to a given @event
- *
- * PRU system events are mapped to channels, and these channels are mapped
- * to host interrupts. Events can be mapped to channels in a one-to-one or
- * many-to-one ratio (multiple events per channel), and channels can be
- * mapped to host interrupts in a one-to-one or many-to-one ratio (multiple
- * channels per interrupt).
- *
- */
-struct pruss_event_chnl {
-	s8 event;
-	s8 chnl;
-};
 
 /**
- * struct fw_rsc_custom_intrmap - custom resource to define PRU interrupts
- * @reserved: reserved field providing padding and alignment
- * @chnl_host_intr_map: array of PRU channels to host interrupt mappings
- * @event_chnl_map_size: number of event_channel mappings defined in
- *			 @event_chnl_map_addr
- * @event_chnl_map_addr: PRU device address of pointer to array of events to
- *			 channel mappings (struct pruss_event_chnl elements)
+ * struct fw_rsc_pruss_intrmap - vendor resource to define PRU interrupts
+ * @type: should be PRUSS_RSC_INTRS
+ * @version: should be 1 or greater. 0 was for prototyping and is not supported
+ * @num_maps: number of interrupt mappings that follow
+ * @data: Array of 'num_maps' mappings.
+ *		Each mapping is a triplet {s, c, h}
+ *		s - system event id
+ *		c - channel id
+ *		h - host interrupt id
  *
  * PRU system events are mapped to channels, and these channels are mapped
  * to host interrupts. Events can be mapped to channels in a one-to-one or
  * many-to-one ratio (multiple events per channel), and channels can be
  * mapped to host interrupts in a one-to-one or many-to-one ratio (multiple
  * channels per interrupt).
+ *
+ * This resource is variable length due to the nature of INTC map.
+ * The below data structure is scalable so it can support sufficiently
+ * large number of sysevents and hosts.
  */
-struct fw_rsc_custom_intrmap {
-	u16 reserved;
-	s8 chnl_host_intr_map[10];
-	u32 event_chnl_map_size;
-	u32 event_chnl_map_addr;
-};
+struct fw_rsc_pruss_intrmap {
+	u16 type;
+	u16 version;
+	u8 num_maps;
+	u8 data[];
+} __packed;
 
 #endif	/* _PRU_REMOTEPROC_H_ */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

