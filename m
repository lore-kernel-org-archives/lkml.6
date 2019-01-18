Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA56C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744702086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfARRBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:01:20 -0500
Received: from foss.arm.com ([217.140.101.70]:34696 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfARRBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:01:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E08F980D;
        Fri, 18 Jan 2019 09:01:19 -0800 (PST)
Received: from localhost (unknown [10.37.6.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7951E3F7BE;
        Fri, 18 Jan 2019 09:01:19 -0800 (PST)
Date:   Fri, 18 Jan 2019 17:01:17 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Grant Likely <Grant.Likely@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-eng] [RFC 0/3] Abstract empty functions with STUB_UNLESS
 macro
Message-ID: <20190118170117.GC8120@e119886-lin.cambridge.arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
 <20190118164425.GC3578@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118164425.GC3578@e103592.cambridge.arm.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:44:25PM +0000, Dave Martin wrote:
> On Fri, Jan 18, 2019 at 04:37:36PM +0000, Russell King - ARM Linux admin wrote:
> > On Fri, Jan 18, 2019 at 04:00:27PM +0000, Andrew Murray wrote:
> > > A common pattern found in header files is a function declaration dependent
> > > on a CONFIG_ option being enabled, followed by an empty function for when
> > > that option isn't enabled. This boilerplate code can often take up a lot
> > > of space and impact code readability.
> > > 
> > > This series introduces a STUB_UNLESS macro that simplifies header files as
> > > follows:
> > > 
> > > STUB_UNLESS(CONFIG_FOO, [body], prototype)
> > 
> > Can you explain the desire to make the second argument optional,
> > rather than having the mandatory arguments first and the optional body
> > last?  It will mean more lines at each site, but I don't think that's
> > a bad thing:

My intent was to make the function prototype look like an ordinary prototype
but with all this special macro stuff on the preceding line. Much like this:

> > 
> > STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> > void hw_breakpoint_thread_switch(struct task_struct *next));

Besides the extra ')' at the end it looks like a normal prototype. I felt this
may be important as existing tooling (ctags etc) might have a better chance of
recognising it and it wouldn't be so alien to new developers. I feared that if
the 'prototype' argument was in the middle then it would get lost in all the
other arguments and be less readable as a prototype.

> > 
> > STUB_UNLESS(CONFIG_CPU_FREQ,
> > struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu), return NULL);
> > 
> > or:
> > 
> > STUB_UNLESS(CONFIG_CPU_FREQ,
> > struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu),
> > 	return NULL);

As you indicate here, it's possible to spread this to three lines and keep the
readability of the prototype - though I was keen to condense it to as few lines
as possible (I was probably putting too much focus on the diff stat).

> > 
> > Seems to be more readable in terms of the flow.
> 
> Hmmm, looking at that, I probably prefer that too.

Feedback I've had so far suggests that there is a preference to putting the
optional argument at the end, I have no objection to this.

> 
> In the unlikely case that <body> uses the function arguments it would be
> quite confusing to have the body before the function prototype.
> 
> If we can keep this down to two lines so much the better, but still
> seems fine.

This is the compromise - having the optional argument after the prototype
will likely result in wrapping to the next line as prototypes tend to be
long. Perhaps this is more readable.

> 
> Provided we don't end up needing a trailing comma in the void case, to
> supply the empty body argument, that is.

No this isn't necessary.

Thanks,

Andrew Murray

> 
> Cheers
> ---Dave
