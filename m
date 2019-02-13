Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3B7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E082222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391550AbfBMOED convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:04:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfBMOED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:04:03 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7391B222B2;
        Wed, 13 Feb 2019 14:04:02 +0000 (UTC)
Date:   Wed, 13 Feb 2019 09:04:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] tracing/probes: Mark expected switch fall-through
Message-ID: <20190213090401.5b501e15@gandalf.local.home>
In-Reply-To: <20190212211040.GA24476@embeddedor>
References: <20190212211040.GA24476@embeddedor>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 15:10:40 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> kernel/trace/trace_probe.c: In function ‘parse_probe_arg’:
> kernel/trace/trace_probe.c:302:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    arg++; /* Skip '+', because kstrtol() rejects it. */
>    ~~~^~
> kernel/trace/trace_probe.c:303:2: note: here
>   case '-':
>   ^~~~

I also already applied this patch (still need to run through tests)

  http://lkml.kernel.org/r/20190114203039.16535-1-malat@debian.org

-- Steve

> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/trace/trace_probe.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 9962cb5da8ac..89da34b326e3 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -300,6 +300,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
>  
>  	case '+':	/* deref memory */
>  		arg++;	/* Skip '+', because kstrtol() rejects it. */
> +		/* fall through */
>  	case '-':
>  		tmp = strchr(arg, '(');
>  		if (!tmp)

