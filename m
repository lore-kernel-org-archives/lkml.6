Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2EFC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA4020870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548077164;
	bh=pn8NvDkjUXZxm5vucToeMhlBwtPcbI5F3xg+Z+D2ics=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UEgrbqpihPPjnBl90Db6WIzilf7vBVis9VWK6r/++KaJgxzYjjGOhxpAT5RLz40cE
	 ZS/d9QarwyGYyrz8IEgv24TaQD9nniOfswRmrpRzH40gM0q7pfChezN0kC8+6U6Nm4
	 saz6WYsCcJP75HorQyM6yZya33sxiQi1UwbskYwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfAUN0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbfAUN0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:26:02 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B40C2085A;
        Mon, 21 Jan 2019 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548077161;
        bh=pn8NvDkjUXZxm5vucToeMhlBwtPcbI5F3xg+Z+D2ics=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FUeHwPeQ5nFLt5HD7NicHyHtjx6By4fg3ObhnySxQPDKO9LARuobbpOcZ6Ib7aLMq
         WNOJh1GfiAM7GH61i63NPm27ge7qxxNMpWdP99kRj8V6CCLeZDgeLYTikq1Za53puI
         9H8u3NL3mLQoFKvL7gePmkdTiyauZ77NiGuRFkhg=
Date:   Mon, 21 Jan 2019 22:25:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
In-Reply-To: <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
        <154753353370.31541.14485875717131836689.stgit@devbox>
        <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019 12:20:07 +0000
James Morse <james.morse@arm.com> wrote:

> Hello,
> 
> On 15/01/2019 06:25, Masami Hiramatsu wrote:
> > Use arch_populate_kprobe_blacklist() instead of
> > arch_within_kprobe_blacklist() so that we can see the full
> > blacklisted symbols under the debugfs.
> > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > index b9e9758b6534..6c066c34c8a4 100644
> > --- a/arch/arm64/kernel/probes/kprobes.c
> > +++ b/arch/arm64/kernel/probes/kprobes.c
> > @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> >  	return DBG_HOOK_HANDLED;
> >  }
> >  
> > -bool arch_within_kprobe_blacklist(unsigned long addr)
> > +int __init arch_populate_kprobe_blacklist(void)
> >  {
> > -	if ((addr >= (unsigned long)__kprobes_text_start &&
> > -	    addr < (unsigned long)__kprobes_text_end) ||
> > -	    (addr >= (unsigned long)__entry_text_start &&
> > -	    addr < (unsigned long)__entry_text_end) ||
> > -	    (addr >= (unsigned long)__idmap_text_start &&
> > -	    addr < (unsigned long)__idmap_text_end) ||
> 
> > -	    in_exception_text(addr))
> 
> You added this one in the previous patch, but it disappears here.

Yes, it is easy to explain how we transcribe from 
arch_within_kprobe_blacklist() to arch_populate_kprobe_blacklist().

> 
> 
> > -		return true;
> > -
> > -	if (!is_kernel_in_hyp_mode()) {
> > -		if ((addr >= (unsigned long)__hyp_text_start &&
> > -		    addr < (unsigned long)__hyp_text_end) ||
> > -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> > -		    addr < (unsigned long)__hyp_idmap_text_end))
> > -			return true;
> > -	}
> > -
> > -	return false;
> > +	int ret;
> 
> 
> > +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> > +					(unsigned long)__kprobes_text_end);
> > +	if (ret)
> > +		return ret;
> 
> Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
> blacklist the kprobes section itself?

Ah, good catch! No, we don't need it here. Sorry I worked on older patch.
I'll update it.

> The weak arch_within_kprobe_blacklist() will test it at kprobe-load time, and
> populate_kprobe_blacklist() adds it to the list before it calls
> arch_populate_kprobe_blacklist().
> 
> Won't this result in duplicate entries?

yes, so it should not.

> 
> 
> > +	ret = kprobe_add_area_blacklist((unsigned long)__entry_text_start,
> > +					(unsigned long)__entry_text_end);
> > +	if (ret)
> > +		return ret;
> 
> > +	ret = kprobe_add_area_blacklist((unsigned long)__idmap_text_start,
> > +					(unsigned long)__idmap_text_end);
> 
> > +	if (ret || is_kernel_in_hyp_mode())
> > +		return ret;
> 
> 
> Hmmm, I think we have a bug here today.

OK.

> 
> This is saying we can kprobe KVM when we have VHE, because all of KVMs code runs
> at the same exception-level as the kernel. Which is true...
> But KVM switches VBAR_EL1, so if we run over one of kprobes BRK instructions,
> we're going to hyp-panic, because KVM doesn't handle synchronous exceptions from
> EL2.
> 
> The __hyp_text also contains the guest entry/exit code, which we mustn't probe,
> even on VHE.

Hmm, I'm not sure when the original code decided this. But it sounds reasonable.

> 
> I think we should always blacklist the __hyp_text, and KVM should mark its
> vhe-only functions with __kprobes. I'll post patches for this.

OK, then I should wait for that, because this series is a kind of improvement.
But your's is a bugfix, that should be backported to stable.

Thank you,

> 
> 
> Thanks,
> 
> James
> 
> 
> > +	ret = kprobe_add_area_blacklist((unsigned long)__hyp_text_start,
> > +					(unsigned long)__hyp_text_end);
> > +	if (ret)
> > +		return ret;
> > +	ret = kprobe_add_area_blacklist((unsigned long)__hyp_idmap_text_start,
> > +					(unsigned long)__hyp_idmap_text_end);
> > +	return ret;
> >  }
> >  
> >  void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
