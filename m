Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88BDC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AEF2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9heAXVy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96AEF2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeLDTxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbeLDTxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:53:37 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B6EC20878;
        Tue,  4 Dec 2018 19:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543953217;
        bh=X/zdaUkNUY6L5NHayOuRZVhi3YroeoSyi3nlIlFZLvY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c9heAXVy5h0INkJXqUOnVd7Rr/YMWNBSFHJGPM5cIDAOiP6aGLjRawUYKbHslrzmC
         Xl5KMQD+Scbxi7Roe+3kOnSQrxmQRZ4Bbd9Rpnj7RNkf4KFYztoMvNFPM36hF+NCzR
         qMydQaissk7vBtpcfYj8irJpJPfXMSUG8o4wk6aM=
Message-ID: <1543953214.2790.14.camel@kernel.org>
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and
 save action
From:   Tom Zanussi <zanussi@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Date:   Tue, 04 Dec 2018 13:53:34 -0600
In-Reply-To: <20181204072549.GA16733@sejong>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
         <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
         <20181123025000.GC25952@sejong> <1543875722.2018.22.camel@kernel.org>
         <20181204072549.GA16733@sejong>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On Tue, 2018-12-04 at 16:25 +0900, Namhyung Kim wrote:
> On Mon, Dec 03, 2018 at 04:22:02PM -0600, Tom Zanussi wrote:
> > Hi Namhyung,
> > 
> > On Fri, 2018-11-23 at 11:50 +0900, Namhyung Kim wrote:
> > > Hi Tom,
> > > 
> > > On Wed, Nov 14, 2018 at 02:18:02PM -0600, Tom Zanussi wrote:
> > > > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > > > 
> > 
> > [snip]
> > 
> > > > 
> > 
> >  enum handler_id {
> > > >  	HANDLER_ONMATCH = 1,
> > > >  	HANDLER_ONMAX,
> > > > @@ -349,14 +358,18 @@ struct action_data {
> > > >  
> > > >  		struct {
> > > >  			char			*var_str;
> > > > -			unsigned int		max_var_re
> > > > f_idx;
> > > > -			struct hist_field	*max_var;
> > > > -			struct hist_field	*var;
> > > > -		} onmax;
> > > > +			struct hist_field	*var_ref;
> > > > +			unsigned int		var_ref_id
> > > > x;
> > > 
> > > I have a question.  It's confusing for me there are many indexes
> > > for
> > > a
> > > variable (ref).  The hist_field already has var.idx, var_idx and
> > > var_ref_idx in it.  But you also added an external var_ref_idx
> > > along
> > > with the var_ref.  Also I see another var_ref_idx in the action
> > > data.
> > > Is all that really needed?  Could you please add some comment
> > > then?
> > > 
> > 
> > Below is a patch with some comments I'll merge into the next
> > version
> > that I hope will help make things more clear.  Basically, the
> > hist_field.var_idx isn't used so I've removed it and therefore that
> 
> Thanks!
> 
> 
> > source of confusion, while var.idx is the variable's unique
> > 'handle' in
> > the tracing_map, used when getting and setting the variable.  And
> > then
> > there are the several versions of var_ref_idx used for different
> > purposes depending on the context, but all of them are indices into
> > the
> > array of variable values collected when a trigger is hit.  For
> > example,
> 
> So IIUC field->var_ref_idx is an index to the val_ref_vals array,
> right?  Then if we keep the all hist_fields we don't need to have a
> separate var_ref_idx IMHO.
> 

hist_field_var_ref() needs to be be able to retrieve var_ref_idx given
the field alone, so I'm not sure this can be removed.

> 
> > the var_ref_idx defined inside track_data is the index that points
> > to
> > the tracked var value, which the action can use directly, and the
> 
> I guess the track_data.var_ref_idx is always same as the
> track_data.track_var.var_ref_idx, no?  If so we can get rid of it.
> 

Yes, you're right, that seems to be redundant in the code, will remove
it.

> 
> > var_ref_idx alongside the synth fields in action_data is the index
> > of
> > the first param used when generating a synthetic event, and so on.
> 
> For synth event, we have hist_data->synth_var_refs[] but it's not
> passed to trace_synth() so no way to know original var_ref_idx and
> I'm
> ok with having action_data.var_ref_idx.
> 
> But I don't see where hist_data->synth_var_refs is used other than
> find_var_ref().  And for that purpose, I guess it's more efficient to
> use hist_data->var_refs[] so that we can remove synth_var_refs.
> 

It's also used to destroy hist_fields in destroy_synth_var_refs(), but
this points out something that should be cleaned up too - because of
the way the code developed over time, we now have separate sets of
fields like this that should be unified - I'll add some patches to do
that.  And that will get rid of the separate synth_var_refs and use
hist_data->var_refs, which as you correctly point out will be more
efficient.

> 
> > 
> > Tom 
> > 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index 818944391d97..5310ef73f023 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -39,6 +39,16 @@ enum field_op_id {
> >  	FIELD_OP_UNARY_MINUS,
> >  };
> >  
> > +/*
> > + * A hist_var (histogram variable) contains variable information
> > for
> > + * hist_fields having the HIST_FIELD_FL_VAR or
> > HIST_FIELD_FL_VAR_REF
> > + * flag set.  A hist_var has a variable name e.g. ts0, and is
> > + * associated with a given histogram trigger, as specified by
> > + * hist_data.  The hist_var idx is the unique index assigned to
> > the
> > + * variable by the hist trigger's tracing_map.  The idx is what is
> > + * used to set a variable's value and, by a variable reference, to
> > + * retrieve it.
> > + */
> >  struct hist_var {
> >  	char				*name;
> >  	struct hist_trigger_data	*hist_data;
> > @@ -60,7 +70,15 @@ struct hist_field {
> >  	char				*system;
> >  	char				*event_name;
> >  	char				*name;
> > -	unsigned int			var_idx;
> > +
> > +	/*
> > +	 * When a histogram trigger is hit, if it has any
> > references
> > +	 * to variables, the values of those variables are
> > collected
> > +	 * into a var_ref_vals array by resolve_var_refs().  The
> > +	 * current value of each variable is read from the
> > tracing_map
> > +	 * using the hist field's hist_var.idx and entered into
> > the
> > +	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
> > +	 */
> >  	unsigned int			var_ref_idx;
> >  	bool                            read_once;
> >  };
> > @@ -350,6 +368,14 @@ struct action_data {
> >  	unsigned int		n_params;
> >  	char			*params[SYNTH_FIELDS_MAX];
> >  
> > +	/*
> > +	 * When a histogram trigger is hit, the values of any
> > +	 * references to variables, including variables being
> > passed
> > +	 * as parameters to synthetic events, are collected into a
> > +	 * var_ref_vals array.  This var_ref_idx is the index of
> > the
> > +	 * first param in the array to be passed to the synthetic
> > +	 * event invocation.
> > +	 */
> >  	unsigned int		var_ref_idx;
> >  	struct synth_event	*synth_event;
> >  	bool			use_trace_keyword;
> > @@ -362,10 +388,29 @@ struct action_data {
> >  		} match_data;
> >  
> >  		struct {
> > +			/*
> > +			 * var_str and var_ref refer to the
> > variable
> > +			 * being tracked e.g onmax($var).
> > +			 */
> >  			char			*var_str;
> 
> Can it be different from var_ref->var.name?
> 

Well, it's slightly different in that it still has the '$' prefix -
it's used for printing the action, but there's no reason not to get rid
of it and use var_ref instead.

Thanks for the useful comments,

Tom

