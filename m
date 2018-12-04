Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CB820834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CB820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLDHZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:25:52 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:36178 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725994AbeLDHZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:25:51 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.52 with ESMTP; 4 Dec 2018 16:25:49 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 4 Dec 2018 16:25:49 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Tue, 4 Dec 2018 16:25:49 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and save
 action
Message-ID: <20181204072549.GA16733@sejong>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
 <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
 <20181123025000.GC25952@sejong>
 <1543875722.2018.22.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1543875722.2018.22.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 04:22:02PM -0600, Tom Zanussi wrote:
> Hi Namhyung,
> 
> On Fri, 2018-11-23 at 11:50 +0900, Namhyung Kim wrote:
> > Hi Tom,
> > 
> > On Wed, Nov 14, 2018 at 02:18:02PM -0600, Tom Zanussi wrote:
> > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > 
> 
> [snip]
> 
> > > 
>  enum handler_id {
> > >  	HANDLER_ONMATCH = 1,
> > >  	HANDLER_ONMAX,
> > > @@ -349,14 +358,18 @@ struct action_data {
> > >  
> > >  		struct {
> > >  			char			*var_str;
> > > -			unsigned int		max_var_ref_idx;
> > > -			struct hist_field	*max_var;
> > > -			struct hist_field	*var;
> > > -		} onmax;
> > > +			struct hist_field	*var_ref;
> > > +			unsigned int		var_ref_idx;
> > 
> > I have a question.  It's confusing for me there are many indexes for
> > a
> > variable (ref).  The hist_field already has var.idx, var_idx and
> > var_ref_idx in it.  But you also added an external var_ref_idx along
> > with the var_ref.  Also I see another var_ref_idx in the action data.
> > Is all that really needed?  Could you please add some comment then?
> > 
> 
> Below is a patch with some comments I'll merge into the next version
> that I hope will help make things more clear.  Basically, the
> hist_field.var_idx isn't used so I've removed it and therefore that

Thanks!


> source of confusion, while var.idx is the variable's unique 'handle' in
> the tracing_map, used when getting and setting the variable.  And then
> there are the several versions of var_ref_idx used for different
> purposes depending on the context, but all of them are indices into the
> array of variable values collected when a trigger is hit.  For example,

So IIUC field->var_ref_idx is an index to the val_ref_vals array,
right?  Then if we keep the all hist_fields we don't need to have a
separate var_ref_idx IMHO.


> the var_ref_idx defined inside track_data is the index that points to
> the tracked var value, which the action can use directly, and the

I guess the track_data.var_ref_idx is always same as the
track_data.track_var.var_ref_idx, no?  If so we can get rid of it.


> var_ref_idx alongside the synth fields in action_data is the index of
> the first param used when generating a synthetic event, and so on.

For synth event, we have hist_data->synth_var_refs[] but it's not
passed to trace_synth() so no way to know original var_ref_idx and I'm
ok with having action_data.var_ref_idx.

But I don't see where hist_data->synth_var_refs is used other than
find_var_ref().  And for that purpose, I guess it's more efficient to
use hist_data->var_refs[] so that we can remove synth_var_refs.


> 
> Tom 
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 818944391d97..5310ef73f023 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -39,6 +39,16 @@ enum field_op_id {
>  	FIELD_OP_UNARY_MINUS,
>  };
>  
> +/*
> + * A hist_var (histogram variable) contains variable information for
> + * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
> + * flag set.  A hist_var has a variable name e.g. ts0, and is
> + * associated with a given histogram trigger, as specified by
> + * hist_data.  The hist_var idx is the unique index assigned to the
> + * variable by the hist trigger's tracing_map.  The idx is what is
> + * used to set a variable's value and, by a variable reference, to
> + * retrieve it.
> + */
>  struct hist_var {
>  	char				*name;
>  	struct hist_trigger_data	*hist_data;
> @@ -60,7 +70,15 @@ struct hist_field {
>  	char				*system;
>  	char				*event_name;
>  	char				*name;
> -	unsigned int			var_idx;
> +
> +	/*
> +	 * When a histogram trigger is hit, if it has any references
> +	 * to variables, the values of those variables are collected
> +	 * into a var_ref_vals array by resolve_var_refs().  The
> +	 * current value of each variable is read from the tracing_map
> +	 * using the hist field's hist_var.idx and entered into the
> +	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
> +	 */
>  	unsigned int			var_ref_idx;
>  	bool                            read_once;
>  };
> @@ -350,6 +368,14 @@ struct action_data {
>  	unsigned int		n_params;
>  	char			*params[SYNTH_FIELDS_MAX];
>  
> +	/*
> +	 * When a histogram trigger is hit, the values of any
> +	 * references to variables, including variables being passed
> +	 * as parameters to synthetic events, are collected into a
> +	 * var_ref_vals array.  This var_ref_idx is the index of the
> +	 * first param in the array to be passed to the synthetic
> +	 * event invocation.
> +	 */
>  	unsigned int		var_ref_idx;
>  	struct synth_event	*synth_event;
>  	bool			use_trace_keyword;
> @@ -362,10 +388,29 @@ struct action_data {
>  		} match_data;
>  
>  		struct {
> +			/*
> +			 * var_str and var_ref refer to the variable
> +			 * being tracked e.g onmax($var).
> +			 */
>  			char			*var_str;

Can it be different from var_ref->var.name?

Thanks,
Namhyung


>  			struct hist_field	*var_ref;
> +
> +			/*
> +			 * When a histogram trigger is hit, the values
> +			 * of any references to variables, including
> +			 * variables being tracked e.g. onmax($var),
> +			 * are collected into a var_ref_vals array.
> +			 * This var_ref_idx is the index of the
> +			 * tracked var value in var_ref_vals, which
> +			 * the action can make use of directly.
> +			 */
>  			unsigned int		var_ref_idx;
>  
> +			/*
> +			 * This track_var contains the 'invisible'
> +			 * tracking variable created to keep the
> +			 * current e.g. max value.
> +			 */
>  			struct hist_field	*track_var;
>  
>  			check_track_val_fn_t	check_val;
