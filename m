Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82936C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553AB21917
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfBHJPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:15:23 -0500
Received: from foss.arm.com ([217.140.101.70]:46656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbfBHJPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:15:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C8380D;
        Fri,  8 Feb 2019 01:15:22 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D01E3F557;
        Fri,  8 Feb 2019 01:15:21 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:15:19 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-ID: <20190208091519.GB6972@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
 <154753353370.31541.14485875717131836689.stgit@devbox>
 <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
 <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, Jan 21, 2019 at 10:25:58PM +0900, Masami Hiramatsu wrote:
> On Mon, 21 Jan 2019 12:20:07 +0000
> James Morse <james.morse@arm.com> wrote:
> > On 15/01/2019 06:25, Masami Hiramatsu wrote:
> > > Use arch_populate_kprobe_blacklist() instead of
> > > arch_within_kprobe_blacklist() so that we can see the full
> > > blacklisted symbols under the debugfs.
> > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > index b9e9758b6534..6c066c34c8a4 100644
> > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> > >  	return DBG_HOOK_HANDLED;
> > >  }
> > >  
> > > -bool arch_within_kprobe_blacklist(unsigned long addr)
> > > +int __init arch_populate_kprobe_blacklist(void)
> > >  {
> > > -	if ((addr >= (unsigned long)__kprobes_text_start &&
> > > -	    addr < (unsigned long)__kprobes_text_end) ||
> > > -	    (addr >= (unsigned long)__entry_text_start &&
> > > -	    addr < (unsigned long)__entry_text_end) ||
> > > -	    (addr >= (unsigned long)__idmap_text_start &&
> > > -	    addr < (unsigned long)__idmap_text_end) ||
> > 
> > > -	    in_exception_text(addr))
> > 
> > You added this one in the previous patch, but it disappears here.
> 
> Yes, it is easy to explain how we transcribe from 
> arch_within_kprobe_blacklist() to arch_populate_kprobe_blacklist().
> 
> > 
> > 
> > > -		return true;
> > > -
> > > -	if (!is_kernel_in_hyp_mode()) {
> > > -		if ((addr >= (unsigned long)__hyp_text_start &&
> > > -		    addr < (unsigned long)__hyp_text_end) ||
> > > -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> > > -		    addr < (unsigned long)__hyp_idmap_text_end))
> > > -			return true;
> > > -	}
> > > -
> > > -	return false;
> > > +	int ret;
> > 
> > 
> > > +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> > > +					(unsigned long)__kprobes_text_end);
> > > +	if (ret)
> > > +		return ret;
> > 
> > Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
> > blacklist the kprobes section itself?
> 
> Ah, good catch! No, we don't need it here. Sorry I worked on older patch.
> I'll update it.

Did you send a new version of this series? I can't seem to spot it in my
inbox.

Cheers,

Will
