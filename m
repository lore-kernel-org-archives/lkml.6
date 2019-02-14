Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F612C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17051222D7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550157328;
	bh=bgJxjCFJcz9k8tw/eI5LlMsIc2vqpuOAtoCMZBOK0DY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=mrEC895twhk+xKfMziK/eaDEwore31aD4KdOo49V7M+rt8892rNYGA3oJyyIPyfDZ
	 f2SyKx/elWgWXgQ8ViYXO1nf0R9LiQLWrKfbIIt6w9d5r8LPLXJmEtBmBnMkcgWV/0
	 DY5eL4wjW3NuHXvaeqfjChx6CdTZ1T7+2P1phRB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407473AbfBNPP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 10:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbfBNPP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 10:15:26 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38BB222C9;
        Thu, 14 Feb 2019 15:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550157325;
        bh=bgJxjCFJcz9k8tw/eI5LlMsIc2vqpuOAtoCMZBOK0DY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qsWcfuOviLw5TpWzrJfPQ0J7trkFP82qYaKu092BP/PuEvFszTpJemkT0Q6TnQ16k
         cdJaEfr6Z+/3gxqOjNe3F+DTGHgJsDjpUiZSlDRVkwaq6N/Uel0e8EXbgLQ1+CFWoy
         JfmL52w40hPt/Thz684F1Dq8ZWDtHTGzlhhiAMcA=
Message-ID: <1550157323.2498.2.camel@kernel.org>
Subject: Re: [RFC PATCH v2 0/5] tracing: common error_log for ftrace
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Date:   Thu, 14 Feb 2019 09:15:23 -0600
In-Reply-To: <20190214121357.727a0f34246b51e6660354bc@kernel.org>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
         <20190214121357.727a0f34246b51e6660354bc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Thu, 2019-02-14 at 12:13 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> Thank you for your great work!

Thanks!

> 
> On Wed, 13 Feb 2019 12:17:51 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Last April, I posted an RFC patchset [1] implementing a common
> > error_log interface as suggested by Masami [2].  We were supposed
> > to
> > discuss it at Plumbers but that never happened, and Steve recently
> > asked about patches for a follow-on discussion [3], so here they
> > are.
> > 
> > 

[snip]

> >   # cat /sys/kernel/debug/tracing/error_log
> >   hist:sched:sched_wakeup: error: Variable already defined
> >   Command: keys=pid:ts0=common_timestamp.usecs if
> > comm=="cyclictest"
> >                     ^
> >   hist:sched:sched_waking: error: Couldn't find onmax or onchange
> > variable
> >     Command: key=comm:p=prio:onchange($q).snapshot()
> >                                        ^
> >   hist:sched:sched_wakeup: error: Hist trigger already exists
> >     Command: keys=pid
> >              ^
> >   event filter parse error: error: Invalid operator
> >     Command: comm="cyclictest"
> >                   ^
> >   event filter parse error: error: Field not found
> >     Command: ((sig >= 10 && sig < 15) || dsig == 17) && comm !=
> > bash
> >                                               ^  
> 
> I like this very much! One point I would like to comment is to add a
> kind of
> entry number tag, so that user distinguish the error message, e.g.
> 
>   # cat /sys/kernel/debug/tracing/error_log
>   [1] hist:sched:sched_wakeup: error: Variable already defined
>     Command: keys=pid:ts0=common_timestamp.usecs if
> comm=="cyclictest"
>                     ^
>   [2] hist:sched:sched_waking: error: Couldn't find onmax or onchange
> variable
>     Command: key=comm:p=prio:onchange($q).snapshot()
>                                        ^
>   [3] hist:sched:sched_wakeup: error: Hist trigger already exists
>     Command: keys=pid
>              ^
>   ...
> 
> What would you think?
> 

I think that makes sense and would be simple to add - will do in the
next version.

Thanks,

Tom

> Thank you,
> 
