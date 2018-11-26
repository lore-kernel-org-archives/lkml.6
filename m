Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3BCC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF4420663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF4420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbeKZSrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:47:09 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36558 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKZSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:47:08 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rn9U102551;
        Mon, 26 Nov 2018 01:53:49 -0600
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rnmf084094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:49 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:46 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:46 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rldY009288;
        Mon, 26 Nov 2018 01:53:47 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1R024490;
        Mon, 26 Nov 2018 01:53:43 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 13/16] remoteproc/pru: add support for configuring GPMUX based on client setup
Date:   Mon, 26 Nov 2018 09:52:46 +0200
Message-ID: <1543218769-5507-14-git-send-email-rogerq@ti.com>
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

Client device node property ti,pruss-gp-mux-sel can now be used to
configure the GPMUX config value for PRU.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[s-anna@ti.com: simplify the pru id usage]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index d8b823d..9a08937 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -72,6 +72,7 @@ enum pru_mem {
  * @sdram_da: device address of secondary Data RAM for this PRU
  * @shrdram_da: device address of shared Data RAM
  * @fw_name: name of firmware image used during loading
+ * @gpmux_save: saved value for gpmux config
  * @lock: mutex to protect client usage
  * @dbg_single_step: debug state variable to set PRU into single step mode
  * @dbg_continuous: debug state variable to restore PRU execution mode
@@ -95,6 +96,7 @@ struct pru_rproc {
 	u32 sdram_da;
 	u32 shrdram_da;
 	const char *fw_name;
+	u8 gpmux_save;
 	struct mutex lock; /* client access lock */
 	u32 dbg_single_step;
 	u32 dbg_continuous;
@@ -184,12 +186,16 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
 {
 	struct rproc *rproc;
 	struct pru_rproc *pru;
+	struct device *dev;
+	int ret;
+	u32 mux;
 
 	rproc = __pru_rproc_get(np, index);
 	if (IS_ERR(rproc))
 		return rproc;
 
 	pru = rproc->priv;
+	dev = &rproc->dev;
 
 	mutex_lock(&pru->lock);
 
@@ -203,7 +209,27 @@ struct rproc *pru_rproc_get(struct device_node *np, int index)
 
 	mutex_unlock(&pru->lock);
 
+	ret = pruss_cfg_get_gpmux(pru->pruss, pru->id, &pru->gpmux_save);
+	if (ret) {
+		dev_err(dev, "failed to get cfg gpmux: %d\n", ret);
+		goto err;
+	}
+
+	ret = of_property_read_u32_index(np, "ti,pruss-gp-mux-sel", index,
+					 &mux);
+	if (!ret) {
+		ret = pruss_cfg_set_gpmux(pru->pruss, pru->id, mux);
+		if (ret) {
+			dev_err(dev, "failed to set cfg gpmux: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return rproc;
+
+err:
+	pru_rproc_put(rproc);
+	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(pru_rproc_get);
 
@@ -229,6 +255,8 @@ void pru_rproc_put(struct rproc *rproc)
 	if (!pru->client_np)
 		return;
 
+	pruss_cfg_set_gpmux(pru->pruss, pru->id, pru->gpmux_save);
+
 	mutex_lock(&pru->lock);
 	pru->client_np = NULL;
 	mutex_unlock(&pru->lock);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

