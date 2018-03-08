Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbeCHXVB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:21:01 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44366 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeCHXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:21:00 -0500
X-Google-Smtp-Source: AG47ELtxKG1MyNdG56HbsmCuhzXj87SPdFGrlOoLJsM3KFUmaor8T45O5cSh93xpVwm4x1t6H8IWXaNhvGnQemJpr6I=
MIME-Version: 1.0
In-Reply-To: <20180308223632.GA15694@pd.tnic>
References: <20180306094920.16917-1-bp@alien8.de> <20180306094920.16917-6-bp@alien8.de>
 <CA+55aFxwdftN1KcA=Q26oN_GYWyeuyjmMPs-whxZcmz=-ARPFg@mail.gmail.com>
 <20180307101314.GC23662@pd.tnic> <20180307132535.g7c2jro5n7okavbh@treble>
 <CA+55aFwxPBNk+kh+rmNzLViOqu-GFoJD-FsRe0oahDiwMXy-xw@mail.gmail.com>
 <20180308101628.GA21166@pd.tnic> <CA+55aFxBivWhvrMzowmb60M=aek3xWkrpOu3Rj6CtDbA77crFw@mail.gmail.com>
 <20180308223632.GA15694@pd.tnic>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 15:20:58 -0800
X-Google-Sender-Auth: r_gCV6m5EDiKwCMMmqsBH8m5kpQ
Message-ID: <CA+55aFwpXcoXJEPGShDSjovA7X20qc_iMioD129BSzGmNiQNaw@mail.gmail.com>
Subject: Re: [PATCH 5/9] x86/dumpstack: Improve opcodes dumping in the Code: section
To: Borislav Petkov <bp@alien8.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 8, 2018 at 2:36 PM, Borislav Petkov <bp@alien8.de> wrote:
>
> Btw, do we have any explanation for the two-thirds prologue? I dug it
> out to the patch below but it doesn't say why the prologue being bigger
> is more important than the epilogue.

Yes, so the reason the prologue is more important is that there's
really two cases for the "Code:" line:

 (a) it doesn't matter at all, because you have the kernel image
anyway, and can just get the code from there based on the faulting
instruction pointer address.

 (b) it ends up helping you match things up roughly, because maybe you
have a different compiler version and different code generation
(and/or maybe just different config options)

In the (a) case, the code doesn't matter at all, and you might as well
just look at the whole function by just doing "gdb vmlinux" and then
disassemble it. You have everything just from %rip.

In the (b) case, there are two reasons to give code "around" the
faulting instruction pointer:

 - to help match up when you compare your not-identical vmlinux sequence

 - to actually figure out what the register allocation in the faulting
kernel was, so that you can make sense of the register dump, because
your local kernel might have completely different register allocaiton.

And for that *second* case, the instructions that _precede_ the
faulting instructions are generally much more important than the
instructions that follow the faulting instruction.

The instructions that *follow* the faulting instructions generally
have little or no relevance for the register dump (obviously loops etc
_can_ make them  matter, but you see the rough point).

So the instructions that precede the faulting instruction are in many
ways much more relevant than the instructions that follow it. So you
want more of those.

Also, the instructions that precede the faulting instruction have
another issue - with variable-length instructions, it's hard to sync
up things. Even if we were to use a disassembler (which we almost
certainly don't at fault time), walking backwards can easily be
ambiguous.

So you want extra "slop" in the bytes that get dumped before the
instruction, because you don't know quite where the instruction
boundaries may be.  In contrast, the faulting instruction itself - and
the instrucvtions that follow it - you can tell where the instruction
boundaries are (unless you had an exception due to a corrupted
indirect branch, which does happen but is quite rare).

So there's two reasons for why the bytes _before_ the instruction are
more important than the bytes _after_ the instruction: the register
state is more relevant for them, and the slop for decoding.

The "two thirds" then just comes from that. It's just a random
estimate of "instruction bytes that precede the faulting instructions
are more important than later ones".

In fact, to some degree the "one third" can be seen as "the faulting
instruction itself needs some space".

An x86 instruction can be at most 15 bytes, and you do likely want at
least that. Any bytes after the first instruction aren't _useless_
(because they definitely can help line things up when you have
slightly different code generation due to compiler versions etc), so
"at least 15 bytes, and maybe a bit more" again makes that 2/3rds
thing work out well when you print out 64 bytes.

                      Linus

PS. Historical side note:

We haven't always printed out that much. This is Linux-0.01:

        for(i=0;i<10;i++)
                printk("%02x ",0xff & get_seg_byte(esp[1],(i+(char *)esp[0])));

so it just printed out 10 bytes, basically just the faulting
instruction (and not even all of it if it has a lot of immediates).

We eventually extended the 10 bytes into 20 bytes, again starting at
the existing instruction, because if you don't print out a lot, you
need to start at the faulting instruction itself because of slop.

The expansion from 20 to 64 bytes happened in 2004 in v2.6.9. And
that's also when we started dumping preceding instructions, because
once you print out a fair chunk of bytes, that's when "preceding
instructions are more important" comes in. Because before that, you
want to guarantee that you at least print out the faulting
instruction.
