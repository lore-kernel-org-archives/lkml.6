Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424DFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1671520873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 11:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeLRLqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 06:46:14 -0500
Received: from foss.arm.com ([217.140.101.70]:44086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeLRLqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 06:46:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2000D80D;
        Tue, 18 Dec 2018 03:46:14 -0800 (PST)
Received: from [10.1.194.37] (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FDC73F5C0;
        Tue, 18 Dec 2018 03:46:13 -0800 (PST)
Subject: Re: [PATCH v2 3/3] sched/fair: fix unnecessary increase of balance
 interval
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>
References: <1544803317-7610-1-git-send-email-vincent.guittot@linaro.org>
 <1544803317-7610-4-git-send-email-vincent.guittot@linaro.org>
 <f6443ca2-3e82-d4eb-deb8-2aff44c618e2@arm.com>
 <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <07400c1b-d9d7-7619-57fb-b09276d7da92@arm.com>
Date:   Tue, 18 Dec 2018 11:46:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCJBGtmx7pQJCwhcMaxyXWoh04o_C+pR6z+YVykXwvv5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2018 09:32, Vincent Guittot wrote:
[...]
> In this asym packing case, It has nothing to do with pinned tasks and
> that's the root cause of the problem:
> the active balance triggered by asym packing is wrongly assumed to be
> an active balance due to pinned task(s) and the load balance interval
> is increased without any reason
> 
[...]> hmm the increase of balance interval is not linked to cpu stopper but
> to increase the load balance interval when we know that there is no
> possible load balance to perform
> 
> Regards,
> Vincent

Ah, I think I get it: you're saying that this balance_interval increase
is done because it is always assumed we do an active balance with
busiest->nr_running > 1 && pinned tasks, and that all that is left to
migrate after the active_balance is pinned tasks that we can't actually
migrate.

Maybe that's what we should target (as always, totally untested):

-----8<-----
@@ -9131,18 +9144,16 @@ static int load_balance(int this_cpu, struct rq *this_rq,
        } else
                sd->nr_balance_failed = 0;
 
-       if (likely(!active_balance)) {
-               /* We were unbalanced, so reset the balancing interval */
-               sd->balance_interval = sd->min_interval;
-       } else {
+       if (unlikely(active_balance && (env.flags & LBF_ALL_PINNED))) {
                /*
-                * If we've begun active balancing, start to back off. This
-                * case may not be covered by the all_pinned logic if there
-                * is only 1 task on the busy runqueue (because we don't call
-                * detach_tasks).
+                * We did an active balance as a last resort (all other tasks
+                * were pinned), start to back off.
                 */
                if (sd->balance_interval < sd->max_interval)
                        sd->balance_interval *= 2;
+       } else {
+               /* We were unbalanced, so reset the balancing interval */
+               sd->balance_interval = sd->min_interval;
        }
 
        goto out;
----->8-----

can_migrate_task() called by detach_tasks() in the
'if (busiest->nr_running > 1)' block should clear that LBF_ALL_PINNED flag
if there is any migratable task (even if we don't end up migrating it),
and it's not set if (busiest->nr_running == 1), so that *should* work.

I believe the argument that this applies to all kinds of active balances
is still valid - this shouldn't be changed just for asym packing active
balance.
