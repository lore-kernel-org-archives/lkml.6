Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD811ECDE47
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F8E21479
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:02:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F8E21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbeKHCd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:33:58 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46668 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbeKHCd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:33:57 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jzZqfa5QN0ab; Wed,  7 Nov 2018 18:02:42 +0100 (CET)
Received: from zn.tnic (p200300EC2BCBE000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:e000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 352AB1EC0AC9;
        Wed,  7 Nov 2018 18:02:42 +0100 (CET)
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 15/16] x86/microcode/AMD: Check the equivalence table size when scanning it
Date:   Wed,  7 Nov 2018 18:02:17 +0100
Message-Id: <20181107170218.7596-16-bp@alien8.de>
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

Currently, the code scanning the CPU equivalence table read from a
microcode container file assumes that it actually contains a terminating
zero entry.

Check also the size of this table to make sure that no reads past its
end happen, in case there's no terminating zero entry at the end of the
table.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
[ Adjust to new changes. ]
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 99c9928ec240..dc17a5f87f55 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -39,6 +39,7 @@
 #include <asm/msr.h>
 
 static struct equiv_cpu_table {
+	unsigned int num_entries;
 	struct equiv_cpu_entry *entry;
 } equiv_table;
 
@@ -67,13 +68,19 @@ ucode_path[] __maybe_unused = "kernel/x86/microcode/AuthenticAMD.bin";
 
 static u16 find_equiv_id(struct equiv_cpu_table *et, u32 sig)
 {
-	struct equiv_cpu_entry *entry = et->entry;
+	unsigned int i;
 
-	for (; entry && entry->installed_cpu; entry++) {
-		if (sig == entry->installed_cpu)
-			return entry->equiv_cpu;
-	}
+	if (!et || !et->num_entries)
+		return 0;
+
+	for (i = 0; i < et->num_entries; i++) {
+		struct equiv_cpu_entry *e = &et->entry[i];
 
+		if (sig == e->installed_cpu)
+			return e->equiv_cpu;
+
+		e++;
+	}
 	return 0;
 }
 
@@ -302,6 +309,7 @@ static size_t parse_container(u8 *ucode, size_t size, struct cont_desc *desc)
 	buf = ucode;
 
 	table.entry = (struct equiv_cpu_entry *)(buf + CONTAINER_HDR_SZ);
+	table.num_entries = hdr[2] / sizeof(struct equiv_cpu_entry);
 
 	/*
 	 * Find the equivalence ID of our CPU in this table. Even if this table
@@ -727,6 +735,7 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	}
 
 	memcpy(equiv_table.entry, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	equiv_table.num_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
 	/* add header length */
 	return equiv_tbl_len + CONTAINER_HDR_SZ;
@@ -735,7 +744,7 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 static void free_equiv_cpu_table(void)
 {
 	vfree(equiv_table.entry);
-	equiv_table.entry = NULL;
+	memset(&equiv_table, 0, sizeof(equiv_table));
 }
 
 static void cleanup(void)
-- 
2.19.1

