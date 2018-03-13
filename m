Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeCMKOI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 06:14:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40486 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932292AbeCMKOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 06:14:07 -0400
Date: Tue, 13 Mar 2018 11:14:01 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 3/3] tracing: Rewrite filter logic to be simpler and
 faster
Message-ID: <20180313101401.GD16389@krava>
References: <20180310023442.791997138@goodmis.org>
 <20180310023907.798690563@goodmis.org>
 <20180312151017.GE23111@krava>
 <20180312144001.788380fa@vmware.local.home>
 <20180312185414.GA13138@krava>
 <20180312195245.346cef71@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180312195245.346cef71@vmware.local.home>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 07:52:45PM -0400, Steven Rostedt wrote:
> On Mon, 12 Mar 2018 19:54:14 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > On Mon, Mar 12, 2018 at 02:40:01PM -0400, Steven Rostedt wrote:
> > > On Mon, 12 Mar 2018 16:10:17 +0100
> > > Jiri Olsa <jolsa@redhat.com> wrote:
> > >   
> > > > got it crashed when clearing the filter via 'echo > filter'  
> > > 
> > > Awesome. I'll go and test this out. Thanks!
> > > 
> > > Hmm, could you pull my tree and test my branch: ftrace/core. I may have
> > > already fixed this but haven't posted the latest (which I'll do before
> > > pushing to next).  
> > 
> > I couldn't apply your patches from mailbox so I used your ftrace/core already
> >
> 
> Jiri, If you apply the below, does it fix it for you?

yes, the crash is gone and I can set filter ftrace/function,
but I'm still having some issues put that filter through perf

  # perf record -e ftrace:function --filter "ip == 0xffffffffa41e8490" ls

but I might be just missing something.. it's been a while ;-) I'm looking to that

jirka


> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index a5a131ec3c9c..4099e141188c 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1498,11 +1498,14 @@ static int process_preds(struct trace_event_call *call,
>  		return ret;
>  	}
>  
> -	prog = predicate_parse(filter_string, nr_parens, nr_preds,
> +	if (!nr_preds) {
> +		prog = NULL;
> +	} else {
> +		prog = predicate_parse(filter_string, nr_parens, nr_preds,
>  			       parse_pred, call, pe);
> -	if (IS_ERR(prog))
> -		return PTR_ERR(prog);
> -
> +		if (IS_ERR(prog))
> +			return PTR_ERR(prog);
> +	}
>  	rcu_assign_pointer(filter->prog, prog);
>  	return 0;
>  }
