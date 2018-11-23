Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842ABC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383B120685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383B120685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502205AbeKWRoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:44:04 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:44031 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733170AbeKWRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:44:04 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 23 Nov 2018 16:01:05 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 23 Nov 2018 16:01:05 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 23 Nov 2018 16:01:05 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and save
 action
Message-ID: <20181123070105.GA3838@sejong>
References: <cover.1542221862.git.tom.zanussi@linux.intel.com>
 <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9baa2b4a9b708791b39f176e3b63c207163d8c3b.1542221863.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2018 at 02:18:02PM -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> The action refactor code allowed actions and handlers to be separated,
> but the existing onmax handler and save action code is still not
> flexible enough to handle arbitrary coupling.  This change generalizes
> them and in the process makes additional handlers and actions easier
> to implement.
> 
> The onmax action can be broken up and thought of as two separate
> components - a variable to be tracked (the parameter given to the
> onmax($var_to_track) function) and an invisible variable created to
> save the ongoing result of doing something with that variable, such as
> saving the max value of that variable so far seen.
> 
> Separating it out like this and renaming it appropriately allows us to
> use the same code for similar tracking functions such as
> onchange($var_to_track), which would just track the last value seen
> rather than the max seen so far, which is useful in some situations.
> 
> Additionally, because different handlers and actions may want to save
> and access data differently e.g. save and retrieve tracking values as
> local variables vs something more global, save_val() and get_val()
> interface functions are introduced and max-specific implementations
> are used instead.
> 
> The same goes for the code that checks whether a maximum has been hit
> - a generic check_val() interface and max-checking implementation is
> used instead, which allows future patches to make use of he same code
> using their own implemetations of similar functionality.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 225 ++++++++++++++++++++++++++-------------
>  1 file changed, 151 insertions(+), 74 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 54b78cfe2766..ac48ad1482c8 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -319,6 +319,15 @@ typedef void (*action_fn_t) (struct hist_trigger_data *hist_data,
>  			     struct ring_buffer_event *rbe,
>  			     struct action_data *data, u64 *var_ref_vals);
>  
> +typedef bool (*check_track_val_fn_t) (u64 track_val, u64 var_val);
> +typedef bool (*save_track_val_fn_t) (struct hist_trigger_data *hist_data,
> +				     struct tracing_map_elt *elt,
> +				     struct action_data *data,
> +				     unsigned int track_var_idx, u64 var_val);
> +typedef u64 (*get_track_val_fn_t) (struct hist_trigger_data *hist_data,
> +				   struct tracing_map_elt *elt,
> +				   struct action_data *data);
> +
>  enum handler_id {
>  	HANDLER_ONMATCH = 1,
>  	HANDLER_ONMAX,
> @@ -349,14 +358,18 @@ struct action_data {
>  
>  		struct {
>  			char			*var_str;
> -			unsigned int		max_var_ref_idx;
> -			struct hist_field	*max_var;
> -			struct hist_field	*var;
> -		} onmax;
> +			struct hist_field	*var_ref;
> +			unsigned int		var_ref_idx;
> +
> +			struct hist_field	*track_var;
> +
> +			check_track_val_fn_t	check_val;
> +			save_track_val_fn_t	save_val;
> +			get_track_val_fn_t	get_val;
> +		} track_data;
>  	};
>  };
>  
> -
>  static char last_hist_cmd[MAX_FILTER_STR_VAL];
>  static char hist_err_str[MAX_FILTER_STR_VAL];
>  
> @@ -3133,10 +3146,10 @@ static void update_field_vars(struct hist_trigger_data *hist_data,
>  			    hist_data->n_field_vars, 0);
>  }
>  
> -static void update_max_vars(struct hist_trigger_data *hist_data,
> -			    struct tracing_map_elt *elt,
> -			    struct ring_buffer_event *rbe,
> -			    void *rec)
> +static void update_save_vars(struct hist_trigger_data *hist_data,
> +			     struct tracing_map_elt *elt,
> +			     struct ring_buffer_event *rbe,
> +			     void *rec)
>  {
>  	__update_field_vars(elt, rbe, rec, hist_data->save_vars,
>  			    hist_data->n_save_vars, hist_data->n_field_var_str);
> @@ -3274,14 +3287,68 @@ create_target_field_var(struct hist_trigger_data *target_hist_data,
>  	return create_field_var(target_hist_data, file, var_name);
>  }
>  
> -static void onmax_print(struct seq_file *m,
> -			struct hist_trigger_data *hist_data,
> -			struct tracing_map_elt *elt,
> -			struct action_data *data)
> +static bool check_track_val_max(u64 track_val, u64 var_val)
>  {
> -	unsigned int i, save_var_idx, max_idx = data->onmax.max_var->var.idx;
> +	if (var_val <= track_val)
> +		return false;
> +
> +	return true;
> +}
>  
> -	seq_printf(m, "\n\tmax: %10llu", tracing_map_read_var(elt, max_idx));
> +static u64 get_track_val_local(struct hist_trigger_data *hist_data,
> +			       struct tracing_map_elt *elt,
> +			       struct action_data *data)
> +{
> +	unsigned int track_var_idx = data->track_data.track_var->var.idx;
> +	u64 track_val;
> +
> +	track_val = tracing_map_read_var(elt, track_var_idx);
> +
> +	return track_val;
> +}
> +
> +static bool save_track_val_local(struct hist_trigger_data *hist_data,
> +				 struct tracing_map_elt *elt,
> +				 struct action_data *data,
> +				 unsigned int track_var_idx, u64 var_val)
> +{
> +	bool ret = false;
> +	u64 track_val;
> +
> +	track_val = tracing_map_read_var(elt, track_var_idx);
> +
> +	if (data->track_data.check_val(track_val, var_val)) {
> +		tracing_map_set_var(elt, track_var_idx, var_val);
> +		ret = true;
> +	}
> +
> +	return ret;
> +}
> +
> +static bool update_track_val(struct hist_trigger_data *hist_data,
> +			     struct tracing_map_elt *elt,
> +			     struct action_data *data, u64 *var_ref_vals)
> +{
> +	unsigned int track_var_idx = data->track_data.track_var->var.idx;
> +	unsigned int track_var_ref_idx = data->track_data.var_ref_idx;
> +	u64 var_val;
> +
> +	var_val = var_ref_vals[track_var_ref_idx];
> +
> +	return data->track_data.save_val(hist_data, elt, data,
> +					 track_var_idx, var_val);
> +}

It's bit confusing for me update_track_val() calls ->save_val() and it
in turn calls ->check_val().  Why not having wrappers corresponding to
their callback name?  - get_track_val(), check_track_val() and
save_trace_val()...


> +
> +static void track_data_print(struct seq_file *m,
> +			     struct hist_trigger_data *hist_data,
> +			     struct tracing_map_elt *elt,
> +			     struct action_data *data)
> +{
> +	u64 track_val = data->track_data.get_val(hist_data, elt, data);
> +	unsigned int i, save_var_idx;
> +
> +	if (data->handler == HANDLER_ONMAX)
> +		seq_printf(m, "\n\tmax: %10llu", track_val);
>  
>  	for (i = 0; i < hist_data->n_save_vars; i++) {
>  		struct hist_field *save_val = hist_data->save_vars[i]->val;
> @@ -3300,25 +3367,13 @@ static void onmax_print(struct seq_file *m,
>  	}
>  }
>  
> -static void onmax_save(struct hist_trigger_data *hist_data,
> -		       struct tracing_map_elt *elt, void *rec,
> -		       struct ring_buffer_event *rbe,
> -		       struct action_data *data, u64 *var_ref_vals)
> +static void ontrack_save(struct hist_trigger_data *hist_data,
> +			 struct tracing_map_elt *elt, void *rec,
> +			 struct ring_buffer_event *rbe,
> +			 struct action_data *data, u64 *var_ref_vals)
>  {
> -	unsigned int max_idx = data->onmax.max_var->var.idx;
> -	unsigned int max_var_ref_idx = data->onmax.max_var_ref_idx;
> -
> -	u64 var_val, max_val;
> -
> -	var_val = var_ref_vals[max_var_ref_idx];
> -	max_val = tracing_map_read_var(elt, max_idx);
> -
> -	if (var_val <= max_val)
> -		return;
> -
> -	tracing_map_set_var(elt, max_idx, var_val);
> -
> -	update_max_vars(hist_data, elt, rbe, rec);
> +	if (update_track_val(hist_data, elt, data, var_ref_vals))
> +		update_save_vars(hist_data, elt, rbe, rec);

... and then it should look like:

	if (check_track_val()) {
		save_track_val();
		update_save_vars();
	}

I also think update_save_vars() also needs to be renamed something
like save_track_vars() or save_trace_data().

Thanks,
Namhyung


>  }
