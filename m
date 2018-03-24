Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751009AbeCXGqd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 02:46:33 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:37141 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeCXGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 02:46:31 -0400
X-Google-Smtp-Source: AG47ELuyWG5WT4+YpyS1pAsiE4FlyLQWips+Mp01GAQFnIQMroy8lQUtiRb9Cw5JTi1I/ZvjNCOSlQ==
Date: Sat, 24 Mar 2018 07:46:27 +0100
From: Vincent Guittot <vincent.guittot@linaro.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with commit 31e77c93e432 "sched/fair: Update blocked
 load when newly idle"
Message-ID: <20180324064627.GA10884@linaro.org>
References: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1da0be1-94d8-d5d0-8329-4507c51ddd64@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

Le Friday 23 Mar 2018 à 22:28:09 (+0100), Heiner Kallweit a écrit :
> Recently I started to get the following problems with linux-next:
> 
> - When working via Putty/SSH on the system the console frequently freezes
>   for few seconds. Sometimes only opening a second console makes the
>   first one react again.
> 
> - I get "INFO: rcu_sched detected stalls on CPUs/tasks:" warnings as
>   described in [1].
> 
> Bisecting the issue resulted in:
> 
> 31e77c93e432dec79c7d90b888bbfc3652592741 is the first bad commit
> commit 31e77c93e432dec79c7d90b888bbfc3652592741
> Author: Vincent Guittot <vincent.guittot@linaro.org>
> Date:   Wed Feb 14 16:26:46 2018 +0100
> 
>     sched/fair: Update blocked load when newly idle
> 
>     When NEWLY_IDLE load balance is not triggered, we might need to update the
>     blocked load anyway. We can kick an ilb so an idle CPU will take care of
>     updating blocked load or we can try to update them locally before entering
>     idle. In the latter case, we reuse part of the nohz_idle_balance.
>
> After reversing this commit at least the issue with the freezing console
> is gone. The second one appeared only sporadically, I still have to see
> whether it pops up again.
>

Can you check if the change below fix the problem ? 

---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3582117..672f212 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9430,6 +9430,9 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 		has_blocked_load |= update_nohz_stats(rq, true);
 
+		if (flags == NOHZ_STATS_KICK)
+			continue;
+
 		/*
 		 * If time for next balance is due,
 		 * do the balance.
-- 

> System is a Zotac CI321 mini PC with Intel Celeron 2961Y CPU.
> If you need more details, please let me know.
> 
> Regards, Heiner
> 
> [1] https://lkml.org/lkml/2018/3/22/605
