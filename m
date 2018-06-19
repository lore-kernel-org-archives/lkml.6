Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0DAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470620661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2470620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030534AbeFSSs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:48:26 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39816 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030465AbeFSSr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:56 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfJ-0003Wf-SI; Tue, 19 Jun 2018 20:47:41 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 9/9] x86/microcode/AMD: Check the equivalence table size when scanning it
Date:   Tue, 19 Jun 2018 20:47:39 +0200
Message-Id: <c23d04b8d01c8e1e35f30c0684918590ecbc9fe4.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the code scanning the CPU equivalence table read from a
microcode container file assumes that it actually contains a terminating
zero entry.
Let's check also the size of this table to make sure that we don't read
past it in case it actually doesn't.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 33 +++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 10aabd9d3121..7548dfcf12b0 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -40,6 +40,7 @@
 
 static struct equiv_cpu_table {
 	struct equiv_cpu_entry *table;
+	unsigned int entries;
 } equiv_table;
 
 /*
@@ -65,12 +66,18 @@ static u8 amd_ucode_patch[PATCH_MAX_SIZE];
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
@@ -312,7 +319,8 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/* Find the equivalence ID of our CPU in this table: */
-	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(eq, equiv_tbl_len / sizeof(*eq),
+			      desc->cpuid_1_eax);
 
 	buf  += CONTAINER_HDR_SZ;
 	buf  += equiv_tbl_len;
@@ -583,20 +591,21 @@ void reload_ucode_amd(void)
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(equiv_table.table, uci->cpu_sig.sig);
+	return find_equiv_id(equiv_table.table, equiv_table.entries,
+			     uci->cpu_sig.sig);
 }
 
 static u32 find_cpu_family_by_equiv_cpu(u16 equiv_cpu)
 {
-	int i = 0;
+	unsigned int i;
 
 	BUG_ON(!equiv_table.table);
 
-	while (equiv_table.table[i].equiv_cpu != 0) {
+	for (i = 0; i < equiv_table.entries &&
+		     equiv_table.table[i].equiv_cpu != 0; i++)
 		if (equiv_cpu == equiv_table.table[i].equiv_cpu)
 			return equiv_table.table[i].installed_cpu;
-		i++;
-	}
+
 	return 0;
 }
 
@@ -740,6 +749,7 @@ static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	}
 
 	memcpy(equiv_table.table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	equiv_table.entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
 	return equiv_tbl_len;
 }
@@ -748,6 +758,7 @@ static void free_equiv_cpu_table(void)
 {
 	vfree(equiv_table.table);
 	equiv_table.table = NULL;
+	equiv_table.entries = 0;
 }
 
 static void cleanup(void)
