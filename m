Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB01C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C8420840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 09:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52C8420840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeKIS6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 13:58:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:46119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeKIS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 13:58:10 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gL2vq-0007nU-VZ; Fri, 09 Nov 2018 10:18:27 +0100
Date:   Fri, 9 Nov 2018 10:18:25 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Cyrill Gorcunov <gorcunov@gmail.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrey Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] posix-timers: Use array safe helper when fetching
 notification symbolic name
In-Reply-To: <20181101182722.GA2869@uranus.lan>
Message-ID: <alpine.DEB.2.21.1811091010440.1640@nanos.tec.linutronix.de>
References: <20181101182722.GA2869@uranus.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018, Cyrill Gorcunov wrote:

> When showing timer's notify symbolic name make sure we never fetch a value
> sitting outside of the names array. Though the former issue displaying
> timer->it_sigev_notify has been fixed by Thomas in commit cef31d9af9082434,
> better to make sure we won't hit it again in furher modifications.
> 
> Cc: Andrey Vagin <avagin@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
> ---
>  fs/proc/base.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> Index: linux-ml.git/fs/proc/base.c
> ===================================================================
> --- linux-ml.git.orig/fs/proc/base.c
> +++ linux-ml.git/fs/proc/base.c
> @@ -2287,7 +2287,7 @@ static int show_timer(struct seq_file *m
>  {
>  	struct k_itimer *timer;
>  	struct timers_private *tp = m->private;
> -	int notify;
> +	int notify, nidx;
>  	static const char * const nstr[] = {
>  		[SIGEV_SIGNAL] = "signal",
>  		[SIGEV_NONE] = "none",
> @@ -2296,13 +2296,13 @@ static int show_timer(struct seq_file *m
>  
>  	timer = list_entry((struct list_head *)v, struct k_itimer, list);
>  	notify = timer->it_sigev_notify;
> +	nidx = array_index_nospec(notify & ~SIGEV_THREAD_ID, ARRAY_SIZE(nstr));

I completely understand your intention, but this is misleading. The above
is really not a speculation gadget.

I'd rather do an open coded check here and fail the thing instead of
printing wrong information:

    	   nidx = timer->it_sigev_notify & ~SIGEV_THREAD_ID;
	   if (nidx >= ARRAY_SIZE(nstr))
	   	return -EINVAL;

Thanks,

	tglx
