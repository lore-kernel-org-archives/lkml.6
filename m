Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A81C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5571A21B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405681AbfBNTH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393773AbfBNTH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:07:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFE921B24;
        Thu, 14 Feb 2019 19:07:26 +0000 (UTC)
Date:   Thu, 14 Feb 2019 14:07:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        b.zolnierkie@samsung.com, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org,
        mingo@redhat.com
Subject: Re: [PATCH 2/2] drivers: devfreq: add tracing for scheduling work
Message-ID: <20190214140725.307d493c@gandalf.local.home>
In-Reply-To: <1550170676-14173-3-git-send-email-l.luba@partner.samsung.com>
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185811eucas1p1e2f44d59495296fbfed42f28a2c897a0@eucas1p1.samsung.com>
        <1550170676-14173-3-git-send-email-l.luba@partner.samsung.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2019 19:57:56 +0100
Lukasz Luba <l.luba@partner.samsung.com> wrote:

> This patch add basic tracing of the devfreq workqueue and delayed work.
> It aims to capture changes of the polling intervals and device state.
> 
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de7..c9714fd 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -29,6 +29,9 @@
>  #include <linux/of.h>
>  #include "governor.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/devfreq.h>
> +
>  static struct class *devfreq_class;
>  
>  /*
> @@ -394,6 +397,11 @@ static void devfreq_monitor(struct work_struct *work)
>  	queue_delayed_work(devfreq_wq, &devfreq->work,
>  				msecs_to_jiffies(devfreq->profile->polling_ms));
>  	mutex_unlock(&devfreq->lock);
> +
> +	trace_devfreq_monitor(dev_name(&devfreq->dev), devfreq->previous_freq,
> +			      devfreq->profile->polling_ms,
> +			      devfreq->last_status.busy_time,
> +			      devfreq->last_status.total_time);

I would pass just devfreq into the tracepoint (it will be less work by
gcc in this code path), and do all this work in the TP__fast_assign()

The string can still handle this with:

		__string(dev_name, dev_name(&devfreq->dev))

And assigned:

		__assign_str(dev_name, dev_name(&devfreq->dev))

But the rest of fast assign should be:

	TP_fast_assign(
		__entry->freq = devfreq->previous_freq;
		__entry->busy_time = devfreq->last_status.busy_time;
		__entry->total_time = devfreq->last_status.total_time;
		__entry->polling_ms = devfreq->profile->polling_ms;
		__assign_str(dev_name, dev_name(&deqfreq->dev));
	}

-- Steve

>  }
>  
>  /**

