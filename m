Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D744C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299A02147D
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFAsDmg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299A02147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbeHZMYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 08:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbeHZMYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 08:24:37 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B97E42147D;
        Sun, 26 Aug 2018 08:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535272963;
        bh=G+yiS2JzF0IldxeGkiIALbqJKF94Wq7YqJ/nPkQsUOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oFAsDmg2AIZUNn2i8xZ9EQzG2JM3hg3FMiUdpOBYWCm/w8tIcriUcx2/MoZ0mVNcG
         mJjoIbgO0eAzUXvgQi6iCYvCw+dehvrIWdYkslgus5KuV3n6U3UTN0O6xxY3wvM90J
         Iv4V1UhSd0x6llhVnua6vhtAnQr0oRdQkMBfJWqo=
Date:   Sun, 26 Aug 2018 17:42:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 24/32] selftests/ftrace: Add max stack tracer
 testcase
Message-Id: <20180826174240.22bc6c2c79da25f1ef261bf6@kernel.org>
In-Reply-To: <20180824224122.2e10e7f9@vmware.local.home>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
        <153443763074.23257.4052504725796725062.stgit@devbox>
        <20180824192352.262144f5@gandalf.local.home>
        <20180825104509.1b739d5d17d860e453daa0ca@kernel.org>
        <20180824224122.2e10e7f9@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Aug 2018 22:41:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 25 Aug 2018 10:45:09 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Fri, 24 Aug 2018 19:23:52 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Fri, 17 Aug 2018 01:40:30 +0900
> > > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > >   
> > > > Add a testcase for max stack tracer, which checks basic
> > > > max stack usage tracing and its filter feature.
> > > > 
> > > > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > ---
> > > >  .../ftrace/test.d/ftrace/func_stack_tracer.tc      |   39 ++++++++++++++++++++
> > > >  1 file changed, 39 insertions(+)
> > > >  create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
> > > > 
> > > > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
> > > > new file mode 100644
> > > > index 000000000000..b414f0e3c646
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_stack_tracer.tc
> > > > @@ -0,0 +1,39 @@
> > > > +#!/bin/sh
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# description: ftrace - Max stack tracer
> > > > +# Test the basic function of max-stack usage tracing
> > > > +
> > > > +if [ ! -f stack_trace ]; then
> > > > +  echo "Max stack tracer is not supported - please make CONFIG_STACK_TRACER=y"
> > > > +  exit_unsupported
> > > > +fi
> > > > +
> > > > +echo > stack_trace_filter
> > > > +echo 0 > stack_max_size
> > > > +echo 1 > /proc/sys/kernel/stack_tracer_enabled
> > > > +
> > > > +: "Fork and wait for the first entry become !lock"
> > > > +timeout=10
> > > > +while [ $timeout -ne 0 ]; do
> > > > +  ( echo "forked" )
> > > > +  FL=`grep " 0)" stack_trace`
> > > > +  echo $FL | grep -q "lock" || break;
> > > > +  timeout=$((timeout - 1))
> > > > +done
> > > > +echo 0 > /proc/sys/kernel/stack_tracer_enabled
> > > > +
> > > > +echo '*lock*' > stack_trace_filter
> > > > +test `cat stack_trace_filter | wc -l` -eq `grep lock stack_trace_filter | wc -l`
> > > > +
> > > > +echo 0 > stack_max_size
> > > > +echo 1 > /proc/sys/kernel/stack_tracer_enabled  
> > > 
> > > This test fails quite a bit because it doesn't guarantee that another
> > > stack trace gets in that is bigger, and we don't find the "lock".  
> > 
> > Hmm, maybe I misunderstand what is the stack_trace_filter.
> > I thought it filtered the function that triggered stack trace,
> > so the top of stack trace was always filtered function.
> > If not, what does this filter?
> 
> Ah, I missed the filter part, no its correct, and actually found a
> bug ;-) By adding this patch, it works again:

Great! this shows ftracetest really works :)
Anyway, with this fix, we don't need the timeout things anymore.

Thanks!

> 
> diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> index 4237eba4ef20..2b0d1ee3241c 100644
> --- a/kernel/trace/trace_stack.c
> +++ b/kernel/trace/trace_stack.c
> @@ -111,7 +111,7 @@ check_stack(unsigned long ip, unsigned long *stack)
>  	stack_trace_max_size = this_size;
>  
>  	stack_trace_max.nr_entries = 0;
> -	stack_trace_max.skip = 3;
> +	stack_trace_max.skip = 0;
>  
>  	save_stack_trace(&stack_trace_max);
>  
> 
> 
> -- Steve
> 
> > >   
> > > > +
> > > > +: "Fork and always the first entry including lock"
> > > > +timeout=10
> > > > +while [ $timeout -ne 0 ]; do
> > > > +  ( echo "forked" )
> > > > +  FL=`grep " 0)" stack_trace`
> > > > +  echo $FL | grep -q "lock"
> > > > +  timeout=$((timeout - 1))
> > > > +done
> > > > +echo 0 > /proc/sys/kernel/stack_tracer_enabled  
> > >   
> > 
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
