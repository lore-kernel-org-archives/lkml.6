Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702CEC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6AA20C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ6VKJyz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6AA20C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392463AbeHPTiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:38:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392441AbeHPTiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:38:24 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F0220C0D;
        Thu, 16 Aug 2018 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437529;
        bh=VfygmLqZlAAp0Tc95k3Cs4qdd1+vX3Yksj1AydcitJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hJ6VKJyz6AyyfBQMFKo5Z9y/LPxjt8mCkw+ERo6+FaJ3Gcemmlbe5YWvyGcYeBjE5
         ULys7wWdkiwv9si/Hj6PWMuHVFABbDjjvwsI4Io+seL9jzBhbErlr5KDQbUAWkAJyF
         s23hxhpXDCNozKAEAaGUGy9rvnY42dnjeSPRRZXs=
Date:   Fri, 17 Aug 2018 01:38:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] tracing/blktrace: Fix to allow setting same value
Message-Id: <20180817013847.85ff26224bfd48d0fca1fd3f@kernel.org>
In-Reply-To: <20180816103802.08678002@gandalf.local.home>
References: <153441301698.6024.1680500212551396320.stgit@devbox>
        <153441307534.6024.2684721209411781531.stgit@devbox>
        <20180816103802.08678002@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 10:38:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 16 Aug 2018 18:51:15 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Current trace-enable attribute in sysfs returns an error
> > if user writes the same setting value as current one,
> > e.g.
> > 
> >   # cat /sys/block/sda/trace/enable
> >   0
> >   # echo 0 > /sys/block/sda/trace/enable
> >   bash: echo: write error: Invalid argument
> >   # echo 1 > /sys/block/sda/trace/enable
> >   # echo 1 > /sys/block/sda/trace/enable
> >   bash: echo: write error: Device or resource busy
> > 
> > But this is not a preferred behavior, it should ignore
> > if new setting is same as current one. This fixes the
> > problem as below.
> > 
> >   # cat /sys/block/sda/trace/enable
> >   0
> >   # echo 0 > /sys/block/sda/trace/enable
> >   # echo 1 > /sys/block/sda/trace/enable
> >   # echo 1 > /sys/block/sda/trace/enable
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: linux-block@vger.kernel.org
> > ---
> >  kernel/trace/blktrace.c |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> > index 987d9a9ae283..e67db1e8a000 100644
> > --- a/kernel/trace/blktrace.c
> > +++ b/kernel/trace/blktrace.c
> > @@ -1602,11 +1602,11 @@ static int blk_trace_remove_queue(struct request_queue *q)
> >  	struct blk_trace *bt;
> >  
> >  	bt = xchg(&q->blk_trace, NULL);
> > -	if (bt == NULL)
> > -		return -EINVAL;
> > +	if (bt != NULL) {
> > +		put_probe_ref();
> > +		blk_trace_free(bt);
> > +	}
> >  
> > -	put_probe_ref();
> > -	blk_trace_free(bt);
> >  	return 0;
> >  }
> >  
> > @@ -1619,6 +1619,9 @@ static int blk_trace_setup_queue(struct request_queue *q,
> >  	struct blk_trace *bt = NULL;
> >  	int ret = -ENOMEM;
> >  
> > +	if (q->blk_trace)
> > +		return 0;
> > +
> >  	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
> >  	if (!bt)
> >  		return -ENOMEM;
> 
> Hmm, why not just do this? Does this fix it too?

Ah, yes, but we need to clear "ret" in that case.

Thanks!

> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 987d9a9ae283..10b2b9c5fd25 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -1841,6 +1841,8 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
>  	mutex_lock(&q->blk_trace_mutex);
>  
>  	if (attr == &dev_attr_enable) {
> +		if (!!value == !!q->blk_trace)
> +			goto out_unlock_bdev;
>  		if (value)
>  			ret = blk_trace_setup_queue(q, bdev);
>  		else
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
