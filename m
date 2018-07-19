Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D4ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189D20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1189D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731340AbeGSXK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:10:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44681 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbeGSXK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:10:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMPfxp2438831
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:25:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMPffq2438828;
        Thu, 19 Jul 2018 15:25:41 -0700
Date:   Thu, 19 Jul 2018 15:25:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-6fffacb30349e0903602d664f7ab6fc87e85162e@git.kernel.org>
Cc:     pasha.tatashin@oracle.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          pasha.tatashin@oracle.com, mingo@kernel.org, hpa@zytor.com
In-Reply-To: <20180719205545.16512-9-pasha.tatashin@oracle.com>
References: <20180719205545.16512-9-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/alternatives, jumplabel: Use text_poke_early()
 before mm_init()
Git-Commit-ID: 6fffacb30349e0903602d664f7ab6fc87e85162e
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

Commit-ID:  6fffacb30349e0903602d664f7ab6fc87e85162e
Gitweb:     https://git.kernel.org/tip/6fffacb30349e0903602d664f7ab6fc87e85162e
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:27 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:38 +0200

x86/alternatives, jumplabel: Use text_poke_early() before mm_init()

It supposed to be safe to modify static branches after jump_label_init().
But, because static key modifying code eventually calls text_poke() it can
end up accessing a struct page which has not been initialized yet.

Here is how to quickly reproduce the problem. Insert code like this
into init/main.c:

| +static DEFINE_STATIC_KEY_FALSE(__test);
| asmlinkage __visible void __init start_kernel(void)
| {
|        char *command_line;
|@@ -587,6 +609,10 @@ asmlinkage __visible void __init start_kernel(void)
|        vfs_caches_init_early();
|        sort_main_extable();
|        trap_init();
|+       {
|+       static_branch_enable(&__test);
|+       WARN_ON(!static_branch_likely(&__test));
|+       }
|        mm_init();

The following warnings show-up:
WARNING: CPU: 0 PID: 0 at arch/x86/kernel/alternative.c:701 text_poke+0x20d/0x230
RIP: 0010:text_poke+0x20d/0x230
Call Trace:
 ? text_poke_bp+0x50/0xda
 ? arch_jump_label_transform+0x89/0xe0
 ? __jump_label_update+0x78/0xb0
 ? static_key_enable_cpuslocked+0x4d/0x80
 ? static_key_enable+0x11/0x20
 ? start_kernel+0x23e/0x4c8
 ? secondary_startup_64+0xa5/0xb0

---[ end trace abdc99c031b8a90a ]---

If the code above is moved after mm_init(), no warning is shown, as struct
pages are initialized during handover from memblock.

Use text_poke_early() in static branching until early boot IRQs are enabled
and from there switch to text_poke. Also, ensure text_poke() is never
invoked when unitialized memory access may happen by using adding a
!after_bootmem assertion.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-9-pasha.tatashin@oracle.com
---
 arch/x86/include/asm/text-patching.h |  1 +
 arch/x86/kernel/alternative.c        |  7 +++++++
 arch/x86/kernel/jump_label.c         | 11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 2ecd34e2d46c..e85ff65c43c3 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -37,5 +37,6 @@ extern void *text_poke_early(void *addr, const void *opcode, size_t len);
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
+extern int after_bootmem;
 
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index a481763a3776..014f214da581 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -668,6 +668,7 @@ void *__init_or_module text_poke_early(void *addr, const void *opcode,
 	local_irq_save(flags);
 	memcpy(addr, opcode, len);
 	local_irq_restore(flags);
+	sync_core();
 	/* Could also do a CLFLUSH here to speed up CPU recovery; but
 	   that causes hangs on some VIA CPUs. */
 	return addr;
@@ -693,6 +694,12 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 	struct page *pages[2];
 	int i;
 
+	/*
+	 * While boot memory allocator is runnig we cannot use struct
+	 * pages as they are not yet initialized.
+	 */
+	BUG_ON(!after_bootmem);
+
 	if (!core_kernel_text((unsigned long)addr)) {
 		pages[0] = vmalloc_to_page(addr);
 		pages[1] = vmalloc_to_page(addr + PAGE_SIZE);
diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index e56c95be2808..eeea935e9bb5 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -37,15 +37,18 @@ static void bug_at(unsigned char *ip, int line)
 	BUG();
 }
 
-static void __jump_label_transform(struct jump_entry *entry,
-				   enum jump_label_type type,
-				   void *(*poker)(void *, const void *, size_t),
-				   int init)
+static void __ref __jump_label_transform(struct jump_entry *entry,
+					 enum jump_label_type type,
+					 void *(*poker)(void *, const void *, size_t),
+					 int init)
 {
 	union jump_code_union code;
 	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 
+	if (early_boot_irqs_disabled)
+		poker = text_poke_early;
+
 	if (type == JUMP_LABEL_JMP) {
 		if (init) {
 			/*
