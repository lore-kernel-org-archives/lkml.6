Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644ECC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FC88223AE
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MrJkAa0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC88223AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbeKLSnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:43:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58940 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FiV8Sx/bNJbokAdpwsOzfPWDOBMjFv27VvCNUYxmih4=; b=MrJkAa0azYfbepo+u6S5mv/k4W
        t5juG8x9Hrwe5vnDlvghTH40UQzZ0FO4ZiBff/sEfSd7GlKTQqzTxjLzN1DoizoyPpzQa+6CJC/Js
        U2kxCFGN1W77EeuzYcuU3iMJst7l4peZMCF28GmyBJ4LvjeD7PNNDotiZ842ZVd0kIvttamJXnqzp
        w7IdJEjm7/F2xK8F/7ZaGKfVJkKTeBPDas4fvpIxqte2vBUy7K+Fx5cp36UL51tbqT0gBTLAzmGuC
        Jw3KwWZvBQ3KcKHfz/9IOSfyVLDxg6+0z/rUn+0dvu/PSqwlJ6Kyy3yFoZZaXRfA8WfPAIPwc51nU
        pcXdXgdA==;
Received: from [64.114.255.114] (helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM7vt-0005ji-G2; Mon, 12 Nov 2018 08:50:57 +0000
Received: by worktop (Postfix, from userid 1000)
        id 381AE6E03B0; Mon, 12 Nov 2018 09:50:56 +0100 (CET)
Date:   Mon, 12 Nov 2018 09:50:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 06/10] x86/alternative: use temporary mm for text
 poking
Message-ID: <20181112085056.GK3056@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
 <20181111145936.GA3021@worktop>
 <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
 <20181111235220.GB3056@worktop>
 <20181112034646.GA88919@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112034646.GA88919@gmail.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 04:46:46AM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Sun, Nov 11, 2018 at 08:53:07PM +0000, Nadav Amit wrote:
> > 
> > > >> +	/*
> > > >> +	 * The lock is not really needed, but this allows to avoid open-coding.
> > > >> +	 */
> > > >> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> > > >> +
> > > >> +	/*
> > > >> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> > > >> +	 * since we preallocate the PTE.
> > > >> +	 */
> > > >> +	if (WARN_ON_ONCE(!ptep))
> > > >> +		goto out;
> > > > 
> > > > Since we hard rely on init getting that right; can't we simply get rid
> > > > of this?
> > > 
> > > This is a repeated complaint of yours, which I do not feel comfortable with.
> > > One day someone will run some static analysis tool and start finding that
> > > all these checks are missing.
> > > 
> > > The question is why do you care about them.
> > 
> > Mostly because they should not be happening, ever.
> 
> Since get_locked_pte() might in principle return NULL, it's an entirely 
> routine pattern to check the return for NULL. This will save reviewer 
> time in the future.

The reviewer can read a comment.

> > > If it is because they affect the
> > > generated code and make it less efficient, I can fully understand and perhaps
> > > we should have something like PARANOID_WARN_ON_ONCE() which compiles into nothing
> > > unless a certain debug option is set.
> > > 
> > > If it is about the way the source code looks - I guess it doesn’t sore my
> > > eyes as hard as some other stuff, and I cannot do much about it (other than
> > > removing it as you asked).
> > 
> > And yes on the above two points. It adds both runtime overhead (albeit
> > trivially small) and code complexity.
> 
> It's trivially small cycle level overhead in something that will be 
> burdened by two TLB flushes anyway is is utterly slow.

The code complexity not so much.

> > > >> +out:
> > > >> +	if (memcmp(addr, opcode, len))
> > > >> +		r = -EFAULT;
> > > > 
> > > > How could this ever fail? And how can we reliably recover from that?
> > > 
> > > This code has been there before (with slightly uglier code). Before this
> > > patch, a BUG_ON() was used here. However, I noticed that kgdb actually
> > > checks that text_poke() succeeded after calling it and gracefully fail.
> > > However, this was useless, since text_poke() would panic before kgdb gets
> > > the chance to do anything (see patch 7).
> > 
> > Yes, I know it was there before, and I did see kgdb do it too. But aside
> > from that out-label case, which we also should never hit, how can we
> > realistically ever fail that memcmp()?
> > 
> > If we fail here, something is _seriously_ buggered.
> 
> So wouldn't it be better to just document and verify our assumptions of 
> this non-trivial code by using return values intelligently?

The thing is, I don't think there is realistically anything the caller
can do; our text is not what we expect it to be, that is a fairly
fundamentally buggered situation to be in.

I'm fine with validating it; I'm as paranoid as the next guy; but
passing along that information seems pointless. At best we can try
poking again, but that's not going to help much if it failed the first
time around.
