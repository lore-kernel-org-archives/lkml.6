Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx4+ALs5HJaqtu12NywQk5Bc87XT44Pl0IvDuLzskpAfZ9PVK4B+KDZ4z4qX/Z7h6kAGoot0u
ARC-Seal: i=1; a=rsa-sha256; t=1522103210; cv=none;
        d=google.com; s=arc-20160816;
        b=I+Q24a9TEbpRQ28gVGPxZ0yzH3x2NHsv/j4UURuYVmvOAq7o7X6o262Oyu2WgKEsiv
         o6FtixuUMCWW3sbBNvFJxIaZUC2QRp4NMbFS5p3W/yWON7cJgA73u+VIQfGB1UKtuzkp
         U0UFPGVWkvY6cem6RzyObguJcFZv1qPrmGliuM6XACfKzpU9TcY0JJRjiV+TNdEd0GsN
         eU0Exf1+htFrNUqg6YRLu7FJdhiiK91cPh1Okr8kJpViYzJmjfMymwyFNuegcZOvN8WP
         MJOlxOPftTUPEezdtsHZbDJuIlSLVK3pKxBddz2x/tA+oitBli1XcxM2LVAUUHXm1In6
         32BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=TjqGDunUmqGRKKlemixhq2nXFMe1t+AOjErXNRN6E1c=;
        b=pTHxk3Yz33UoAvgJK0Rbh15C2vzl87FrrAtIhAD/sGSF4JnVdPX0K5v8u78g0iQ4Cb
         0dCrIDvkvr9XIi6W1ZQQwfpPmmD+diUJOfMm+3Fg1e1ZQCAsVVIy7VXL+vKQxtHwkSKb
         8eIB49cuhifvQ680U8K4j5wzTLMz2oMYIuTrmugt38HlWpAFAbvqpnMXslbjrdRVxI+3
         cU1+QYvRms7xP4gXKJ/Cwm9UCFemuvJc0CNjVtJJyQT5p8qOUWdMV6Z0+BlCtaIj+L3x
         nTdrGsXOUQIlWjIEScgUN4w0I8yNfRS9CqELMe7H1qKK77EvhJJSFGQXfTDiv0Xa+PPO
         VH2w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 2/6] sched: Introduce energy models of CPUs
To: Quentin Perret <quentin.perret@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-3-dietmar.eggemann@arm.com>
 <20180320095215.GB23359@kroah.com>
 <20180325134548.GA1344@queper01-VirtualBox>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <ab194f83-85eb-4bec-feea-5fbe5d5b20f5@arm.com>
Date: Tue, 27 Mar 2018 00:26:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180325134548.GA1344@queper01-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449333969249680?=
X-GMAIL-MSGID: =?utf-8?q?1596040895798925315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/25/2018 03:48 PM, Quentin Perret wrote:
> On Tuesday 20 Mar 2018 at 10:52:15 (+0100), Greg Kroah-Hartman wrote:
>> On Tue, Mar 20, 2018 at 09:43:08AM +0000, Dietmar Eggemann wrote:
>>> From: Quentin Perret <quentin.perret@arm.com>
> 
> [...]
> 
>>> +#ifdef CONFIG_PM_OPP
>>
>> #ifdefs go in .h files, not .c files, right?
>>
> 
> So, after looking into this, my suggestion would be to: 1) remove the
> #ifdef CONFIG_PM_OPP from energy.c entirely; 2) make sure
> init_sched_energy() is stubbed properly for !CONFIG_SMP and
> !CONFIG_PM_OPP in include/linux/sched/energy.h; 3) relocate the global
> variables (energy_model, freq_domains, ...) to fair.c; and 4) modify
> kernel/sched/Makefile with something like:
> 
> ifeq ($(CONFIG_PM_OPP),y)
> obj-$(CONFIG_SMP) += energy.o
> endif
> 
> That way, energy.c is not compiled if not needed by the arch, and the
> ifdef are kept within header files and Makefiles.
> 
> Would that work ?

Could we extend this idea a little bit further and leave the global
variables in energy.c? Normally, all energy interfaces could be
declared or stubbed in energy.h.

We could hide the access to energy_model, sched_energy_present and
freq_domains behind functions.

It would be nice to provide also find_energy_efficient_cpu() in energy.c
but it uses itself a lot of fair.c stuff and we do want to avoid function
calls in the wakeup path, right?

Boot-tested on juno r0 (CONFIG_SMP=y and CONFIG_PM_OPP=y). Build-tested on
i386 (CONFIG_SMP and CONFIG_PM_OPP not set), arm multi_v5_defconfig (CONFIG_SMP
not set and CONFIG_PM_OPP=y).

in energy.h:

#ifdef CONFIG_SMP
#ifdef CONFIG_PM_OPP
static inline struct capacity_state *find_cap_state(int cpu, unsigned long util)
{
    ...
}
static inline bool sched_energy_enabled(void)
{
   ...
}
static inline struct list_head *get_freq_domains(void)
{
   ...
}
#endif
#endif

#if !defined(CONFIG_SMP) || !defined(CONFIG_PM_OPP)
static inline struct capacity_state *find_cap_state(int cpu, unsigned long util) { return false; }
static inline struct list_head *get_freq_domains(void) { return NULL; }
static inline struct capacity_state *
find_cap_state(int cpu, unsigned long util) { return NULL; }
static inline void init_sched_energy(void) { }
#endif

#define for_each_freq_domain(fdom) \
		list_for_each_entry(fdom, get_freq_domains(), next)

--->8---

diff --git a/include/linux/sched/energy.h b/include/linux/sched/energy.h
index b4f43564ffe4..5aad03ec5b30 100644
--- a/include/linux/sched/energy.h
+++ b/include/linux/sched/energy.h
@@ -20,12 +20,49 @@ struct freq_domain {
 extern struct sched_energy_model ** __percpu energy_model;
 extern struct static_key_false sched_energy_present;
 extern struct list_head freq_domains;
-#define for_each_freq_domain(fdom) \
-                       list_for_each_entry(fdom, &freq_domains, next)
 
-void init_sched_energy(void);
-#else
-static inline void init_sched_energy(void) { }
+#ifdef CONFIG_PM_OPP
+static inline bool sched_energy_enabled(void)
+{
+       return static_branch_unlikely(&sched_energy_present);
+}
+
+static inline struct list_head *get_freq_domains(void)
+{
+       return &freq_domains;
+}
+
+static inline
+struct capacity_state *find_cap_state(int cpu, unsigned long util)
+{
+       struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
+       struct capacity_state *cs = NULL;
+       int i;
+
+       util += util >> 2;
+
+       for (i = 0; i < em->nr_cap_states; i++) {
+               cs = &em->cap_states[i];
+               if (cs->cap >= util)
+                       break;
+       }
+
+       return cs;
+}
+
+extern void init_sched_energy(void);
 #endif
+#endif /* CONFIG_SMP */
 
+#if !defined(CONFIG_SMP) || !defined(CONFIG_PM_OPP)
+static inline bool sched_energy_enabled(void) { return false; }
+static inline struct list_head *get_freq_domains(void) { return NULL; }
+static inline struct capacity_state *
+find_cap_state(int cpu, unsigned long util) { return NULL; }
+static inline void init_sched_energy(void) { }
 #endif
+
+#define for_each_freq_domain(fdom) \
+                       list_for_each_entry(fdom, get_freq_domains(), next)
+
+#endif /* _LINUX_SCHED_ENERGY_H */
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 912972ad4dbc..e34bec3ae353 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -20,7 +20,7 @@ obj-y += core.o loadavg.o clock.o cputime.o
 obj-y += idle.o fair.o rt.o deadline.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
-obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o energy.o
+obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o
 obj-$(CONFIG_SCHED_AUTOGROUP) += autogroup.o
 obj-$(CONFIG_SCHEDSTATS) += stats.o
 obj-$(CONFIG_SCHED_DEBUG) += debug.o
@@ -29,3 +29,6 @@ obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_CPU_FREQ_GOV_SCHEDUTIL) += cpufreq_schedutil.o
 obj-$(CONFIG_MEMBARRIER) += membarrier.o
 obj-$(CONFIG_CPU_ISOLATION) += isolation.o
+ifeq ($(CONFIG_PM_OPP),y)
+       obj-$(CONFIG_SMP) += energy.o
+endif
diff --git a/kernel/sched/energy.c b/kernel/sched/energy.c
index 4662c993e096..1de8226943b9 100644
--- a/kernel/sched/energy.c
+++ b/kernel/sched/energy.c
@@ -30,7 +30,6 @@ struct sched_energy_model ** __percpu energy_model;
  */
 LIST_HEAD(freq_domains);
 
-#ifdef CONFIG_PM_OPP
 static struct sched_energy_model *build_energy_model(int cpu)
 {
        unsigned long cap_scale = arch_scale_cpu_capacity(NULL, cpu);
@@ -185,6 +184,3 @@ void init_sched_energy(void)
 exit_fail:
        pr_err("Energy Aware Scheduling initialization failed.\n");
 }
-#else
-void init_sched_energy(void) {}
-#endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65a1bead0773..b3e6a2656b68 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6456,27 +6456,6 @@ static int wake_cap(struct task_struct *p, int cpu, int prev_cpu)
        return !util_fits_capacity(task_util(p), min_cap);
 }
 
-static struct capacity_state *find_cap_state(int cpu, unsigned long util)
-{
-       struct sched_energy_model *em = *per_cpu_ptr(energy_model, cpu);
-       struct capacity_state *cs = NULL;
-       int i;
-
-       /*
-        * As the goal is to estimate the OPP reached for a specific util
-        * value, mimic the behaviour of schedutil with a 1.25 coefficient
-        */
-       util += util >> 2;
-
-       for (i = 0; i < em->nr_cap_states; i++) {
-               cs = &em->cap_states[i];
-               if (cs->cap >= util)
-                       break;
-       }
-
-       return cs;
-}
-
 static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
 {
        unsigned long util, fdom_max_util;
@@ -6557,7 +6536,7 @@ static inline bool wake_energy(struct task_struct *p, int prev_cpu)
 {
        struct sched_domain *sd;
 
-       if (!static_branch_unlikely(&sched_energy_present))
+       if (!sched_energy_enabled())
                return false;
 
        sd = rcu_dereference_sched(cpu_rq(prev_cpu)->sd);
@@ -9252,8 +9231,7 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
                }
                max_cost += sd->max_newidle_lb_cost;
 
-               if (static_branch_unlikely(&sched_energy_present) &&
-                   !sd_overutilized(sd))
+               if (sched_energy_enabled() && !sd_overutilized(sd))
                        continue;
 
                if (!(sd->flags & SD_LOAD_BALANCE))
@@ -9823,8 +9801,7 @@ static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
                        break;
                }
 
-               if (static_branch_unlikely(&sched_energy_present) &&
-                   !sd_overutilized(sd))
+               if (sched_energy_enabled() && !sd_overutilized(sd))
                        continue;
 
                if (sd->flags & SD_BALANCE_NEWIDLE) {
