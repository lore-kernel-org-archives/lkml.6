Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AA9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E2320684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E2320684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393971AbeKVUvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:51:24 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59279 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbeKVUvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:51:24 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAMACEHK3744068
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 22 Nov 2018 02:12:15 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAMACE5g3744065;
        Thu, 22 Nov 2018 02:12:14 -0800
Date:   Thu, 22 Nov 2018 02:12:14 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-a1a371c468f7238b7826fde55786b02377faf8e2@git.kernel.org>
Cc:     tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        yu-cheng.yu@intel.com, dave.hansen@linux.intel.com,
        luto@kernel.org, riel@surriel.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, riel@surriel.com,
          dave.hansen@linux.intel.com, luto@kernel.org,
          yu-cheng.yu@intel.com, bp@alien8.de, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
References: <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/fault: Decode page fault OOPSes better
Git-Commit-ID: a1a371c468f7238b7826fde55786b02377faf8e2
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

Commit-ID:  a1a371c468f7238b7826fde55786b02377faf8e2
Gitweb:     https://git.kernel.org/tip/a1a371c468f7238b7826fde55786b02377faf8e2
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 21 Nov 2018 15:11:25 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Nov 2018 09:24:28 +0100

x86/fault: Decode page fault OOPSes better

One of Linus' favorite hobbies seems to be looking at OOPSes and
decoding the error code in his head.  This is not one of my favorite
hobbies :)

Teach the page fault OOPS hander to decode the error code.  If it's
a !USER fault from user mode, print an explicit note to that effect
and print out the addresses of various tables that might cause such
an error.

With this patch applied, if I intentionally point the LDT at 0x0 and
run the x86 selftests, I get:

  BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
  HW error: normal kernel read fault
  This was a system access from user code
  IDT: 0xfffffe0000000000 (limit=0xfff) GDT: 0xfffffe0000001000 (limit=0x7f)
  LDTR: 0x50 -- base=0x0 limit=0xfff7
  TR: 0x40 -- base=0xfffffe0000003000 limit=0x206f
  PGD 800000000456e067 P4D 800000000456e067 PUD 4623067 PMD 0
  SMP PTI
  CPU: 0 PID: 153 Comm: ldt_gdt_64 Not tainted 4.19.0+ #1317
  Hardware name: ...
  RIP: 0033:0x401454

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/fault.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ca38bd0472f2..f5efbdba2b6d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -27,6 +27,7 @@
 #include <asm/vm86.h>			/* struct vm86			*/
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
 #include <asm/efi.h>			/* efi_recover_from_page_fault()*/
+#include <asm/desc.h>			/* store_idt(), ...		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -571,10 +572,53 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
 	return 0;
 }
 
+static void show_ldttss(const struct desc_ptr *gdt, const char *name, u16 index)
+{
+	u32 offset = (index >> 3) * sizeof(struct desc_struct);
+	unsigned long addr;
+	struct ldttss_desc desc;
+
+	if (index == 0) {
+		pr_alert("%s: NULL\n", name);
+		return;
+	}
+
+	if (offset + sizeof(struct ldttss_desc) >= gdt->size) {
+		pr_alert("%s: 0x%hx -- out of bounds\n", name, index);
+		return;
+	}
+
+	if (probe_kernel_read(&desc, (void *)(gdt->address + offset),
+			      sizeof(struct ldttss_desc))) {
+		pr_alert("%s: 0x%hx -- GDT entry is not readable\n",
+			 name, index);
+		return;
+	}
+
+	addr = desc.base0 | (desc.base1 << 16) | (desc.base2 << 24);
+#ifdef CONFIG_X86_64
+	addr |= ((u64)desc.base3 << 32);
+#endif
+	pr_alert("%s: 0x%hx -- base=0x%lx limit=0x%x\n",
+		 name, index, addr, (desc.limit0 | (desc.limit1 << 16)));
+}
+
+static void errstr(unsigned long ec, char *buf, unsigned long mask,
+		   const char *txt)
+{
+	if (ec & mask) {
+		if (buf[0])
+			strcat(buf, " ");
+		strcat(buf, txt);
+	}
+}
+
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
 {
+	char errtxt[64];
+
 	if (!oops_may_print())
 		return;
 
@@ -602,6 +646,46 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
 		 (void *)address);
 
+	errtxt[0] = 0;
+	errstr(error_code, errtxt, X86_PF_PROT, "PROT");
+	errstr(error_code, errtxt, X86_PF_WRITE, "WRITE");
+	errstr(error_code, errtxt, X86_PF_USER, "USER");
+	errstr(error_code, errtxt, X86_PF_RSVD, "RSVD");
+	errstr(error_code, errtxt, X86_PF_INSTR, "INSTR");
+	errstr(error_code, errtxt, X86_PF_PK, "PK");
+	pr_alert("HW error: %s\n", error_code ? errtxt :
+		 "normal kernel read fault");
+	if (!(error_code & X86_PF_USER) && user_mode(regs)) {
+		struct desc_ptr idt, gdt;
+		u16 ldtr, tr;
+
+		pr_alert("This was a system access from user code\n");
+
+		/*
+		 * This can happen for quite a few reasons.  The more obvious
+		 * ones are faults accessing the GDT, or LDT.  Perhaps
+		 * surprisingly, if the CPU tries to deliver a benign or
+		 * contributory exception from user code and gets a page fault
+		 * during delivery, the page fault can be delivered as though
+		 * it originated directly from user code.  This could happen
+		 * due to wrong permissions on the IDT, GDT, LDT, TSS, or
+		 * kernel or IST stack.
+		 */
+		store_idt(&idt);
+
+		/* Usable even on Xen PV -- it's just slow. */
+		native_store_gdt(&gdt);
+
+		pr_alert("IDT: 0x%lx (limit=0x%hx) GDT: 0x%lx (limit=0x%hx)\n",
+			 idt.address, idt.size, gdt.address, gdt.size);
+
+		store_ldt(ldtr);
+		show_ldttss(&gdt, "LDTR", ldtr);
+
+		store_tr(tr);
+		show_ldttss(&gdt, "TR", tr);
+	}
+
 	dump_pagetable(address);
 }
 
