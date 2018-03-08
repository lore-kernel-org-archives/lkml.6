Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbeCHWgs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 17:36:48 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53552 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbeCHWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 17:36:47 -0500
Date: Thu, 8 Mar 2018 23:36:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180308223632.GA15694@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de>
 <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic>
 <20180307132535.g7c2jro5n7okavbh@treble>
 <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com>
 <20180308101628.GA21166@pd.tnic>
 <CA+55aFxBivWhvrMzowmb60M=aek3xWkrpOu3Rj6CtDbA77crFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxBivWhvrMzowmb60M=aek3xWkrpOu3Rj6CtDbA77crFw@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 10:00:09AM -0800, Linus Torvalds wrote:
> On Thu, Mar 8, 2018 at 2:16 AM, Borislav Petkov <bp@alien8.de> wrote:
> > +#define OPCODE_BUFSIZE 64
> > +       unsigned int code_prologue = OPCODE_BUFSIZE * 43 / OPCODE_BUFSIZE;
> 
> Heh.
> 
> That's a very odd way of writing "43".

I was simply search-replacing code_bytes :-)

> Honestly, the "43" is just "two thirds" rounded to closest, and it's
> not important anyway, so I think you should just write it as
> 
>         unsigned int code_prologue = OPCODE_BUFSIZE * 2 / 3;

Btw, do we have any explanation for the two-thirds prologue? I dug it
out to the patch below but it doesn't say why the prologue being bigger
is more important than the epilogue.

I would've made it half and half but I guess it is more important to see
the opcode bytes leading to rip... Oh well.

> and never mind that it will now be 42.
>
> 42 is obviously the right answer anyway, which makes me think we got
> it wrong earlier.

Doh, of course! What was I thinking?!? :-)

Done.

---
>From 313c2652ce75899d7801b021ed40e5b8ef233aca Mon Sep 17 00:00:00 2001
From: Keith Owens <kaos@ocs.com.au>
Date: Sun, 22 Aug 2004 22:36:42 -0700
Subject: [PATCH] [PATCH] i386 oops output: dump preceding code

This teaches the i386 oops dumper to dump opcodes preceding and after the
offending EIP.  Supporting code against ksymoops has been tested and produces
output like the below.

Support for this was added to ksymoops-2.4.9.

Note that ksymoops will guarantee that the disassembly after the <eip> value
is always in sync - if the disassembly from the start of the Code: line does
not sync up with the EIP address ksymoops will perform the resync.


Warning (merge_maps): no symbols in merged map
Mar 18 23:47:36 vmm kernel: kernel BUG at fs/open.c:802!
Mar 18 23:47:36 vmm kernel: invalid operand: 0000 [#1]
Mar 18 23:47:36 vmm kernel: CPU:    0
Mar 18 23:47:36 vmm kernel: EIP:    0060:[<c014fedf>] VLI    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Mar 18 23:47:36 vmm kernel: EFLAGS: 00010246
Mar 18 23:47:36 vmm kernel: eax: ccdfb900   ebx: 4001020d   ecx: 00000000   edx: 0000007b
Mar 18 23:47:36 vmm kernel: esi: 00000000   edi: bfffdd70   ebp: ccdfdfbc   esp: ccdfdfb0
Mar 18 23:47:36 vmm kernel: ds: 007b   es: 007b   ss: 0068
Mar 18 23:47:36 vmm kernel: Stack: 4001020d 00000000 bfffdd70 ccdfc000 c0109213 4001020d 00000000 00000003
Mar 18 23:47:36 vmm kernel:        00000000 bfffdd70 bfffdc88 00000005 0000007b 0000007b 00000005 4000ef94
Mar 18 23:47:36 vmm kernel:        00000073 00000206 bfffdbd8 0000007b
Mar 18 23:47:36 vmm kernel: Call Trace:
Mar 18 23:47:36 vmm kernel:  [<c0109213>] syscall_call+0x7/0xb
Mar 18 23:47:36 vmm kernel: Code: 14 98 f0 81 41 04 00 00 00 01 5b 89 ec 5d c3 90 b8 00 e0 ff ff 21 e0 55 89 e5 57 56 53 8b 00 81 b8 e4 01 00 00 0f 27 00 00 75 08 <0f> 0b 22 03 85 18 2f c0 8b 45 08 50 e8 30 d4 00 00 89 c7 83 c4


>>EIP; c014fedf No symbols available   <=====

Trace; c0109213 No symbols available

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c014feb4 No symbols available
00000000 <_EIP>:
Code;  c014feb4 No symbols available
   0:   14 98                     adc    $0x98,%al
Code;  c014feb6 No symbols available
   2:   f0 81 41 04 00 00 00      lock addl $0x1000000,0x4(%ecx)
Code;  c014febd No symbols available
   9:   01
Code;  c014febe No symbols available
   a:   5b                        pop    %ebx
Code;  c014febf No symbols available
   b:   89 ec                     mov    %ebp,%esp
Code;  c014fec1 No symbols available
   d:   5d                        pop    %ebp
Code;  c014fec2 No symbols available
   e:   c3                        ret
Code;  c014fec3 No symbols available
   f:   90                        nop
Code;  c014fec4 No symbols available
  10:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  c014fec9 No symbols available
  15:   21 e0                     and    %esp,%eax
Code;  c014fecb No symbols available
  17:   55                        push   %ebp
Code;  c014fecc No symbols available
  18:   89 e5                     mov    %esp,%ebp
Code;  c014fece No symbols available
  1a:   57                        push   %edi
Code;  c014fecf No symbols available
  1b:   56                        push   %esi
Code;  c014fed0 No symbols available
  1c:   53                        push   %ebx
Code;  c014fed1 No symbols available
  1d:   8b 00                     mov    (%eax),%eax
Code;  c014fed3 No symbols available
  1f:   81 b8 e4 01 00 00 0f      cmpl   $0x270f,0x1e4(%eax)
Code;  c014feda No symbols available
  26:   27 00 00
Code;  c014fedd No symbols available
  29:   75 08                     jne    33 <_EIP+0x33> c014fee7 No symbols available

This decode from eip onwards should be reliable

Code;  c014fedf No symbols available
00000000 <_EIP>:
Code;  c014fedf No symbols available   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c014fee1 No symbols available
   2:   22 03                     and    (%ebx),%al
Code;  c014fee3 No symbols available
   4:   85 18                     test   %ebx,(%eax)
Code;  c014fee5 No symbols available
   6:   2f                        das
Code;  c014fee6 No symbols available
   7:   c0 8b 45 08 50 e8 30      rorb   $0x30,0xe8500845(%ebx)
Code;  c014feed No symbols available
   e:   d4 00                     aam    $0x0
Code;  c014feef No symbols available
  10:   00                        .byte 0x0
Code;  c014fef0 No symbols available
  11:   89 c7                     mov    %eax,%edi
Code;  c014fef2 No symbols available
  13:   83                        .byte 0x83
Code;  c014fef3 No symbols available
  14:   c4                        .byte 0xc4



Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
---
 arch/i386/kernel/traps.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 12e9ce87f46c..ae69bf846a40 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -216,7 +216,7 @@ void show_registers(struct pt_regs *regs)
 		ss = regs->xss & 0xffff;
 	}
 	print_modules();
-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx"
+	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\nEFLAGS: %08lx"
 			"   (%s) \n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
 		print_tainted(), regs->eflags, UTS_RELEASE);
@@ -234,23 +234,25 @@ void show_registers(struct pt_regs *regs)
 	 * time of the fault..
 	 */
 	if (in_kernel) {
+		u8 *eip;
 
 		printk("\nStack: ");
 		show_stack(NULL, (unsigned long*)esp);
 
 		printk("Code: ");
-		if(regs->eip < PAGE_OFFSET)
-			goto bad;
 
-		for(i=0;i<20;i++)
-		{
+		eip = (u8 *)regs->eip - 43;
+		for (i = 0; i < 64; i++, eip++) {
 			unsigned char c;
-			if(__get_user(c, &((unsigned char*)regs->eip)[i])) {
-bad:
+
+			if (eip < (u8 *)PAGE_OFFSET || __get_user(c, eip)) {
 				printk(" Bad EIP value.");
 				break;
 			}
-			printk("%02x ", c);
+			if (eip == (u8 *)regs->eip)
+				printk("<%02x> ", c);
+			else
+				printk("%02x ", c);
 		}
 	}
 	printk("\n");
-- 
2.13.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
