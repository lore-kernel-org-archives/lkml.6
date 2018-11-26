Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30122C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD7C20663
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD7C20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeKZSqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36530 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbeKZSqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7rRWW102518;
        Mon, 26 Nov 2018 01:53:27 -0600
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7rRE2059653
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:53:27 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:53:27 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:53:26 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7rQwJ002527;
        Mon, 26 Nov 2018 01:53:26 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1M024490;
        Mon, 26 Nov 2018 01:53:23 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 08/16] remoteproc/pru: Add pru_rproc_set_ctable() function
Date:   Mon, 26 Nov 2018 09:52:41 +0200
Message-ID: <1543218769-5507-9-git-send-email-rogerq@ti.com>
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

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
[s-anna@ti.com: add the NOTE: on patch description, minor cleanups]
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/pru_rproc.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pruss.h          | 29 ++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index e0554b3..fa3559b 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -65,6 +65,7 @@ enum pru_mem {
  * @dram0: PRUSS DRAM0 region
  * @dram1: PRUSS DRAM1 region
  * @shrdram: PRUSS SHARED RAM region
+ * @rmw_lock: lock for read, modify, write operations on registers
  * @iram_da: device address of Instruction RAM for this PRU
  * @pdram_da: device address of primary Data RAM for this PRU
  * @sdram_da: device address of secondary Data RAM for this PRU
@@ -85,6 +86,7 @@ struct pru_rproc {
 	struct pruss_mem_region dram0;
 	struct pruss_mem_region dram1;
 	struct pruss_mem_region shrdram;
+	spinlock_t rmw_lock; /* register access lock */
 	u32 iram_da;
 	u32 pdram_da;
 	u32 sdram_da;
@@ -107,6 +109,54 @@ void pru_control_write_reg(struct pru_rproc *pru, unsigned int reg, u32 val)
 	writel_relaxed(val, pru->mem_regions[PRU_MEM_CTRL].va + reg);
 }
 
+static inline
+void pru_control_set_reg(struct pru_rproc *pru, unsigned int reg,
+			 u32 mask, u32 set)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pru->rmw_lock, flags);
+
+	val = pru_control_read_reg(pru, reg);
+	val &= ~mask;
+	val |= (set & mask);
+	pru_control_write_reg(pru, reg, val);
+
+	spin_unlock_irqrestore(&pru->rmw_lock, flags);
+}
+
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
+	pru_control_set_reg(pru, reg, mask, set);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pru_rproc_set_ctable);
+
 static inline u32 pru_debug_read_reg(struct pru_rproc *pru, unsigned int reg)
 {
 	return readl_relaxed(pru->mem_regions[PRU_MEM_DEBUG].va + reg);
@@ -537,6 +587,7 @@ static int pru_rproc_probe(struct platform_device *pdev)
 	pru->pruss = platform_get_drvdata(ppdev);
 	pru->rproc = rproc;
 	pru->fw_name = fw_name;
+	spin_lock_init(&pru->rmw_lock);
 
 	ret = pruss_request_mem_region(pru->pruss, PRUSS_MEM_DRAM0,
 				       &pru->dram0);
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index c797fb1..af04a1c 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -134,7 +134,22 @@ struct pruss_intc_config {
 	s8 ch_to_host[MAX_PRU_CHANNELS];
 };
 
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
 struct pruss;
+struct rproc;
 
 #if IS_ENABLED(CONFIG_TI_PRUSS)
 
@@ -232,4 +247,18 @@ int pruss_intc_unconfigure(struct pruss *pruss,
 
 #endif /* CONFIG_TI_PRUSS */
 
+#if IS_ENABLED(CONFIG_PRUSS_REMOTEPROC)
+
+int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr);
+
+#else
+
+static inline int pru_rproc_set_ctable(struct rproc *rproc,
+				       enum pru_ctable_idx c, u32 addr)
+{
+	return -ENOTSUPP;
+}
+
+#endif /* CONFIG_PRUSS_REMOTEPROC */
+
 #endif /* __LINUX_PRUSS_H */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

