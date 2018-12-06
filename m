Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D079DC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82735214DE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:59:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82735214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLFP7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:59:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbeLFP7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:59:18 -0500
Received: from vmware.local.home (unknown [208.91.3.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C905214C1;
        Thu,  6 Dec 2018 15:59:17 +0000 (UTC)
Date:   Thu, 6 Dec 2018 10:59:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        keescook@chromium.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 2/2] arm64: ftrace: Set FTRACE_SCHEDULABLE before
 ftrace_modify_all_code()
Message-ID: <20181206105914.7a29efa9@vmware.local.home>
In-Reply-To: <20181206132007.GB27744@arm.com>
References: <20181205174852.435233070@goodmis.org>
        <20181205183304.000714627@goodmis.org>
        <20181206132007.GB27744@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 13:20:07 +0000
Will Deacon <will.deacon@arm.com> wrote:

> On Wed, Dec 05, 2018 at 12:48:54PM -0500, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > It has been reported that ftrace_replace_code() which is called by
> > ftrace_modify_all_code() can cause a soft lockup warning for an
> > allmodconfig kernel. This is because all the debug options enabled
> > causes the loop in ftrace_replace_code() (which loops over all the
> > functions being enabled where there can be 10s of thousands), is too
> > slow, and never schedules out.
> > 
> > To solve this, setting FTRACE_SCHEDULABLE to the command passed into
> > ftrace_replace_code() will make it call cond_resched() in the loop,
> > which prevents the soft lockup warning from triggering.
> > 
> > Link: http://lkml.kernel.org/r/20181204192903.8193-1-anders.roxell@linaro.org
> > 
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  arch/arm64/kernel/ftrace.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
> > index 57e962290df3..9a8de0a79f97 100644
> > --- a/arch/arm64/kernel/ftrace.c
> > +++ b/arch/arm64/kernel/ftrace.c
> > @@ -193,6 +193,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  
> >  void arch_ftrace_update_code(int command)
> >  {
> > +	command |= FTRACE_SCHEDULABLE;
> >  	ftrace_modify_all_code(command);
> >  }  
> 
> Bikeshed: I'd probably go for FTRACE_MAY_SLEEP, but I'm not going to die
> on that hill so...

I like bike sheds. Hmm, it's not too late to change this. Perhaps I
will.

> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

If I decide to change the name to MAY_SLEEP, I assume I can still keep
your Acked-by.

-- Steve

