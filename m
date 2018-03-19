Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970277AbeCSVVY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:21:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S969858AbeCSVUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:20:55 -0400
Date: Mon, 19 Mar 2018 16:20:53 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] x86/unwind: Make CONFIG_UNWINDER_ORC=y the default
 in kconfig for 64-bit
Message-ID: <20180319212053.e77dc3vmemfazt3b@treble>
References: <20171013052544.euk7yawni47lhmdq@gmail.com>
 <9b1237bbe7244ed9cdf8db2dcb1253e37e1c341e.1507924831.git.jpoimboe@redhat.com>
 <20180319185732.GD37438@google.com>
 <20180319192910.wfbi656bxkrlurgf@treble>
 <20180319203130.GE37438@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319203130.GE37438@google.com>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 01:31:30PM -0700, Matthias Kaehlcke wrote:
> > The ORC unwinder relies on objtool, which reverse engineers the compiled
> > code.  This is objtool's first exposure to clang, so I'm not at all
> > surprised if it's getting confused.
> > 
> > Send me one of the .o files and I can take a quick look to see how bad
> > it is, but I'm guessing it's going to be a lot of work to make objtool
> > compatible with clang (and unfortunately I won't have the bandwidth to
> > work on that in the near term.)
> > 
> > In the meantime I'd recommend that you use frame pointers (and
> > CONFIG_STACK_VALIDATION=n) for clang-compiled kernels.
> 
> Thanks for your assessment!
> 
> dvo_ch7017.o is attached.

Here's a (surprisingly easy) fix for this particular issue, though I'd
be shocked if there weren't a bunch more issues lurking elsewhere.  Let
me know how it goes.

BTW, one thing I noticed in the .o file is that most of the functions'
stacks are aligned to 16 bytes.  It might be worth checking if the clang
-mstack-alignment=8 option is getting set, and if so, if it's working
properly.  Otherwise, with aligned stacks, the frame pointer is forced,
which defeats most of the benefits of ORC.

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 92b6a2c21631..f02df714c18e 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1386,6 +1386,17 @@ static int update_insn_state(struct instruction *insn, struct insn_state *state)
 				state->vals[op->dest.reg].offset = -state->stack_size;
 			}
 
+			else if (op->src.reg == CFI_BP && op->dest.reg == CFI_SP &&
+				 cfa->base == CFI_BP) {
+
+				/*
+				 * mov %rbp, %rsp
+				 *
+				 * Restore the original stack pointer (clang).
+				 */
+				state->stack_size = -state->regs[CFI_BP].offset;
+			}
+
 			else if (op->dest.reg == cfa->base) {
 
 				/* mov %reg, %rsp */
