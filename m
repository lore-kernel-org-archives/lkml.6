Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2905FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3376206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfAIXAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:00:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbfAIXAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:00:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C6C2C070E05;
        Wed,  9 Jan 2019 23:00:11 +0000 (UTC)
Received: from treble.redhat.com (ovpn-125-32.rdu2.redhat.com [10.10.125.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98492100034B;
        Wed,  9 Jan 2019 23:00:01 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@ACULAB.COM>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH v3 5/6] x86/alternative: Use a single access in text_poke() where possible
Date:   Wed,  9 Jan 2019 16:59:40 -0600
Message-Id: <279b8003f7f0a6831d090ab822d37bc958f974de.1547073843.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1547073843.git.jpoimboe@redhat.com>
References: <cover.1547073843.git.jpoimboe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 09 Jan 2019 23:00:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Static call inline patching will need to use single 32-bit writes.
Change text_poke() to do so where possible.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/alternative.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ebeac487a20c..607f48a90097 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -692,7 +692,7 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	unsigned long flags;
-	char *vaddr;
+	unsigned long vaddr;
 	struct page *pages[2];
 	int i;
 
@@ -714,14 +714,39 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	}
 	BUG_ON(!pages[0]);
 	local_irq_save(flags);
+
 	set_fixmap(FIX_TEXT_POKE0, page_to_phys(pages[0]));
 	if (pages[1])
 		set_fixmap(FIX_TEXT_POKE1, page_to_phys(pages[1]));
-	vaddr = (char *)fix_to_virt(FIX_TEXT_POKE0);
-	memcpy(&vaddr[(unsigned long)addr & ~PAGE_MASK], opcode, len);
+
+	vaddr = fix_to_virt(FIX_TEXT_POKE0) + ((unsigned long)addr & ~PAGE_MASK);
+
+	/*
+	 * Use a single access where possible.  Note that a single unaligned
+	 * multi-byte write will not necessarily be atomic on x86-32, or if the
+	 * address crosses a cache line boundary.
+	 */
+	switch (len) {
+	case 1:
+		WRITE_ONCE(*(u8 *)vaddr, *(u8 *)opcode);
+		break;
+	case 2:
+		WRITE_ONCE(*(u16 *)vaddr, *(u16 *)opcode);
+		break;
+	case 4:
+		WRITE_ONCE(*(u32 *)vaddr, *(u32 *)opcode);
+		break;
+	case 8:
+		WRITE_ONCE(*(u64 *)vaddr, *(u64 *)opcode);
+		break;
+	default:
+		memcpy((void *)vaddr, opcode, len);
+	}
+
 	clear_fixmap(FIX_TEXT_POKE0);
 	if (pages[1])
 		clear_fixmap(FIX_TEXT_POKE1);
+
 	local_flush_tlb();
 	sync_core();
 	/* Could also do a CLFLUSH here to speed up CPU recovery; but
-- 
2.17.2

