Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C284C43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC16724D0E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 21:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="wMBBA13m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC16724D0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeFWVLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 17:11:20 -0400
Received: from vern.gendns.com ([206.190.152.46]:36165 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751637AbeFWVJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 17:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=References:In-Reply-To:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lSgwewMcm/apejmQpE4qQ1jpAR8vjxD4m3ut62rWC3g=; b=wMBBA13mcm1rnIwrfm3U7MbU0
        9R6gJ05nDWQ5ZlCRTZFGL9zyZ/I+1eIkf0T1gufOkzhQG9Ik2LrwBoBuoJKiTLqR8iIyHP2gNjkXo
        43kYh+27snG6MlN0T6Pyzv7K1GpTH4hE6ZeVlTx453R2UEs4eGbY1sSUra+4KkdeABH8a8Yh88tvm
        Eodt/UhjoqX6zJEnQU/eIhWYgImYUII+Zd9mIYzd6FSBMU7hHCSwPGbhx7z2BhEHZRpq9hSOmr0gl
        MNn49Q65ci58X42a0sQ9Mm2BVQBhma8fSTwUYdWCulNpFZzgWl8TE7tfG+ch3KBkXp6gG6sr7/12E
        n58c6+8qA==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:51098 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1fWpmf-00CkwS-Jy; Sat, 23 Jun 2018 17:09:25 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     David Lechner <david@lechnology.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] remoteproc: add page lookup for TI PRU to ELF loader
Date:   Sat, 23 Jun 2018 16:08:04 -0500
Message-Id: <20180623210810.21232-3-david@lechnology.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a special handler to the default remoteproc ELF firmware
loader that looks up the memory map on TI PRU firmware files.

These processors have multiple memory maps that share the same address
space, so we need to know the page in addition to the physical address
in order to translate the address to a local CPU address.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 117 +++++++++++++++++++--
 include/uapi/linux/elf-em.h                |   1 +
 2 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index 8888d39e1b13..f041b6fb798f 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -32,6 +32,103 @@
 
 #include "remoteproc_internal.h"
 
+#define SHT_TI_PHATTRS 0x7F000004
+#define SHT_TI_SH_PAGE 0x7F000007
+
+typedef struct {
+	Elf32_Half pha_seg_id; /* Segment id */
+	Elf32_Half pha_tag_id; /* Attribute kind id */
+	union {
+		Elf32_Off pha_offset; /* byte offset within the section */
+		Elf32_Word pha_value; /* Constant tag value */
+	} pha_un;
+} Elf32_TI_PHAttrs;
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
+	Elf32_TI_PHAttrs *attrs = NULL;
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
+			attrs = (Elf32_TI_PHAttrs *)(elf_data + shdr->sh_offset);
+			break;
+		}
+	}
+
+	if (!attrs)
+		return 0;
+
+	/* list is terminated by tag id == 0 (PHA_NULL) */
+	for (; attrs->pha_tag_id; attrs++) {
+		if (attrs->pha_tag_id == 3 && attrs->pha_seg_id == id)
+			return attrs->pha_un.pha_value;
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
index 31aa10178335..ce114abc7a50 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -37,6 +37,7 @@
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
 #define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
+#define EM_TI_PRU	144	/* TI Programmable Realtime Unit */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_TILEPRO	188	/* Tilera TILEPro */
 #define EM_MICROBLAZE	189	/* Xilinx MicroBlaze */
-- 
2.17.1

