Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBF9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15057215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7yYS1FS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15057215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbeKLKcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 05:32:23 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35402 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeKLKcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 05:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x+V/mpkFJL350jC6rpFriOnnIh0JqQqhLM0py63U4ic=; b=u7yYS1FS0m5tLC26vNjK/hS2lC
        9q48ZNVjylegLxaMQ1nOvj1YXhVLHFEl0U5qJReyGe0mCh0dJHhsgwpZoYn4uHcB6bT6SavyY6CMo
        q2jw28bIWDv6iRW5eh+IsLWPifcOMFU0AaTwbL19017qGryWM1KHYQo1wNs/+ekAw+Jn0nFbqipyJ
        kq1iSjN+d+7mQRD1CeobNKe8jY0p4Dp+RHNFIVf8vOHPDT0TfjAI5+KSJL5NOlpjoRvAFG6igiCX/
        0hjWfSdlV8iZbXj59XNoHKh71erudyVDgHWHIO6AsWVh4ZbDL7Q7bSLMSXTHZjNuxdRBTzVIWl9lS
        dlnRTxCw==;
Received: from [64.114.255.97] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gM0IO-0004YT-To; Mon, 12 Nov 2018 00:41:41 +0000
Received: by worktop (Postfix, from userid 1000)
        id 326296E061A; Mon, 12 Nov 2018 01:41:40 +0100 (CET)
Date:   Mon, 12 Nov 2018 01:41:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20181112004140.GF3056@worktop>
References: <20181110231732.15060-1-namit@vmware.com>
 <20181110231732.15060-7-namit@vmware.com>
 <20181111145936.GA3021@worktop>
 <43C8C690-F079-4513-82CD-46A62DBA5A3B@vmware.com>
 <20181111235220.GB3056@worktop>
 <70EACCF7-D854-4051-9F71-4E966FD6C37B@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70EACCF7-D854-4051-9F71-4E966FD6C37B@vmware.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 12:09:32AM +0000, Nadav Amit wrote:
> > On Sun, Nov 11, 2018 at 08:53:07PM +0000, Nadav Amit wrote:
> > 
> >>>> +	/*
> >>>> +	 * The lock is not really needed, but this allows to avoid open-coding.
> >>>> +	 */
> >>>> +	ptep = get_locked_pte(poking_mm, poking_addr, &ptl);
> >>>> +
> >>>> +	/*
> >>>> +	 * If we failed to allocate a PTE, fail. This should *never* happen,
> >>>> +	 * since we preallocate the PTE.
> >>>> +	 */
> >>>> +	if (WARN_ON_ONCE(!ptep))
> >>>> +		goto out;
> >>> 
> >>> Since we hard rely on init getting that right; can't we simply get rid
> >>> of this?

> I understand. So the question is - what would you prefer: something like
> PARANOID_WARN_ON_ONCE() or should I just remove the assertion?

Something like:

	/*
	 * @ptep cannot be NULL per construction in poking_init().
	 */

And then leave it at that. If it ever comes unstuck we'll get the NULL
deref, which is just as good as a BUG_ON().

> >>>> +out:
> >>>> +	if (memcmp(addr, opcode, len))
> >>>> +		r = -EFAULT;
> >>> 
> >>> How could this ever fail? And how can we reliably recover from that?
> >> 
> >> This code has been there before (with slightly uglier code). Before this
> >> patch, a BUG_ON() was used here. However, I noticed that kgdb actually
> >> checks that text_poke() succeeded after calling it and gracefully fail.
> >> However, this was useless, since text_poke() would panic before kgdb gets
> >> the chance to do anything (see patch 7).
> > 
> > Yes, I know it was there before, and I did see kgdb do it too. But aside
> > from that out-label case, which we also should never hit, how can we
> > realistically ever fail that memcmp()?
> > 
> > If we fail here, something is _seriously_ buggered.
> 
> I agree. But as it may be useful at least to warn in such a case, as
> debugging of SMC/CMC is hard. For example, if there is some sort of a race
> between module (un)loading and static-keys - such a check might be
> beneficial to indicate so. Having said that, changing it into VM_BUG_ON() or
> something similar may make more sense.
> 
> Personally, I don’t care much - I’m just worried that I made some intrusive
> changes *and* you want me to remove the assertion that checks that I didn’t
> screw up.

Ah, so I'm perfectly fine with something like:

	VM_BUG_ON(memcmp());

I just don't see value in the whole return code here. If this comes
unstuck, we're buggered beyond repair.
