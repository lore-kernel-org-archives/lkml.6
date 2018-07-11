Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855F0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C88820854
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghTyBpie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbeGKJQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:16:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36642 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbeGKJQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V70Dcordknmgk0HmEDzEZsFCiABvqy1N1KLguVpmJu0=; b=ghTyBpieehW3H6dhM9eWLkGm4
        Y5kwyjCkKgajb1nYaNmrSKbLo+KgK173ssnAuRTcMlWE7LOVOuU0099RbDGVw06mtdBX+12hoEDC4
        LHdh+lJhyU+1cFT7Y64sQZI1nf6MRker7qg20w4PEwhC8SXqhr6TqpgKAsmYBkZxsouqR99qyhdjm
        rZRs2/bnvUNOz/UcePQDftQcGgUzAMSlWrRueQ/xRAmRy8+xz0xsohCWPNJ+7q99UzJrm/luyxWng
        5rKlOy2t+tTu7OmmBx62doqfZi0vwJQEuBPyabtSVAuSCXtUsTox2IxEaojgi41iddE9EPnSFU/ag
        j7Bk/2Ufw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdBAo-0005ex-37; Wed, 11 Jul 2018 09:12:34 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8ABDC20291063; Wed, 11 Jul 2018 11:12:32 +0200 (CEST)
Date:   Wed, 11 Jul 2018 11:12:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Subject: Re: [RFC PATCH v2 15/27] mm/mprotect: Prevent mprotect from changing
 shadow stack
Message-ID: <20180711091232.GU2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
 <20180710222639.8241-16-yu-cheng.yu@intel.com>
 <04800c52-1f86-c485-ba7c-2216d8c4966f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04800c52-1f86-c485-ba7c-2216d8c4966f@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:10:08PM -0700, Dave Hansen wrote:
> On 07/10/2018 03:26 PM, Yu-cheng Yu wrote:
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> 
> This still needs a changelog, even if you think it's simple.
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -446,6 +446,15 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
> >  	error = -ENOMEM;
> >  	if (!vma)
> >  		goto out;
> > +
> > +	/*
> > +	 * Do not allow changing shadow stack memory.
> > +	 */
> > +	if (vma->vm_flags & VM_SHSTK) {
> > +		error = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> I think this is a _bit_ draconian.  Why shouldn't we be able to use
> protection keys with a shadow stack?  Or, set it to PROT_NONE?

Right, and then there's also madvise() and some of the other accessors.

Why do we need to disallow this? AFAICT the worst that can happen is
that a process wrecks itself, so what?
