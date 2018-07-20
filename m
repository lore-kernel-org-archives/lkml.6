Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3222ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665AE206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 665AE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbeGTQY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:24:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37018 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbeGTQY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:24:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id a19-v6so10193416wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 08:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=63NvMfyl9V5CBogwexVxhaEw53ygPuTVjf+vh9tMbQg=;
        b=DhPMT8/tQ5RTYG/ZJd651gmeYFGtX8yLrUFCo6ACt7NtZV+bDpnnYP2n5CfuJPskhR
         xiLdVKIULZdNxl19zX05EI6rTk9vu+Uq8JgIasfEVS4sTH2Tzjz2ZEPIrzWg18zqkPkv
         /W5efe1u5Lp98BE3do85iJKKfEwUtm5rqT2ZPTiS4jVtkJyJs5Prkm0c+cTZpkvbeNex
         PbbWDzLCKuBxC8gyNT0jcR+k6D4pkFf7pa5T+RPTNPvYUGZaY60KoX8zqsHiFRXaiISl
         CNliU/E/LmhO9zK7xf7XdSV69Z56HVHnq3yulfTHjzBBQCVblKcf2bSgn4PWfpQguj10
         CQ2A==
X-Gm-Message-State: AOUpUlEkXd8NhCIWhlvzXVu1tOBdMLiz+ZIIfmzPSEuUVHvxX5p+u8cQ
        I/LlAtmZ0nX/nT8MaGwQNC3jxA==
X-Google-Smtp-Source: AAOMgpfzO6cVP7n2fvWr7ZCya0rYt/NHh630JzaM4QEhK5tgtghWd/kDfm4i3PBpFVIF4AKg1GUbtQ==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr1751013wmd.18.1532100968245;
        Fri, 20 Jul 2018 08:36:08 -0700 (PDT)
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id l127-v6sm4856902wma.41.2018.07.20.08.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 08:36:07 -0700 (PDT)
Subject: Re: [PATCH V3] sched/deadline: Update rq_clock of later_rq when
 pushing a task
To:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Clark Williams <williams@redhat.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
References: <ca31d073a4788acf0684a8b255f14fea775ccf20.1532077269.git.bristot@redhat.com>
 <20180720124615.GM2476@hirez.programming.kicks-ass.net>
 <20180720124821.GB2512@hirez.programming.kicks-ass.net>
 <20180720125329.GD3642@localhost.localdomain>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <183815b1-50dd-9027-31df-a18a604719e8@redhat.com>
Date:   Fri, 20 Jul 2018 17:36:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180720125329.GD3642@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/2018 02:53 PM, Juri Lelli wrote:
> On 20/07/18 14:48, Peter Zijlstra wrote:
>> On Fri, Jul 20, 2018 at 02:46:15PM +0200, Peter Zijlstra wrote:
>>> On Fri, Jul 20, 2018 at 11:16:30AM +0200, Daniel Bristot de Oliveira wrote:
>>>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>>>> index fbfc3f1d368a..8b50eea4b607 100644
>>>> --- a/kernel/sched/deadline.c
>>>> +++ b/kernel/sched/deadline.c
>>>> @@ -2090,8 +2090,14 @@ static int push_dl_task(struct rq *rq)
>>>>  	sub_rq_bw(&next_task->dl, &rq->dl);
>>>>  	set_task_cpu(next_task, later_rq->cpu);
>>>>  	add_rq_bw(&next_task->dl, &later_rq->dl);
>>>> +
>>>> +	/*
>>>> +	 * Update the later_rq clock here, because the clock is used
>>>> +	 * by the cpufreq_update_util() inside __add_running_bw().
>>>> +	 */
>>>> +	update_rq_clock(later_rq);
>>>>  	add_running_bw(&next_task->dl, &later_rq->dl);
>>>> -	activate_task(later_rq, next_task, 0);
>>>> +	activate_task(later_rq, next_task, ENQUEUE_NOCLOCK);
>>>>  	ret = 1;
>>>>  
>>>>  	resched_curr(later_rq);
>>>
>>> Why isn't push_rt_task() affected by the very same issue?
>>
>> Aah, I see, its the add_running_bw() think; for which RT doesn't have a
>> counter-part.
> 
> Right, but doesn't enqueue_top_rt_rq end-up being called by activate_
> task on lowest_rq? Mmm.


AFAICS we have:

push_rt_task() {
	activate_task() {
		enqueue_task(,,(flags=0)) {
		        if (!(flags & ENQUEUE_NOCLOCK))
	        	        update_rq_clock(rq);
			enqueue_task_rt() {
				enqueue_rt_entity() {
					enqueue_top_rt_rq();
			}
		}
	}
}

So we will have the clock updated already...

Am I missing something?

Thanks,
-- Daniel
