Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9146C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8712082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iaV7fXeF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbfBDOYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43182 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfBDOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENK65031831;
        Mon, 4 Feb 2019 08:23:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290200;
        bh=aQ07n4dTRhZW4jPqtL1fwT+4odc4r2dow30BwK9E+w8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iaV7fXeFoHKr94AWTx1zRW8z+rq/Lh6p+d4TbN9hh2XifdJUw5fHifVLWRt3/HDcI
         L/cs9O4JZV0MKTA9aC8ACWUp/L6iXH11xwLZXAWRxPdAraR4VcGvZ5JwkWMsUtGOMi
         /9ylDL6lNkKiadx2z2GqqM6z4MDN7dhEk9kmf+Dk=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENJZo115822
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:20 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:19 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:19 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKe012232;
        Mon, 4 Feb 2019 08:23:16 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH v2 06/14] remoteproc: add page lookup for TI PRU to ELF loader
Date:   Mon, 4 Feb 2019 16:22:39 +0200
Message-ID: <1549290167-876-7-git-send-email-rogerq@ti.com>
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

This adds a special handler to the default remoteproc ELF firmware
loader that looks up the memory map on TI PRU firmware files.

These processors have multiple memory maps that share the same address
space, so we need to know the page in addition to the physical address
in order to translate the address to a local CPU address.

Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 117 +++++++++++++++++++++++++++--
 include/uapi/linux/elf-em.h                |   1 +
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 8888d39..79c9d39 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -32,6 +32,103 @@
 
 #include "remoteproc_internal.h"
 
+#define SHT_TI_PHATTRS 0x7F000004
+#define SHT_TI_SH_PAGE 0x7F000007
+
+struct elf32_ti_phattrs {
+	Elf32_Half pha_seg_id; /* Segment id */
+	Elf32_Half pha_tag_id; /* Attribute kind id */
+	union {
+		Elf32_Off pha_offset; /* byte offset within the section */
+		Elf32_Word pha_value; /* Constant tag value */
+	} pha_un;
+};
+
+/* this struct is reverse engineered, so not sure what most of the values are */
+struct ti_section_page {
+	u32 unk0;
+	u32 unk1;
+	u32 unk2;
+	u32 unk3;
+	u32 unk4;
+	u16 size;
+	u16 unk5;
+	u16 unk6;
+	u8 data[0]; /* array of size */
+};
+
+/**
+ * rproc_elf_segment_to_map() - Gets memory map for segment
+ * @id: segment id
+ * @elf_data: pointer to ELF file data
+ *
+ * Returns the memory map for the segment.
+ */
+static int rproc_elf_segment_to_map(u32 id, const u8 *elf_data)
+{
+	struct elf32_hdr *ehdr;
+	struct elf32_shdr *shdr;
+	struct elf32_ti_phattrs *ti_attrs = NULL;
+	int i;
+
+	ehdr = (struct elf32_hdr *)elf_data;
+	shdr = (struct elf32_shdr *)(elf_data + ehdr->e_shoff);
+
+	if (ehdr->e_machine != EM_TI_PRU)
+		return 0;
+
+	for (i = 0; i < ehdr->e_shnum; i++, shdr++) {
+		if (shdr->sh_type == SHT_TI_PHATTRS) {
+			ti_attrs = (struct elf32_ti_phattrs *)(elf_data + shdr->sh_offset);
+			break;
+		}
+	}
+
+	if (!ti_attrs)
+		return 0;
+
+	/* list is terminated by tag id == 0 (PHA_NULL) */
+	for (; ti_attrs->pha_tag_id; ti_attrs++) {
+		if (ti_attrs->pha_tag_id == 3 && ti_attrs->pha_seg_id == id)
+			return ti_attrs->pha_un.pha_value;
+	}
+
+	return 0;
+}
+
+/**
+ * rproc_elf_section_to_map() - Gets memory map for section
+ * @id: segment id
+ * @elf_data: pointer to ELF file data
+ *
+ * Returns the memory map for the section.
+ */
+static int rproc_elf_section_to_map(u32 id, const u8 *elf_data)
+{
+	struct elf32_hdr *ehdr;
+	struct elf32_shdr *shdr;
+	struct ti_section_page *map = NULL;
+	int i;
+
+	ehdr = (struct elf32_hdr *)elf_data;
+	shdr = (struct elf32_shdr *)(elf_data + ehdr->e_shoff);
+
+	if (ehdr->e_machine != EM_TI_PRU)
+		return 0;
+
+	for (i = 0; i < ehdr->e_shnum; i++, shdr++) {
+		if (shdr->sh_type == SHT_TI_SH_PAGE) {
+			map = (struct ti_section_page *)(elf_data + shdr->sh_offset);
+			break;
+		}
+	}
+
+	if (!map || id >= map->size)
+		return 0;
+
+	return map->data[id];
+}
+
 /**
  * rproc_elf_sanity_check() - Sanity Check ELF firmware image
  * @rproc: the remote processor handle
@@ -147,7 +244,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 	struct device *dev = &rproc->dev;
 	struct elf32_hdr *ehdr;
 	struct elf32_phdr *phdr;
-	int i, ret = 0;
+	int i, map, ret = 0;
 	const u8 *elf_data = fw->data;
 
 	ehdr = (struct elf32_hdr *)elf_data;
@@ -181,8 +278,10 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 			break;
 		}
 
+		map = rproc_elf_segment_to_map(i, elf_data);
+
 		/* grab the kernel address for this device address */
-		ptr = rproc_da_to_va(rproc, da, memsz, 0);
+		ptr = rproc_da_to_va(rproc, da, memsz, map);
 		if (!ptr) {
 			dev_err(dev, "bad phdr da 0x%x mem 0x%x\n", da, memsz);
 			ret = -EINVAL;
@@ -209,7 +308,7 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw)
 EXPORT_SYMBOL(rproc_elf_load_segments);
 
 static struct elf32_shdr *
-find_table(struct device *dev, struct elf32_hdr *ehdr, size_t fw_size)
+find_table(struct device *dev, struct elf32_hdr *ehdr, size_t fw_size, int *id)
 {
 	struct elf32_shdr *shdr;
 	int i;
@@ -261,6 +360,9 @@ find_table(struct device *dev, struct elf32_hdr *ehdr, size_t fw_size)
 			return NULL;
 		}
 
+		if (id)
+			*id = i;
+
 		return shdr;
 	}
 
@@ -288,7 +390,7 @@ int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw)
 
 	ehdr = (struct elf32_hdr *)elf_data;
 
-	shdr = find_table(dev, ehdr, fw->size);
+	shdr = find_table(dev, ehdr, fw->size, NULL);
 	if (!shdr)
 		return -EINVAL;
 
@@ -328,11 +430,14 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 {
 	struct elf32_hdr *ehdr = (struct elf32_hdr *)fw->data;
 	struct elf32_shdr *shdr;
+	int id, map;
 
-	shdr = find_table(&rproc->dev, ehdr, fw->size);
+	shdr = find_table(&rproc->dev, ehdr, fw->size, &id);
 	if (!shdr)
 		return NULL;
 
-	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size, 0);
+	map = rproc_elf_section_to_map(id, fw->data);
+
+	return rproc_da_to_va(rproc, shdr->sh_addr, shdr->sh_size, map);
 }
 EXPORT_SYMBOL(rproc_elf_find_loaded_rsc_table);
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 0c3000fa..70b487a 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -38,6 +38,7 @@
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_TI_PRU	144	/* TI Programmable Realtime Unit */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

