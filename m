Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752716AbeESWId (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:08:33 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49442 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752586AbeESWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:48 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 5/8] x86/microcode/AMD: Check microcode container data in the late loader
Date: Sun, 20 May 2018 00:07:19 +0200
Message-Id: <32c2d5a36010a7e9e538f081d4f3a8e8c94da890.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526767245.git.mail@maciej.szmigiero.name>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the late loader in the AMD microcode update driver to use newly
introduced microcode container data checking functions as it was previously
done for the early loader.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 70 +++++++++++++----------------
 1 file changed, 32 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f8bd74341ed8..3e10a5920f58 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -693,28 +693,26 @@ static enum ucode_state apply_microcode_amd(int cpu)
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
@@ -739,13 +737,19 @@ static void cleanup(void)
 static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 				unsigned int *crnt_size)
 {
+	u32 *hdr = (u32 *)fw;
 	struct microcode_header_amd *mc_hdr;
 	struct ucode_patch *patch;
-	unsigned int patch_size, ret;
+	u32 patch_size;
 	u32 proc_fam;
 	u16 proc_id;
 
-	patch_size  = *(u32 *)(fw + 4);
+	if (!verify_patch_section(fw, leftover, false)) {
+		*crnt_size = leftover;
+		return 0;
+	}
+
+	patch_size  = hdr[1];
 	*crnt_size  = patch_size + SECTION_HDR_SIZE;
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
@@ -767,16 +771,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover,
 		return 0;
 	}
 
-	/*
-	 * The section header length is not included in this indicated size
-	 * but is present in the leftover file length so we need to subtract
-	 * it before passing this value to the function below.
-	 */
-	ret = verify_patch_size(family, patch_size, leftover - SECTION_HDR_SIZE);
-	if (!ret) {
-		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
+	if (!verify_patch(family, fw, leftover, false))
 		return 0;
-	}
 
 	patch = kzalloc(sizeof(*patch), GFP_KERNEL);
 	if (!patch) {
@@ -810,21 +806,21 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	enum ucode_state ret = UCODE_ERROR;
 	unsigned int leftover;
 	u8 *fw = (u8 *)data;
-	int offset;
+	unsigned int offset;
 
-	offset = install_equiv_cpu_table(data);
-	if (offset < 0) {
+	offset = install_equiv_cpu_table(data, size);
+	if (!offset) {
 		pr_err("failed to create equivalent cpu table\n");
 		return ret;
 	}
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
@@ -912,10 +908,8 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
-	if (*(u32 *)fw->data != UCODE_MAGIC) {
-		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
+	if (!verify_container(fw->data, fw->size, false))
 		goto fw_release;
-	}
 
 	ret = load_microcode_amd(bsp, c->x86, fw->data, fw->size);
 
