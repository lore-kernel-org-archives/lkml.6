Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51FAC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DF02086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 19:08:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DF02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbeKJEt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:49:56 -0500
Received: from foss.arm.com ([217.140.101.70]:36656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbeKJEt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:49:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 072ACA78;
        Fri,  9 Nov 2018 11:08:02 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9E6EB3F5CF;
        Fri,  9 Nov 2018 11:07:59 -0800 (PST)
Subject: Re: [PATCH v3 05/10] sched/fair: Hoist idle_stamp up from
 idle_balance
To:     Steve Sistare <steven.sistare@oracle.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541767840-93588-1-git-send-email-steven.sistare@oracle.com>
 <1541767840-93588-6-git-send-email-steven.sistare@oracle.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <9ad62a6f-0269-a5d9-9757-ba5419f9cc1d@arm.com>
Date:   Fri, 9 Nov 2018 19:07:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541767840-93588-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 09/11/2018 12:50, Steve Sistare wrote:
> Move the update of idle_stamp from idle_balance to the call site in
> pick_next_task_fair, to prepare for a future patch that adds work to
> pick_next_task_fair which must be included in the idle_stamp interval.
> No functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  kernel/sched/fair.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 9031d39..da368ed 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3725,6 +3725,8 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  	rq->misfit_task_load = task_h_load(p);
>  }
>  
> +#define IF_SMP(statement)	statement
> +

I'm not too hot on those IF_SMP() macros. Since you're not introducing
any other user for them, what about an inline function for rq->idle_stamp
setting ? When it's mapped to an empty statement (!CONFIG_SMP) GCC is
smart enough to remove the rq_clock() that would be passed to it on
CONFIG_SMP:

----->8-----

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c11adf3..34d9864 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3725,7 +3725,10 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
        rq->misfit_task_load = task_h_load(p);
 }
 
-#define IF_SMP(statement)      statement
+static inline void set_rq_idle_stamp(struct rq *rq, u64 value)
+{
+       rq->idle_stamp = value;
+}
 
 static void overload_clear(struct rq *rq)
 {
@@ -3772,7 +3775,7 @@ static inline int idle_balance(struct rq *rq, struct rq_flags *rf)
        return 0;
 }
 
-#define IF_SMP(statement)      /* empty */
+static inline void set_rq_idle_stamp(struct rq *rq, u64 value) {}
 
 static inline void overload_clear(struct rq *rq) {}
 static inline void overload_set(struct rq *rq) {}
@@ -6773,12 +6776,12 @@ done: __maybe_unused;
         * We must set idle_stamp _before_ calling idle_balance(), such that we
         * measure the duration of idle_balance() as idle time.
         */
-       IF_SMP(rq->idle_stamp = rq_clock(rq);)
+       set_rq_idle_stamp(rq, rq_clock(rq));
 
        new_tasks = idle_balance(rq, rf);
 
        if (new_tasks)
-               IF_SMP(rq->idle_stamp = 0;)
+               set_rq_idle_stamp(rq, 0);
 
        /*
         * Because idle_balance() releases (and re-acquires) rq->lock, it is
