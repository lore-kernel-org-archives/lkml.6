Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B58ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98B720661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D98B720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387862AbeGTQew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:34:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46994 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732550AbeGTQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:34:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id s11-v6so11716736wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=haBLWyBZry5ObqYBt9/PPG+UJJPcuQD3O7D6I3Cmceg=;
        b=fUWv49f/HU0etVAeWGUtJAQxH26m0/gvUEmv0ysQ3AweIdJiijhXGyLf37fv8SXIw5
         Z52w4nITZt6A+jQLwnsYfJn11bZ7wN/COoddOjwDZazKIQhb5M/WXUbzD3+RYC76m+qu
         y2hZRINbl/QKSAJ7dGqltP1fjFthlrfxwZ30iJnTFWKQEluyYyP99r2zBfcgtQtkRxA+
         szu3xbx4Cw+WiGcixvo5wbR0vUNwXRseaFm7W5MbMOstcqkr6hE8BT3skYzzQfk6GfWZ
         dVkd6VJTPWkYtP3PRkz5xhNGWBmyaEglUaclcKMBQY/9r5S3LV5UahCu9F51LllU60aI
         PAEw==
X-Gm-Message-State: AOUpUlE4xTj+Kvuh7xVXR4eLhh6sB0DZJf0FeK80oQq0/GFIhPgJvbMx
        NB2liSUHzst5XuqyrLkMZL7B9A==
X-Google-Smtp-Source: AAOMgpeZE/n4MzuYquTpZGs2JqbIWdJ754fVormWzO+ioW2QvMjWxfFSDuDqiJb4/4AmWEzU98/5Yg==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr1794981wrt.71.1532101558774;
        Fri, 20 Jul 2018 08:45:58 -0700 (PDT)
Received: from localhost.localdomain ([151.15.255.159])
        by smtp.gmail.com with ESMTPSA id i1-v6sm2180785wrq.69.2018.07.20.08.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:45:58 -0700 (PDT)
Date:   Fri, 20 Jul 2018 17:45:56 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH V3] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Message-ID: <20180720154556.GE3642@localhost.localdomain>
References: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
 <20180720124615.GM2476@hirez.programming.kicks-ass.net>
 <20180720124821.GB2512@hirez.programming.kicks-ass.net>
 <20180720125329.GD3642@localhost.localdomain>
 <183815b1-50dd-9027-31df-a18a604719e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <183815b1-50dd-9027-31df-a18a604719e8@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/18 17:36, Daniel Bristot de Oliveira wrote:
> On 07/20/2018 02:53 PM, Juri Lelli wrote:
> > On 20/07/18 14:48, Peter Zijlstra wrote:
> >> On Fri, Jul 20, 2018 at 02:46:15PM +0200, Peter Zijlstra wrote:
> >>> On Fri, Jul 20, 2018 at 11:16:30AM +0200, Daniel Bristot de Oliveira wrote:
> >>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> >>>> index fbfc3f1d368a..8b50eea4b607 100644
> >>>> --- a/kernel/sched/deadline.c
> >>>> +++ b/kernel/sched/deadline.c
> >>>> @@ -2090,8 +2090,14 @@ static int push_dl_task(struct rq *rq)
> >>>>  	sub_rq_bw(&next_task->dl, &rq->dl);
> >>>>  	set_task_cpu(next_task, later_rq->cpu);
> >>>>  	add_rq_bw(&next_task->dl, &later_rq->dl);
> >>>> +
> >>>> +	/*
> >>>> +	 * Update the later_rq clock here, because the clock is used
> >>>> +	 * by the cpufreq_update_util() inside __add_running_bw().
> >>>> +	 */
> >>>> +	update_rq_clock(later_rq);
> >>>>  	add_running_bw(&next_task->dl, &later_rq->dl);
> >>>> -	activate_task(later_rq, next_task, 0);
> >>>> +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> >>>>  	ret = 1;
> >>>>  
> >>>>  	resched_curr(later_rq);
> >>>
> >>> Why isn't push_rt_task() affected by the very same issue?
> >>
> >> Aah, I see, its the add_running_bw() think; for which RT doesn't have a
> >> counter-part.
> > 
> > Right, but doesn't enqueue_top_rt_rq end-up being called by activate_
> > task on lowest_rq? Mmm.
> 
> 
> AFAICS we have:
> 
> push_rt_task() {
> 	activate_task() {
> 		enqueue_task(,,(flags=0)) {
> 		        if (!(flags & ENQUEUE_NOCLOCK))
> 	        	        update_rq_clock(rq);
> 			enqueue_task_rt() {
> 				enqueue_rt_entity() {
> 					enqueue_top_rt_rq();
> 			}
> 		}
> 	}
> }
> 
> So we will have the clock updated already...
> 
> Am I missing something?

Ah, indeed.
