Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BAFC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD60220893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD60220893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbeGYUmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbeGYUmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:42:11 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA988204EC;
        Wed, 25 Jul 2018 19:29:05 +0000 (UTC)
Date:   Wed, 25 Jul 2018 15:29:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Fix double free of event_trigger_data
Message-ID: <20180725152904.11edde2b@gandalf.local.home>
In-Reply-To: <20180725124008.7008e586@gandalf.local.home>
References: <20180725085740.5e7efaa1@gandalf.local.home>
        <20180726004349.e71303133ff8e095a1a1499e@kernel.org>
        <20180725124008.7008e586@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 12:40:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, looks to me that event_enable_trigger_func() suffers the same
> issue. Perhaps we should add this patch too:
> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d18ec0e58be2..2681d917f896 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1457,6 +1457,10 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
>  	ret = trace_event_enable_disable(event_enable_file, 1, 1);
>  	if (ret < 0)
>  		goto out_put;
> +
> +	/* Up the trigger_data count to make sure reg doesn't free it on failure */
> +	event_trigger_init(trigger_ops, trigger_data);
> +
>  	ret = cmd_ops->reg(glob, trigger_ops, trigger_data, file);
>  	/*
>  	 * The above returns on success the # of functions enabled,
> @@ -1464,12 +1468,13 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
>  	 * Consider no functions a failure too.
>  	 */
>  	if (!ret) {
> +		cmd_ops->unreg(glob, trigger_ops, trigger_data, file);
>  		ret = -ENOENT;
> -		goto out_disable;
> -	} else if (ret < 0)
> -		goto out_disable;
> -	/* Just return zero, not the number of enabled functions */
> -	ret = 0;
> +	} else if (ret > 0)
> +		ret = 0;
> +
> +	/* Down the counter of trigger_data or free it if not used anymore */
> +	event_trigger_free(trigger_ops, trigger_data);

Nope, this doesn't work. It's a little more complex than the other one.
I'll just leave it, and fix the reg code for 4.19.

-- Steve

>   out:
>  	return ret;
>  

