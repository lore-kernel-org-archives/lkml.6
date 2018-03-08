Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934577AbeCHKQo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:16:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755259AbeCHKQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:16:42 -0500
Date: Thu, 8 Mar 2018 11:16:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180308101628.GA21166@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de>
 <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic>
 <20180307132535.g7c2jro5n7okavbh@treble>
 <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 01:08:32PM -0800, Linus Torvalds wrote:
> On Wed, Mar 7, 2018 at 5:25 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > How about we just remove the 'code_bytes=' option?  (Or at the very
> > least, reduce its possible range to a reasonable max?)
> 
> Ack. Just limit it to 64 bytes max sounds plenty.

Done, combined diff ontop. With a 64-byte on-stack opcodes buffer:

---
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b37c1c30c16f..2c74c1694d9d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -587,11 +587,6 @@
 			Sets the size of memory pool for coherent, atomic dma
 			allocations, by default set to 256K.
 
-	code_bytes	[X86] How many bytes of object code to print
-			in an oops report.
-			Range: 0 - 8192
-			Default: 64
-
 	com20020=	[HW,NET] ARCnet - COM20020 chipset
 			Format:
 			<io>[,<irq>[,<nodeID>[,<backplane>[,<ckp>[,<timeout>]]]]]
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 409a5bd02a18..2fc009a1824e 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -22,13 +22,9 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
 
-#define OPCODE_BUFSIZE 64
-
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
-static unsigned int code_bytes = OPCODE_BUFSIZE;
-static u8 __opc[OPCODE_BUFSIZE];
-static u8 *opcodes = __opc;
+
 static int die_counter;
 
 static struct pt_regs exec_summary_regs;
@@ -77,19 +73,21 @@ static void printk_stack_address(unsigned long address, int reliable,
 
 void show_opcodes(u8 *rip, const char *loglvl)
 {
-	unsigned int code_prologue = code_bytes * 43 / OPCODE_BUFSIZE;
+#define OPCODE_BUFSIZE 64
+	unsigned int code_prologue = OPCODE_BUFSIZE * 43 / OPCODE_BUFSIZE;
+	u8 opcodes[OPCODE_BUFSIZE];
 	u8 *ip;
 	int i;
 
 	printk("%sCode: ", loglvl);
 
 	ip = (u8 *)rip - code_prologue;
-	if (probe_kernel_read(opcodes, ip, code_bytes)) {
+	if (probe_kernel_read(opcodes, ip, OPCODE_BUFSIZE)) {
 		pr_cont(" Bad RIP value.\n");
 		return;
 	}
 
-	for (i = 0; i < code_bytes; i++, ip++) {
+	for (i = 0; i < OPCODE_BUFSIZE; i++, ip++) {
 		if (ip == (u8 *)rip)
 			pr_cont("<%02x> ", opcodes[i]);
 		else
@@ -387,34 +385,6 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
 }
 
-static int __init code_bytes_setup(char *s)
-{
-	unsigned long val;
-	ssize_t ret;
-
-	if (!s)
-		return -EINVAL;
-
-	ret = kstrtoul(s, 0, &val);
-	if (ret)
-		return ret;
-
-	code_bytes = val;
-	if (code_bytes > 8192)
-		code_bytes = 8192;
-
-	if (code_bytes > OPCODE_BUFSIZE) {
-		u8 *new_buf = kzalloc(code_bytes, GFP_KERNEL);
-		if (!new_buf)
-			return -ENOMEM;
-
-		opcodes = new_buf;
-	}
-
-	return 1;
-}
-__setup("code_bytes=", code_bytes_setup);
-
 void show_regs(struct pt_regs *regs)
 {
 	bool all = true;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
