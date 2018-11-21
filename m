Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AF7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 839A02087E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1hAFVrPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 839A02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbeKVJsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390454AbeKVJsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:48:04 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32467208A3;
        Wed, 21 Nov 2018 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542841894;
        bh=2UHPORN3wmI9ALce+PuAv7LC7vPr8ZI80iPHqST0K2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=1hAFVrPVtpdMmq0SkUr9Y60/FAcOb4gD8/l0J+aoeXGGpxLMZmcJAxxJaTy82Aqzk
         xla7Q77LGN6K8+f2DaVmvGSIgTXlWkqhxeaB7ISlI+QEqQG533cU5scQcOr3CGrGFD
         KrdUAvtS/FfHZC0AgcptCQaiOblkBglB8yXkaYdQ=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 4/5] x86/fault: Decode page fault OOPSes better
Date:   Wed, 21 Nov 2018 15:11:25 -0800
Message-Id: <11212acb25980cd1b3030875cd9502414fbb214d.1542841400.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542841400.git.luto@kernel.org>
References: <cover.1542841400.git.luto@kernel.org>
In-Reply-To: <cover.1542841400.git.luto@kernel.org>
References: <cover.1542841400.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/mm/fault.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
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
 
-- 
2.17.2

