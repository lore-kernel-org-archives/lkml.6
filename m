Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71D6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9150F218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeLSTkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:40:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbeLSTkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:40:51 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 331A620874;
        Wed, 19 Dec 2018 19:40:49 +0000 (UTC)
Date:   Wed, 19 Dec 2018 14:40:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/7] tracing: Change strlen to sizeof for hist trigger
 static strings
Message-ID: <20181219144047.49fabfa6@gandalf.local.home>
In-Reply-To: <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
        <e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 14:33:21 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> There's no need to use strlen() for static strings when the length is
> already known, so update trace_events_hist.c with sizeof() for those
> cases.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index d29bf8a8e1dd..25d06b3ae1f6 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -507,7 +507,7 @@ static int synth_field_string_size(char *type)
>  	start = strstr(type, "char[");
>  	if (start == NULL)
>  		return -EINVAL;
> -	start += strlen("char[");
> +	start += sizeof("char[") - 1;
>  
>  	end = strchr(type, ']');
>  	if (!end || end < start)
> @@ -1843,8 +1843,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
>  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
>  		return ret;
>  
> -	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
> -	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
> +	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) ||
> +	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
>  		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->action_str[attrs->n_actions]) {
>  			ret = -ENOMEM;
> @@ -1861,34 +1861,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
>  {
>  	int ret = 0;
>  
> -	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
> -	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
> +	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
> +	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
>  		attrs->keys_str = kstrdup(str, GFP_KERNEL);

I'll apply this as is, but since there's a lot of these, I wonder if we
should make a marcro for this:

#define strcmp_const(str, str_const) strncmp(str, str_const, sizeof(str_const) - 1)

?

This would help prevent bugs due to typos and bad cut and paste.

-- Steve



>  		if (!attrs->keys_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
> -		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
> -		 (strncmp(str, "values=", strlen("values=")) == 0)) {
> +	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0) ||
> +		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0) ||
> +		 (strncmp(str, "values=", sizeof("values=") - 1) == 0)) {
>  		attrs->vals_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->vals_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
> +	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) == 0) {
>  		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->sort_key_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
> +	} else if (strncmp(str, "name=", sizeof("name=") - 1) == 0) {
>  		attrs->name = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->name) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
> +	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) == 0) {
>  		strsep(&str, "=");
>  		if (!str) {
>  			ret = -EINVAL;
> @@ -1901,7 +1901,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
> +	} else if (strncmp(str, "size=", sizeof("size=") - 1) == 0) {
>  		int map_bits = parse_map_size(str);
>  
>  		if (map_bits < 0) {
> @@ -3497,7 +3497,7 @@ static struct action_data *onmax_parse(char *str)
>  	if (!onmax_fn_name || !str)
>  		goto free;
>  
> -	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
> +	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) == 0) {
>  		char *params = strsep(&str, ")");
>  
>  		if (!params) {
> @@ -4302,8 +4302,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
>  		str = hist_data->attrs->action_str[i];
>  
> -		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
> -			char *action_str = str + strlen("onmatch(");
> +		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) {
> +			char *action_str = str + sizeof("onmatch(") - 1;
>  
>  			data = onmatch_parse(tr, action_str);
>  			if (IS_ERR(data)) {
> @@ -4311,8 +4311,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  				break;
>  			}
>  			data->fn = action_trace;
> -		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
> -			char *action_str = str + strlen("onmax(");
> +		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0) {
> +			char *action_str = str + sizeof("onmax(") - 1;
>  
>  			data = onmax_parse(action_str);
>  			if (IS_ERR(data)) {
> @@ -5548,9 +5548,9 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
>  			p++;
>  			continue;
>  		}
> -		if (p >= param + strlen(param) - strlen("if") - 1)
> +		if (p >= param + strlen(param) - (sizeof("if") - 1) - 1)
>  			return -EINVAL;
> -		if (*(p + strlen("if")) != ' ' && *(p + strlen("if")) != '\t') {
> +		if (*(p + sizeof("if") - 1) != ' ' && *(p + sizeof("if") - 1) != '\t') {
>  			p++;
>  			continue;
>  		}

