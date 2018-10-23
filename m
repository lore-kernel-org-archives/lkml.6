Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D864C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDB92081B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1NUh8X6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDB92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbeJXFnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:43:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725761AbeJXFnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:43:17 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869DB207DD;
        Tue, 23 Oct 2018 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540329488;
        bh=rGwM+/he2C5lkmu77Rkx4DoUaHmAX2c8/DU8mxwK7lI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=1NUh8X6lvh/F8x/lWpsrgKUCFAYhpNSUPFtVZ61T06v3e7z5hS5B4fXTfkvzK2TWD
         yuuSWNvcn6LULM0KJhAbut3f3B0p1AUPVNB4aXenUUy8lSvuaUO1VvGxRvY36p1+YQ
         SJ6O5pkUNN+8fH2u1NFmy4DUT0CC6/pFWj+u2JwY=
Message-ID: <1540329486.6502.7.camel@kernel.org>
Subject: Re: [PATCH v6 01/15] tracing: Refactor hist trigger action code
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 23 Oct 2018 16:18:06 -0500
In-Reply-To: <20181023140923.1833a0a6239210b29ee4aa27@kernel.org>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
         <d8321db01e0021d03086470bd38dc3bac7dc0829.1539288364.git.tom.zanussi@linux.intel.com>
         <20181023140923.1833a0a6239210b29ee4aa27@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, 2018-10-23 at 14:09 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Thu, 11 Oct 2018 16:01:58 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > The hist trigger action code currently implements two essentially
> > hard-coded pairs of 'actions' - onmax(), which tracks a variable
> > and
> > saves some event fields when a max is hit, and onmatch(), which is
> > hard-coded to generate a synthetic event.
> > 
> > These hardcoded pairs (track max/save fields and detect
> > match/generate
> > synthetic event) should really be decoupled into separate
> > components
> > that can then be arbitrarily combined.  The first component of each
> > pair (track max/detect match) is called a 'handler' in the new
> > code,
> > while the second component (save fields/generate synthetic event)
> > is
> > called an 'action' in this scheme.
> > 
> > This change refactors the action code to reflect this split by
> > adding
> > two handlers, HANDLER_ONMATCH and HANDLER_ONMAX, along with two
> > actions, ACTION_SAVE and ACTION_TRACE.
> > 
> > The new code combines them to produce the existing ONMATCH/TRACE
> > and
> > ONMAX/SAVE functionality, but doesn't implement the other
> > combinations
> > now possible.  Future patches will expand these to further useful
> > cases, such as ONMAX/TRACE, as well as add additional handlers and
> > actions such as ONCHANGE and SNAPSHOT.
> 
> This patch looks good, but I have some comment below;
> 
> [...]
> > @@ -3248,11 +3260,12 @@ static void onmax_print(struct seq_file *m,
> >  {
> >  	unsigned int i, save_var_idx, max_idx = data-
> > >onmax.max_var->var.idx;
> >  
> > -	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt,
> > max_idx));
> > +	if (data->handler == HANDLER_ONMAX)
> 
> It seems a bit odd that checks HANDLER_ONMAX or not in onmax_X
> function().
> 

Later patches change things so it makes more sense i.e. onmax_print is
renamed to track_data_print() which handles not just ONMAX but ONCHANGE
as well, and then this check is needed.  But I can move this check to
those patches.

> > +		seq_printf(m, "\n\tmax: %10llu",
> > tracing_map_read_var(elt, max_idx));
> >  
> > -	for (i = 0; i < hist_data->n_max_vars; i++) {
> > -		struct hist_field *save_val = hist_data-
> > >max_vars[i]->val;
> > -		struct hist_field *save_var = hist_data-
> > >max_vars[i]->var;
> > +	for (i = 0; i < hist_data->n_save_vars; i++) {
> > +		struct hist_field *save_val = hist_data-
> > >save_vars[i]->val;
> > +		struct hist_field *save_var = hist_data-
> > >save_vars[i]->var;
> >  		u64 val;
> >  
> >  		save_var_idx = save_var->var.idx;
> > @@ -3296,7 +3309,7 @@ static void onmax_destroy(struct action_data
> > *data)
> >  	destroy_hist_field(data->onmax.var, 0);
> >  
> >  	kfree(data->onmax.var_str);
> > -	kfree(data->onmax.fn_name);
> > +	kfree(data->action_name);
> >  
> >  	for (i = 0; i < data->n_params; i++)
> >  		kfree(data->params[i]);
> > @@ -3304,16 +3317,17 @@ static void onmax_destroy(struct
> > action_data *data)
> >  	kfree(data);
> >  }
> >  
> > +static int action_create(struct hist_trigger_data *hist_data,
> > +			 struct action_data *data);
> > +
> >  static int onmax_create(struct hist_trigger_data *hist_data,
> >  			struct action_data *data)
> >  {
> > +	struct hist_field *var_field, *ref_field, *max_var = NULL;
> >  	struct trace_event_file *file = hist_data->event_file;
> > -	struct hist_field *var_field, *ref_field, *max_var;
> >  	unsigned int var_ref_idx = hist_data->n_var_refs;
> > -	struct field_var *field_var;
> > -	char *onmax_var_str, *param;
> > +	char *onmax_var_str;
> >  	unsigned long flags;
> > -	unsigned int i;
> >  	int ret = 0;
> >  
> >  	onmax_var_str = data->onmax.var_str;
> > @@ -3343,9 +3357,10 @@ static int onmax_create(struct
> > hist_trigger_data *hist_data,
> >  	ref_field->var_ref_idx = hist_data->n_var_refs++;
> >  	data->onmax.var = ref_field;
> >  
> > -	data->fn = onmax_save;
> >  	data->onmax.max_var_ref_idx = var_ref_idx;
> > -	max_var = create_var(hist_data, file, "max", sizeof(u64),
> > "u64");
> > +
> > +	if (data->handler == HANDLER_ONMAX)
> 
> Ditto.

Same here, this changes to track_data_create() in later patches, where
it makes sense.  But, will move it there.

> 
> > +		max_var = create_var(hist_data, file, "max",
> > sizeof(u64), "u64");
> >  	if (IS_ERR(max_var)) {
> >  		hist_err("onmax: Couldn't create onmax variable:
> > ", "max");
> >  		ret = PTR_ERR(max_var);
> > @@ -3353,27 +3368,7 @@ static int onmax_create(struct
> > hist_trigger_data *hist_data,
> >  	}
> >  	data->onmax.max_var = max_var;
> >  
> > -	for (i = 0; i < data->n_params; i++) {
> > -		param = kstrdup(data->params[i], GFP_KERNEL);
> > -		if (!param) {
> > -			ret = -ENOMEM;
> > -			goto out;
> > -		}
> > -
> > -		field_var = create_target_field_var(hist_data,
> > NULL, NULL, param);
> > -		if (IS_ERR(field_var)) {
> > -			hist_err("onmax: Couldn't create field
> > variable: ", param);
> > -			ret = PTR_ERR(field_var);
> > -			kfree(param);
> > -			goto out;
> > -		}
> > -
> > -		hist_data->max_vars[hist_data->n_max_vars++] =
> > field_var;
> > -		if (field_var->val->flags & HIST_FIELD_FL_STRING)
> > -			hist_data->n_max_var_str++;
> > -
> > -		kfree(param);
> > -	}
> > +	ret = action_create(hist_data, data);
> >   out:
> >  	return ret;
> >  }
> > @@ -3384,11 +3379,14 @@ static int parse_action_params(char
> > *params, struct action_data *data)
> >  	int ret = 0;
> >  
> >  	while (params) {
> > -		if (data->n_params >= SYNTH_FIELDS_MAX)
> > +		if (data->n_params >= SYNTH_FIELDS_MAX) {
> > +			hist_err("Too many action params", "");
> >  			goto out;
> > +		}
> >  
> >  		param = strsep(&params, ",");
> >  		if (!param) {
> > +			hist_err("No action param found", "");
> >  			ret = -EINVAL;
> >  			goto out;
> >  		}
> > @@ -3412,10 +3410,69 @@ static int parse_action_params(char
> > *params, struct action_data *data)
> >  	return ret;
> >  }
> >  
> > -static struct action_data *onmax_parse(char *str)
> > +static int action_parse(char *str, struct action_data *data,
> > +			enum handler_id handler)
> > +{
> > +	char *action_name;
> > +	int ret = 0;
> > +
> > +	strsep(&str, ".");
> > +	if (!str) {
> > +		hist_err("action parsing: No action found", "");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	action_name = strsep(&str, "(");
> > +	if (!action_name || !str) {
> > +		hist_err("action parsing: No action found", "");
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (strncmp(action_name, "save", strlen("save")) == 0) {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (!params) {
> > +			hist_err("action parsing: No params found
> > for %s", "save");
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		ret = parse_action_params(params, data);
> > +		if (ret)
> > +			goto out;
> > +
> > +		if (handler == HANDLER_ONMAX)
> > +			data->fn = onmax_save;
> > +
> > +		data->action = ACTION_SAVE;
> > +	} else {
> > +		char *params = strsep(&str, ")");
> > +
> > +		if (params) {
> > +			ret = parse_action_params(params, data);
> > +			if (ret)
> > +				goto out;
> > +		}
> > +
> > +		data->fn = action_trace;
> > +		data->action = ACTION_TRACE;
> > +	}
> > +
> > +	data->action_name = kstrdup(action_name, GFP_KERNEL);
> > +	if (!data->action_name) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> 
> Since we know "handler", it is natural that data->handler is assigned
> here.


Makes sense, will change.

> 
> > + out:
> > +	return ret;
> > +}
> > +
> > +static struct action_data *onmax_parse(char *str, enum handler_id
> > handler)
> >  {
> > -	char *onmax_fn_name, *onmax_var_str;
> >  	struct action_data *data;
> > +	char *onmax_var_str;
> >  	int ret = -EINVAL;
> >  
> >  	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > @@ -3434,33 +3491,11 @@ static struct action_data *onmax_parse(char
> > *str)
> >  		goto free;
> >  	}
> >  
> > -	strsep(&str, ".");
> > -	if (!str)
> > -		goto free;
> > -
> > -	onmax_fn_name = strsep(&str, "(");
> > -	if (!onmax_fn_name || !str)
> > -		goto free;
> > -
> > -	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
> > -		char *params = strsep(&str, ")");
> > -
> > -		if (!params) {
> > -			ret = -EINVAL;
> > -			goto free;
> > -		}
> > -
> > -		ret = parse_action_params(params, data);
> > -		if (ret)
> > -			goto free;
> > -	} else
> > +	ret = action_parse(str, data, handler);
> > +	if (ret)
> >  		goto free;
> >  
> > -	data->onmax.fn_name = kstrdup(onmax_fn_name, GFP_KERNEL);
> > -	if (!data->onmax.fn_name) {
> > -		ret = -ENOMEM;
> > -		goto free;
> > -	}
> > +	data->handler = handler;
> >   out:
> >  	return data;
> >   free:
> > @@ -3477,7 +3512,7 @@ static void onmatch_destroy(struct
> > action_data *data)
> >  
> >  	kfree(data->onmatch.match_event);
> >  	kfree(data->onmatch.match_event_system);
> > -	kfree(data->onmatch.synth_event_name);
> > +	kfree(data->action_name);
> >  
> >  	for (i = 0; i < data->n_params; i++)
> >  		kfree(data->params[i]);
> > @@ -3554,8 +3589,9 @@ static int check_synth_field(struct
> > synth_event *event,
> >  }
> >  
> >  static struct hist_field *
> > -onmatch_find_var(struct hist_trigger_data *hist_data, struct
> > action_data *data,
> > -		 char *system, char *event, char *var)
> > +trace_action_find_var(struct hist_trigger_data *hist_data,
> > +		      struct action_data *data,
> > +		      char *system, char *event, char *var)
> >  {
> >  	struct hist_field *hist_field;
> >  
> > @@ -3563,7 +3599,7 @@ onmatch_find_var(struct hist_trigger_data
> > *hist_data, struct action_data *data,
> >  
> >  	hist_field = find_target_event_var(hist_data, system,
> > event, var);
> >  	if (!hist_field) {
> > -		if (!system) {
> > +		if (!system && data->handler == HANDLER_ONMATCH) {
> >  			system = data->onmatch.match_event_system;
> >  			event = data->onmatch.match_event;
> >  		}
> > @@ -3572,15 +3608,15 @@ onmatch_find_var(struct hist_trigger_data
> > *hist_data, struct action_data *data,
> >  	}
> >  
> >  	if (!hist_field)
> > -		hist_err_event("onmatch: Couldn't find onmatch
> > param: $", system, event, var);
> > +		hist_err_event("trace action: Couldn't find param:
> > $", system, event, var);
> >  
> >  	return hist_field;
> >  }
> >  
> >  static struct hist_field *
> > -onmatch_create_field_var(struct hist_trigger_data *hist_data,
> > -			 struct action_data *data, char *system,
> > -			 char *event, char *var)
> > +trace_action_create_field_var(struct hist_trigger_data *hist_data,
> > +			      struct action_data *data, char
> > *system,
> > +			      char *event, char *var)
> >  {
> >  	struct hist_field *hist_field = NULL;
> >  	struct field_var *field_var;
> > @@ -3603,7 +3639,7 @@ onmatch_create_field_var(struct
> > hist_trigger_data *hist_data,
> >  		 * looking for fields on the
> > onmatch(system.event.xxx)
> >  		 * event.
> >  		 */
> > -		if (!system) {
> > +		if (!system && data->handler == HANDLER_ONMATCH) {
> >  			system = data->onmatch.match_event_system;
> >  			event = data->onmatch.match_event;
> >  		}
> > @@ -3627,9 +3663,8 @@ onmatch_create_field_var(struct
> > hist_trigger_data *hist_data,
> >  	goto out;
> >  }
> >  
> > -static int onmatch_create(struct hist_trigger_data *hist_data,
> > -			  struct trace_event_file *file,
> > -			  struct action_data *data)
> > +static int trace_action_create(struct hist_trigger_data
> > *hist_data,
> > +			       struct action_data *data)
> >  {
> >  	char *event_name, *param, *system = NULL;
> >  	struct hist_field *hist_field, *var_ref;
> > @@ -3639,12 +3674,14 @@ static int onmatch_create(struct
> > hist_trigger_data *hist_data,
> >  	int ret = 0;
> >  
> >  	mutex_lock(&synth_event_mutex);
> > -	event = find_synth_event(data->onmatch.synth_event_name);
> > +
> > +	event = find_synth_event(data->action_name);
> >  	if (!event) {
> > -		hist_err("onmatch: Couldn't find synthetic event:
> > ", data->onmatch.synth_event_name);
> > +		hist_err("trace action: Couldn't find synthetic
> > event: ", data->action_name);
> >  		mutex_unlock(&synth_event_mutex);
> >  		return -EINVAL;
> >  	}
> > +
> >  	event->ref++;
> >  	mutex_unlock(&synth_event_mutex);
> >  
> > @@ -3673,13 +3710,15 @@ static int onmatch_create(struct
> > hist_trigger_data *hist_data,
> >  		}
> >  
> >  		if (param[0] == '$')
> > -			hist_field = onmatch_find_var(hist_data,
> > data, system,
> > -						      event_name,
> > param);
> > +			hist_field =
> > trace_action_find_var(hist_data, data,
> > +							   system,
> > event_name,
> > +							   param);
> >  		else
> > -			hist_field =
> > onmatch_create_field_var(hist_data, data,
> > -							      syst
> > em,
> > -							      even
> > t_name,
> > -							      para
> > m);
> > +			hist_field =
> > trace_action_create_field_var(hist_data,
> > +								  
> >  data,
> > +								  
> >  system,
> > +								  
> >  event_name,
> > +								  
> >  param);
> >  
> >  		if (!hist_field) {
> >  			kfree(p);
> > @@ -3701,7 +3740,7 @@ static int onmatch_create(struct
> > hist_trigger_data *hist_data,
> >  			continue;
> >  		}
> >  
> > -		hist_err_event("onmatch: Param type doesn't match
> > synthetic event field type: ",
> > +		hist_err_event("trace action: Param type doesn't
> > match synthetic event field type: ",
> >  			       system, event_name, param);
> >  		kfree(p);
> >  		ret = -EINVAL;
> > @@ -3709,12 +3748,11 @@ static int onmatch_create(struct
> > hist_trigger_data *hist_data,
> >  	}
> >  
> >  	if (field_pos != event->n_fields) {
> > -		hist_err("onmatch: Param count doesn't match
> > synthetic event field count: ", event->name);
> > +		hist_err("trace action: Param count doesn't match
> > synthetic event field count: ", event->name);
> >  		ret = -EINVAL;
> >  		goto err;
> >  	}
> >  
> > -	data->fn = action_trace;
> >  	data->onmatch.synth_event = event;
> >  	data->onmatch.var_ref_idx = var_ref_idx;
> >   out:
> > @@ -3727,10 +3765,60 @@ static int onmatch_create(struct
> > hist_trigger_data *hist_data,
> >  	goto out;
> >  }
> >  
> > +static int action_create(struct hist_trigger_data *hist_data,
> > +			 struct action_data *data)
> > +{
> > +	struct field_var *field_var;
> > +	unsigned int i;
> > +	char *param;
> > +	int ret = 0;
> > +
> > +	if (data->action == ACTION_TRACE) {
> > +		ret = trace_action_create(hist_data, data);
> 
> This can return soon without "goto".
> 
> > +		goto out;
> > +	}
> > +
> > +	if (data->action == ACTION_SAVE) {
> > +		if (hist_data->n_save_vars) {
> > +			ret = -EINVAL;
> 
> Maybe -EEXIST?
> 

Yep, makes sense, will change.

> > +			hist_err("save action: Can't have more
> > than one save() action per hist", "");
> > +			goto out;
> > +		}
> > +
> > +		for (i = 0; i < data->n_params; i++) {
> > +			param = kstrdup(data->params[i],
> > GFP_KERNEL);
> > +			if (!param) {
> > +				ret = -ENOMEM;
> > +				goto out;
> > +			}
> > +
> > +			field_var =
> > create_target_field_var(hist_data, NULL, NULL, param);
> > +			if (IS_ERR(field_var)) {
> > +				hist_err("save action: Couldn't
> > create field variable: ", param);
> > +				ret = PTR_ERR(field_var);
> > +				kfree(param);
> > +				goto out;
> > +			}
> > +
> > +			hist_data->save_vars[hist_data-
> > >n_save_vars++] = field_var;
> > +			if (field_var->val->flags &
> > HIST_FIELD_FL_STRING)
> > +				hist_data->n_save_var_str++;
> > +			kfree(param);
> > +		}
> > +	}
> > + out:
> > +	return ret;
> > +}
> > +
> > +static int onmatch_create(struct hist_trigger_data *hist_data,
> > +			  struct action_data *data)
> > +{
> > +	return action_create(hist_data, data);
> > +}
> > +
> >  static struct action_data *onmatch_parse(struct trace_array *tr,
> > char *str)
> >  {
> >  	char *match_event, *match_event_system;
> > -	char *synth_event_name, *params;
> >  	struct action_data *data;
> >  	int ret = -EINVAL;
> >  
> > @@ -3768,33 +3856,11 @@ static struct action_data
> > *onmatch_parse(struct trace_array *tr, char *str)
> >  		goto free;
> >  	}
> >  
> > -	strsep(&str, ".");
> > -	if (!str) {
> > -		hist_err("onmatch: Missing . after onmatch(): ",
> > str);
> > -		goto free;
> > -	}
> > -
> > -	synth_event_name = strsep(&str, "(");
> > -	if (!synth_event_name || !str) {
> > -		hist_err("onmatch: Missing opening paramlist
> > paren: ", synth_event_name);
> > -		goto free;
> > -	}
> > -
> > -	data->onmatch.synth_event_name = kstrdup(synth_event_name,
> > GFP_KERNEL);
> > -	if (!data->onmatch.synth_event_name) {
> > -		ret = -ENOMEM;
> > -		goto free;
> > -	}
> > -
> > -	params = strsep(&str, ")");
> > -	if (!params || !str || (str && strlen(str))) {
> > -		hist_err("onmatch: Missing closing paramlist
> > paren: ", params);
> > -		goto free;
> > -	}
> > -
> > -	ret = parse_action_params(params, data);
> > +	ret = action_parse(str, data, HANDLER_ONMATCH);
> >  	if (ret)
> >  		goto free;
> > +
> > +	data->handler = HANDLER_ONMATCH;
> 
> This assignment seems to be done in action_parse().
> 
> >   out:
> >  	return data;
> >   free:
> > @@ -4232,9 +4298,9 @@ static void destroy_actions(struct
> > hist_trigger_data *hist_data)
> >  	for (i = 0; i < hist_data->n_actions; i++) {
> >  		struct action_data *data = hist_data->actions[i];
> >  
> > -		if (data->fn == action_trace)
> > +		if (data->handler == HANDLER_ONMATCH)
> >  			onmatch_destroy(data);
> > -		else if (data->fn == onmax_save)
> > +		else if (data->handler == HANDLER_ONMAX)
> >  			onmax_destroy(data);
> >  		else
> >  			kfree(data);
> > @@ -4260,16 +4326,14 @@ static int parse_actions(struct
> > hist_trigger_data *hist_data)
> >  				ret = PTR_ERR(data);
> >  				break;
> >  			}
> > -			data->fn = action_trace;
> >  		} else if (strncmp(str, "onmax(",
> > strlen("onmax(")) == 0) {
> >  			char *action_str = str + strlen("onmax(");
> >  
> > -			data = onmax_parse(action_str);
> > +			data = onmax_parse(action_str,
> > HANDLER_ONMAX);
> >  			if (IS_ERR(data)) {
> >  				ret = PTR_ERR(data);
> >  				break;
> >  			}
> > -			data->fn = onmax_save;
> >  		} else {
> >  			ret = -EINVAL;
> >  			break;
> > @@ -4281,8 +4345,7 @@ static int parse_actions(struct
> > hist_trigger_data *hist_data)
> >  	return ret;
> >  }
> >  
> > -static int create_actions(struct hist_trigger_data *hist_data,
> > -			  struct trace_event_file *file)
> > +static int create_actions(struct hist_trigger_data *hist_data)
> >  {
> >  	struct action_data *data;
> >  	unsigned int i;
> > @@ -4291,14 +4354,17 @@ static int create_actions(struct
> > hist_trigger_data *hist_data,
> >  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
> >  		data = hist_data->actions[i];
> >  
> > -		if (data->fn == action_trace) {
> > -			ret = onmatch_create(hist_data, file,
> > data);
> > +		if (data->handler == HANDLER_ONMATCH) {
> > +			ret = onmatch_create(hist_data, data);
> >  			if (ret)
> >  				return ret;
> > -		} else if (data->fn == onmax_save) {
> > +		} else if (data->handler == HANDLER_ONMAX) {
> >  			ret = onmax_create(hist_data, data);
> >  			if (ret)
> >  				return ret;
> > +		} else {
> > +			ret = -EINVAL;
> 
> This is a bit odd (or just mixtured), return -EINVAL will be enough
> here.
> Or above "if (ret) return ret;" shoud be "if (ret) break;" since this
> function
> returns ret soon after this loop.
> 

Yeah, I'll change them all to just break, and have them all fall into
the final ret.

Thanks,

Tom

> > +			break;
> >  		}
> >  	}
> >  
> 
> Thank you,
> 
> 
