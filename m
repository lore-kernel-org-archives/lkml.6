Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD1CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D55520875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D55520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933458AbeGIQoU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932755AbeGIQoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:44:19 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF7C320852;
        Mon,  9 Jul 2018 16:44:17 +0000 (UTC)
Date:   Mon, 9 Jul 2018 12:44:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Josef Bacik <jbacik@fb.com>,
        daniel@iogearbox.net, davem@davemloft.net,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing/kprobe: Release kprobe print_fmt properly
Message-ID: <20180709124416.2527e40e@gandalf.local.home>
In-Reply-To: <20180709141906.2390-1-jolsa@kernel.org>
References: <20180709141906.2390-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 16:19:06 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> We don't release tk->tp.call.print_fmt when destroying
> local uprobe. Also there's missing print_fmt kfree in
> create_local_trace_kprobe error path.
> 
> Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Thanks for the patch, I'm applying it now (and testing it).

> ---
>  kernel/trace/trace_kprobe.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index daa81571b22a..21f718472942 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -1480,8 +1480,10 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
>  	}
>  
>  	ret = __register_trace_kprobe(tk);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(tk->tp.call.print_fmt);
>  		goto error;
> +	}
>  
>  	return &tk->tp.call;
>  error:
> @@ -1501,6 +1503,8 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
>  	}
>  
>  	__unregister_trace_kprobe(tk);
> +
> +	kfree(tk->tp.call.print_fmt);

Bah! The naming convention of "set_print_fmt()" is horrible, and leads
to these kinds of bugs. I'll make a patch (not for stable though) that
makes it a bit more obvious to what is happening.

-- Steve


>  	free_trace_kprobe(tk);
>  }
>  #endif /* CONFIG_PERF_EVENTS */

