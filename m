Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6206C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B09D21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBGKNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:13:12 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37594 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfBGKNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:13:11 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1grgg2-0005vQ-0y; Thu, 07 Feb 2019 11:13:02 +0100
Date:   Thu, 7 Feb 2019 11:13:01 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 07/22] x86/fpu: Remove fpu->initialized
Message-ID: <20190207101301.vlaiikyqweftemxu@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-8-bigeasy@linutronix.de>
 <20190124133449.GC11554@zn.tnic>
 <20190205180336.smegi6rz7waprfaf@linutronix.de>
 <20190206140114.GD7314@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206140114.GD7314@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-02-06 15:01:14 [+0100], Borislav Petkov wrote:
> On Tue, Feb 05, 2019 at 07:03:37PM +0100, Sebastian Andrzej Siewior wrote:
> > Well, nothing changes in regard to the logic. Earlier we had a variable
> > which helped us to distinguish between user & kernel thread. Now we have
> > a different one. 
> > I'm going to add a comment to switch_fpu_prepare() about ->mm since you
> > insist but I would like to avoid it.
> 
> I don't understand what that aversion is towards commenting stuff,
> especially important stuff like the meaning of the presence of ->mm for
> the FPU code. What is the downside to documenting that?

I don't like commenting the obvious things in code but I might be wrong
on what I consider here obvious. The important part is probably that we
don't save/restore FPU registers for kernel threads but this isn't new,
it was always like that (more or less implicit). The ->mm part is an
implementation detail (and is used in other places).
That said I already added this:
|@@ -525,11 +525,14 @@ static inline void fpregs_activate(struc
|  *
|  *  - switch_fpu_finish() restores the new state as
|  *    necessary.
|+ *
|+ * The FPU context is only stored/restore for user task and ->mm is used to
|+ * distinguish between kernel and user threads.
|  */
| static inline void
| switch_fpu_prepare(struct fpu *old_fpu, int cpu)
| {

and I *think* that this is enough. This *what* we do and not *why*. I
don't have an answer towards *why*.

> Considering that in this very thread we ourselves encountered the fact
> that stuff is not documented and we complained that it wasn't!

Yes. We had no idea why we save the FPU registers on user's stack during
signal handling. Was this an implementation detail on kernel side as
part of signal handling or is this required/ expected by the user as
part of a use case? We have now the explanation that signals may
cascade. Do we know by now if userland is supposed to use it or it
accessed the register because they were available?
The MPX code did access the MPX part of the xsave area (others do it for
"testing/debug" as per my I google research). This kind of things should
be part of the ABI document and not only a comment in the kernel.
Are the MAGIC constants only in-kernel use (to check if the user
accidentally overwrote its stack) or should be checked by the user
during signal handling to ensure that the xsave area is available.

> > We have a comment, it is just not helping.
> 
> Why is it not helping?

The part you referred to was:
|-       /* Update the thread's fxstate to save the fsave header. */
|-       if (ia32_fxstate) 
|-               copy_fxregs_to_kernel(fpu);

and it is not helping because it does not explain why it is done. I can
see based on the code that the FXstate is saved in case of a 32bit
frame. It is saved into thread's state. It does not explain why it
needs to be done. That is the "not helping" part.

> > Steven said on IRC that it can be removed.
> 
> Did he give an explanation why is it ok?

I can forward you the IRC pieces offlist if you like. He said I can
remove it if there are no users and I am not aware of any. He pointed
out that sched_wakeup had a "success" member which was relied on by
tools so it remained in order not to break them. So we have
	__entry->success        = 1; /* rudiment, kill when possible */

in the tree now. I can loop him in if this is not enough.

> Thx.

Sebastian
