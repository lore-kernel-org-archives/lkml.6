Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F573C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A9D121848
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBTR43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:56:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfBTR42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:56:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 879FC2146E;
        Wed, 20 Feb 2019 17:56:26 +0000 (UTC)
Date:   Wed, 20 Feb 2019 12:56:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
Message-ID: <20190220125625.77802cac@gandalf.local.home>
In-Reply-To: <1550684302.2027.6.camel@kernel.org>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
        <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
        <20190220121748.7aa83459@gandalf.local.home>
        <1550684302.2027.6.camel@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 11:38:22 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> Hi Steve,
> 
> On Wed, 2019-02-20 at 12:17 -0500, Steven Rostedt wrote:
> > On Wed, 13 Feb 2019 17:42:55 -0600
> > Tom Zanussi <zanussi@kernel.org> wrote:
> >   
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Add a test case verifying that basic action combinations fail as
> > > expected.
> > >   
> > 
> > Hi Tom,
> > 
> > This test appears to fail:
> > 
> > # echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)'  
> > >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger  
> > -bash: echo: write error: Invalid argument
> > 
> > # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist 
> > 
> > ERROR: action parsing: Handler doesn't support action: save
> >   Last command: keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)
> > 
> > 
> > Is the "save" feature implemented here? It's in the README too.
> > Should
> > it be removed?
> >   
> 
> The "save" feature is implemented, but it's not currently supported
> with onmatch(), which is why it fails, and is used in the xfail test,
> since it's expected to.  So, in this case, the command fails, which
> means the xfail test actually passed.  ;-)
> 
> There are other tests in the inter-event testcases that use save() but
> with onmax() and onchange(), and they pass.

So the test needs to pass on failure?

Because, it shouldn't be flagged as a failure in the test suite.

-- Steve

> 
> Hope that explains things in this case,
> 
> Tom
> 
> > -- Steve
> >   
> > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > ---
> > >  .../inter-event/trigger-action-hist-xfail.tc       | 30
> > > ++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > >  create mode 100644
> > > tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-
> > > action-hist-xfail.tc
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > event/trigger-action-hist-xfail.tc
> > > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > event/trigger-action-hist-xfail.tc
> > > new file mode 100644
> > > index 000000000000..1221240f8cf6
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > event/trigger-action-hist-xfail.tc
> > > @@ -0,0 +1,30 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: event trigger - test inter-event histogram trigger
> > > expected fail actions
> > > +
> > > +fail() { #msg
> > > +    echo $1
> > > +    exit_fail
> > > +}
> > > +
> > > +if [ ! -f set_event ]; then
> > > +    echo "event tracing is not supported"
> > > +    exit_unsupported
> > > +fi
> > > +
> > > +if [ ! -f snapshot ]; then
> > > +    echo "snapshot is not supported"
> > > +    exit_unsupported
> > > +fi
> > > +
> > > +grep -q "snapshot()" README || exit_unsupported # version issue
> > > +
> > > +echo "Test expected snapshot action failure"
> > > +
> > > +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()' >>
> > > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger &&
> > > exit_fail
> > > +
> > > +echo "Test expected save action failure"
> > > +
> > > +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)'  
> > > >> /sys/kernel/debug/tracing/events/sched/sched_waking/trigger &&  
> > > exit_fail
> > > +
> > > +exit_xfail  
> > 
> >   

