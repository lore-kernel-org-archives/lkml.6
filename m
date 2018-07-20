Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAD7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF3120661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF3120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbeGTNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:41:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33244 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731833AbeGTNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:41:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so11259615wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 05:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hO9gjRcwiUHt7lNNOrFkiM04cvKbGj0Bp/sIbfZ5wU0=;
        b=oZpbYSfkI54ykqR7B1I9MQIJuZIOQGiGey6w252cjHLe6MYmx8Dq6m2TYM8cOJqn5V
         EL09IR9pN8zT4in/LGUkFaGYLE1O5kobuXwp2YhjWU3W7K8hLhPj7ILkYzdDtYKw/9fX
         WQj3yYbENmQzr3pGfuSMvtWqZmFz/IROxwGHQTTJ5ngTAmreadG/Qjgvm5fh5ARWzNyF
         M9olqnSzVjv38cEWGo8Su4AZHfC2BGEbfOvi1015AiVi3hOKQ0abfCswYLVB7ETkJ9LM
         sMVyuK8GhWv0pP6ptQu2UtZSqjyvZBQSuefm+b/hLE+d+D8RKmamgj+3blslMlVwZwwH
         lfNg==
X-Gm-Message-State: AOUpUlF135YQNyHBKSXbDi9j7rJcmuLdNROWqZ5LpKJHhPAQa7zurKJl
        B3/sYE1qvgAqYF5WGzfSPiBm4g==
X-Google-Smtp-Source: AAOMgpes0TToMc60XNNn6nZYK1/Gw4yxlGzug2tU8ecxEzXQ8ti120f7csEZyOsEkRXaUQSQirkWeQ==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr1552008wrr.138.1532091212753;
        Fri, 20 Jul 2018 05:53:32 -0700 (PDT)
Received: from localhost.localdomain ([151.15.255.159])
        by smtp.gmail.com with ESMTPSA id t9-v6sm1889299wra.62.2018.07.20.05.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 05:53:32 -0700 (PDT)
Date:   Fri, 20 Jul 2018 14:53:29 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH V3] sched/deadline: Update rq_clock of later_rq when
 pushing a task
Message-ID: <20180720125329.GD3642@localhost.localdomain>
References: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
 <20180720124615.GM2476@hirez.programming.kicks-ass.net>
 <20180720124821.GB2512@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720124821.GB2512@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/18 14:48, Peter Zijlstra wrote:
> On Fri, Jul 20, 2018 at 02:46:15PM +0200, Peter Zijlstra wrote:
> > On Fri, Jul 20, 2018 at 11:16:30AM +0200, Daniel Bristot de Oliveira wrote:
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index fbfc3f1d368a..8b50eea4b607 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -2090,8 +2090,14 @@ static int push_dl_task(struct rq *rq)
> > >  	sub_rq_bw(&next_task->dl, &rq->dl);
> > >  	set_task_cpu(next_task, later_rq->cpu);
> > >  	add_rq_bw(&next_task->dl, &later_rq->dl);
> > > +
> > > +	/*
> > > +	 * Update the later_rq clock here, because the clock is used
> > > +	 * by the cpufreq_update_util() inside __add_running_bw().
> > > +	 */
> > > +	update_rq_clock(later_rq);
> > >  	add_running_bw(&next_task->dl, &later_rq->dl);
> > > -	activate_task(later_rq, next_task, 0);
> > > +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
> > >  	ret = 1;
> > >  
> > >  	resched_curr(later_rq);
> > 
> > Why isn't push_rt_task() affected by the very same issue?
> 
> Aah, I see, its the add_running_bw() think; for which RT doesn't have a
> counter-part.

Right, but doesn't enqueue_top_rt_rq end-up being called by activate_
task on lowest_rq? Mmm.
