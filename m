Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752733AbeESWIe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:08:34 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49448 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752594AbeESWHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:48 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/8] x86/microcode/AMD: Don't scan past the CPU equivalence table data
Date: Sun, 20 May 2018 00:07:22 +0200
Message-Id: <04a252b1e06673b8a1f62196093d0573d302fc1b.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526767245.git.mail@maciej.szmigiero.name>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the code scanning a CPU equivalence table read from a microcode
container file assumes that it actually contains a terminating zero entry,
but if does not then the code will continue the scan past its valid data.

For the late loader this can be improved by always appending a terminating
zero entry to such table when loading it.
This way we don't need an extra global variable for holding the table size
and we don't have to reject such incomplete tables (for backward
compatibility with the existing code which didn't do so).

For the early loader, since we can't allocate memory and have to work
in-place, let's pass an explicit size of this table to its scanning
functions so they will know when to stop.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 46 ++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index cc38182c76d2..f443aede50d5 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -63,12 +63,18 @@ static u8 amd_ucode_patch[PATCH_MAX_SIZE];
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
@@ -273,7 +279,8 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/* Find the equivalence ID of our CPU in this table: */
-	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(eq, equiv_tbl_len / sizeof(*eq),
+			      desc->cpuid_1_eax);
 
 	buf  += CONTAINER_HDR_SZ;
 	buf  += equiv_tbl_len;
@@ -540,12 +547,14 @@ void reload_ucode_amd(void)
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
+
+	/* install_equiv_cpu_table() guarantees us a terminating entry */
+	return find_equiv_id(equiv_cpu_table, UINT_MAX, uci->cpu_sig.sig);
 }
 
 static u32 find_cpu_family_by_equiv_cpu(u16 equiv_cpu)
 {
-	int i = 0;
+	unsigned int i = 0;
 
 	BUG_ON(!equiv_cpu_table);
 
@@ -683,20 +692,37 @@ static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 {
 	const u32 *hdr;
 	u32 equiv_tbl_len;
+	unsigned int equiv_tbl_entries;
+	const unsigned int equiv_tbl_entries_max =
+		UINT_MAX / sizeof(struct equiv_cpu_entry);
 
 	if (!verify_equivalence_table(buf, buf_size, false))
 		return 0;
 
 	hdr = (const u32 *)buf;
 	equiv_tbl_len = hdr[2];
+	equiv_tbl_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
-	equiv_cpu_table = vmalloc(equiv_tbl_len);
+	/*
+	 * Make space for a terminating entry. If there is no space left we
+	 * reuse the last entry instead.
+	 */
+	if (equiv_tbl_entries < equiv_tbl_entries_max)
+		equiv_tbl_entries++;
+
+	equiv_cpu_table = vmalloc(equiv_tbl_entries *
+				  sizeof(struct equiv_cpu_entry));
 	if (!equiv_cpu_table) {
 		pr_err("failed to allocate equivalent CPU table\n");
 		return 0;
 	}
 
-	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ,
+	       (equiv_tbl_entries - 1) * sizeof(struct equiv_cpu_entry));
+
+	/* Set up the terminating entry. */
+	memset(&equiv_cpu_table[equiv_tbl_entries - 1], 0,
+	       sizeof(struct equiv_cpu_entry));
 
 	return equiv_tbl_len;
 }
