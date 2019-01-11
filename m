Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB06C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43820872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 04:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547181173;
	bh=H+/w2VplSzFGk+rcZ7Z3AWc2rfKSwAgI6Qp5fsRX67M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ss2AiDaoq0wvG6xUydr1Y7b1BKcKnpU/6x7ZjiTg1LnNGh5wR6qlK4NbrLE7xvCCD
	 uCQ/8KbVVyfjulMBFemp/5irxRmkXKII9p69Xw6NK4grUHEUGk56aCI1i7YecqhIUz
	 n8xG8BG4wh2fy/7sEy8xhPNQlZU9+OdOK8eSMPls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbfAKEcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 23:32:53 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:58536 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbfAKEcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 23:32:52 -0500
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 11 Jan 2019 13:32:50 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.125 with ESMTP; 11 Jan 2019 13:32:48 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Fri, 11 Jan 2019 13:32:46 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v11 03/15] tracing: Split up onmatch action data
Message-ID: <20190111043246.GB625@sejong>
References: <cover.1547062835.git.tom.zanussi@linux.intel.com>
 <37949f9c6e89144e6ed553e75617ff6528b9b7eb.1547062835.git.tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37949f9c6e89144e6ed553e75617ff6528b9b7eb.1547062835.git.tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, Jan 09, 2019 at 01:49:10PM -0600, Tom Zanussi wrote:
> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Currently, the onmatch action data binds the onmatch action to data
> related to synthetic event generation.  Since we want to allow the
> onmatch handler to potentially invoke a different action, and because
> we expect other handlers to generate synthetic events, we need to
> separate the data related to these two functions.
> 
> Also rename the onmatch data to something more descriptive, and create
> and use common action data destroy function.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
[SNIP]
>  
> -static void onmax_destroy(struct action_data *data)
> +static void action_data_destroy(struct action_data *data)
>  {
>  	unsigned int i;
>  
> -	destroy_hist_field(data->onmax.max_var, 0);
> -	destroy_hist_field(data->onmax.var, 0);
> +	lockdep_assert_held(&event_mutex);
>  
> -	kfree(data->onmax.var_str);
>  	kfree(data->action_name);
>  
>  	for (i = 0; i < data->n_params; i++)
>  		kfree(data->params[i]);
>  
> +	if (data->synth_event)
> +		data->synth_event->ref--;
> +

I was wondering about the missing synth_event_mutex used to guard the
refcount.  Then I noticed that I totally missed Masami's dynamic event
work which removed it.  Nice job..

Thanks,
Namhyung


>  	kfree(data);
>  }
>  
> +static void onmax_destroy(struct action_data *data)
> +{
> +	destroy_hist_field(data->onmax.max_var, 0);
> +	destroy_hist_field(data->onmax.var, 0);
> +
> +	kfree(data->onmax.var_str);
> +
> +	action_data_destroy(data);
> +}
