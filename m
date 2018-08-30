Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB11C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422EE20666
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 01:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj3uL4mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422EE20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeH3Fim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 01:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbeH3Fim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 01:38:42 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65D920647;
        Thu, 30 Aug 2018 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535593143;
        bh=8VlH8e8j2cWDJs9IABSd5/ciDypp8K7ukiOk3NJaHAE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zj3uL4mopCYWNyOGbCZxST7/BgQSQ4Ijlk2bHjO0Or977olW+02NjRbrMVcW5mFTN
         iJmhwJcARnz1n+fCI2z2Pkt9y6n0ACUn5HgkhhPaEq5YMXsz3IYW5i83f7SjWAIxB1
         zAy0yHWUVhmh2+zNCXB3t2dS7V8NmH+8peL1UL6c=
Date:   Thu, 30 Aug 2018 10:38:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/6] x86/mm: temporary mm struct
Message-Id: <20180830103859.ac309b71c53d267da2f6e9f8@kernel.org>
In-Reply-To: <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
References: <20180829081147.184610-1-namit@vmware.com>
        <20180829081147.184610-3-namit@vmware.com>
        <20180829184925.64caee4dadf705080373f84f@kernel.org>
        <CALCETrWF5XQndPikmBgo9t1UWKS7T0K2kFGOpzX-tavFVis5_Q@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 08:41:00 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, Aug 29, 2018 at 2:49 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > On Wed, 29 Aug 2018 01:11:43 -0700
> > Nadav Amit <namit@vmware.com> wrote:
> >
> >> From: Andy Lutomirski <luto@kernel.org>
> >>
> >> Sometimes we want to set a temporary page-table entries (PTEs) in one of
> >> the cores, without allowing other cores to use - even speculatively -
> >> these mappings. There are two benefits for doing so:
> >>
> >> (1) Security: if sensitive PTEs are set, temporary mm prevents their use
> >> in other cores. This hardens the security as it prevents exploding a
> >> dangling pointer to overwrite sensitive data using the sensitive PTE.
> >>
> >> (2) Avoiding TLB shootdowns: the PTEs do not need to be flushed in
> >> remote page-tables.
> >>
> >> To do so a temporary mm_struct can be used. Mappings which are private
> >> for this mm can be set in the userspace part of the address-space.
> >> During the whole time in which the temporary mm is loaded, interrupts
> >> must be disabled.
> >>
> >> The first use-case for temporary PTEs, which will follow, is for poking
> >> the kernel text.
> >>
> >> [ Commit message was written by Nadav ]
> >>
> >> Cc: Andy Lutomirski <luto@kernel.org>
> >> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> >> Cc: Kees Cook <keescook@chromium.org>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Signed-off-by: Nadav Amit <namit@vmware.com>
> >> ---
> >>  arch/x86/include/asm/mmu_context.h | 20 ++++++++++++++++++++
> >>  1 file changed, 20 insertions(+)
> >>
> >> diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
> >> index eeeb9289c764..96afc8c0cf15 100644
> >> --- a/arch/x86/include/asm/mmu_context.h
> >> +++ b/arch/x86/include/asm/mmu_context.h
> >> @@ -338,4 +338,24 @@ static inline unsigned long __get_current_cr3_fast(void)
> >>       return cr3;
> >>  }
> >>
> >> +typedef struct {
> >> +     struct mm_struct *prev;
> >> +} temporary_mm_state_t;
> >> +
> >> +static inline temporary_mm_state_t use_temporary_mm(struct mm_struct *mm)
> >> +{
> >> +     temporary_mm_state_t state;
> >> +
> >> +     lockdep_assert_irqs_disabled();
> >> +     state.prev = this_cpu_read(cpu_tlbstate.loaded_mm);
> >> +     switch_mm_irqs_off(NULL, mm, current);
> >> +     return state;
> >> +}
> >
> > Hmm, why don't we return mm_struct *prev directly?
> 
> I did it this way to make it easier to add future debugging stuff
> later. Also, when I first wrote this, I stashed the old CR3 instead
> of the old mm_struct, and it seemed like callers should be insulated
> from details like this.

Hmm, I see. But in that case, we should call it "struct temporary_mm"
and explicitly allocate (and pass) it, since we can not return the
data structure from stack. If we can combine it with new mm, it will
be more encapsulated e.g.

struct temporary_mm {
	struct mm_struct *mm;
	struct mm_struct *prev;
};

static struct temporary_mm poking_tmp_mm;

poking_init()
{
	if (init_temporary_mm(&tmp_mm, &init_mm))
		goto error;
	...
}

text_poke_safe()
{
	...
	use_temporary_mm(&tmp_mm);
	...
	unuse_temporary_mm(&tmp_mm);
}

Any thought?

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
