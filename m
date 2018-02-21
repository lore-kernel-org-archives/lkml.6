Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBUCmR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 21:42:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50628 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751017AbeBUCmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 21:42:16 -0500
Date: Tue, 20 Feb 2018 20:42:14 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>, Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH] x86/entry/64: Simplify ENCODE_FRAME_POINTER
Message-ID: <20180221024214.lhl5jfgw33c4vz3m@treble>
References: <20180220210113.6725-1-linux@dominikbrodowski.net>
 <20180220210113.6725-2-linux@dominikbrodowski.net>
 <CA+55aFx=moDaKj3Ogc_Fvm0vKQ1DP=yA9UE3axmpECyv3Khi1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFx=moDaKj3Ogc_Fvm0vKQ1DP=yA9UE3axmpECyv3Khi1Q@mail.gmail.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2018 at 02:25:03PM -0800, Linus Torvalds wrote:
> On Tue, Feb 20, 2018 at 1:01 PM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
> > +ENTRY(interrupt_entry)
> > +       UNWIND_HINT_FUNC
> > +
> > +       PUSH_AND_CLEAR_REGS save_ret=1
> > +       ENCODE_FRAME_POINTER 8
> > +
> > +       ret
> > +END(interrupt_entry)
> 
> There's nothing wrong with this patch, but it does expose what a nasty
> hack our "ENCODE_FRAME_POINTER" thing is.
> 
> It generates (when there is an offset, like this):
> 
>         leaq \ptregs_offset(%rsp), %rbp
>         orq     $0x1, %rbp
> 
> and I would _really_ hope that the stack pointer is always aligned on
> interrupt entry, so I don't see why it's not just
> 
>         leaq 1+\ptregs_offset(%rsp), %rbp
> 
> instead.
> 
> I dunno. Let's ask Josh what the reason for the separate "or" was.
> 
> But this is an independent issue of this patch, really.

Indeed, how about this?

----

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/entry/64: Simplify ENCODE_FRAME_POINTER

On 64-bit, the stack pointer is always aligned on interrupt, so instead
of setting the LSB of the pt_regs address, we can just add 1 to it.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/entry/calling.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index dce7092ab24a..400cea8bbf4b 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -172,12 +172,7 @@ For 32-bit we have the following conventions - kernel is built with
  */
 .macro ENCODE_FRAME_POINTER ptregs_offset=0
 #ifdef CONFIG_FRAME_POINTER
-	.if \ptregs_offset
-		leaq \ptregs_offset(%rsp), %rbp
-	.else
-		mov %rsp, %rbp
-	.endif
-	orq	$0x1, %rbp
+	leaq 1+\ptregs_offset(%rsp), %rbp
 #endif
 .endm
 
-- 
2.14.3
