Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA8CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CEE20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CEE20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030436AbeFSSr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:47:59 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:39718 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030443AbeFSSrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:47:53 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fVLfJ-0003WZ-JM; Tue, 19 Jun 2018 20:47:41 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/9] x86/microcode/AMD: Convert CPU equivalence table variable into a struct
Date:   Tue, 19 Jun 2018 20:47:38 +0200
Message-Id: <09cccdaaf4683cc962db83b0ea7523ee99381f1b.1529424596.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529424596.git.mail@maciej.szmigiero.name>
References: <cover.1529424596.git.mail@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert pointer to CPU equivalence table global static variable into a
struct descriptor in preparation for tracking also the size of this table.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 arch/x86/kernel/cpu/microcode/amd.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 9807e27f8fde..10aabd9d3121 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -38,7 +38,9 @@
 #include <asm/cpu.h>
 #include <asm/msr.h>
 
-static struct equiv_cpu_entry *equiv_cpu_table;
+static struct equiv_cpu_table {
+	struct equiv_cpu_entry *table;
+} equiv_table;
 
 /*
  * This points to the current valid container of microcode patches which we will
@@ -581,18 +583,18 @@ void reload_ucode_amd(void)
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-	return find_equiv_id(equiv_cpu_table, uci->cpu_sig.sig);
+	return find_equiv_id(equiv_table.table, uci->cpu_sig.sig);
 }
 
 static u32 find_cpu_family_by_equiv_cpu(u16 equiv_cpu)
 {
 	int i = 0;
 
-	BUG_ON(!equiv_cpu_table);
+	BUG_ON(!equiv_table.table);
 
-	while (equiv_cpu_table[i].equiv_cpu != 0) {
-		if (equiv_cpu == equiv_cpu_table[i].equiv_cpu)
-			return equiv_cpu_table[i].installed_cpu;
+	while (equiv_table.table[i].equiv_cpu != 0) {
+		if (equiv_cpu == equiv_table.table[i].equiv_cpu)
+			return equiv_table.table[i].installed_cpu;
 		i++;
 	}
 	return 0;
@@ -731,21 +733,21 @@ static unsigned int install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	hdr = (const u32 *)buf;
 	equiv_tbl_len = hdr[2];
 
-	equiv_cpu_table = vmalloc(equiv_tbl_len);
-	if (!equiv_cpu_table) {
+	equiv_table.table = vmalloc(equiv_tbl_len);
+	if (!equiv_table.table) {
 		pr_err("failed to allocate equivalent CPU table\n");
 		return 0;
 	}
 
-	memcpy(equiv_cpu_table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	memcpy(equiv_table.table, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
 
 	return equiv_tbl_len;
 }
 
 static void free_equiv_cpu_table(void)
 {
-	vfree(equiv_cpu_table);
-	equiv_cpu_table = NULL;
+	vfree(equiv_table.table);
+	equiv_table.table = NULL;
 }
 
 static void cleanup(void)
