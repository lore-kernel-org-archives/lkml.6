Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93818C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7AA20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A7AA20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbeKSUnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:43:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:43:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAKNZJ2524915
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:20:23 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAKN4Q2524912;
        Mon, 19 Nov 2018 02:20:23 -0800
Date:   Mon, 19 Nov 2018 02:20:23 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Maciej S. Szmigiero" <tipbot@zytor.com>
Message-ID: <tip-39cd7c17f9bc3fe3737dacd4225eeabe56df197c@git.kernel.org>
Cc:     hpa@zytor.com, bp@suse.de, linux-kernel@vger.kernel.org,
        mail@maciej.szmigiero.name, tglx@linutronix.de, mingo@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, bp@suse.de,
          mail@maciej.szmigiero.name, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20181107170218.7596-15-bp@alien8.de>
References: <20181107170218.7596-15-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Convert CPU equivalence
 table variable into a struct
Git-Commit-ID: 39cd7c17f9bc3fe3737dacd4225eeabe56df197c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  39cd7c17f9bc3fe3737dacd4225eeabe56df197c
Gitweb:     https://git.kernel.org/tip/39cd7c17f9bc3fe3737dacd4225eeabe56df197c
Author:     Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate: Thu, 13 Sep 2018 11:45:42 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:55:12 +0100

x86/microcode/AMD: Convert CPU equivalence table variable into a struct

Convert the CPU equivalence table into a proper struct in preparation
for tracking also the size of this table.

 [ bp: Have functions deal with struct equiv_cpu_table pointers only. Rediff. ]

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-15-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index ce6f8381641b..6048d9dd1a15 100644
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
@@ -573,7 +577,7 @@ void reload_ucode_amd(void)
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
+	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 }
 
 /*
@@ -717,13 +721,13 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
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
@@ -731,8 +735,8 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 
 static void free_equiv_cpu_table(void)
 {
-	vfree(equiv_cpu_table);
-	equiv_cpu_table = NULL;
+	vfree(equiv_table.entry);
+	equiv_table.entry = NULL;
 }
 
 static void cleanup(void)
