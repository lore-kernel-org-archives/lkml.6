Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF514C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730F72086E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="acJH0YJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 730F72086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbeKZSqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:46:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40880 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbeKZSqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:46:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7qw36043386;
        Mon, 26 Nov 2018 01:52:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218778;
        bh=7kOxLaAQ9Jp0JZcpYjcc6R3FqKlSJT75I2AzPGbOI1M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=acJH0YJZoUE0yXAugA2OAgBUx/uY9Uw7049BX3WIXdFkfZ6mbUovLttcWRXa1taQZ
         HB4b+I062PA4/mb7A4SLpCD5gLpO2pmfW4GuD0om/pVRgCpQkp29SAAEuMQxLItrpP
         ER9mxQAvjy8xSPAEVVyQxDiiijZi0gp30AXiuhGw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7qwnZ059022
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:52:58 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:52:58 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:52:58 -0600
Received: from dlelxv97.itg.ti.com (dlelxv97.itg.ti.com [172.17.2.193])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qwt2008479;
        Mon, 26 Nov 2018 01:52:58 -0600
Received: from localhost.localdomain (vboxa0400828d.dhcp.ti.com [172.22.237.3])
        by dlelxv97.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7qn1F024490;
        Mon, 26 Nov 2018 01:52:54 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <tony@atomide.com>, <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH 01/16] remoteproc: Extend rproc_da_to_va() API with a flags parameter
Date:   Mon, 26 Nov 2018 09:52:34 +0200
Message-ID: <1543218769-5507-2-git-send-email-rogerq@ti.com>
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

The rproc_da_to_va() API is currently used to perform any device
to kernel address translations to meet the different needs of the
remoteproc core/platform drivers (eg: loading). The function also
invokes the da_to_va ops, if present, to allow the remoteproc
platform drivers to provide address translation. However, not all
platform implementations have linear address spaces, and may need
an additional parameter to be able to perform proper translations.

The rproc_da_to_va() API and the rproc .da_to_va ops have therefore
been expanded to take in an additional flags field enabling some
remoteproc implementations (like the TI PRUSS remoteproc driver)
to use these flags. Also, define some semantics for this flags
argument as this can vary from one implementation to another. A
new flags type is encoded into the upper 16 bits along side the
actual value in the lower 16-bits for the flags argument, to
allow different individual implementations to have better
flexibility in interpreting the flags as per their needs.

Also, update the various remoteproc implementations that use the
.da_to_va() ops for the new signature.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/imx_rproc.c             |  2 +-
 drivers/remoteproc/keystone_remoteproc.c   |  3 ++-
 drivers/remoteproc/qcom_q6v5_mss.c         |  5 +++--
 drivers/remoteproc/qcom_q6v5_pas.c         |  2 +-
 drivers/remoteproc/qcom_q6v5_wcss.c        |  2 +-
 drivers/remoteproc/qcom_wcnss.c            |  2 +-
 drivers/remoteproc/remoteproc_core.c       | 15 ++++++++++-----
 drivers/remoteproc/remoteproc_elf_loader.c |  6 ++++--
 drivers/remoteproc/remoteproc_internal.h   |  2 +-
 drivers/remoteproc/st_slim_rproc.c         |  3 ++-
 drivers/remoteproc/wkup_m3_rproc.c         |  3 ++-
 include/linux/remoteproc.h                 | 16 +++++++++++++++-
 12 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 54c07fd..14d7f15 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -211,7 +211,7 @@ static int imx_rproc_da_to_sys(struct imx_rproc *priv, u64 da,
 	return -ENOENT;
 }
 
-static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 {
 	struct imx_rproc *priv = rproc->priv;
 	void *va = NULL;
diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index aaac311..41c4d5c 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -254,7 +254,8 @@ static void keystone_rproc_kick(struct rproc *rproc, int vqid)
  * can be used either by the remoteproc core for loading (when using kernel
  * remoteproc loader), or by any rpmsg bus drivers.
  */
-static void *keystone_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *keystone_rproc_da_to_va(struct rproc *rproc, u64 da, int len,
+				     u32 flags)
 {
 	struct keystone_rproc *ksproc = rproc->priv;
 	void __iomem *va = NULL;
diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 01be731..3b77e12 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -971,7 +971,8 @@ static void qcom_q6v5_dump_segment(struct rproc *rproc,
 	int ret = 0;
 	struct q6v5 *qproc = rproc->priv;
 	unsigned long mask = BIT((unsigned long)segment->priv);
-	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+	void *ptr = rproc_da_to_va(rproc, segment->da, segment->size,
+				   RPROC_FLAGS_NONE);
 
 	/* Unlock mba before copying segments */
 	if (!qproc->dump_mba_loaded)
@@ -1052,7 +1053,7 @@ static int q6v5_stop(struct rproc *rproc)
 	return 0;
 }
 
-static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *q6v5_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 {
 	struct q6v5 *qproc = rproc->priv;
 	int offset;
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index b1e63fc..46e1c6b 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -167,7 +167,7 @@ static int adsp_stop(struct rproc *rproc)
 	return ret;
 }
 
-static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *adsp_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
 	int offset;
diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
index f93e1e4..5b4d4c6 100644
--- a/drivers/remoteproc/qcom_q6v5_wcss.c
+++ b/drivers/remoteproc/qcom_q6v5_wcss.c
@@ -406,7 +406,7 @@ static int q6v5_wcss_stop(struct rproc *rproc)
 	return 0;
 }
 
-static void *q6v5_wcss_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *q6v5_wcss_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 {
 	struct q6v5_wcss *wcss = rproc->priv;
 	int offset;
diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index b0e07e9..eb7d4b9 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -295,7 +295,7 @@ static int wcnss_stop(struct rproc *rproc)
 	return ret;
 }
 
-static void *wcnss_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *wcnss_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 {
 	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
 	int offset;
diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 54ec38f..39458a7 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -166,6 +166,7 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
  * @rproc: handle of a remote processor
  * @da: remoteproc device address to translate
  * @len: length of the memory region @da is pointing to
+ * @flags: flags to pass onto platform implementations for aiding translations
  *
  * Some remote processors will ask us to allocate them physically contiguous
  * memory regions (which we call "carveouts"), and map them to specific
@@ -181,7 +182,10 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
  * carveouts and translate specific device addresses to kernel virtual addresses
  * so we can access the referenced memory. This function also allows to perform
  * translations on the internal remoteproc memory regions through a platform
- * implementation specific da_to_va ops, if present.
+ * implementation specific da_to_va ops, if present. The @flags field is passed
+ * onto these ops to aid the translation within the ops implementation. The
+ * @flags field is to be passed as a combination of the RPROC_FLAGS_xxx type
+ * and the pertinent flags value for that type.
  *
  * The function returns a valid kernel address on success or NULL on failure.
  *
@@ -190,13 +194,13 @@ static phys_addr_t rproc_va_to_pa(void *cpu_addr)
  * here the output of the DMA API for the carveouts, which should be more
  * correct.
  */
-void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags)
 {
 	struct rproc_mem_entry *carveout;
 	void *ptr = NULL;
 
 	if (rproc->ops->da_to_va) {
-		ptr = rproc->ops->da_to_va(rproc, da, len);
+		ptr = rproc->ops->da_to_va(rproc, da, len, flags);
 		if (ptr)
 			goto out;
 	}
@@ -575,7 +579,7 @@ static int rproc_handle_trace(struct rproc *rproc, struct fw_rsc_trace *rsc,
 	}
 
 	/* what's the kernel address of this resource ? */
-	ptr = rproc_da_to_va(rproc, rsc->da, rsc->len);
+	ptr = rproc_da_to_va(rproc, rsc->da, rsc->len, RPROC_FLAGS_NONE);
 	if (!ptr) {
 		dev_err(dev, "erroneous trace resource entry\n");
 		return -EINVAL;
@@ -1549,7 +1553,8 @@ static void rproc_coredump(struct rproc *rproc)
 		if (segment->dump) {
 			segment->dump(rproc, segment, data + offset);
 		} else {
-			ptr = rproc_da_to_va(rproc, segment->da, segment->size);
+			ptr = rproc_da_to_va(rproc, segment->da, segment->size,
+					     RPROC_FLAGS_NONE);
 			if (!ptr) {
 				dev_err(&rproc->dev,
 					"invalid coredump segment (%pad, %zu)\n",
diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index b17d72e..fff2e0b 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -182,7 +182,8 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 		}
 
 		/* grab the kernel address for this device address */
-		ptr = rproc_da_to_va(rproc, da, memsz);
+		ptr = rproc_da_to_va(rproc, da, memsz,
+				     RPROC_FLAGS_ELF_PHDR | phdr->p_flags);
 		if (!ptr) {
 			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
 			ret = -EINVAL;
@@ -333,6 +334,7 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 	if (!shdr)
 		return NULL;
 
-	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size);
+	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size,
+			      RPROC_FLAGS_ELF_SHDR | shdr->sh_flags);
 }
 EXPORT_SYMBOL(rproc_elf_find_loaded_rsc_table);
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f6cad24..c62b3e7 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -51,7 +51,7 @@ void rproc_exit_sysfs(void);
 void rproc_free_vring(struct rproc_vring *rvring);
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
 
-void *rproc_da_to_va(struct rproc *rproc, u64 da, int len);
+void *rproc_da_to_va(struct rproc *rproc, u64 da, int len, u32 flags);
 int rproc_trigger_recovery(struct rproc *rproc);
 
 int rproc_elf_sanity_check(struct rproc *rproc, const struct firmware *fw);
diff --git a/drivers/remoteproc/st_slim_rproc.c b/drivers/remoteproc/st_slim_rproc.c
index d711d94..c41e58c 100644
--- a/drivers/remoteproc/st_slim_rproc.c
+++ b/drivers/remoteproc/st_slim_rproc.c
@@ -178,7 +178,8 @@ static int slim_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
-static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *slim_rproc_da_to_va(struct rproc *rproc, u64 da, int len,
+				 u32 flags)
 {
 	struct st_slim_rproc *slim_rproc = rproc->priv;
 	void *va = NULL;
diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 1ada0e5..eff7497 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -88,7 +88,8 @@ static int wkup_m3_rproc_stop(struct rproc *rproc)
 	return 0;
 }
 
-static void *wkup_m3_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
+static void *wkup_m3_rproc_da_to_va(struct rproc *rproc, u64 da, int len,
+				    u32 flags)
 {
 	struct wkup_m3_rproc *wkupm3 = rproc->priv;
 	void *va = NULL;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 68e72f3..9e01a44 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -41,6 +41,7 @@
 #include <linux/completion.h>
 #include <linux/idr.h>
 #include <linux/of.h>
+#include <linux/bitops.h>
 
 /**
  * struct resource_table - firmware resource table header
@@ -339,6 +340,19 @@ struct rproc_mem_entry {
 
 struct firmware;
 
+/*
+ * Macros to use with flags field in rproc_da_to_va API. Use
+ * the upper 16 bits to dictate the flags type and the lower
+ * 16 bits to pass on the value of the flags pertinent to that
+ * type.
+ *
+ * Add any new flags type at a new bit-field position
+ */
+#define RPROC_FLAGS_SHIFT	16
+#define RPROC_FLAGS_NONE	0
+#define RPROC_FLAGS_ELF_PHDR	BIT(0 + RPROC_FLAGS_SHIFT)
+#define RPROC_FLAGS_ELF_SHDR	BIT(1 + RPROC_FLAGS_SHIFT)
+
 /**
  * struct rproc_ops - platform-specific device handlers
  * @start:	power on the device and boot it
@@ -356,7 +370,7 @@ struct rproc_ops {
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-	void * (*da_to_va)(struct rproc *rproc, u64 da, int len);
+	void * (*da_to_va)(struct rproc *rproc, u64 da, int len, u32 flags);
 	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
 	struct resource_table *(*find_loaded_rsc_table)(
 				struct rproc *rproc, const struct firmware *fw);
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

