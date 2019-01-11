Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8959C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFBE20663
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547186877;
	bh=SBb0pEKip+bcvaXrjt33yoWv5ekqMKS24J4XEzKY+QA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bbpWrjMB5N0lwstBC3m0bL7R8xAJ98BGj93ktJF7SRuRwsm7r5nD6lgncM1wb3PBf
	 6XFUwG7EQGKw4CdDFwDr/lCfeELp0mBWujZRv/E1wxSJYYv8VW9qr+QkmJuGMufTe2
	 gBA3uqHY7lniiykpfjeKTGEbUuLl5ymdHKVhJBCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbfAKGH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:07:56 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:43784 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfAKGH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:07:56 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 11 Jan 2019 15:07:53 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.121 with ESMTP; 11 Jan 2019 15:07:53 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 11 Jan 2019 15:07:52 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v11 10/15] tracing: Add alternative synthetic event trace
 action syntax
Message-ID: <20190111060752.GC625@sejong>
References: <cover.1547062835.git.tom.zanussi@linux.intel.com>
 <f41e107a68bd018b388f7bd962d22a5bbc152598.1547062835.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f41e107a68bd018b388f7bd962d22a5bbc152598.1547062835.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 01:49:17PM -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a 'trace(synthetic_event_name, params)' alternative to
> synthetic_event_name(params).
> 
> Currently, the syntax used for generating synthetic events is to
> invoke synthetic_event_name(params) i.e. use the synthetic event name
> as a function call.
> 
> Users requested a new form that more explicitly shows that the
> synthetic event is in effect being traced.  In this version, a new
> 'trace()' keyword is used, and the synthetic event name is passed in
> as the first argument.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  Documentation/trace/histogram.rst | 21 ++++++++++++++++++++
>  kernel/trace/trace.c              |  1 +
>  kernel/trace/trace_events_hist.c  | 42 +++++++++++++++++++++++++++++++++++----
>  3 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 79476c906b1a..4939bad1c1cd 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -1874,6 +1874,7 @@ The available handlers are:
>  The available actions are:
>  
>    - <synthetic_event_name>(param list)         - generate synthetic event
> +  - trace(<synthetic_event_name>,(param list)) - generate synthetic event

Shouldn't it be

	"trace(<synthetic_event_name>,param list)"

?  Otherwise it looks like we need two parentheses.

IMHO, it seems better for consistency using this new syntax only.
Of course it should support the old syntax as well for compatibility
(and maybe make it undocumented?).  But I won't insist strongly..


>    - save(field,...)                            - save current event fields
>    - snapshot()                                 - snapshot the trace buffer
>  
> @@ -1881,6 +1882,10 @@ The following commonly-used handler.action pairs are available:
>  
>    - onmatch(matching.event).<synthetic_event_name>(param list)
>  
> +    or
> +
> +  - onmatch(matching.event).trace(<synthetic_event_name>,(param list))
> +

Ditto.


>      The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
>      trigger action is invoked whenever an event matches and the
>      histogram entry would be added or updated.  It causes the named
> @@ -1889,6 +1894,16 @@ The following commonly-used handler.action pairs are available:
>      that consists of the values contained in those variables at the
>      time the invoking event was hit.
>  
> +    There are two equivalent forms available for generating synthetic
> +    events.  In the first form, the synthetic event name is used as if
> +    it were a function name.  For example, if the synthetic event name
> +    is 'wakeup_latency', the wakeup_latency event would be generated
> +    by invoking it as if it were a function call, with the event field
> +    values passed in as arguments: wakeup_latency(arg1,arg2).  The
> +    second form simply uses the 'trace' keyword as the function name
> +    and passes in the synthetic event name as the first argument,
> +    followed by the field values: trace(wakeup_latency,arg1,arg2).
> +
>      The 'param list' consists of one or more parameters which may be
>      either variables or fields defined on either the 'matching.event'
>      or the target event.  The variables or fields specified in the
> @@ -1928,6 +1943,12 @@ The following commonly-used handler.action pairs are available:
>                wakeup_new_test($testpid) if comm=="cyclictest"' >> \
>                /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
>  
> +    Or, equivalently, using the 'trace' keyword syntax:
> +
> +    # echo 'hist:keys=$testpid:testpid=pid:onmatch(sched.sched_wakeup_new).\
> +            trace(wakeup_new_test,$testpid) if comm=="cyclictest"' >> \
> +            /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/trigger
> +
>      Creating and displaying a histogram based on those events is now
>      just a matter of using the fields and new synthetic event in the
>      tracing/events/synthetic directory, as usual::
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 917677a9bcaa..aae0e4127afc 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4900,6 +4900,7 @@ static const char readme_msg[] =
>  	"\t        onchange(var)            - invoke action if var changes\n\n"
>  	"\t    The available actions are:\n\n"
>  	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
> +	"\t        trace(<synthetic_event>,(param list))- generate synthetic event\n"

Ditto.

Thanks,
Namhyung


>  	"\t        save(field,...)                      - save current event fields\n"
>  	"\t        snapshot()                           - snapshot the trace buffer\n"
>  #endif
