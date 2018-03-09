Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCIKQK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:16:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:49900 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbeCIKQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:16:06 -0500
Date: Fri, 9 Mar 2018 11:15:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180309101551.GA10753@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de>
 <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic>
 <20180307132535.g7c2jro5n7okavbh@treble>
 <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com>
 <20180308101628.GA21166@pd.tnic>
 <CA+55aFxBivWhvrMzowmb60M=aek3xWkrpOu3Rj6CtDbA77crFw@mail.gmail.com>
 <20180308223632.GA15694@pd.tnic>
 <CA+55aFwpXcoXJEPGShDSjovA7X20qc_iMioD129BSzGmNiQNaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwpXcoXJEPGShDSjovA7X20qc_iMioD129BSzGmNiQNaw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 03:20:58PM -0800, Linus Torvalds wrote:
> Yes, so the reason the prologue is more important is that there's
> really two cases for the "Code:" line:

Yap, I had a hunch it must be about some of those but thanks for taking
the time and writing it down!

I've tried to summarize the reasoning and slap it as a comment above it
so that it is clear why we do it this way:

---
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index c3aa0e29513e..7a21098c9128 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -71,6 +71,25 @@ static void printk_stack_address(unsigned long address, int reliable,
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
 }
 
+/*
+ * The are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
+ *
+ * In case where we don't have the exact kernel image (which, if we did, we can
+ * simply disassemble and navigate to the RIP), the purpose of the bigger
+ * prologue is to have more context and to be able to correlate the code from
+ * the different toolchains better.
+ *
+ * In addition, it helps in recreating the register allocation of the failing
+ * kernel and thus make sense of the register dump.
+ *
+ * What is more, the additional complication of a variable length insn arch like
+ * x86 warrants having longer byte sequence before rIP so that the disassembler
+ * can "sync" up properly and find instruction boundaries when decoding the
+ * opcode bytes.
+ *
+ * Thus, the 2/3rds prologue and 64 byte OPCODE_BUFSIZE is just a random
+ * guesstimate in attempt to achieve all of the above.
+ */
 void show_opcodes(u8 *rip, const char *loglvl)
 {
 #define OPCODE_BUFSIZE 64

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
