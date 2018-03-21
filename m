Return-Path: <dietmar.eggemann@arm.com>
X-Google-Smtp-Source: AIpwx49TMXR1ibONuE7a8GsUBNNoElpSB1ci03H3ankD7gsDMSf2ERJGSV4hhPaJ/vCWfgdCJijE
ARC-Seal: i=1; a=rsa-sha256; t=1521666929; cv=none;
        d=google.com; s=arc-20160816;
        b=eIsyayxblr6rnnzBAto8eovMYMgfsibCt0WDutHTh56TKnvMXCUxo9Ppz49fIel23/
         RogFzIBlDwRKUqlJ6PSy7PZt+FVHQ4AUJ+Y+zLGAuIudmajE77MAJSA9wW58vZEsdYLk
         E7B6VILFV3IODXLjL+DwaCSVSJwAGm9644hOiLckpj+8CpUockGSUvfsXDO4d59DrioT
         SOXqZjttnLsP0C3AFjSEuxCVxoG4hS6cb7iVtHdl536Ujyhff/klOsEAu6Aft3SqIDYh
         2OAZJT7dP4RJAZG8slpKXefo1L8wnQ40C+8JlmWZceDU1DcWNkzlQjUp8PBLgRF1sJMU
         3Lbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=V3V7TfAzVv7H5ZswscExjcQvHvkGiao/WOzCbe6xU2w=;
        b=FuNVe/PXMYoB2JLIXzVGJ3ybqc2qo6y45WosIV/eBxW00M2dmY/aOkE+qnI8nTWcjo
         9ZjHnRtmP8c72uN1N0EYUivrVnrt1YARRMM1fxj4yZGBybmZYutsT7cgorBHOzkL3XuG
         s4UZG9R3sCkgkz8jiSPTyAiL78MnuG5sG6LMOhXwRrpi3qhL2idyM9eGQoHn8fCRzYe9
         NmjricXY+sjff3QS+b+iyOuLLnloGfMtbmgy6uFPLWFgL0dOVUeNS3vuqKVXQ7uXfXYL
         4xlao90Va2ncIqYtJRdl2Mvki8zWOHMx5/WzJ6ohH9oyaxzb3QX5Kj1As+LGWwQmQVlU
         OWYg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of dietmar.eggemann@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 4/6] sched/fair: Introduce an energy estimation helper
 function
To: Quentin Perret <quentin.perret@arm.com>,
 Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@gmail.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Thara Gopinath <thara.gopinath@linaro.org>, linux-pm@vger.kernel.org,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Chris Redpath <chris.redpath@arm.com>,
 Valentin Schneider <valentin.schneider@arm.com>,
 "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>,
 Joel Fernandes <joelaf@google.com>
References: <20180320094312.24081-1-dietmar.eggemann@arm.com>
 <20180320094312.24081-5-dietmar.eggemann@arm.com>
 <20180321090430.GA6913@localhost.localdomain>
 <20180321122621.GA13951@e110439-lin>
 <20180321140235.GA2168@queper01-VirtualBox>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <832b7772-aa83-5205-874b-06d1fcdc8b86@arm.com>
Date: Wed, 21 Mar 2018 22:15:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180321140235.GA2168@queper01-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595449339672655930?=
X-GMAIL-MSGID: =?utf-8?q?1595583422695094115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/2018 03:02 PM, Quentin Perret wrote:
> On Wednesday 21 Mar 2018 at 12:26:21 (+0000), Patrick Bellasi wrote:
>> On 21-Mar 10:04, Juri Lelli wrote:
>>> Hi,
>>>
>>> On 20/03/18 09:43, Dietmar Eggemann wrote:
>>>> From: Quentin Perret <quentin.perret@arm.com>

[...]

>> Actually I think that this whole function can be written "just" as:
>>
>> ---8<---
>>     unsigned long util = cpu_util_wake(cpu);
>>
>>     if (cpu != dst_cpu)
>>          return util;
>>
>>     return min(util + task_util(p), capacity_orig_of(cpu));
>> ---8<---
>>
> 
> Yes this should be functionally equivalent. However, with your
> suggestion you can potentially remove the task contribution from the
> cpu_util in cpu_util_wake() and then add it back right after if
> cpu==dst_cpu. This is sub-optimal and that's why I implemented things
> slightly differently. But maybe this optimization really is too small to
> justify the extra complexity involved ...

What about we merge both functions by adding an additional 'int dst_cpu'
parameter to cpu_util_wake() (only lightly tested, w/o util_est):

--->8---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65a1bead0773..4d4f104d5b3d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5860,11 +5860,11 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static inline unsigned long task_util(struct task_struct *p);
-static unsigned long cpu_util_wake(int cpu, struct task_struct *p);
+static unsigned long cpu_util_wake(int cpu, int dst_cpu, struct task_struct *p);
 
 static unsigned long capacity_spare_wake(int cpu, struct task_struct *p)
 {
-       return max_t(long, capacity_of(cpu) - cpu_util_wake(cpu, p), 0);
+       return max_t(long, capacity_of(cpu) - cpu_util_wake(cpu, -1, p), 0);
 }
 
 /*
@@ -6384,16 +6384,22 @@ static inline unsigned long task_util(struct task_struct *p)
  * cpu_util_wake: Compute CPU utilization with any contributions from
  * the waking task p removed.
  */
-static unsigned long cpu_util_wake(int cpu, struct task_struct *p)
+static unsigned long cpu_util_wake(int cpu, int dst_cpu, struct task_struct *p)
 {
        unsigned long util, capacity;
 
        /* Task has no contribution or is new */
-       if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
+       if ((cpu != task_cpu(p) && cpu != dst_cpu) ||
+           dst_cpu == task_cpu(p) || !p->se.avg.last_update_time)
                return cpu_util(cpu);
 
        capacity = capacity_orig_of(cpu);
-       util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
+       util = cpu_rq(cpu)->cfs.avg.util_avg;
+
+       if (likely(dst_cpu != cpu))
+               util = max_t(long, util - task_util(p), 0);
+       else
+               util += task_util(p);
 
        return (util >= capacity) ? capacity : util;
 }
@@ -6409,30 +6415,6 @@ static inline int cpu_overutilized(int cpu)
 }
 
 /*
- * Returns the util of "cpu" if "p" wakes up on "dst_cpu".
- */
-static unsigned long cpu_util_next(int cpu, struct task_struct *p, int dst_cpu)
-{
-       unsigned long util = cpu_rq(cpu)->cfs.avg.util_avg;
-       unsigned long capacity = capacity_orig_of(cpu);
-
-       /*
-        * If p is where it should be, or if it has no impact on cpu, there is
-        * not much to do.
-        */
-       if ((task_cpu(p) == dst_cpu) || (cpu != task_cpu(p) && cpu != dst_cpu))
-               goto clamp_util;
-
-       if (dst_cpu == cpu)
-               util += task_util(p);
-       else
-               util = max_t(long, util - task_util(p), 0);
-
-clamp_util:
-       return (util >= capacity) ? capacity : util;
-}
-
-/*
  * Disable WAKE_AFFINE in the case where task @p doesn't fit in the
  * capacity of either the waking CPU @cpu or the previous CPU @prev_cpu.
  *
@@ -6488,7 +6470,7 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
        for_each_freq_domain(fdom) {
                fdom_max_util = 0;
                for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
-                       util = cpu_util_next(cpu, p, dst_cpu);
+                       util = cpu_util_wake(cpu, dst_cpu, p);
                        fdom_max_util = max(util, fdom_max_util);
                }
 
@@ -6506,7 +6488,7 @@ static unsigned long compute_energy(struct task_struct *p, int dst_cpu)
                 * busy time.
                 */
                for_each_cpu_and(cpu, &(fdom->span), cpu_online_mask) {
-                       util = cpu_util_next(cpu, p, dst_cpu);
+                       util = cpu_util_wake(cpu, dst_cpu, p);
                        energy += cs->power * util / cs->cap;
                }
        }
