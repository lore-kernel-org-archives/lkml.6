Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83153C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1EA20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1EA20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeLFQG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:06:26 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:54406 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbeLFQGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:06:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E7180D;
        Thu,  6 Dec 2018 08:06:25 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D644E3F59C;
        Thu,  6 Dec 2018 08:06:24 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id F052C1AE0BD1; Thu,  6 Dec 2018 16:06:45 +0000 (GMT)
Date:   Thu, 6 Dec 2018 16:06:45 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        keescook@chromium.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before
 ftrace_modify_all_code()
Message-ID: <20181206160645.GA4728@arm.com>
References: <20181205174852.435233070@goodmis.org>
 <20181205183304.000714627@goodmis.org>
 <20181206132007.GB27744@arm.com>
 <20181206105914.7a29efa9@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206105914.7a29efa9@vmware.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 10:59:14AM -0500, Steven Rostedt wrote:
> On Thu, 6 Dec 2018 13:20:07 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> 
> > On Wed, Dec 05, 2018 at 12:48:54PM -0500, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > It has been reported that ftrace_replace_code() which is called by
> > > ftrace_modify_all_code() can cause a soft lockup warning for an
> > > allmodconfig kernel. This is because all the debug options enabled
> > > causes the loop in ftrace_replace_code() (which loops over all the
> > > functions being enabled where there can be 10s of thousands), is too
> > > slow, and never schedules out.
> > > 
> > > To solve this, setting FTRACE_SCHEDULABLE to the command passed into
> > > ftrace_replace_code() will make it call cond_resched() in the loop,
> > > which prevents the soft lockup warning from triggering.
> > > 
> > > Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
> > > 
> > > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  arch/arm64/kernel/ftrace.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > > index 57e962290df3..9a8de0a79f97 100644
> > > --- a/arch/arm64/kernel/ftrace.c
> > > +++ b/arch/arm64/kernel/ftrace.c
> > > @@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> > >  
> > >  void arch_ftrace_update_code(int command)
> > >  {
> > > +	command |= FTRACE_SCHEDULABLE;
> > >  	ftrace_modify_all_code(command);
> > >  }  
> > 
> > Bikeshed: I'd probably go for FTRACE_MAY_SLEEP, but I'm not going to die
> > on that hill so...
> 
> I like bike sheds. Hmm, it's not too late to change this. Perhaps I
> will.
> 
> > 
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks!
> 
> If I decide to change the name to MAY_SLEEP, I assume I can still keep
> your Acked-by.

Of course!

Will
