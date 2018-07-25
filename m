Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E56DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA7920843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWN55wjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA7920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731627AbeGZAFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:05:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731344AbeGZAFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:05:22 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5686F20685;
        Wed, 25 Jul 2018 22:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532559092;
        bh=hmvR2GOVuDAGaZcNTWqiPO040sMpVAPqxNsHypRYzvQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YWN55wjIL9KAzSqBR688zrPWpDEJt1oFKcecWv4rtZxiCD5I3E8hu13F+JdTeC9po
         GCUdqWwFkgCybTJOONSl0rUgOguYvmNzlD2x5gNMdXaw2aLiRatPOT9bUfzZ21NpTf
         YTpeJbX1qt09qY2qf3ImXdbz69ZWa/LrZzKbOIGQ=
Date:   Thu, 26 Jul 2018 07:51:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tracing: Fix double free of event_trigger_data
Message-Id: <20180726075129.52a71d05a05249a723374002@kernel.org>
In-Reply-To: <20180725155321.3e677387@gandalf.local.home>
References: <20180725085740.5e7efaa1@gandalf.local.home>
        <20180726004349.e71303133ff8e095a1a1499e@kernel.org>
        <20180725124008.7008e586@gandalf.local.home>
        <20180725152904.11edde2b@gandalf.local.home>
        <20180725155321.3e677387@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 15:53:21 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 25 Jul 2018 15:29:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Nope, this doesn't work. It's a little more complex than the other one.
> > I'll just leave it, and fix the reg code for 4.19.
> 
> I take this back. Looks like it just needs to be handled slightly
> differently. Thoughts?

Ah, I see, the filter should be cleared :)
OK, this should work.

Reivewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> -- Steve
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d18ec0e58be2..5dea177cef53 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1420,6 +1420,9 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
>  		goto out;
>  	}
>  
> +	/* Up the trigger_data count to make sure nothing frees it on failure */
> +	event_trigger_init(trigger_ops, trigger_data);
> +
>  	if (trigger) {
>  		number = strsep(&trigger, ":");
>  
> @@ -1470,6 +1473,7 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
>  		goto out_disable;
>  	/* Just return zero, not the number of enabled functions */
>  	ret = 0;
> +	event_trigger_free(trigger_ops, trigger_data);
>   out:
>  	return ret;
>  
> @@ -1480,7 +1484,7 @@ int event_enable_trigger_func(struct event_command *cmd_ops,
>   out_free:
>  	if (cmd_ops->set_filter)
>  		cmd_ops->set_filter(NULL, trigger_data, NULL);
> -	kfree(trigger_data);
> +	event_trigger_free(trigger_ops, trigger_data);
>  	kfree(enable_data);
>  	goto out;
>  }


-- 
Masami Hiramatsu <mhiramat@kernel.org>
