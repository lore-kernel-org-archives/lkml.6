Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeESWH6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 18:07:58 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:49628 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752553AbeESWHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 18:07:53 -0400
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/8] x86/microcode/AMD: Check microcode container data in the early loader
Date: Sun, 20 May 2018 00:07:17 +0200
Message-Id: <0c53181bd5eb4e172407d9fde534cedb12e19b98.1526767245.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1526767245.git.mail@maciej.szmigiero.name>
References: <cover.1526767245.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the early loader in the AMD microcode update driver to use the
container data checking functions introduced by the previous commit.

We have to be careful to call these functions with 'early' parameter set,
so they won't try to print errors as the early loader runs too early for
printk()-style functions to work.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 59 ++++++++++++++++-------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index f9485ff7183c..f4c7479a961c 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -224,29 +224,36 @@ static bool verify_patch(u8 family, const u8 *buf, size_t buf_size, bool early)
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
+	u32 equiv_tbl_len;
 	u16 eq_id;
 	u8 *buf;
 
-	/* Am I looking at an equivalence table header? */
-	if (hdr[0] != UCODE_MAGIC ||
-	    hdr[1] != UCODE_EQUIV_CPU_TABLE_TYPE ||
-	    hdr[2] == 0)
-		return CONTAINER_HDR_SZ;
+	/*
+	 * Skip one byte when a container cannot be parsed successfully
+	 * so the parser will correctly skip unknown data of any size until
+	 * it hopefully arrives at something that it is able to recognize.
+	 */
+	if (!verify_container(ucode, size, true) ||
+	    !verify_equivalence_table(ucode, size, true))
+		return 1;
 
 	buf = ucode;
 
+	equiv_tbl_len = hdr[2];
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/* Find the equivalence ID of our CPU in this table: */
 	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
 
-	buf  += hdr[2] + CONTAINER_HDR_SZ;
-	size -= hdr[2] + CONTAINER_HDR_SZ;
+	buf  += CONTAINER_HDR_SZ;
+	buf  += equiv_tbl_len;
+	size -= CONTAINER_HDR_SZ;
+	size -= equiv_tbl_len;
 
 	/*
 	 * Scan through the rest of the container to find where it ends. We do
@@ -258,25 +265,27 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
 
 		hdr = (u32 *)buf;
 
-		if (hdr[0] != UCODE_UCODE_TYPE)
+		if (!verify_patch_section(buf, size, true))
 			break;
 
-		/* Sanity-check patch size. */
 		patch_size = hdr[1];
-		if (patch_size > PATCH_MAX_SIZE)
-			break;
 
-		/* Skip patch section header: */
-		buf  += SECTION_HDR_SIZE;
-		size -= SECTION_HDR_SIZE;
+		mc = (struct microcode_amd *)(buf + SECTION_HDR_SIZE);
+		if (eq_id != mc->hdr.processor_rev_id)
+			goto next_patch;
 
-		mc = (struct microcode_amd *)buf;
-		if (eq_id == mc->hdr.processor_rev_id) {
-			desc->psize = patch_size;
-			desc->mc = mc;
-		}
+		if (!verify_patch(x86_family(desc->cpuid_1_eax), buf, size,
+				  true))
+			goto next_patch;
+
+		/* We have found a matching patch! */
+		desc->psize = patch_size;
+		desc->mc = mc;
 
+next_patch:
+		buf  += SECTION_HDR_SIZE;
 		buf  += patch_size;
+		size -= SECTION_HDR_SIZE;
 		size -= patch_size;
 	}
 
@@ -303,15 +312,13 @@ static ssize_t parse_container(u8 *ucode, ssize_t size, struct cont_desc *desc)
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
 
