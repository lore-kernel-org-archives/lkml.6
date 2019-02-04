Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ED8C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B7E2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UTs8vmFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfBDOYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43388 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbfBDOY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENdAG032100;
        Mon, 4 Feb 2019 08:23:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290219;
        bh=qsmYhumlh7XE3EZ26jo895vDIW3+iN+t0S4IYcX/ScU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UTs8vmFmgpVVIukQVYPq5xQgTZy4W+RN3d89GlaMAVJxa6jyEvLuH1NHIYuL8FBRh
         xuiQUnbWrmWwciVZ/r7YueUf73SeO+jS0g/5Wk1UFRGbTFU4lS8HGhDTkHEAUvxYN9
         Ix2+MEIlTqeGIvGp6nNSO2LeWzqVGMDtlQxbStEA=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENdBo069143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:39 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:39 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:39 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKj012232;
        Mon, 4 Feb 2019 08:23:35 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v2 11/14] remoteproc/pru: Add pru_rproc_set_ctable() and pru_rproc_set_gpimode()
Date:   Mon, 4 Feb 2019 16:22:44 +0200
Message-ID: <1549290167-876-12-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some firmwares expect the OS drivers to configure the CTABLE
entries publishing dynamically allocated memory regions. For
example, the PRU Ethernet firmwares use the C28 and C30 entries
for retrieving the Shared RAM and System SRAM (OCMC) areas
allocated by the PRU Ethernet client driver.

Provide a way for users to do that through a new API,
pru_rproc_set_ctable(). The API returns 0 on success and
a negative value on error.

NOTE:
The programmable CTABLE entries are typically re-programmed by
the PRU firmwares when dealing with a certain block of memory
during block processing. This API provides an interface to the
PRU client drivers to publish a dynamically allocated memory
block with the PRU firmware using a CTABLE entry instead of a
negotiated address in shared memory. Additional synchronization
may be needed between the PRU client drivers and firmwares if
different addresses needs to be published at run-time reusing
the same CTABLE entry.

Some client drivers need to set the GPI mode of the
PRU. The GPI mode select bits like in the GPCFG register
space. Add pru_rproc_set_gpimode() API to set the GPI
mode for the PRU.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna@ti.com: add the NOTE: on patch description, minor cleanups]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c       | 48 ++++++++++++++++++++++++++++++++++++
 include/linux/remoteproc/pru_rproc.h | 30 ++++++++++++++++++++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index ddd4b64..85463f7 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -398,6 +398,54 @@ void pru_rproc_put(struct rproc *rproc)
 }
 EXPORT_SYMBOL_GPL(pru_rproc_put);
 
+/**
+ * pru_rproc_set_ctable() - set the constant table index for the PRU
+ * @rproc: the rproc instance of the PRU
+ * @c: constant table index to set
+ * @addr: physical address to set it to
+ */
+int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
+{
+	struct pru_rproc *pru = rproc->priv;
+	unsigned int reg;
+	u32 mask, set;
+	u16 idx;
+	u16 idx_mask;
+
+	/* pointer is 16 bit and index is 8-bit so mask out the rest */
+	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
+
+	/* ctable uses bit 8 and upwards only */
+	idx = (addr >> 8) & idx_mask;
+
+	/* configurable ctable (i.e. C24) starts at PRU_CTRL_CTBIR0 */
+	reg = PRU_CTRL_CTBIR0 + 4 * (c >> 1);
+	mask = idx_mask << (16 * (c & 1));
+	set = idx << (16 * (c & 1));
+
+	regmap_update_bits(pru->ctrl_regmap, reg, mask, set);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pru_rproc_set_ctable);
+
+/**
+ * pru_rproc_set_gpimode() - set the GPI mode for the PRU
+ * @rproc: the rproc instance of the PRU
+ * @mode: GPI mode to set
+ *
+ * Returns 0 on success, negative error value otherwise.
+ */
+int pru_rproc_set_gpimode(struct rproc *rproc, enum pruss_gpi_mode mode)
+{
+	struct pru_rproc *pru = rproc->priv;
+
+	return regmap_update_bits(pru->cfg, pru->gpcfg_reg,
+				  PRUSS_GPCFG_PRU_GPI_MODE_MASK,
+				  mode << PRUSS_GPCFG_PRU_GPI_MODE_SHIFT);
+}
+EXPORT_SYMBOL_GPL(pru_rproc_set_gpimode);
+
 /*
  * Control PRU single-step mode
  *
diff --git a/include/linux/remoteproc/pru_rproc.h b/include/linux/remoteproc/pru_rproc.h
index 841da09..887d996 100644
--- a/include/linux/remoteproc/pru_rproc.h
+++ b/include/linux/remoteproc/pru_rproc.h
@@ -8,10 +8,28 @@
 #ifndef __LINUX_REMOTEPROC_PRU_RPROC_H
 #define __LINUX_REMOTEPROC_PRU_RPROC_H
 
+/**
+ * enum pru_ctable_idx - Configurable Constant table index identifiers
+ */
+enum pru_ctable_idx {
+	PRU_C24 = 0,
+	PRU_C25,
+	PRU_C26,
+	PRU_C27,
+	PRU_C28,
+	PRU_C29,
+	PRU_C30,
+	PRU_C31,
+};
+
+enum pruss_gpi_mode;
+
 #if IS_ENABLED(CONFIG_PRUSS_REMOTEPROC)
 
 struct rproc *pru_rproc_get(struct device_node *node, int index);
 void pru_rproc_put(struct rproc *rproc);
+int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
+int pru_rproc_set_gpimode(struct rproc *rproc, enum pruss_gpi_mode mode);
 
 #else
 
@@ -22,6 +40,18 @@ static inline struct rproc *pru_rproc_get(struct device_node *node, int index)
 
 static inline void pru_rproc_put(struct rproc *rproc) { }
 
+static inline int pru_rproc_set_ctable(struct rproc *rproc,
+				       enum pru_ctable_idx c, u32 addr)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pru_rproc_set_gpimode(struct rproc *rproc,
+					enum pruss_gpi_mode mode)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_PRUSS_REMOTEPROC */
 
 #endif /* __LINUX_REMOTEPROC_PRU_RPROC_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

