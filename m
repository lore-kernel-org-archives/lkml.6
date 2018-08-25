Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF35BC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522E9208B2
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 02:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 522E9208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbeHYGSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 02:18:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbeHYGSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 02:18:41 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ECF9208B2;
        Sat, 25 Aug 2018 02:41:24 +0000 (UTC)
Date:   Fri, 24 Aug 2018 22:41:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/32] selftests/ftrace: Add max stack tracer
 testcase
Message-ID: <20180824224122.2e10e7f9@vmware.local.home>
In-Reply-To: <20180825104509.1b739d5d17d860e453daa0ca@kernel.org>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443763074.23257.4052504725796725062.stgit@devbox>
        <20180824192352.262144f5@gandalf.local.home>
        <20180825104509.1b739d5d17d860e453daa0ca@kernel.org>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018 10:45:09 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 24 Aug 2018 19:23:52 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 17 Aug 2018 01:40:30 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > Add a testcase for max stack tracer, which checks basic
> > > max stack usage tracing and its filter feature.
> > > 
> > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > >  .../ftrace/test.d/ftrace/func_stack_tracer.tc      |   39 ++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > >  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
> > > 
> > > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
> > > new file mode 100644
> > > index 000000000000..b414f0e3c646
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
> > > @@ -0,0 +1,39 @@
> > > +#!/bin/sh
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# description: ftrace - Max stack tracer
> > > +# Test the basic function of max-stack usage tracing
> > > +
> > > +if [ ! -f stack_trace ]; then
> > > +  echo "Max stack tracer is not supported - please make CONFIG_STACK_TRACER=y"
> > > +  exit_unsupported
> > > +fi
> > > +
> > > +echo > stack_trace_filter
> > > +echo 0 > stack_max_size
> > > +echo 1 > /proc/sys/kernel/stack_tracer_enabled
> > > +
> > > +: "Fork and wait for the first entry become !lock"
> > > +timeout=10
> > > +while [ $timeout -ne 0 ]; do
> > > +  ( echo "forked" )
> > > +  FL=`grep " 0)" stack_trace`
> > > +  echo $FL | grep -q "lock" || break;
> > > +  timeout=$((timeout - 1))
> > > +done
> > > +echo 0 > /proc/sys/kernel/stack_tracer_enabled
> > > +
> > > +echo '*lock*' > stack_trace_filter
> > > +test `cat stack_trace_filter | wc -l` -eq `grep lock stack_trace_filter | wc -l`
> > > +
> > > +echo 0 > stack_max_size
> > > +echo 1 > /proc/sys/kernel/stack_tracer_enabled  
> > 
> > This test fails quite a bit because it doesn't guarantee that another
> > stack trace gets in that is bigger, and we don't find the "lock".  
> 
> Hmm, maybe I misunderstand what is the stack_trace_filter.
> I thought it filtered the function that triggered stack trace,
> so the top of stack trace was always filtered function.
> If not, what does this filter?

Ah, I missed the filter part, no its correct, and actually found a
bug ;-) By adding this patch, it works again:

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 4237eba4ef20..2b0d1ee3241c 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -111,7 +111,7 @@ check_stack(unsigned long ip, unsigned long *stack)
 	stack_trace_max_size = this_size;
 
 	stack_trace_max.nr_entries = 0;
-	stack_trace_max.skip = 3;
+	stack_trace_max.skip = 0;
 
 	save_stack_trace(&stack_trace_max);
 


-- Steve

> >   
> > > +
> > > +: "Fork and always the first entry including lock"
> > > +timeout=10
> > > +while [ $timeout -ne 0 ]; do
> > > +  ( echo "forked" )
> > > +  FL=`grep " 0)" stack_trace`
> > > +  echo $FL | grep -q "lock"
> > > +  timeout=$((timeout - 1))
> > > +done
> > > +echo 0 > /proc/sys/kernel/stack_tracer_enabled  
> >   
> 
> 

