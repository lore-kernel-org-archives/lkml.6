Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB354C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5F020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 04:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547441981;
	bh=aTrL4Ggh/aveLAt8mewf0Pmq4CJkaa9RMEaomqFM/Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sCSTT+dH+ywMWo7CRQz750WV2BpEG3bj2w0hSh10ZUIi0lHPTYeA16e+h1AsoRNhE
	 6Jd2HOe2MYCHrM8zXiZTzk53B/0+0IUxkckBeHzJP86wZ70kpnZk14qkQNcdCLWJRl
	 ZBUj4Yf8yMXHsLh2fb1IGk7qYnWyDR2tSQ//+2w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfANE7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 23:59:39 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:33973 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726450AbfANE7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 23:59:39 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 14 Jan 2019 13:59:36 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 14 Jan 2019 13:59:36 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Mon, 14 Jan 2019 13:59:35 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v11 10/15] tracing: Add alternative synthetic event trace
 action syntax
Message-ID: <20190114045935.GA20802@sejong>
References: <cover.1547062835.git.tom.zanussi@linux.intel.com>
 <f41e107a68bd018b388f7bd962d22a5bbc152598.1547062835.git.tom.zanussi@linux.intel.com>
 <20190111060752.GC625@sejong>
 <1547223940.7869.8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1547223940.7869.8.camel@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Fri, Jan 11, 2019 at 10:25:40AM -0600, Tom Zanussi wrote:
> Hi Namhyung,
> 
> On Fri, 2019-01-11 at 15:07 +0900, Namhyung Kim wrote:
> > On Wed, Jan 09, 2019 at 01:49:17PM -0600, Tom Zanussi wrote:
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> > > Add a 'trace(synthetic_event_name, params)' alternative to
> > > synthetic_event_name(params).
> > > 
> > > Currently, the syntax used for generating synthetic events is to
> > > invoke synthetic_event_name(params) i.e. use the synthetic event
> > > name
> > > as a function call.
> > > 
> > > Users requested a new form that more explicitly shows that the
> > > synthetic event is in effect being traced.  In this version, a new
> > > 'trace()' keyword is used, and the synthetic event name is passed
> > > in
> > > as the first argument.
> > > 
> > > Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > ---
> > >  Documentation/trace/histogram.rst | 21 ++++++++++++++++++++
> > >  kernel/trace/trace.c              |  1 +
> > >  kernel/trace/trace_events_hist.c  | 42
> > > +++++++++++++++++++++++++++++++++++----
> > >  3 files changed, 60 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/trace/histogram.rst
> > > b/Documentation/trace/histogram.rst
> > > index 79476c906b1a..4939bad1c1cd 100644
> > > --- a/Documentation/trace/histogram.rst
> > > +++ b/Documentation/trace/histogram.rst
> > > @@ -1874,6 +1874,7 @@ The available handlers are:
> > >  The available actions are:
> > >  
> > >    - <synthetic_event_name>(param list)         - generate
> > > synthetic event
> > > +  - trace(<synthetic_event_name>,(param list)) - generate
> > > synthetic event
> > 
> > Shouldn't it be
> > 
> > 	"trace(<synthetic_event_name>,param list)"
> > 
> > ?  Otherwise it looks like we need two parentheses.
> 
> Good point, I'll remove the params.
> 
> > 
> > IMHO, it seems better for consistency using this new syntax only.
> > Of course it should support the old syntax as well for compatibility
> > (and maybe make it undocumented?).  But I won't insist strongly..
> > 
> 
> OK, yeah, I really hate when things are undocumented, so I think
> removing the documentation would be a step backward, but maybe changing
> the emphasis to the trace() form would suffice.  How about the below?:

Looks good to me!

Thanks,
Namhyung


> 
> 
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index e5bcef360997..0ea59d45aef1 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -1873,46 +1873,45 @@ The available handlers are:
>  
>  The available actions are:
>  
> -  - <synthetic_event_name>(param list)         - generate synthetic event
>    - trace(<synthetic_event_name>,param list)   - generate synthetic event
>    - save(field,...)                            - save current event fields
>    - snapshot()                                 - snapshot the trace buffer
>  
>  The following commonly-used handler.action pairs are available:
>  
> -  - onmatch(matching.event).<synthetic_event_name>(param list)
> -
> -    or
> -
>    - onmatch(matching.event).trace(<synthetic_event_name>,param list)
>  
> -    The 'onmatch(matching.event).<synthetic_event_name>(params)' hist
> -    trigger action is invoked whenever an event matches and the
> -    histogram entry would be added or updated.  It causes the named
> -    synthetic event to be generated with the values given in the
> +    The 'onmatch(matching.event).trace(<synthetic_event_name>,param
> +    list)' hist trigger action is invoked whenever an event matches
> +    and the histogram entry would be added or updated.  It causes the
> +    named synthetic event to be generated with the values given in the
>      'param list'.  The result is the generation of a synthetic event
>      that consists of the values contained in those variables at the
> -    time the invoking event was hit.
> -
> -    There are two equivalent forms available for generating synthetic
> -    events.  In the first form, the synthetic event name is used as if
> -    it were a function name.  For example, if the synthetic event name
> -    is 'wakeup_latency', the wakeup_latency event would be generated
> -    by invoking it as if it were a function call, with the event field
> -    values passed in as arguments: wakeup_latency(arg1,arg2).  The
> -    second form simply uses the 'trace' keyword as the function name
> -    and passes in the synthetic event name as the first argument,
> -    followed by the field values: trace(wakeup_latency,arg1,arg2).
> -
> -    The 'param list' consists of one or more parameters which may be
> -    either variables or fields defined on either the 'matching.event'
> -    or the target event.  The variables or fields specified in the
> -    param list may be either fully-qualified or unqualified.  If a
> -    variable is specified as unqualified, it must be unique between
> -    the two events.  A field name used as a param can be unqualified
> -    if it refers to the target event, but must be fully qualified if
> -    it refers to the matching event.  A fully-qualified name is of the
> -    form 'system.event_name.$var_name' or 'system.event_name.field'.
> +    time the invoking event was hit.  For example, if the synthetic
> +    event name is 'wakeup_latency', a wakeup_latency event is
> +    generated using onmatch(event).trace(wakeup_latency,arg1,arg2).
> +
> +    There is also an equivalent alternative form available for
> +    generating synthetic events.  In this form, the synthetic event
> +    name is used as if it were a function name.  For example, using
> +    the 'wakeup_latency' synthetic event name again, the
> +    wakeup_latency event would be generated by invoking it as if it
> +    were a function call, with the event field values passed in as
> +    arguments: onmatch(event).wakeup_latency(arg1,arg2).  The syntax
> +    for this form is:
> +
> +      onmatch(matching.event).<synthetic_event_name>(param list)
> +
> +    In either case, the 'param list' consists of one or more
> +    parameters which may be either variables or fields defined on
> +    either the 'matching.event' or the target event.  The variables or
> +    fields specified in the param list may be either fully-qualified
> +    or unqualified.  If a variable is specified as unqualified, it
> +    must be unique between the two events.  A field name used as a
> +    param can be unqualified if it refers to the target event, but
> +    must be fully qualified if it refers to the matching event.  A
> +    fully-qualified name is of the form 'system.event_name.$var_name'
> +    or 'system.event_name.field'.
>  
>      The 'matching.event' specification is simply the fully qualified
>      event name of the event that matches the target event for the
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 84981b61d45f..8c220d97c214 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4899,7 +4899,6 @@ static const char readme_msg[] =
>  	"\t        onmax(var)               - invoke if var exceeds current max\n"
>  	"\t        onchange(var)            - invoke action if var changes\n\n"
>  	"\t    The available actions are:\n\n"
> -	"\t        <synthetic_event>(param list)        - generate synthetic event\n"
>  	"\t        trace(<synthetic_event>,param list)  - generate synthetic event\n"
>  	"\t        save(field,...)                      - save current event fields\n"
>  	"\t        snapshot()                           - snapshot the trace buffer\n"
