Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F7DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61FDE2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gwXwTyox"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FDE2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbeJaW6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:58:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33218 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbeJaW6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7FIXNmW1rq3sjMWtDvDoTVWTt1PCS4dnycReiPvH37c=; b=gwXwTyoxhFJilNsVg86HtKZes
        gt8786f7UjECGnt5evRfGUUuPCI60AeR+jFNdzWvwk/BgAcLAQynDkGHPjsJMxYK54UbMm3Mr0tPa
        /5sN0s9NbiC+7+5+eCzm0o44DYWDm7ui6skTfaqWfWtCxvmi1CyNf6Cd59i4IPyUhojOigredCM7h
        2qnuQ3UT5Ipa8vKAd6vTGia90hicbPPf7mzLp29x887KgZPJMAt3uBeCEW9Rw4BamCs8NldGfOdSS
        5S8mC7bXyzkRkY3C3KnT5kIu83dQGoFTGpjSxskvInbfqmSYLeB5Iq5Y23B4OtVsJe8CNOKSk6s3h
        zfT30zu+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHr2w-0005yx-1L; Wed, 31 Oct 2018 14:00:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1B54920297608; Wed, 31 Oct 2018 15:00:32 +0100 (CET)
Date:   Wed, 31 Oct 2018 15:00:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     Linux-Kernel <linux-kernel@vger.kernel.org>, mingo@redhat.com,
        konrad.wilk@oracle.com, dwmw@amazon.co.uk, tglx@linutronix.de,
        Srinivas REDDY Eeda <srinivas.eeda@oracle.com>, bp@suse.de,
        hpa@zytor.com
Subject: Re: [PATCH 3/3] kprobes/x86: Simplify indirect-jump check in
 retpoline
Message-ID: <20181031140032.GB13257@hirez.programming.kicks-ass.net>
References: <cc8f9981-f327-4238-8378-262579584db4@default>
 <20181030083650.GB1459@hirez.programming.kicks-ass.net>
 <849ae148-85cd-5f46-d98b-b827cc9c605c@oracle.com>
 <20181031135320.GC13237@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031135320.GC13237@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 02:53:20PM +0100, Peter Zijlstra wrote:
> On Wed, Oct 31, 2018 at 02:01:20PM +0800, Zhenzhong Duan wrote:
> > On 2018/10/30 16:36, Peter Zijlstra wrote:
> > > On Mon, Oct 29, 2018 at 11:55:06PM -0700, Zhenzhong Duan wrote:
> > > > Since CONFIG_RETPOLINE hard depends on compiler support now, so
> > > > replacing indirect-jump check with the range check is safe in that case.
> > > 
> > > Can we put kprobes on module init text before we run alternatives on it?
> > 
> > Forgive me I doesn't understand your question. Do you mean this patch impact
> > kprobes on module init text?
> 
> In that case we would still see the indirect paravirt calls for example,
> and we'd still need that cascade you took out.
> 
> Now, I'm not at all sure we're able to use kprobes at those times, so it
> might be a non-issue.

Hmm, what about the case where we have RETPOLINE runtime disabled? Then
the CALL_NOSPEC alternative patches in an indirect call again, and the
retpolines are gone.

Does that not need the __insn_is_indirect_jump() thing?

> > > > @@ -240,20 +242,16 @@ static int insn_jump_into_range(struct insn *insn, unsigned long start, int len)
> > > >   static int insn_is_indirect_jump(struct insn *insn)
> > > >   {
> > > > -	int ret = __insn_is_indirect_jump(insn);
> > > > +	int ret;
> > > >   #ifdef CONFIG_RETPOLINE
> > > > -	/*
> > > > -	 * Jump to x86_indirect_thunk_* is treated as an indirect jump.
> > > > -	 * Note that even with CONFIG_RETPOLINE=y, the kernel compiled with
> > > > -	 * older gcc may use indirect jump. So we add this check instead of
> > > > -	 * replace indirect-jump check.
> > > > -	 */
> > > > -	if (!ret)
> > > > +	/* Jump to x86_indirect_thunk_* is treated as an indirect jump. */
> > > >   		ret = insn_jump_into_range(insn,
> > > >   				(unsigned long)__indirect_thunk_start,
> > > >   				(unsigned long)__indirect_thunk_end -
> > > >   				(unsigned long)__indirect_thunk_start);
> > > > +#else
> > > > +		ret = __insn_is_indirect_jump(insn);
> > > >   #endif
> > > >   	return ret;
> > > >   }
> > > 
> > > The resulting code is indented wrong.
> > > 
> > 
> > Oh, yes. Thanks for point out.
> > 
> > Zhenzhong
