Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC6C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFDB21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfBGOKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:10:32 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:38614 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfBGOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:10:32 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1grkNn-0002nU-G7; Thu, 07 Feb 2019 15:10:27 +0100
Date:   Thu, 7 Feb 2019 15:10:27 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 17/22] x86/fpu: Prepare copy_fpstate_to_sigframe() for
 TIF_NEED_FPU_LOAD
Message-ID: <20190207141027.ig3vjozwndspuwiw@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-18-bigeasy@linutronix.de>
 <20190130115614.GF18383@zn.tnic>
 <20190130122820.qyyn4vbtkqelmp54@linutronix.de>
 <20190130125351.GH18383@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130125351.GH18383@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-30 13:53:51 [+0100], Borislav Petkov wrote:
> > I've been asked to add comment above the sequence so it is understood. I
> > think the general approach is easy to follow once the concept is
> > understood. I don't mind renaming the TIF_ thingy once again (it
> > happend once or twice and I think the current one was suggested by Andy
> > unless I mixed things up).
> > The problem I have with the above is that
> > 
> > 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> > 		do_that()
> > 
> > becomes
> > 	if (!test_thread_flag(TIF_FPU_REGS_VALID))
> > 		do_that()
> 
> Err, above it becomes
> 
> 	if (test_thread_flag(TIF_FPU_REGS_VALID))
> 		copy_fpregs_to_fpstate(fpu);

The (your) above example yes. But the reverse state
 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
 		do_that()

becomes
 	if (!test_thread_flag(TIF_FPU_REGS_VALID))
 		do_that()

> without the "!". I.e., CPU's FPU regs are valid and we need to save them.
> 
> Or am I misreading the comment above?

Your example is correct. But in the opposite case, when ! was not there
then we have to add it.

> > and you could argue again the other way around. So do we want NEED_LOAD
> > or NEED_SAVE flag which is another way of saying REGS_VALID?
> 
> All fine and dandy except NEED_FPU_LOAD is ambiguous to me: we need to
> load them where? Into the CPU? Or into the FPU state save area?

if you need to LOAD then task-saved-area into CPU-state. If you need to
save it then CPU-state into task-saved-area.

> TIF_FPU_REGS_VALID is clearer in the sense that the CPU's FPU registers
> are currently valid for the current task. As there are no other FPU
> registers except the CPU's.

hmmm. I think it is just taste / habit.

> > More importantly the logic is changed when the bit is set and this
> > requires more thinking than just doing sed on the patch series.
> 
> Sure.
> 
> And I'll get accustomed to the logic whatever the name is - this is just
> a "wouldn't it be better" thing.

If it would be just a name thing then I probably wouldn't mind. But
swapping the logic might break things so I try to avoid that.

> Thx.
> 

Sebastian
