Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD52BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F80520663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ohHL1fKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F80520663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbeKZSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:47:00 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49494 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeKZSq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rdME115949;
        Mon, 26 Nov 2018 01:53:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218819;
        bh=l0MhL2S79mZ5X3JBIlhYX7eDB29eRWidkIFQRsLrfoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ohHL1fKEgCpZ5AQVzPEBhrOIjmwBKCAk3VNscuxLFEMNRkTOWMLjwtrM8LMNN1L28
         2Z2foSJziUCi1jWb44opbNHVPUiKUOgxtyN0ppIZl7del8KijeeAb15t83hiv8KcVy
         ahlwtkQUyV5IydV1YwnywxsmRynb8eo87Fz+h1jk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rdvV103711
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:39 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:39 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rdKU002632;
        Mon, 26 Nov 2018 01:53:39 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1P024490;
        Mon, 26 Nov 2018 01:53:35 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 11/16] soc: ti: pruss: add helper functions to set GPI mode, MII_RT_event and XFR
Date:   Mon, 26 Nov 2018 09:52:44 +0200
Message-ID: <1543218769-5507-12-git-send-email-rogerq@ti.com>
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

The PRUSS CFG module is represented as a syscon node and is currently
managed by the PRUSS platform driver. Add easy accessor functions to set
GPI mode, MII_RT event enable/disable and XFR (XIN XOUT) enable/disable
to enable the PRUSS Ethernet usecase. These functions reuse the generic
pruss_regmap_update() API function.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/pruss.h | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index c0a3b3e..7227aae 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -204,6 +204,69 @@ int pruss_intc_configure(struct pruss *pruss,
 int pruss_intc_unconfigure(struct pruss *pruss,
 			   struct pruss_intc_config *intc_config);
 
+/**
+ * pruss_cfg_get_gpmux() - get the current GPMUX value for a PRU device
+ * @pruss: pruss instance
+ * @id: PRU identifier (0-1)
+ * @mux: pointer to store the current mux value into
+ */
+static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
+				      enum pruss_pru_id id, u8 *mux)
+{
+	int ret = 0;
+	u32 val;
+
+	ret = pruss_cfg_read(pruss, PRUSS_CFG_GPCFG(id), &val);
+	if (!ret)
+		*mux = (u8)((val & PRUSS_GPCFG_PRU_MUX_SEL_MASK) >>
+			    PRUSS_GPCFG_PRU_MUX_SEL_SHIFT);
+	return ret;
+}
+
+/**
+ * pruss_cfg_set_gpmux() - set the GPMUX value for a PRU device
+ * @pruss: pruss instance
+ * @pru_id: PRU identifier (0-1)
+ * @mux: new mux value for PRU
+ */
+static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
+				      enum pruss_pru_id id, u8 mux)
+{
+	if (mux >= PRUSS_GP_MUX_SEL_MAX)
+		return -EINVAL;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_GPCFG(id),
+				PRUSS_GPCFG_PRU_MUX_SEL_MASK,
+				(u32)mux << PRUSS_GPCFG_PRU_MUX_SEL_SHIFT);
+}
+
+/**
+ * pruss_cfg_miirt_enable() - Enable/disable MII RT Events
+ * @pruss: the pruss instance
+ * @enable: enable/disable
+ *
+ * Enable/disable the MII RT Events for the PRUSS.
+ */
+static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
+{
+	u32 set = enable ? PRUSS_MII_RT_EVENT_EN : 0;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_MII_RT,
+				PRUSS_MII_RT_EVENT_EN, set);
+}
+
+/**
+ * pruss_cfg_xfr_enable() - Enable/disable XIN XOUT shift functionality
+ * @pruss: the pruss instance
+ * @enable: enable/disable
+ */
+static inline int pruss_cfg_xfr_enable(struct pruss *pruss, bool enable)
+{
+	u32 set = enable ? PRUSS_SPP_XFER_SHIFT_EN : 0;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_SPP,
+				PRUSS_SPP_XFER_SHIFT_EN, set);
+}
 #else
 
 static inline struct pruss *pruss_get(struct rproc *rproc)
@@ -254,6 +317,28 @@ int pruss_intc_unconfigure(struct pruss *pruss,
 	return -ENOTSUPP;
 }
 
+static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
+				      enum pruss_pru_id id, u8 *mux)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
+				      enum pruss_pru_id id, u8 mux)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pruss_cfg_xfr_enable(struct pruss *pruss, bool enable)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_TI_PRUSS */
 
 #if IS_ENABLED(CONFIG_PRUSS_REMOTEPROC)
@@ -263,6 +348,30 @@ void pru_rproc_put(struct rproc *rproc);
 enum pruss_pru_id pru_rproc_get_id(struct rproc *rproc);
 int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
 
+/**
+ * pruss_cfg_gpimode() - set the GPI mode of the PRU
+ * @pruss: the pruss instance handle
+ * @pru: the rproc instance handle of the PRU
+ * @mode: GPI mode to set
+ *
+ * Sets the GPI mode for a given PRU by programming the
+ * corresponding PRUSS_CFG_GPCFGx register
+ *
+ * Returns 0 on success, or an error code otherwise
+ */
+static inline int pruss_cfg_gpimode(struct pruss *pruss, struct rproc *pru,
+				    enum pruss_gpi_mode mode)
+{
+	enum pruss_pru_id id = pru_rproc_get_id(pru);
+
+	if (id < 0)
+		return -EINVAL;
+
+	return pruss_cfg_update(pruss, PRUSS_CFG_GPCFG(id),
+				PRUSS_GPCFG_PRU_GPI_MODE_MASK,
+				mode << PRUSS_GPCFG_PRU_GPI_MODE_SHIFT);
+}
+
 #else
 
 static inline struct rproc *pru_rproc_get(struct device_node *node, int index)
@@ -283,6 +392,12 @@ static inline int pru_rproc_set_ctable(struct rproc *rproc,
 	return -ENOTSUPP;
 }
 
+static inline int pruss_cfg_gpimode(struct pruss *pruss, struct rproc *pru,
+				    enum pruss_gpi_mode mode)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_PRUSS_REMOTEPROC */
 
 #endif /* __LINUX_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

