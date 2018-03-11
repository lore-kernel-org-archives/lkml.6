Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeCKP1I (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 11:27:08 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:53678 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932155AbeCKP1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 11:27:07 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v2] x86/microcode/AMD: check microcode file sanity before
 loading it
To: Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <787b0ecc-8c1a-3b5a-82e0-9840c7b7c595@maciej.szmigiero.name>
Date: Sun, 11 Mar 2018 16:27:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Language: en-US
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, it is very easy to make the AMD microcode update driver crash
or spin on a malformed microcode file since it does very little
consistency checking on data loaded from such file.

This commit introduces various checks, mostly on length-type fields, so
all corrupted microcode files are (hopefully) correctly rejected instead.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: Capitalize a comment, rename 'eqsize' and 'bufsize'
to 'eq_size' and 'buf_size', respectively, attach a comment about
checking the equivalence table header to its first size check, rename
'equiv{_cpu,}_table_size' to 'equiv{_cpu,}_table_entries'.

Test files are at https://pastebin.com/XkKUSmMp
One has to enable KASAN in the kernel config and rename a particular
test file to name appropriate to the running CPU family to test its
loading.

 arch/x86/include/asm/microcode_amd.h |   6 ++
 arch/x86/kernel/cpu/microcode/amd.c  | 112 ++++++++++++++++++++++++++---------
 2 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/microcode_amd.h b/arch/x86/include/asm/microcode_amd.h
index 209492849566..373a202ea569 100644
--- a/arch/x86/include/asm/microcode_amd.h
+++ b/arch/x86/include/asm/microcode_amd.h
@@ -19,6 +19,9 @@ struct equiv_cpu_entry {
 	u16	res;
 } __attribute__((packed));
 
+/* 4k */
+#define UCODE_EQUIV_CPU_TABLE_MAX_SIZE (256 * sizeof(struct equiv_cpu_entry))
+
 struct microcode_header_amd {
 	u32	data_code;
 	u32	patch_id;
@@ -41,6 +44,9 @@ struct microcode_amd {
 	unsigned int			mpb[0];
 };
 
+/* If a patch is larger than this the microcode file is surely corrupted */
+#define PATCH_MAX_SIZE_ABSOLUTE (16 * 1024 * 1024)
+
 #define PATCH_MAX_SIZE PAGE_SIZE
 
 #ifdef CONFIG_MICROCODE_AMD
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index a998e1a7d46f..1cbccf79ff68 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -39,6 +39,7 @@
 #include <asm/msr.h>
 
 static struct equiv_cpu_entry *equiv_cpu_table;
+static unsigned int equiv_cpu_table_entries;
 
 /*
  * This points to the current valid container of microcode patches which we will
@@ -63,12 +64,18 @@ static u8 amd_ucode_patch[PATCH_MAX_SIZE];
 static const char
 ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
 
-static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
+static u16 find_equiv_id(const struct equiv_cpu_entry *equiv_table,
+			 unsigned int equiv_table_entries, u32 sig)
 {
-	for (; equiv_table && equiv_table->installed_cpu; equiv_table++) {
-		if (sig == equiv_table->installed_cpu)
-			return equiv_table->equiv_cpu;
-	}
+	unsigned int i;
+
+	if (!equiv_table)
+		return 0;
+
+	for (i = 0; i < equiv_table_entries && equiv_table[i].installed_cpu;
+	     i++)
+		if (sig == equiv_table[i].installed_cpu)
+			return equiv_table[i].equiv_cpu;
 
 	return 0;
 }
@@ -80,29 +87,41 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
  * Returns the amount of bytes consumed while scanning. @desc contains all the
  * data we're going to use in later stages of the application.
  */
-static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
+static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 {
 	struct equiv_cpu_entry *eq;
-	ssize_t orig_size = size;
+	size_t orig_size = size;
 	u32 *hdr = (u32 *)ucode;
+	u32 eq_size;
 	u16 eq_id;
 	u8 *buf;
 
 	/* Am I looking at an equivalence table header? */
+	if (size < CONTAINER_HDR_SZ)
+		return 0;
+
 	if (hdr[0] != UCODE_MAGIC ||
 	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
 	    hdr[2] == 0)
 		return CONTAINER_HDR_SZ;
 
+	eq_size = hdr[2];
+	if (eq_size < sizeof(*eq) ||
+	    eq_size > UCODE_EQUIV_CPU_TABLE_MAX_SIZE)
+		return 0;
+
+	if (size < CONTAINER_HDR_SZ + eq_size)
+		return 0;
+
 	buf = ucode;
 
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/* Find the equivalence ID of our CPU in this table: */
-	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(eq, eq_size / sizeof(*eq), desc->cpuid_1_eax);
 
-	buf  += hdr[2] + CONTAINER_HDR_SZ;
-	size -= hdr[2] + CONTAINER_HDR_SZ;
+	buf  += eq_size + CONTAINER_HDR_SZ;
+	size -= eq_size + CONTAINER_HDR_SZ;
 
 	/*
 	 * Scan through the rest of the container to find where it ends. We do
@@ -112,6 +131,9 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 		struct microcode_amd *mc;
 		u32 patch_size;
 
+		if (size < SECTION_HDR_SIZE)
+			break;
+
 		hdr = (u32 *)buf;
 
 		if (hdr[0] != UCODE_UCODE_TYPE)
@@ -126,6 +148,10 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 		buf  += SECTION_HDR_SIZE;
 		size -= SECTION_HDR_SIZE;
 
+		if (size < sizeof(*mc) ||
+		    size < patch_size)
+			break;
+
 		mc = (struct microcode_amd *)buf;
 		if (eq_id == mc->hdr.processor_rev_id) {
 			desc->psize = patch_size;
@@ -159,15 +185,13 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
  */
 static void scan_containers(u8 *ucode, size_t size, struct cont_desc *desc)
 {
-	ssize_t rem = size;
-
-	while (rem >= 0) {
-		ssize_t s = parse_container(ucode, rem, desc);
+	while (size > 0) {
+		size_t s = parse_container(ucode, size, desc);
 		if (!s)
 			return;
 
 		ucode += s;
-		rem   -= s;
+		size  -= s;
 	}
 }
 
@@ -364,20 +388,21 @@ void reload_ucode_amd(void)
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
+	return find_equiv_id(equiv_cpu_table, equiv_cpu_table_entries,
+			     uci->cpu_sig.sig);
 }
 
 static u32 find_cpu_family_by_equiv_cpu(u16 equiv_cpu)
 {
-	int i = 0;
+	unsigned int i;
 
 	BUG_ON(!equiv_cpu_table);
 
-	while (equiv_cpu_table[i].equiv_cpu != 0) {
+	for (i = 0; i < equiv_cpu_table_entries &&
+		     equiv_cpu_table[i].equiv_cpu != 0; i++)
 		if (equiv_cpu == equiv_cpu_table[i].equiv_cpu)
 			return equiv_cpu_table[i].installed_cpu;
-		i++;
-	}
+
 	return 0;
 }
 
@@ -540,15 +565,31 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	return UCODE_UPDATED;
 }
 
-static int install_equiv_cpu_table(const u8 *buf)
+static int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	unsigned int *ibuf = (unsigned int *)buf;
-	unsigned int type = ibuf[1];
-	unsigned int size = ibuf[2];
+	unsigned int type, size;
 
-	if (type != UCODE_EQUIV_CPU_TABLE_TYPE || !size) {
-		pr_err("empty section/"
-		       "invalid type field in container file section header\n");
+	if (buf_size < CONTAINER_HDR_SZ) {
+		pr_err("no container header\n");
+		return -EINVAL;
+	}
+
+	type = ibuf[1];
+	if (type != UCODE_EQUIV_CPU_TABLE_TYPE) {
+		pr_err("invalid type field in container file section header\n");
+		return -EINVAL;
+	}
+
+	size = ibuf[2];
+	if (size < sizeof(struct equiv_cpu_entry) ||
+	    size > UCODE_EQUIV_CPU_TABLE_MAX_SIZE) {
+		pr_err("equivalent CPU table size invalid\n");
+		return -EINVAL;
+	}
+
+	if (buf_size < CONTAINER_HDR_SZ + size) {
+		pr_err("equivalent CPU table truncated\n");
 		return -EINVAL;
 	}
 
@@ -559,6 +600,7 @@ static int install_equiv_cpu_table(const u8 *buf)
 	}
 
 	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, size);
+	equiv_cpu_table_entries = size / sizeof(struct equiv_cpu_entry);
 
 	/* add header length */
 	return size + CONTAINER_HDR_SZ;
@@ -568,6 +610,7 @@ static void free_equiv_cpu_table(void)
 {
 	vfree(equiv_cpu_table);
 	equiv_cpu_table = NULL;
+	equiv_cpu_table_entries = 0;
 }
 
 static void cleanup(void)
@@ -591,7 +634,15 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 	u32 proc_fam;
 	u16 proc_id;
 
+	if (leftover < SECTION_HDR_SIZE + sizeof(*mc_hdr))
+		return leftover;
+
 	patch_size  = *(u32 *)(fw + 4);
+	if (patch_size > PATCH_MAX_SIZE_ABSOLUTE) {
+		pr_err("mammoth patch size %u\n", patch_size);
+		return -EINVAL;
+	}
+
 	crnt_size   = patch_size + SECTION_HDR_SIZE;
 	mc_hdr	    = (struct microcode_header_amd *)(fw + SECTION_HDR_SIZE);
 	proc_id	    = mc_hdr->processor_rev_id;
@@ -613,7 +664,8 @@ static int verify_and_add_patch(u8 family, u8 *fw, unsigned int leftover)
 		return crnt_size;
 	}
 
-	ret = verify_patch_size(family, patch_size, leftover);
+	ret = verify_patch_size(family, patch_size,
+				leftover - SECTION_HDR_SIZE);
 	if (!ret) {
 		pr_err("Patch-ID 0x%08x: size mismatch.\n", mc_hdr->patch_id);
 		return crnt_size;
@@ -654,7 +706,7 @@ static enum ucode_state __load_microcode_amd(u8 family, const u8 *data,
 	int crnt_size = 0;
 	int offset;
 
-	offset = install_equiv_cpu_table(data);
+	offset = install_equiv_cpu_table(data, size);
 	if (offset < 0) {
 		pr_err("failed to create equivalent cpu table\n");
 		return ret;
@@ -745,6 +797,10 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	}
 
 	ret = UCODE_ERROR;
+	if (fw->size < sizeof(u32)) {
+		pr_err("microcode far too short\n");
+		goto fw_release;
+	}
 	if (*(u32 *)fw->data != UCODE_MAGIC) {
 		pr_err("invalid magic value (0x%08x)\n", *(u32 *)fw->data);
 		goto fw_release;
