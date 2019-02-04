Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE7DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EA32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="H0hmhGAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfBDOYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:10 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49802 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfBDOYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:10 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENGAs043984;
        Mon, 4 Feb 2019 08:23:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290196;
        bh=xYhFn+XoCbY3N+WtnCXNF8c7lPDXw/OdjseI+5U2LQk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=H0hmhGAR/nJFkGmjcDgxw6o4vJ89UPYAYpkZDYdHqkFuFZG79DlXGqsvFILxMZ7Lp
         qN0dWGL5BjDCffbLCcP/FTeO8eNsJ/9QkprXF8MpNrIiNLKqrsvf9V4Gvx5KagCsdI
         A2Px/VPEUIyY8jIkyGMesQCHfRwqFVsrzI7PpSl0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENGcU115765
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:16 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:15 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:15 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKd012232;
        Mon, 4 Feb 2019 08:23:12 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH v2 05/14] remoteproc: add map parameter to da_to_va
Date:   Mon, 4 Feb 2019 16:22:38 +0200
Message-ID: <1549290167-876-6-git-send-email-rogerq@ti.com>
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

From: David Lechner <david@lechnology.com>

This adds a new map parameter to the da_to_va callback for remoteproc
devices. This parameter will be used by devices that have more than
one memory map, such as the PRU found in TI Sitara SoCs.

On these devices, the same physical memory address can refer to two
different locations, i.e. instruction memory or data memory both start
at 0x0. So, an extra bit of information is needed in the da_to_va
callback to tell these apart.

Devices that only have a single memory map will just pass 0 for this
parameter. For now we are using 0 everywhere, but later patches will
modify this value.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/imx_rproc.c             |  2 +-
 drivers/remoteproc/keystone_remoteproc.c   |  3 ++-
 drivers/remoteproc/qcom_q6v5_mss.c         |  2 +-
 drivers/remoteproc/qcom_wcnss.c            |  2 +-
 drivers/remoteproc/remoteproc_core.c       | 11 +++++++----
 drivers/remoteproc/remoteproc_elf_loader.c |  4 ++--
 drivers/remoteproc/remoteproc_internal.h   |  2 +-
 drivers/remoteproc/st_slim_rproc.c         |  2 +-
 drivers/remoteproc/wkup_m3_rproc.c         |  3 ++-
 include/linux/remoteproc.h                 |  2 +-
 10 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 54c07fd..78c3502 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -211,7 +211,7 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	return -ENOENT;
 }
 
-static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len, int map)
 {
 	struct imx_rproc *priv = rproc->priv;
 	void *va = NULL;
diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index aaac311..0f87cf9 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -254,7 +254,8 @@ static void keystone_rproc_kick(struct rproc *rproc, int vqid)
  * can be used either by the remoteproc core for loading (when using kernel
  * remoteproc loader), or by any rpmsg bus drivers.
  */
-static void *keystone_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *keystone_rproc_da_to_va(struct rproc *rproc, u64 da, int len,
+				     int map)
 {
 	struct keystone_rproc *ksproc = rproc->priv;
 	void __iomem *va = NULL;
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be731..d0cdc34 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -971,7 +971,7 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 	int ret = 0;
 	struct q6v5 *qproc = rproc->priv;
 	unsigned long mask = BIT((unsigned long)segment->priv);
-	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size, 0);
 
 	/* Unlock mba before copying segments */
 	if (!qproc->dump_mba_loaded)
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index b0e07e9..92b05fb 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -295,7 +295,7 @@ static int wcnss_stop(struct rproc *rproc)
 	return ret;
 }
 
-static void *wcnss_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *wcnss_da_to_va(struct rproc *rproc, u64 da, int len, int map)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
 	int offset;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 54ec38f..06ef4fa 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -166,6 +166,8 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
  * @rproc: handle of a remote processor
  * @da: remoteproc device address to translate
  * @len: length of the memory region @da is pointing to
+ * @map: indicates which memory map to use for devices with more than one
+ *       memory map or 0 for devices that only have a single memory map
  *
  * Some remote processors will ask us to allocate them physically contiguous
  * memory regions (which we call "carveouts"), and map them to specific
@@ -190,13 +192,13 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
  * here the output of the DMA API for the carveouts, which should be more
  * correct.
  */
-void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, int map)
 {
 	struct rproc_mem_entry *carveout;
 	void *ptr = NULL;
 
 	if (rproc->ops->da_to_va) {
-		ptr = rproc->ops->da_to_va(rproc, da, len);
+		ptr = rproc->ops->da_to_va(rproc, da, len, map);
 		if (ptr)
 			goto out;
 	}
@@ -575,7 +577,7 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
 	}
 
 	/* what's the kernel address of this resource ? */
-	ptr = rproc_da_to_va(rproc, rsc->da, rsc->len);
+	ptr = rproc_da_to_va(rproc, rsc->da, rsc->len, 0);
 	if (!ptr) {
 		dev_err(dev, "erroneous trace resource entry\n");
 		return -EINVAL;
@@ -1549,7 +1551,8 @@ static void rproc_coredump(struct rproc *rproc)
 		if (segment->dump) {
 			segment->dump(rproc, segment, data + offset);
 		} else {
-			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+			ptr = rproc_da_to_va(rproc, segment->da,
+					     segment->size, 0);
 			if (!ptr) {
 				dev_err(&rproc->dev,
 					"invalid coredump segment (%pad, %zu)\n",
diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index b17d72e..8888d39 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -182,7 +182,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		}
 
 		/* grab the kernel address for this device address */
-		ptr = rproc_da_to_va(rproc, da, memsz);
+		ptr = rproc_da_to_va(rproc, da, memsz, 0);
 		if (!ptr) {
 			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
 			ret = -EINVAL;
@@ -333,6 +333,6 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 	if (!shdr)
 		return NULL;
 
-	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size);
+	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size, 0);
 }
 EXPORT_SYMBOL(rproc_elf_find_loaded_rsc_table);
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f6cad24..15e0833 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -51,7 +51,7 @@ void rproc_exit_sysfs(void);
 void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
 
-void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
+void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, int map);
 int rproc_trigger_recovery(struct rproc *rproc);
 
 int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
index d711d94..8b843c8 100644
--- a/drivers/remoteproc/st_slim_rproc.c
+++ b/drivers/remoteproc/st_slim_rproc.c
@@ -178,7 +178,7 @@ static int slim_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
-static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len, int map)
 {
 	struct st_slim_rproc *slim_rproc = rproc->priv;
 	void *va = NULL;
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 1ada0e5..12cb26e 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -88,7 +88,8 @@ static int wkup_m3_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
-static void *wkup_m3_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *wkup_m3_rproc_da_to_va(struct rproc *rproc, u64 da, int len,
+				    int map)
 {
 	struct wkup_m3_rproc *wkupm3 = rproc->priv;
 	void *va = NULL;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 507a2b5..e908b58 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -356,7 +356,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-	void * (*da_to_va)(struct rproc *rproc, u64 da, int len);
+	void * (*da_to_va)(struct rproc *rproc, u64 da, int len, int map);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

