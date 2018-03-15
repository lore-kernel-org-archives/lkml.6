Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752414AbeCOS4X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:56:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57430 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeCOS4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:56:21 -0400
Date: Thu, 15 Mar 2018 19:55:41 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/9] x86/dumpstack: Add a show_ip() function
Message-ID: <20180315185541.GJ27816@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-8-bp@alien8.de>
 <20180315183411.bqq6fd5pqf4xyo5s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315183411.bqq6fd5pqf4xyo5s@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:34:11PM -0500, Josh Poimboeuf wrote:
> Did you intentionally remove the printing of EFLAGS?

Blergh, EFLAGS were supposed to go down in the printk block. Good catch!

---
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 3d1f1226b972..0ae659de21eb 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -82,8 +82,8 @@ void __show_regs(struct pt_regs *regs, int all)
 		regs->ax, regs->bx, regs->cx, regs->dx);
 	printk(KERN_DEFAULT "ESI: %08lx EDI: %08lx EBP: %08lx ESP: %08lx\n",
 		regs->si, regs->di, regs->bp, sp);
-	printk(KERN_DEFAULT " DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x\n",
-	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss);
+	printk(KERN_DEFAULT "DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x EFLAGS: %08lx\n",
+	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss, regs->flags);
 
 	if (!all)
 		return;


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
