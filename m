Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECEBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A192133D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33A192133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbeKHCd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:56 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731565AbeKHCdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:55 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FmcXExWqgqTN; Wed,  7 Nov 2018 18:02:41 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 52AEC1EC0AC9;
        Wed,  7 Nov 2018 18:02:41 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 14/16] x86/microcode/AMD: Convert CPU equivalence table variable into a struct
Date:   Wed,  7 Nov 2018 18:02:16 +0100
Message-Id: <20181107170218.7596-15-bp@alien8.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181107170218.7596-1-bp@alien8.de>
References: <20181107170218.7596-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>

Convert the CPU equivalence table into a proper struct in preparation
for tracking also the size of this table.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
[ Have functions deal with struct equiv_cpu_table pointers only. Rediff. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 32 ++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 5d822ed295b5..99c9928ec240 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -38,7 +38,9 @@
 #include <asm/cpu.h>
 #include <asm/msr.h>
 
-static struct equiv_cpu_entry *equiv_cpu_table;
+static struct equiv_cpu_table {
+	struct equiv_cpu_entry *entry;
+} equiv_table;
 
 /*
  * This points to the current valid container of microcode patches which we will
@@ -63,11 +65,13 @@ static u8 amd_ucode_patch[PATCH_MAX_SIZE];
 static const char
 ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
 
-static u16 find_equiv_id(struct equiv_cpu_entry *equiv_table, u32 sig)
+static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 {
-	for (; equiv_table && equiv_table->installed_cpu; equiv_table++) {
-		if (sig == equiv_table->installed_cpu)
-			return equiv_table->equiv_cpu;
+	struct equiv_cpu_entry *entry = et->entry;
+
+	for (; entry && entry->installed_cpu; entry++) {
+		if (sig == entry->installed_cpu)
+			return entry->equiv_cpu;
 	}
 
 	return 0;
@@ -286,7 +290,7 @@ verify_patch(u8 family, const u8 *buf, size_t buf_size, u32 *patch_size, bool ea
  */
 static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 {
-	struct equiv_cpu_entry *eq;
+	struct equiv_cpu_table table;
 	size_t orig_size = size;
 	u32 *hdr = (u32 *)ucode;
 	u16 eq_id;
@@ -297,14 +301,14 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 
 	buf = ucode;
 
-	eq = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
+	table.entry = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
 
 	/*
 	 * Find the equivalence ID of our CPU in this table. Even if this table
 	 * doesn't contain a patch for the CPU, scan through the whole container
 	 * so that it can be skipped in case there are other containers appended.
 	 */
-	eq_id = find_equiv_id(eq, desc->cpuid_1_eax);
+	eq_id = find_equiv_id(&table, desc->cpuid_1_eax);
 
 	buf  += hdr[2] + CONTAINER_HDR_SZ;
 	size -= hdr[2] + CONTAINER_HDR_SZ;
@@ -572,7 +576,7 @@ void reload_ucode_amd(void)
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
+	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 }
 
 /*
@@ -716,13 +720,13 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	hdr = (const u32 *)buf;
 	equiv_tbl_len = hdr[2];
 
-	equiv_cpu_table = vmalloc(equiv_tbl_len);
-	if (!equiv_cpu_table) {
+	equiv_table.entry = vmalloc(equiv_tbl_len);
+	if (!equiv_table.entry) {
 		pr_err("failed to allocate equivalent CPU table\n");
 		return 0;
 	}
 
-	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	memcpy(equiv_table.entry, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 
 	/* add header length */
 	return equiv_tbl_len + CONTAINER_HDR_SZ;
@@ -730,8 +734,8 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 
 static void free_equiv_cpu_table(void)
 {
-	vfree(equiv_cpu_table);
-	equiv_cpu_table = NULL;
+	vfree(equiv_table.entry);
+	equiv_table.entry = NULL;
 }
 
 static void cleanup(void)
-- 
2.19.1

