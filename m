Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB00DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557D42070B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 16:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544805086;
	bh=hwYrNRXPIcBUJyIkx/U1+4eAu1AHE2oRyldUhk1Nd8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g20jUl6HDo4m+pmEwYFo85QSiketapLFqq5xkDSMSWU0zog9zvbrn3tiFc2chD0Fo
	 Usbtrse+2Ok7LnOHa9WDkPkLKUpEoDSlJvY0JJg4D5xX5u70Wa4GTOOQe/FAp6bhAB
	 CerdBkD9czI045PKfRMB8iiH9ACHZeSjEcm9rWfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbeLNQbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:31:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729672AbeLNQbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 11:31:23 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5AD206C2;
        Fri, 14 Dec 2018 16:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544805083;
        bh=hwYrNRXPIcBUJyIkx/U1+4eAu1AHE2oRyldUhk1Nd8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HUDtuYsja4VjbtYBKjropjemV8yXSCMR42BWmXwcsZz36iLNVkrdlXKGYgskGCokm
         jhcs7K6hQh+OB8onkpqB53LIn+0GuCzzfiq6a3nO3aLChUwFdWMMTfyKn4A5earCFW
         gdPcgDOvn30tBfk/YL67HlZ1ptHCtBvZuaZLQP7k=
Date:   Sat, 15 Dec 2018 01:31:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v8 20/22] tracing: Use hist trigger's var_ref array to
 destroy var_refs
Message-Id: <20181215013119.dc796fd4d2d21535adb4cf6c@kernel.org>
In-Reply-To: <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
        <4d6103ab7b4fdef81a82e2977b4005a26212a726.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 18:01:34 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Since every var ref for a trigger has an entry in the var_ref[] array,
> use that to destroy the var_refs, instead of piecemeal via the field
> expressions.
> 
> This allows us to avoid having to keep and treat differently separate
> lists for the action-related references, which future patches will
> remove.

I'm not so sure, but this seems a bugfix... if so, please move this at
the top of this series.

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index d07bb2d75e18..da4800c3f745 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -2312,6 +2312,15 @@ static int contains_operator(char *str)
>  	return field_op;
>  }
>  
> +static void __destroy_hist_field(struct hist_field *hist_field)
> +{
> +	kfree(hist_field->var.name);
> +	kfree(hist_field->name);
> +	kfree(hist_field->type);
> +
> +	kfree(hist_field);
> +}
> +
>  static void destroy_hist_field(struct hist_field *hist_field,
>  			       unsigned int level)
>  {
> @@ -2323,14 +2332,13 @@ static void destroy_hist_field(struct hist_field *hist_field,
>  	if (!hist_field)
>  		return;
>  
> +	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
> +		return; /* var refs will be destroyed separately */
> +
>  	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
>  		destroy_hist_field(hist_field->operands[i], level + 1);
>  
> -	kfree(hist_field->var.name);
> -	kfree(hist_field->name);
> -	kfree(hist_field->type);
> -
> -	kfree(hist_field);
> +	__destroy_hist_field(hist_field);
>  }
>  
>  static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
> @@ -2457,6 +2465,12 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
>  			hist_data->fields[i] = NULL;
>  		}
>  	}
> +
> +	for (i = 0; i < hist_data->n_var_refs; i++) {
> +		WARN_ON(!(hist_data->var_refs[i]->flags & HIST_FIELD_FL_VAR_REF));
> +		__destroy_hist_field(hist_data->var_refs[i]);
> +		hist_data->var_refs[i] = NULL;
> +	}
>  }
>  
>  static int init_var_ref(struct hist_field *ref_field,
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
