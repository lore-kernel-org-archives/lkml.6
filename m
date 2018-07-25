Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8EBC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC862088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC862088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeGYPmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbeGYPmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:42:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488CC20852;
        Wed, 25 Jul 2018 14:30:42 +0000 (UTC)
Date:   Wed, 25 Jul 2018 10:30:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Artem Savkov <asavkov@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2] tracing/kprobes: Fix trace_probe flags on
 enable_trace_kprobe() failure
Message-ID: <20180725103039.0b7498a6@gandalf.local.home>
In-Reply-To: <20180725142038.4765-1-asavkov@redhat.com>
References: <20180725142038.4765-1-asavkov@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 16:20:38 +0200
Artem Savkov <asavkov@redhat.com> wrote:

> If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
> it returns an error, but does not unset the tp flags it set previously.
> This results in a probe being considered enabled and failures like being
> unable to remove the probe through kprobe_events file since probes_open()
> expects every probe to be disabled.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Masami,

Can you ack this?

Thanks!

-- Steve

> ---
>  kernel/trace/trace_kprobe.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 21f718472942..27ace4513c43 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -400,11 +400,10 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
>  static int
>  enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
>  {
> +	struct event_file_link *link;
>  	int ret = 0;
>  
>  	if (file) {
> -		struct event_file_link *link;
> -
>  		link = kmalloc(sizeof(*link), GFP_KERNEL);
>  		if (!link) {
>  			ret = -ENOMEM;
> @@ -424,6 +423,16 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
>  		else
>  			ret = enable_kprobe(&tk->rp.kp);
>  	}
> +
> +	if (ret) {
> +		if (file) {
> +			list_del_rcu(&link->list);
> +			kfree(link);
> +			tk->tp.flags &= ~TP_FLAG_TRACE;
> +		} else {
> +			tk->tp.flags &= ~TP_FLAG_PROFILE;
> +		}
> +	}
>   out:
>  	return ret;
>  }

