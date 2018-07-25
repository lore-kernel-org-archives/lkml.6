Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7943C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EDB20891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbCINOwA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EDB20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbeGYQx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbeGYQx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:53:28 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6094120843;
        Wed, 25 Jul 2018 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532533276;
        bh=JiPSfkP6Jtly0n5W6fhKC3t99jzsPn/Gom8RJJgwWdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RbCINOwAm9Wul6TXlB37iuWFF4LqrdAOEwyeXFSI9Uy9912xYCR7/XTrZj5l5JURW
         aHrBgIBDDqSfq48vLNFOH0WKUR+/zBqVkv7uMVOsR4dGHg6RcwpiZ/3nfmB3R1ZUlI
         Rjg9/9jwLR2T4HtS1qColjTwya9QvAEmNZU6/Zss=
Date:   Thu, 26 Jul 2018 00:41:13 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v2] tracing/kprobes: Fix trace_probe flags on
 enable_trace_kprobe() failure
Message-Id: <20180726004113.d578f6e6a2fa59adf1efb4ea@kernel.org>
In-Reply-To: <20180725142038.4765-1-asavkov@redhat.com>
References: <20180725142038.4765-1-asavkov@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
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

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Artem Savkov <asavkov@redhat.com>
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
> -- 
> 2.13.6
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
