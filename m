Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE624C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A896208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fA8dghEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A896208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJEWqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:46:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39376 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeJEWqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:46:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id h4-v6so12038778edi.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQcdGjN1cBkzzd5w2pT/hHsSuiSSYr6PnKIR7vaL2W4=;
        b=fA8dghEPwAYEfz5/Ex5x5UOuH0CPafKgMdI9HoDi/n3CMrvX3cULMKQKh7cR+Lyh24
         GoNUBR3LdMrMj/iYzZj4kNVIH+i/6IWwOPSwIbxJlp2DSd207m5qT1v7AkM2jsRDFKpz
         USGzBVQ3Tz3sbKSq/0lmpitGIM/ea/1AjPpLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQcdGjN1cBkzzd5w2pT/hHsSuiSSYr6PnKIR7vaL2W4=;
        b=MNnl0p2Hhjzbrf6RRnULeVLBxsYLeEh+QnYrr1nQquzwUeAtsAuv4ezehCq0HhZXd1
         n6ApxCD2+aV54M+xUj1Hfksl9MdQvTXFExUomSB0kojasQUPv5mnnTxA8EHNG96OZAS8
         MiIOYTlSyOB9v5mdjWGF0XAYb7zYMc+TMvuIkOTfdzR6d26gC9q+CEJYuFhc2qCPa/tn
         Lh+fSeGe6bU0OG2i0zbpZC+65JVjl6VC+8907gCjRC8GSTn48ZxKw/hhkZwF37N+4a4t
         ee1E/SdSQzrNxVgGvN4YuB1CrOaww+/LwRiKfzRh/wCW+yFa7QSJmOjgjJwBOH7UJoRk
         ao/Q==
X-Gm-Message-State: ABuFfojGCkfkhdtZ2KCw6ibJTO5yiFtPHULbeAQmBoSYkMjmkI/lecS2
        rG0a8Wy104dUjSqLg5zuEihykg==
X-Google-Smtp-Source: ACcGV62j3ilUWId/memQD0RmGKtwCVstdd+Hl7/IdxvMZguw7v/CAXtaQXYpM0zIffFQaJvLw6XsDg==
X-Received: by 2002:aa7:c247:: with SMTP id y7-v6mr1474514edo.205.1538754403912;
        Fri, 05 Oct 2018 08:46:43 -0700 (PDT)
Received: from andrea (15.152.230.94.awnet.cz. [94.230.152.15])
        by smtp.gmail.com with ESMTPSA id h3-v6sm2686923ede.42.2018.10.05.08.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 08:46:43 -0700 (PDT)
Date:   Fri, 5 Oct 2018 17:46:32 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peng Hao <peng.hao2@zte.com.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com
Subject: Re: [PATCH v3] sched/rt : return accurate release rq lock info
Message-ID: <20181005154632.GA18077@andrea>
References: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538778131-44406-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On Sat, Oct 06, 2018 at 06:22:11AM +0800, Peng Hao wrote:
> find_lock_lowest_rq may or not releease rq lock when return
> lowest_rq=NULL, but it is fuzzy.
> If not releasing rq lock, it is unnecessary to re-call
> pick_next_pushable_task.

IIRC, deadline.c uses a similar pattern (c.f., find_lock_later_rq() and
pick_next_pushable_dl_task()): should it be considered for this change?

  Andrea


> When CONFIG_PREEMPT=n, not releasing rq lock and return
> lowest_rq=null frequently happens in a simple test case:
> Four different rt priority tasks run on limited two cpus.
> Thanks for Steven Rostedt's advice.
> 
> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  kernel/sched/rt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 2e2955a..be0fc43 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1754,7 +1754,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  				     !task_on_rq_queued(task))) {
>  
>  				double_unlock_balance(rq, lowest_rq);
> -				lowest_rq = NULL;
> +				lowest_rq = RETRY_TASK;
>  				break;
>  			}
>  		}
> @@ -1830,7 +1830,9 @@ static int push_rt_task(struct rq *rq)
>  
>  	/* find_lock_lowest_rq locks the rq if found */
>  	lowest_rq = find_lock_lowest_rq(next_task, rq);
> -	if (!lowest_rq) {
> +	if (!lowest_rq)
> +		goto out;
> +	if (lowest_rq == RETRY_TASK) {
>  		struct task_struct *task;
>  		/*
>  		 * find_lock_lowest_rq releases rq->lock
> -- 
> 1.8.3.1
> 
