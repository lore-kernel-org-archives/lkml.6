Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8C6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B3120820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B3120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501898AbeKWNcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 08:32:21 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:41948 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2439570AbeKWNcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 08:32:20 -0500
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 23 Nov 2018 11:50:00 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 23 Nov 2018 11:50:00 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 23 Nov 2018 11:50:00 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v7 05/16] tracing: Generalize hist trigger onmax and save
 action
Message-ID: <20181123025000.GC25952@sejong>
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

Hi Tom,

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

I have a question.  It's confusing for me there are many indexes for a
variable (ref).  The hist_field already has var.idx, var_idx and
var_ref_idx in it.  But you also added an external var_ref_idx along
with the var_ref.  Also I see another var_ref_idx in the action data.
Is all that really needed?  Could you please add some comment then?

Thanks,
Namhyung


> +
> +			struct hist_field	*track_var;
> +
> +			check_track_val_fn_t	check_val;
> +			save_track_val_fn_t	save_val;
> +			get_track_val_fn_t	get_val;
> +		} track_data;
>  	};
>  };
