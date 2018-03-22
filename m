Return-Path: <joelaf@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521736065; cv=none;
        d=google.com; s=arc-20160816;
        b=g+SAeMGXr4/id4/LZjdYHQk1HB8fx/eAwKSyldNoFxB1WC6+BXvKhUDhkgcn0HONrk
         O/DHepAsLv7MRrlPMTx+hDXG9xzi7DyalFq73pBWyN0zRzXTvYf+NmK4/3OFCA/l4Oo3
         F76CQJTTLJAQJGbI+9zzFgo3RvJmSrIXTwDdxlpgB8dib7YZd+PxYCwI/2cDpZ0rwC2n
         7MZM90TJUnIZ2kkG/M/mhBN0+bsDQ7JPirF8p0Mi4XzD/C1Zy9GBGQz/k2R68CPuJlZD
         AiqEmXdoK8fAbT/pgPtdBkBn1cN+5eH1VE5e2ZQp7CgEsPnJbbQPp+REWIW3BM9t58Yb
         C2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hDXpWMaKdr1aaTOPI18T+aoPa61QO3Nx3mzzCUr4v3o=;
        b=lAsA8ZsX8OLiI4+SdeRty4wGIpwkF/PT3bKyyNp/tRYVDPHyaE7vI7nkLu7Xh+5KNQ
         fsp2IQ/OraqYsvgLO6lbtd5EiGHgzaN7x7XHpDktvxtPm4jd35vJElGjoUmJbnAomMD/
         1CDB5Sem2NQ5OXaoeLunLwMYu9WdTb4n+ftWHTLQe0P63TffqqVGscr4ZK4bb3CcfPeX
         RLNO/fDD1Qh/tjrPG1VDjKHTDCzMlEO5qESbMRLRLMtmWgNz8wthzP3koqI8GP2uGk8t
         c1BAXzJ/f/KDc0vdlZf76jlnnvejkFDxon0GSPXUm17UsY+BGEyo2TbEaebl4uym8e0m
         dt9w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SDykd/4d;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SDykd/4d;
       spf=pass (google.com: domain of joelaf@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joelaf@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELuzsK1wRFqna8Yk6vW4wMUwJorSlrOKAGP2A/vWGmm6MJqcFuC5uPiGEmaNKXlczwTXD0S4s0Q5DpKlcqfiEpU=
MIME-Version: 1.0
In-Reply-To: <20180320094312.24081-6-dietmar.eggemann@arm.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com> <20180320094312.24081-6-dietmar.eggemann@arm.com>
From: Joel Fernandes <joelaf@google.com>
Date: Thu, 22 Mar 2018 09:27:43 -0700
Message-ID: <CAJWu+oqO75h0Ue0=zqD1KTcHFF7tUKYgCHQzXx39RyyGTjiang@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] sched/fair: Select an energy-efficient CPU on
 task wake-up
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Quentin Perret <quentin.perret@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>,
	Linux PM <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>,
	Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>,
	Valentin Schneider <valentin.schneider@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449342602746528?=
X-GMAIL-MSGID: =?utf-8?q?1595655916975284763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, Mar 20, 2018 at 2:43 AM, Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> From: Quentin Perret <quentin.perret@arm.com>
>
> In case an energy model is available, waking tasks are re-routed into a
> new energy-aware placement algorithm. The eligible CPUs to be used in the
> energy-aware wakeup path are restricted to the highest non-overutilized
> sched_domain containing prev_cpu and this_cpu. If no such domain is found,
> the tasks go through the usual wake-up path, hence energy-aware placement
> happens only in lightly utilized scenarios.
>
> The selection of the most energy-efficient CPU for a task is achieved by
> estimating the impact on system-level active energy resulting from the
> placement of the task on each candidate CPU. The best CPU energy-wise is
> then selected if it saves a large enough amount of energy with respect to
> prev_cpu.
>
> Although it has already shown significant benefits on some existing
> targets, this brute force approach clearly cannot scale to platforms with
> numerous CPUs. This patch is an attempt to do something useful as writing
> a fast heuristic that performs reasonably well on a broad spectrum of
> architectures isn't an easy task. As a consequence, the scope of usability
> of the energy-aware wake-up path is restricted to systems with the
> SD_ASYM_CPUCAPACITY flag set. These systems not only show the most
> promising opportunities for saving energy but also typically feature a
> limited number of logical CPUs.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 76bd46502486..65a1bead0773 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6513,6 +6513,60 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
>         return energy;
>  }
>
> +static bool task_fits(struct task_struct *p, int cpu)
> +{
> +       unsigned long next_util = cpu_util_next(cpu, p, cpu);
> +
> +       return util_fits_capacity(next_util, capacity_orig_of(cpu));
> +}
> +
> +static int find_energy_efficient_cpu(struct sched_domain *sd,
> +                                       struct task_struct *p, int prev_cpu)
> +{
> +       unsigned long cur_energy, prev_energy, best_energy;
> +       int cpu, best_cpu = prev_cpu;
> +
> +       if (!task_util(p))
> +               return prev_cpu;
> +
> +       /* Compute the energy impact of leaving the task on prev_cpu. */
> +       prev_energy = best_energy = compute_energy(p, prev_cpu);

Is it possible that before the wakeup, the task's affinity is changed
so that p->cpus_allowed no longer contains prev_cpu ? In that case
prev_energy wouldn't matter since previous CPU is no longer an option?

> +
> +       /* Look for the CPU that minimizes the energy. */
> +       for_each_cpu_and(cpu, &p->cpus_allowed, sched_domain_span(sd)) {
> +               if (!task_fits(p, cpu) || cpu == prev_cpu)
> +                       continue;
> +               cur_energy = compute_energy(p, cpu);
> +               if (cur_energy < best_energy) {
> +                       best_energy = cur_energy;
> +                       best_cpu = cpu;
> +               }
> +       }
> +
> +       /*
> +        * We pick the best CPU only if it saves at least 1.5% of the
> +        * energy used by prev_cpu.
> +        */
> +       if ((prev_energy - best_energy) > (prev_energy >> 6))
> +               return best_cpu;
> +
> +       return prev_cpu;
> +}
> +
> +static inline bool wake_energy(struct task_struct *p, int prev_cpu)
> +{
> +       struct sched_domain *sd;
> +
> +       if (!static_branch_unlikely(&sched_energy_present))
> +               return false;
> +
> +       sd = rcu_dereference_sched(cpu_rq(prev_cpu)->sd);
> +       if (!sd || sd_overutilized(sd))

Shouldn't you check for the SD_ASYM_CPUCAPACITY flag here?

> +               return false;
> +
> +       return true;
> +}
> +
>  /*
>   * select_task_rq_fair: Select target runqueue for the waking task in domains
>   * that have the 'sd_flag' flag set. In practice, this is SD_BALANCE_WAKE,
> @@ -6529,18 +6583,22 @@ static int
>  select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_flags)
>  {
>         struct sched_domain *tmp, *affine_sd = NULL, *sd = NULL;
> +       struct sched_domain *energy_sd = NULL;
>         int cpu = smp_processor_id();
>         int new_cpu = prev_cpu;
> -       int want_affine = 0;
> +       int want_affine = 0, want_energy = 0;
>         int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>
> +       rcu_read_lock();
> +
>         if (sd_flag & SD_BALANCE_WAKE) {
>                 record_wakee(p);
> +               want_energy = wake_energy(p, prev_cpu);
>                 want_affine = !wake_wide(p) && !wake_cap(p, cpu, prev_cpu)
> -                             && cpumask_test_cpu(cpu, &p->cpus_allowed);
> +                             && cpumask_test_cpu(cpu, &p->cpus_allowed)
> +                             && !want_energy;
>         }
>
> -       rcu_read_lock();
>         for_each_domain(cpu, tmp) {
>                 if (!(tmp->flags & SD_LOAD_BALANCE))
>                         break;
> @@ -6555,6 +6613,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>                         break;
>                 }
>
> +               /*
> +                * Energy-aware task placement is performed on the highest
> +                * non-overutilized domain spanning over cpu and prev_cpu.
> +                */
> +               if (want_energy && !sd_overutilized(tmp) &&
> +                   cpumask_test_cpu(prev_cpu, sched_domain_span(tmp)))

Shouldn't you check for the SD_ASYM_CPUCAPACITY flag here for tmp level?


> +                       energy_sd = tmp;
> +
>                 if (tmp->flags & sd_flag)
>                         sd = tmp;
>                 else if (!want_affine)
> @@ -6586,6 +6652,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
>                         if (want_affine)
>                                 current->recent_used_cpu = cpu;
>                 }
> +       } else if (energy_sd) {
> +               new_cpu = find_energy_efficient_cpu(energy_sd, p, prev_cpu);

Even if want_affine = 0 (want_energy = 1), we can have sd = NULL if
sd_flag and tmp->flags don't match. In this case we wont enter the EAS
selection path because sd will be = NULL. So should you be setting sd
= NULL explicitly if energy_sd != NULL , or rather do the if
(energy_sd) before doing the if (!sd) ?

If you still want to keep the logic this way, then probably you should
also check if (tmp->flags & sd_flag) == true in the loop? That way
energy_sd wont be set at all (Since we're basically saying we dont
want to do wake up across this sd (in energy aware fashion in this
case) if the domain flags don't watch the wake up sd_flag.

thanks,

- Joel
