Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932598AbeDWVfB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:35:01 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:41318 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932585AbeDWVex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:34:53 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/6] x86/microcode/AMD: Add microcode container data checking functions
Date: Mon, 23 Apr 2018 23:34:07 +0200
Message-Id: <ea8b42f1d7a0fa75b2a13758f71f6c486862ab47.1524515406.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524515406.git.mail@maciej.szmigiero.name>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds verify_container(), verify_equivalence_table(),
verify_patch_section() and verify_patch() functions to the AMD microcode
update driver.
These functions check whether a passed buffer contains the relevant
structure, whether it isn't truncated and (for actual microcode patches)
whether the size of a patch is not too large for a particular CPU family.
By adding these checks as separate functions the actual microcode loading
code won't get interspersed with a lot of checks and so will be more
readable.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 140 +++++++++++++++++++++++++++++++++++-
 1 file changed, 137 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index dc8ea9a9d962..4fafaf0852d7 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -73,6 +73,142 @@ static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
 	return 0;
 }
 
+/*
+ * Checks whether there is a valid microcode container file at the beginning
+ * of a passed buffer @buf of size @size.
+ * If @early is set this function does not print errors which makes it
+ * usable by the early microcode loader.
+ */
+static bool verify_container(const u8 *buf, size_t buf_size, bool early)
+{
+	u32 cont_magic;
+
+	if (buf_size <= CONTAINER_HDR_SZ) {
+		if (!early)
+			pr_err("Truncated microcode container header.\n");
+
+		return false;
+	}
+
+	cont_magic = *(const u32 *)buf;
+	if (cont_magic != UCODE_MAGIC) {
+		if (!early)
+			pr_err("Invalid magic value (0x%08x).\n", cont_magic);
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Checks whether there is a valid, non-truncated CPU equivalence table
+ * at the beginning of a passed buffer @buf of size @size.
+ * If @early is set this function does not print errors which makes it
+ * usable by the early microcode loader.
+ */
+static bool verify_equivalence_table(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr = (const u32 *)buf;
+	u32 cont_type, equiv_tbl_len;
+
+	cont_type = hdr[1];
+	if (cont_type != UCODE_EQUIV_CPU_TABLE_TYPE) {
+		if (!early)
+			pr_err("Wrong microcode container equivalence table type: %u.\n",
+			       cont_type);
+
+		return false;
+	}
+
+	equiv_tbl_len = hdr[2];
+	if (equiv_tbl_len < sizeof(struct equiv_cpu_entry) ||
+	    buf_size - CONTAINER_HDR_SZ < equiv_tbl_len) {
+		if (!early)
+			pr_err("Truncated equivalence table.\n");
+
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Checks whether there is a valid, non-truncated microcode patch section
+ * at the beginning of a passed buffer @buf of size @size.
+ * If @early is set this function does not print errors which makes it
+ * usable by the early microcode loader.
+ */
+static bool verify_patch_section(const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr = (const u32 *)buf;
+	u32 patch_type, patch_size;
+
+	if (buf_size < SECTION_HDR_SIZE) {
+		if (!early)
+			pr_err("Truncated patch section.\n");
+
+		return false;
+	}
+
+	patch_type = hdr[0];
+	patch_size = hdr[1];
+
+	if (patch_type != UCODE_UCODE_TYPE) {
+		if (!early)
+			pr_err("Invalid type field (%u) in container file section header.\n",
+				patch_type);
+
+		return false;
+	}
+
+	if (patch_size < sizeof(struct microcode_header_amd)) {
+		if (!early)
+			pr_err("Patch of size %u too short.\n", patch_size);
+
+		return false;
+	}
+
+	if (buf_size - SECTION_HDR_SIZE < patch_size) {
+		if (!early)
+			pr_err("Patch of size %u truncated.\n", patch_size);
+
+		return false;
+	}
+
+	return true;
+}
+
+static unsigned int verify_patch_size(u8 family, u32 patch_size,
+				      unsigned int size);
+
+/*
+ * Checks whether a microcode patch located at the beginning of a passed
+ * buffer @buf of size @size is not too large for a particular @family
+ * and is not truncated.
+ * If @early is set this function does not print errors which makes it
+ * usable by the early microcode loader.
+ */
+static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
+{
+	const u32 *hdr = (const u32 *)buf;
+	u32 patch_size = hdr[1];
+
+	/*
+	 * The section header length is not included in this indicated size
+	 * but is present in the leftover file length so we need to subtract
+	 * it before passing this value to the function below.
+	 */
+	if (!verify_patch_size(family, patch_size, buf_size - SECTION_HDR_SIZE)) {
+		if (!early)
+			pr_err("Patch of size %u too large.\n", patch_size);
+
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * This scans the ucode blob for the proper container as we can have multiple
  * containers glued together. Returns the equivalence ID from the equivalence
@@ -494,10 +630,8 @@ static unsigned int verify_patch_size(u8 family, u32 patch_size, unsigned int si
 		break;
 	}
 
-	if (patch_size > min_t(u32, size, max_size)) {
-		pr_err("patch size mismatch\n");
+	if (patch_size > min_t(u32, size, max_size))
 		return 0;
-	}
 
 	return patch_size;
 }
