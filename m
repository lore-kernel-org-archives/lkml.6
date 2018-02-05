Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeBES7o (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 13:59:44 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34515 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753464AbeBES7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 13:59:32 -0500
X-Google-Smtp-Source: AH8x22612JKfspRuL+OdN/qeRAabItYIu3Lg41uQhIZ/rGHTEMmKkSFLczPXRrpaCP24tBq1tJJCAlHZ4Jh6q+uGP8Y=
MIME-Version: 1.0
In-Reply-To: <20180202125231.GT19535@localhost.localdomain>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
 <1517503869-3179-3-git-send-email-mathieu.poirier@linaro.org> <20180202125231.GT19535@localhost.localdomain>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Mon, 5 Feb 2018 11:59:30 -0700
Message-ID: <CANLsYkwq9c+xS-TJrntWzKyCWWwQHfPRTv93SSbacmSjPPHhPA@mail.gmail.com>
Subject: Re: [PATCH V2 2/7] cpuset: Rebuild root domain deadline accounting information
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        "luca.abeni" <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 February 2018 at 05:52, Juri Lelli <juri.lelli@redhat.com> wrote:
> Hi Mathieu,
>
> On 01/02/18 09:51, Mathieu Poirier wrote:
>> When the topology of root domains is modified by CPUset or CPUhotplug
>> operations information about the current deadline bandwidth held in the
>> root domain is lost.
>>
>> This patch address the issue by recalculating the lost deadline
>> bandwidth information by circling through the deadline tasks held in
>> CPUsets and adding their current load to the root domain they are
>> associated with.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> ---
>
> [...]
>
>> +static void update_tasks_root_domain(struct cpuset *cs)
>> +{
>> +     struct css_task_iter it;
>> +     struct task_struct *task;
>> +
>> +     css_task_iter_start(&cs->css, 0, &it);
>> +
>> +     while ((task = css_task_iter_next(&it)))
>> +             dl_add_task_root_domain(task);
>> +
>> +     css_task_iter_end(&it);
>> +}
>> +
>> +/*
>> + * Called with cpuset_mutex held (rebuild_sched_domains())
>> + * Called with hotplug lock held (rebuild_sched_domains_locked())
>> + * Called with sched_domains_mutex held (partition_and_rebuild_domains())
>> + */
>> +static void rebuild_root_domains(void)
>> +{
>> +     struct cpuset *cs = NULL;
>> +     struct cgroup_subsys_state *pos_css;
>> +
>> +     rcu_read_lock();
>> +
>> +     /*
>> +      * Clear default root domain DL accounting, it will be computed again
>> +      * if a task belongs to it.
>> +      */
>> +     dl_clear_root_domain(&def_root_domain);
>
> Can't a __sched_setscheduler sneak in at this point, set a task to
> DEADLINE, add its bandwidth to the rd...

Let me think about that one for a bit.

Thanks for the review,
Mathieu

>
>> +
>> +     cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>> +
>> +             if (cpumask_empty(cs->effective_cpus)) {
>> +                     pos_css = css_rightmost_descendant(pos_css);
>> +                     continue;
>> +             }
>> +
>> +             css_get(&cs->css);
>> +
>> +             rcu_read_unlock();
>> +
>> +             update_tasks_root_domain(cs);
>
> ... and this adds it again?
>
>> +
>> +             rcu_read_lock();
>> +             css_put(&cs->css);
>> +     }
>> +     rcu_read_unlock();
>> +}
>
> Best,
>
> - Juri
