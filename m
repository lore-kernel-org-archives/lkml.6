Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeE1BE2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 21:04:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33807 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbeE1BE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 21:04:26 -0400
X-Google-Smtp-Source: ADUXVKKwyuYV2/fb+PuTXAb9zWwDCqAzh0jqoji9S4ZS199nPrKA/td+sNm6FiiMuFjDsPpsvqD5Aw==
Date: Sun, 27 May 2018 18:04:25 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] kernel/sched/topology: Clarify root domain(s) debug
 string
Message-ID: <20180528010425.GA64067@joelaf.mtv.corp.google.com>
References: <20180524152936.17611-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524152936.17611-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 05:29:36PM +0200, Juri Lelli wrote:
> When scheduler debug is enabled, building scheduling domains outputs
> information about how the domains are laid out and to which root domain
> each CPU (or sets of CPUs) belongs, e.g.:
> 
>  CPU0 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
>  CPU1 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }
> 
>  [...]
> 
>  span: 0-5 (max cpu_capacity = 1024)
> 
> The fact that latest line refers to CPUs 0-5 root domain doesn't however look

                last line?

> immediately obvious to me: one might wonder why span 0-5 is reported "again".
> 
> Make it more clear by adding "root domain" to it, as to end with the
> following.
> 
>  CPU0 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 0:{ span=0 }, 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
>  CPU1 attaching sched-domain(s):
>   domain-0: span=0-5 level=MC
>    groups: 1:{ span=1 }, 2:{ span=2 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 }
> 
>  [...]
> 
>  root domain span: 0-5 (max cpu_capacity = 1024)
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

I played the sched_load_balance flag to trigger this and it makes sense to
improve the print with 'root domain'.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

One thing I believe is a bit weird is sched_load_balance also can affect the
wake-up path, because a NULL sd is attached to the rq if sched_load_balance
is set to 0.

This could turn off the "for_each_domain(cpu, tmp)" loop in
select_task_rq_fair and hence we would always end up in the
select_idle_sibling path for those CPUs.

It also means that "XXX always" can/should be removed because sd can very
well be NULL for other sd_flag types as well, not just sd_flag ==
SD_BALANCE_WAKE. I'll send a patch to remove that comment as I just tested
this is true.

thanks,

 - Joel
