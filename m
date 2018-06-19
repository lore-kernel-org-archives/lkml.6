Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41443C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A28020661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A28020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030560AbeFSStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:49:14 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39616 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030366AbeFSSrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:51 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfJ-0003W4-3E; Tue, 19 Jun 2018 20:47:41 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/9] x86/microcode/AMD: Check microcode container data in the late loader
Date:   Tue, 19 Jun 2018 20:47:36 +0200
Message-Id: <ca5f0606b9e3591b4b2e9fba27a90498cb3547b8.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the late loader in the AMD microcode update driver to use newly
introduced microcode container data checking functions as it was previously
done for the early loader.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 67 +++++++++++++----------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9e29374ce4d0..2dbdd7951475 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -717,28 +717,26 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return UCODE_UPDATED;
 }
 
-static int install_equiv_cpu_table(const u8 *buf)
+static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
-	unsigned int *ibuf = (unsigned int *)buf;
-	unsigned int type = ibuf[1];
-	unsigned int size = ibuf[2];
+	const u32 *hdr;
+	u32 equiv_tbl_len;
 
-	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
-		pr_err("empty section/"
-		       "invalid type field in container file section header\n");
-		return -EINVAL;
-	}
+	if (!verify_equivalence_table(buf, buf_size, false))
+		return 0;
+
+	hdr = (const u32 *)buf;
+	equiv_tbl_len = hdr[2];
 
-	equiv_cpu_table = vmalloc(size);
+	equiv_cpu_table = vmalloc(equiv_tbl_len);
 	if (!equiv_cpu_table) {
 		pr_err("failed to allocate equivalent CPU table\n");
-		return -ENOMEM;
+		return 0;
 	}
 
-	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
+	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 
-	/* add header length */
-	return size + CONTAINER_HDR_SZ;
+	return equiv_tbl_len;
 }
 
 static void free_equiv_cpu_table(void)
@@ -763,14 +761,18 @@ static void cleanup(void)
 static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 				unsigned int *crnt_size)
 {
+	const u32 *hdr;
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size;
+	u32 patch_size;
 	u32 proc_fam;
 	u16 proc_id;
 
-	patch_size  = *(u32 *)(fw + 4);
-	*crnt_size  = patch_size + SECTION_HDR_SIZE;
+	if (!verify_patch(family, fw, leftover, crnt_size, false))
+		return 0;
+
+	hdr = (const u32 *)fw;
+	patch_size  = hdr[1];
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
 
@@ -791,11 +793,6 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 		return 0;
 	}
 
-	if (!verify_patch(family, fw, leftover, crnt_size, false)) {
-		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
-		return 0;
-	}
-
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
 	if (!patch) {
 		pr_err("Patch allocation failure.\n");
@@ -828,21 +825,19 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	enum ucode_state ret = UCODE_ERROR;
 	unsigned int leftover;
 	u8 *fw = (u8 *)data;
-	int offset;
+	unsigned int offset;
 
-	offset = install_equiv_cpu_table(data);
-	if (offset < 0) {
-		pr_err("failed to create equivalent cpu table\n");
+	offset = install_equiv_cpu_table(data, size);
+	if (!offset)
 		return ret;
-	}
-	fw += offset;
-	leftover = size - offset;
 
-	if (*(u32 *)fw != UCODE_UCODE_TYPE) {
-		pr_err("invalid type field in container file section header\n");
-		free_equiv_cpu_table();
-		return ret;
-	}
+	/*
+	 * Skip also the container header, since install_equiv_cpu_table()
+	 * returns just the raw equivalence table size without the header.
+	 */
+	fw += CONTAINER_HDR_SZ;
+	fw += offset;
+	leftover = size - CONTAINER_HDR_SZ - offset;
 
 	while (leftover) {
 		unsigned int crnt_size;
@@ -930,10 +925,8 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
-	if (*(u32 *)fw->data != UCODE_MAGIC) {
-		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
+	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
-	}
 
 	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
