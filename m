Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF8EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C22420823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 10:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C22420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeKSUoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 15:44:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58635 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeKSUoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 15:44:17 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAJAKwHF2524952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 19 Nov 2018 02:20:58 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAJAKvsn2524949;
        Mon, 19 Nov 2018 02:20:57 -0800
Date:   Mon, 19 Nov 2018 02:20:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Maciej S. Szmigiero" <tipbot@zytor.com>
Message-ID: <tip-413c89154c6759cbd5e17febd04c187470613173@git.kernel.org>
Cc:     tglx@linutronix.de, bp@suse.de, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com, mail@maciej.szmigiero.name
Reply-To: mingo@kernel.org, bp@suse.de, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, mail@maciej.szmigiero.name, hpa@zytor.com
In-Reply-To: <20181107170218.7596-16-bp@alien8.de>
References: <20181107170218.7596-16-bp@alien8.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/microcode] x86/microcode/AMD: Check the equivalence table
 size when scanning it
Git-Commit-ID: 413c89154c6759cbd5e17febd04c187470613173
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

Commit-ID:  413c89154c6759cbd5e17febd04c187470613173
Gitweb:     https://git.kernel.org/tip/413c89154c6759cbd5e17febd04c187470613173
Author:     Maciej S. Szmigiero <mail@maciej.szmigiero.name>
AuthorDate: Thu, 13 Sep 2018 12:01:52 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 19 Nov 2018 10:55:12 +0100

x86/microcode/AMD: Check the equivalence table size when scanning it

Currently, the code scanning the CPU equivalence table read from a
microcode container file assumes that it actually contains a terminating
zero entry.

Check also the size of this table to make sure that no reads past its
end happen, in case there's no terminating zero entry at the end of the
table.

 [ bp: Adjust to new changes. ]

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: x86@kernel.org
Link: https://lkml.kernel.org/r/20181107170218.7596-16-bp@alien8.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 6048d9dd1a15..81df4b9eadb7 100644
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
@@ -728,6 +736,7 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 	}
 
 	memcpy(equiv_table.entry, buf + CONTAINER_HDR_SZ, equiv_tbl_len);
+	equiv_table.num_entries = equiv_tbl_len / sizeof(struct equiv_cpu_entry);
 
 	/* add header length */
 	return equiv_tbl_len + CONTAINER_HDR_SZ;
@@ -736,7 +745,7 @@ static size_t install_equiv_cpu_table(const u8 *buf, size_t buf_size)
 static void free_equiv_cpu_table(void)
 {
 	vfree(equiv_table.entry);
-	equiv_table.entry = NULL;
+	memset(&equiv_table, 0, sizeof(equiv_table));
 }
 
 static void cleanup(void)
