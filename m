Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3EFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42FD21568
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 00:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42FD21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbeHXEVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:21:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeHXEVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:21:02 -0400
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21A7921557;
        Fri, 24 Aug 2018 00:48:51 +0000 (UTC)
Date:   Thu, 23 Aug 2018 20:48:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix event filters and triggers to handle
 negative numbers
Message-ID: <20180823204849.3b4aede3@vmware.local.home>
In-Reply-To: <20180823102534.7642-1-ptikhomirov@virtuozzo.com>
References: <20180823102534.7642-1-ptikhomirov@virtuozzo.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 13:25:34 +0300
Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:

> Then tracing syscall exit event it is extremely useful to filter exit
> codes equal to some negative value, to react only to required errors.
> But negative numbers does not work:
> 
> [root@snorch sys_exit_read]# echo "ret == -1" > filter
> bash: echo: write error: Invalid argument
> [root@snorch sys_exit_read]# cat filter
> ret == -1
>         ^
> parse_error: Invalid value (did you forget quotes)?

Thanks for the patch. I'll apply it and then start testing it!

-- Steve

> 
> Similar thing happens when setting triggers.
> 
> These is a regression in v4.17 introduced by the commit mentioned below,
> testing without these commit shows no problem with negative numbers.
> 
> Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> ---
>  kernel/trace/trace_events_filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 84a65173b1e9..2ba449292561 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1299,7 +1299,7 @@ static int parse_pred(const char *str, void *data,
>  		/* go past the last quote */
>  		i++;
>  
> -	} else if (isdigit(str[i])) {
> +	} else if (isdigit(str[i]) || str[i] == '-') {
>  
>  		/* Make sure the field is not a string */
>  		if (is_string_field(field)) {
> @@ -1312,6 +1312,9 @@ static int parse_pred(const char *str, void *data,
>  			goto err_free;
>  		}
>  
> +		if (str[i] == '-')
> +			i++;
> +
>  		/* We allow 0xDEADBEEF */
>  		while (isalnum(str[i]))
>  			i++;

