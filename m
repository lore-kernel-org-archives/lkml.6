Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4414C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83BD921734
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBUMqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:46:38 -0500
Received: from foss.arm.com ([217.140.101.70]:43832 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbfBUMqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:46:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF44680D;
        Thu, 21 Feb 2019 04:46:37 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3E83F575;
        Thu, 21 Feb 2019 04:46:34 -0800 (PST)
Date:   Thu, 21 Feb 2019 12:46:29 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        catalin.marinas@arm.com, james.morse@arm.com,
        valentin.schneider@arm.com, brgerst@gmail.com, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, dvlasenk@redhat.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
Message-ID: <20190221124629.GA12696@fuggles.cambridge.arm.com>
References: <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net>
 <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net>
 <20ABBED1-E505-45F6-8520-FB93786DF9A9@zytor.com>
 <20190216103044.GR32494@hirez.programming.kicks-ass.net>
 <9e037d68-75e7-1beb-0c9c-33a7ffeced1b@zytor.com>
 <20190219090409.GW32494@hirez.programming.kicks-ass.net>
 <20190219124808.GG8501@fuggles.cambridge.arm.com>
 <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8e99706-4e3b-68ec-7a3e-6e6dd876ad2f@zytor.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 02:55:59PM -0800, H. Peter Anvin wrote:
> On 2/19/19 4:48 AM, Will Deacon wrote:
> > 
> > I think you'll still hate this, but could we not disable preemption during
> > the uaccess-enabled region, re-enabling it on the fault path after we've
> > toggled uaccess off and disable it again when we return back to the
> > uaccess-enabled region? Doesn't help with tracing, but it should at least
> > handle the common case.
> > 
> 
> There is a worse problem with this, I still realize: this would mean blocking
> preemption across what could possibly be a *very* large copy_from_user(), for
> example.

I don't think it's legitimate to call copy_{to,from}_user() inside a
user_access_{begin,end} region. You'd need to add some unsafe variants,
which could periodically disable uaccess and call cond_resched() inside
the loop to avoid the problem you're eluding to.

For existing callers of copy_{to,from}_user(), there's no issue as they
don't call into the scheduler during the copy operation. Exceptions are
handled fine by the code in mainline today.

GCC plugins are a cool idea, but I'm just a bit nervous about relying on
them for things like this.

Will
