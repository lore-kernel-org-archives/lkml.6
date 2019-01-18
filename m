Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79D6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B353B20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbfARQob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:44:31 -0500
Received: from foss.arm.com ([217.140.101.70]:34128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfARQoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:44:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5636480D;
        Fri, 18 Jan 2019 08:44:30 -0800 (PST)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FC653F7BE;
        Fri, 18 Jan 2019 08:44:27 -0800 (PST)
Date:   Fri, 18 Jan 2019 16:44:25 +0000
From:   Dave Martin <Dave.Martin@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Andrew Murray <andrew.murray@arm.com>,
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
Message-ID: <20190118164425.GC3578@e103592.cambridge.arm.com>
References: <1547827230-55132-1-git-send-email-andrew.murray@arm.com>
 <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118163736.6lczivagpsdnm7ju@e5254000004ec.dyn.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:37:36PM +0000, Russell King - ARM Linux admin wrote:
> On Fri, Jan 18, 2019 at 04:00:27PM +0000, Andrew Murray wrote:
> > A common pattern found in header files is a function declaration dependent
> > on a CONFIG_ option being enabled, followed by an empty function for when
> > that option isn't enabled. This boilerplate code can often take up a lot
> > of space and impact code readability.
> > 
> > This series introduces a STUB_UNLESS macro that simplifies header files as
> > follows:
> > 
> > STUB_UNLESS(CONFIG_FOO, [body], prototype)
> 
> Can you explain the desire to make the second argument optional,
> rather than having the mandatory arguments first and the optional body
> last?  It will mean more lines at each site, but I don't think that's
> a bad thing:
> 
> STUB_UNLESS(CONFIG_HAVE_HW_BREAKPOINT,
> void hw_breakpoint_thread_switch(struct task_struct *next));
> 
> STUB_UNLESS(CONFIG_CPU_FREQ,
> struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu), return NULL);
> 
> or:
> 
> STUB_UNLESS(CONFIG_CPU_FREQ,
> struct cpufreq_policy *cpufreq_cpu_get_raw(unsigned int cpu),
> 	return NULL);
> 
> Seems to be more readable in terms of the flow.

Hmmm, looking at that, I probably prefer that too.

In the unlikely case that <body> uses the function arguments it would be
quite confusing to have the body before the function prototype.

If we can keep this down to two lines so much the better, but still
seems fine.

Provided we don't end up needing a trailing comma in the void case, to
supply the empty body argument, that is.

Cheers
---Dave
