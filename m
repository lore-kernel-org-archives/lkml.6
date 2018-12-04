Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C43C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE2B2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BE2B2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeLDR0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:26:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbeLDR0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:26:30 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABD9A2081C;
        Tue,  4 Dec 2018 17:26:29 +0000 (UTC)
Date:   Tue, 4 Dec 2018 12:26:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] arm64: ftrace: add cond_resched() to func
 ftrace_make_(call|nop)
Message-ID: <20181204122627.225befaa@vmware.local.home>
In-Reply-To: <20181204111242.GA32596@arm.com>
References: <20181130150956.27620-1-anders.roxell@linaro.org>
        <20181203192228.GC29028@arm.com>
        <CAK8P3a2gekEqUuvsC-_+ijhiqqff2bK-s2wQfkjn7z-HtNnMDQ@mail.gmail.com>
        <20181204005012.11f73df9@vmware.local.home>
        <20181204111242.GA32596@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 11:12:43 +0000
Will Deacon <will.deacon@arm.com> wrote:

> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index 8ef9fc226037..42e89397778b 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -2393,11 +2393,14 @@ void __weak ftrace_replace_code(int enable)
> >  {
> >  	struct dyn_ftrace *rec;
> >  	struct ftrace_page *pg;
> > +	bool schedulable;
> >  	int failed;
> >  
> >  	if (unlikely(ftrace_disabled))
> >  		return;
> >  
> > +	schedulable = !irqs_disabled() & !preempt_count();  
> 
> Looks suspiciously like a bitwise preemptible() to me!

Ah, thanks. Yeah, that should have been &&. But what did you expect.
I didn't even compile this ;-)

> 
> > +
> >  	do_for_each_ftrace_rec(pg, rec) {
> >  
> >  		if (rec->flags & FTRACE_FL_DISABLED)
> > @@ -2409,6 +2412,8 @@ void __weak ftrace_replace_code(int enable)
> >  			/* Stop processing */
> >  			return;
> >  		}
> > +		if (schedulable)
> > +			cond_resched();
> >  	} while_for_each_ftrace_rec();
> >  }  
> 
> If this solves the problem in core code, them I'm all for it. Otherwise, I
> was thinking of rolling our own ftrace_replace_code() for arm64, but that's
> going to involve a fair amount of duplication.
> 

If it does, then I'll add it. Or take a patch for it ;-) 

My main concern is that this can be called from non schedulable context.

-- Steve
