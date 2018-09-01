Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDBC433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6345E20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 03:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="waJYvgkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6345E20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbeIAHwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 03:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbeIAHwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 03:52:36 -0400
Received: from localhost (c-71-202-137-17.hsd1.ca.comcast.net [71.202.137.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADADC20841;
        Sat,  1 Sep 2018 03:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535773329;
        bh=6Jyl8Mm1+hzzQZ0g9D+UpLiBIDTON4rf16/2wC60wT4=;
        h=From:To:Cc:Subject:Date:From;
        b=waJYvgkJgkQJstYmPkah7EcoiKo54eFeIBgz0Bru9KHV6UfxlKjzJe//BXJVbrKbO
         YqQPRK2BH/jZ4rr/vfeQzj2qJjhN381SJtTQd/zUrusTrjDtjwIkZ0sXfPZzbeCMpd
         EHiszFOQycmvGQi0HNGEfHFEgjSa4Oz1c5FILz4s=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/fault: Decode page fault OOPSes better
Date:   Fri, 31 Aug 2018 20:42:08 -0700
Message-Id: <0a4c64885e9a51705dcc0f49526823ed429e0720.1535773238.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.1
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

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---

This is not the best-tested thing in the world, although it appears to
work.  I think it would have made developing PTI much more pleasant.

 arch/x86/mm/fault.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index b9123c497e0a..9381ce880c9d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -25,6 +25,7 @@
 #include <asm/vsyscall.h>		/* emulate_vsyscall		*/
 #include <asm/vm86.h>			/* struct vm86			*/
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
+#include <asm/desc.h>			/* store_idt(), ...		*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -640,10 +641,43 @@ static int is_f00f_bug(struct pt_regs *regs, unsigned long address)
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
 static void
 show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		unsigned long address)
 {
+	char errcode[64];
+
 	if (!oops_may_print())
 		return;
 
@@ -671,6 +705,48 @@ show_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 address < PAGE_SIZE ? "NULL pointer dereference" : "paging request",
 		 (void *)address);
 
+	errcode[0] = 0;
+#define ERRSTR(x) if (error_code & X86_PF_##x) strcat(errcode, " " #x)
+	ERRSTR(PROT);
+	ERRSTR(WRITE);
+	ERRSTR(USER);
+	ERRSTR(RSVD);
+	ERRSTR(INSTR);
+	ERRSTR(PK);
+#undef ERRSTR
+	pr_alert("HW error: %s\n", errcode[0] ? errcode + 1 :
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
2.17.1

