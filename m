Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0868C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6D220866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 21:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390307AbfAOVM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 16:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:59508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732985AbfAOVM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 16:12:58 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84D1020859;
        Tue, 15 Jan 2019 21:12:57 +0000 (UTC)
Date:   Tue, 15 Jan 2019 16:12:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Replace kzalloc with kcalloc
Message-ID: <20190115161255.6afa9dbd@gandalf.local.home>
In-Reply-To: <20190115043408.GA23456@embeddedor>
References: <20190115043408.GA23456@embeddedor>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 22:34:08 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Replace kzalloc() function with its 2-factor argument form, kcalloc().
> 
> This patch replaces cases of:
> 
> 	kzalloc(a * b, gfp)
> 
> with:
> 	kcalloc(a * b, gfp)

I think you meant:

	kcalloc(a, b, gfp)

-- Steve

> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/trace/trace_probe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9962cb5da8ac..57f0cbaf9c58 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -429,7 +429,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  			 parg->count);
>  	}
>  
> -	code = tmp = kzalloc(sizeof(*code) * FETCH_INSN_MAX, GFP_KERNEL);
> +	code = tmp = kcalloc(FETCH_INSN_MAX, sizeof(*code), GFP_KERNEL);
>  	if (!code)
>  		return -ENOMEM;
>  	code[FETCH_INSN_MAX - 1].op = FETCH_OP_END;
> @@ -501,7 +501,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
>  	code->op = FETCH_OP_END;
>  
>  	/* Shrink down the code buffer */
> -	parg->code = kzalloc(sizeof(*code) * (code - tmp + 1), GFP_KERNEL);
> +	parg->code = kcalloc(code - tmp + 1, sizeof(*code), GFP_KERNEL);
>  	if (!parg->code)
>  		ret = -ENOMEM;
>  	else

