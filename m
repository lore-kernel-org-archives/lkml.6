Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E350C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F2521841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 18:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550686237;
	bh=GHsZHLmyDHMv4mrj0dNfeLtgYZlkHLxyFF37RFFg+ss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=nRL4qIqA0IHASiAOPUmHFIA/g9qaatrOl7uZweSOBqVEwvzz0mGBU0kqzIoeJqh7I
	 VfO8NpVOsMRYBBj2IK+nB9i+JSHcv8b6l7mSrthNUB2XP6/DBV1GBUQKq6ROTyjZbD
	 tRDy2NxDdvAefbv18mbPz7CTgdb0UGcguO4kLMsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfBTSKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 13:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbfBTSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 13:10:35 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0418420645;
        Wed, 20 Feb 2019 18:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550686233;
        bh=GHsZHLmyDHMv4mrj0dNfeLtgYZlkHLxyFF37RFFg+ss=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NrID8ZlwDDCBTdDmt7pywVN+jXe2CrZ/Rq3hsCq41lKWn/yYwbnIf2HhVLpDugWIy
         KuGSxAQ0n/U4Us5QLhrvUGkgzyAybyIlpTV6PNoc7MTxmKMETg6dMkYTDciUPwg/Nw
         4mQVECFrDD6TBwDhVKTuO2AMtA+bLW3YhFEAOxg8=
Message-ID: <1550686231.2027.14.camel@kernel.org>
Subject: Re: [PATCH v15 15/15] tracing: Add hist trigger action 'expected
 fail' test case
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 20 Feb 2019 12:10:31 -0600
In-Reply-To: <20190220125625.77802cac@gandalf.local.home>
References: <cover.1550100284.git.tom.zanussi@linux.intel.com>
         <1790bf93e01dbdfa1b4af945f42147d92bd565aa.1550100284.git.tom.zanussi@linux.intel.com>
         <20190220121748.7aa83459@gandalf.local.home>
         <1550684302.2027.6.camel@kernel.org>
         <20190220125625.77802cac@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2019-02-20 at 12:56 -0500, Steven Rostedt wrote:
> On Wed, 20 Feb 2019 11:38:22 -0600
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Wed, 2019-02-20 at 12:17 -0500, Steven Rostedt wrote:
> > > On Wed, 13 Feb 2019 17:42:55 -0600
> > > Tom Zanussi <zanussi@kernel.org> wrote:
> > >   
> > > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > 
> > > > Add a test case verifying that basic action combinations fail
> > > > as
> > > > expected.
> > > >   
> > > 
> > > Hi Tom,
> > > 
> > > This test appears to fail:
> > > 
> > > # echo
> > > 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)'  
> > > > > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger  
> > > 
> > > -bash: echo: write error: Invalid argument
> > > 
> > > # cat /sys/kernel/debug/tracing/events/sched/sched_waking/hist 
> > > 
> > > ERROR: action parsing: Handler doesn't support action: save
> > >   Last command:
> > > keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)
> > > 
> > > 
> > > Is the "save" feature implemented here? It's in the README too.
> > > Should
> > > it be removed?
> > >   
> > 
> > The "save" feature is implemented, but it's not currently supported
> > with onmatch(), which is why it fails, and is used in the xfail
> > test,
> > since it's expected to.  So, in this case, the command fails, which
> > means the xfail test actually passed.  ;-)
> > 
> > There are other tests in the inter-event testcases that use save()
> > but
> > with onmax() and onchange(), and they pass.
> 
> So the test needs to pass on failure?
> 
> Because, it shouldn't be flagged as a failure in the test suite.
> 

As far as I understand it (there's no other case of an xfail test in
the testsuite, so nothing similar to compare it to), the test output is
 correct - here we get the expected fail, XFAIL, and not a FAIL as any
test, xfail or normal, that failed would produce:

tools/testing/selftests/ftrace# ./ftracetest test.d/trigger/
=== Ftrace unit tests ===
[1] event trigger - test inter-event histogram trigger expected fail actions
[XFAIL]
[2] event trigger - test extended error support
[PASS]

And here the summary shows none failed, while we did have one expected
xfail, but that's what was expected, and not a failure:

# of passed:  31
# of failed:  0
# of unresolved:  0
# of untested:  0
# of unsupported:  0
# of xfailed:  1
# of undefined(test bug):  0

If that's not correct, I'll fix it but at this point I'm not sure what
the output should be if not that.

Thanks,

Tom

> -- Steve
> 
> > 
> > Hope that explains things in this case,
> > 
> > Tom
> > 
> > > -- Steve
> > >   
> > > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > ---
> > > >  .../inter-event/trigger-action-hist-xfail.tc       | 30
> > > > ++++++++++++++++++++++
> > > >  1 file changed, 30 insertions(+)
> > > >  create mode 100644
> > > > tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > > event/trigger-
> > > > action-hist-xfail.tc
> > > > 
> > > > diff --git
> > > > a/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > > event/trigger-action-hist-xfail.tc
> > > > b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > > event/trigger-action-hist-xfail.tc
> > > > new file mode 100644
> > > > index 000000000000..1221240f8cf6
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-
> > > > event/trigger-action-hist-xfail.tc
> > > > @@ -0,0 +1,30 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# description: event trigger - test inter-event histogram
> > > > trigger
> > > > expected fail actions
> > > > +
> > > > +fail() { #msg
> > > > +    echo $1
> > > > +    exit_fail
> > > > +}
> > > > +
> > > > +if [ ! -f set_event ]; then
> > > > +    echo "event tracing is not supported"
> > > > +    exit_unsupported
> > > > +fi
> > > > +
> > > > +if [ ! -f snapshot ]; then
> > > > +    echo "snapshot is not supported"
> > > > +    exit_unsupported
> > > > +fi
> > > > +
> > > > +grep -q "snapshot()" README || exit_unsupported # version
> > > > issue
> > > > +
> > > > +echo "Test expected snapshot action failure"
> > > > +
> > > > +echo 'hist:keys=comm:onmatch(sched.sched_wakeup).snapshot()'
> > > > >>
> > > > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger &&
> > > > exit_fail
> > > > +
> > > > +echo "Test expected save action failure"
> > > > +
> > > > +echo
> > > > 'hist:keys=comm:onmatch(sched.sched_wakeup).save(comm,prio)'  
> > > > > > /sys/kernel/debug/tracing/events/sched/sched_waking/trigger
> > > > > > &&  
> > > > 
> > > > exit_fail
> > > > +
> > > > +exit_xfail  
> > > 
> > >   
> 
> 
