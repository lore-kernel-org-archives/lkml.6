Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD3AECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3A52081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3A52081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbeKDXWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:22:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbeKDXWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:22:00 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63E492085A;
        Sun,  4 Nov 2018 14:06:51 +0000 (UTC)
Date:   Sun, 4 Nov 2018 09:06:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/fgraph: remove unnecessary unlikely()
Message-ID: <20181104090649.7c206915@vmware.local.home>
In-Reply-To: <20181104023537.2626-1-tiny.windzz@gmail.com>
References: <20181104023537.2626-1-tiny.windzz@gmail.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  3 Nov 2018 22:35:37 -0400
Yangtao Li <tiny.windzz@gmail.com> wrote:

> WARN_ON() already contains an unlikely(), so it's not necessary to use
> unlikely.

NACK... see below.

> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  kernel/trace/trace_functions_graph.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
> index 169b3c44ee97..f8c2a08e4985 100644
> --- a/kernel/trace/trace_functions_graph.c
> +++ b/kernel/trace/trace_functions_graph.c
> @@ -201,9 +201,8 @@ ftrace_pop_return_trace(struct ftrace_graph_ret *trace, unsigned long *ret,
>  	if (index < 0)
>  		index += FTRACE_NOTRACE_DEPTH;
>  
> -	if (unlikely(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {
> +	if (WARN_ON(index < 0 || index >= FTRACE_RETFUNC_DEPTH)) {

When function graph is enabled, the printk from the warn on will likely
be traced as well and trigger the same WARN_ON, which will again cause
a recursion loop and crash and reboot the box with no output at all.

>  		ftrace_graph_stop();

Notice that I call ftrace_graph_stop() *before* the WARN_ON(). This
disables the ftrace graph tracer and prevents the recursion loop from
happening.

There's a reason that the WARN_ON() is placed where it is.

But thanks for the report, it shows that I need to add a comment here
so that someone else doesn't send a similar patch in the future.

-- Steve


> -		WARN_ON(1);
>  		/* Might as well panic, otherwise we have no where to go */
>  		*ret = (unsigned long)panic;
>  		return;
> @@ -274,9 +273,8 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
>  	 */
>  	ftrace_graph_return(&trace);
>  
> -	if (unlikely(!ret)) {
> +	if (WARN_ON(!ret)) {
>  		ftrace_graph_stop();
> -		WARN_ON(1);
>  		/* Might as well panic. What else to do? */
>  		ret = (unsigned long)panic;
>  	}

