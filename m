Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F70CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02290208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02290208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933344AbeGJNEX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933307AbeGJNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:04:21 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 380AE20877;
        Tue, 10 Jul 2018 13:04:19 +0000 (UTC)
Date:   Tue, 10 Jul 2018 09:04:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20180710090417.21423b1b@gandalf.local.home>
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

OK, I finished testing and I'm all ready to push, but then I noticed
that Masami wasn't Cc'd. I like to get his ack before pushing to Linus.

-- Steve


> 
> Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
>  	free_trace_kprobe(tk);
>  }
>  #endif /* CONFIG_PERF_EVENTS */

