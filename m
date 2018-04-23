Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932539AbeDWVeq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:34:46 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:40970 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932471AbeDWVej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:34:39 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/6] x86/microcode/AMD: Check the equivalence table size when scanning it
Date: Mon, 23 Apr 2018 23:34:11 +0200
Message-Id: <68fade9fda9e63c0722052abecaf4ed0c360beeb.1524515406.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524515406.git.mail@maciej.szmigiero.name>
References: <cover.1524515406.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the code scanning the CPU equivalence table read from a
microcode container file assumes that it actually contains a terminating
zero entry.
Let's check also the size of this table to make sure that we don't read
past it in case it actually doesn't.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 2df366cc71ce..5ba933ce1d51 100644
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
@@ -237,7 +244,8 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/* Find the equivalence ID of our CPU in this table: */
-	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(eq, equiv_tbl_len / sizeof(*eq),
+			      desc->cpuid_1_eax);
 
 	buf  += CONTAINER_HDR_SZ;
 	buf  += equiv_tbl_len;
@@ -499,20 +507,21 @@ void reload_ucode_amd(void)
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
 
@@ -697,6 +706,7 @@ static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	}
 
 	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	equiv_cpu_table_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
 	return equiv_tbl_len;
 }
@@ -705,6 +715,7 @@ static void free_equiv_cpu_table(void)
 {
 	vfree(equiv_cpu_table);
 	equiv_cpu_table = NULL;
+	equiv_cpu_table_entries = 0;
 }
 
 static void cleanup(void)
