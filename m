Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF19C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DA621B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549890630;
	bh=Nz+i2f+o5dnIOkuHcsi+Pot0S53/Oyises7pRO4U6RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wQV8urNUqKA1Iex77rN8nc0hhxC8W3pcs82PbD15U+bV7fIa+a75Dl7f4eNhEEIwN
	 HonaHLYo3gJgOJkwCW3bGGbgwX6qwT4dSIn3No6Goms0nEXvrEisRp1pV/cHp5u5m8
	 +uzKFmCuqxH/KQpuHY98yRJZxFCMA9rFAFOA2I9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbfBKNK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfBKNK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:10:28 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3D6A21855;
        Mon, 11 Feb 2019 13:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549890626;
        bh=Nz+i2f+o5dnIOkuHcsi+Pot0S53/Oyises7pRO4U6RU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gcPlS8RNhA2+aOWnsSveh2Ub/4F7lNA7dJ5vPK8Tpod6PcHLHJF+aq6guobl6kDSn
         tYdscE28fyWyFY09w+HpMoLYK9RBjSBu/mjU/39PVbDpobUuJqm9cjf9WeuI7uJ/ba
         Dm30XLX+3qrNdSTMczGIRUB18fMs8KYRf9dG2BFk=
Date:   Mon, 11 Feb 2019 22:10:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Pratyush Anand <panand@redhat.com>,
        "David A . Long" <dave.long@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: kprobes: Use
 arch_populate_kprobe_blacklist()
Message-Id: <20190211221023.0bb43554647f99afce8dd060@kernel.org>
In-Reply-To: <20190208091519.GB6972@fuggles.cambridge.arm.com>
References: <154753341900.31541.8135985235882849464.stgit@devbox>
        <154753353370.31541.14485875717131836689.stgit@devbox>
        <7f840cc8-4e62-e1d7-9035-4361204fc134@arm.com>
        <20190121222558.1ef0abc89a704597d6c3de7f@kernel.org>
        <20190208091519.GB6972@fuggles.cambridge.arm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019 09:15:19 +0000
Will Deacon <will.deacon@arm.com> wrote:

> Hi Masami,
> 
> On Mon, Jan 21, 2019 at 10:25:58PM +0900, Masami Hiramatsu wrote:
> > On Mon, 21 Jan 2019 12:20:07 +0000
> > James Morse <james.morse@arm.com> wrote:
> > > On 15/01/2019 06:25, Masami Hiramatsu wrote:
> > > > Use arch_populate_kprobe_blacklist() instead of
> > > > arch_within_kprobe_blacklist() so that we can see the full
> > > > blacklisted symbols under the debugfs.
> > > > diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
> > > > index b9e9758b6534..6c066c34c8a4 100644
> > > > --- a/arch/arm64/kernel/probes/kprobes.c
> > > > +++ b/arch/arm64/kernel/probes/kprobes.c
> > > > @@ -465,26 +465,30 @@ kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr)
> > > >  	return DBG_HOOK_HANDLED;
> > > >  }
> > > >  
> > > > -bool arch_within_kprobe_blacklist(unsigned long addr)
> > > > +int __init arch_populate_kprobe_blacklist(void)
> > > >  {
> > > > -	if ((addr >= (unsigned long)__kprobes_text_start &&
> > > > -	    addr < (unsigned long)__kprobes_text_end) ||
> > > > -	    (addr >= (unsigned long)__entry_text_start &&
> > > > -	    addr < (unsigned long)__entry_text_end) ||
> > > > -	    (addr >= (unsigned long)__idmap_text_start &&
> > > > -	    addr < (unsigned long)__idmap_text_end) ||
> > > 
> > > > -	    in_exception_text(addr))
> > > 
> > > You added this one in the previous patch, but it disappears here.
> > 
> > Yes, it is easy to explain how we transcribe from 
> > arch_within_kprobe_blacklist() to arch_populate_kprobe_blacklist().
> > 
> > > 
> > > 
> > > > -		return true;
> > > > -
> > > > -	if (!is_kernel_in_hyp_mode()) {
> > > > -		if ((addr >= (unsigned long)__hyp_text_start &&
> > > > -		    addr < (unsigned long)__hyp_text_end) ||
> > > > -		    (addr >= (unsigned long)__hyp_idmap_text_start &&
> > > > -		    addr < (unsigned long)__hyp_idmap_text_end))
> > > > -			return true;
> > > > -	}
> > > > -
> > > > -	return false;
> > > > +	int ret;
> > > 
> > > 
> > > > +	ret = kprobe_add_area_blacklist((unsigned long)__kprobes_text_start,
> > > > +					(unsigned long)__kprobes_text_end);
> > > > +	if (ret)
> > > > +		return ret;
> > > 
> > > Now that we have arch_populate_kprobe_blacklist(), does the arch-code need to
> > > blacklist the kprobes section itself?
> > 
> > Ah, good catch! No, we don't need it here. Sorry I worked on older patch.
> > I'll update it.
> 
> Did you send a new version of this series? I can't seem to spot it in my
> inbox.

Ah, OK. I just waited for James' patch series,

https://patchwork.kernel.org/cover/10779489/

Are those merged? I'd like to move this series on that.

Thank you for ping! :)


-- 
Masami Hiramatsu <mhiramat@kernel.org>
