Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeBXXBO (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 18:01:14 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33822 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeBXXBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 18:01:12 -0500
X-Google-Smtp-Source: AG47ELvg1UmjKHJMeDbpwL2jchnN2voqQSHVfR1/kX67ZA/Ozk0V/Iw4ZCGhkW/oovAaH7eb8lJbYQ==
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Kevin Wangtao <kevin.wangtao@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <CAKfTPtBZqcFcy9W8ss7vZsXPRzb7KPM0W2M7icnxMPTAq+UkPQ@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <097594b4-fb9a-0c3a-b673-03f092066e68@linaro.org>
Date: Sun, 25 Feb 2018 00:01:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtBZqcFcy9W8ss7vZsXPRzb7KPM0W2M7icnxMPTAq+UkPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2018 16:26, Vincent Guittot wrote:
> Hi Daniel,
> 
> On 21 February 2018 at 16:29, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> +
>> +/**
>> + * struct cpuidle_cooling_device - data for the idle cooling device
>> + * @cdev: a pointer to a struct thermal_cooling_device
>> + * @cpumask: a cpumask containing the CPU managed by the cooling device
>> + * @timer: a hrtimer giving the tempo for the idle injection cycles
>> + * @kref: a kernel refcount on this structure
>> + * @count: an atomic to keep track of the last task exiting the idle cycle
>> + * @idle_cycle: an integer defining the duration of the idle injection
>> + * @state: an normalized integer giving the state of the cooling device
>> + */
>> +struct cpuidle_cooling_device {
>> +       struct thermal_cooling_device *cdev;
>> +       struct cpumask *cpumask;
>> +       struct list_head node;
>> +       struct hrtimer timer;
>> +       struct kref kref;
>> +       atomic_t count;
>> +       unsigned int idle_cycle;
>> +       unsigned int state;
>> +};
>> +
>> +/**
>> + * @tsk: an array of pointer to the idle injection tasks
>> + * @waitq: the waiq for the idle injection tasks
>> + */
>> +struct cpuidle_cooling_tsk {
>> +       struct task_struct *tsk;
>> +       wait_queue_head_t waitq;
> 
> Why are you creating one wait_queue_head_t per cpu instead of one per
> cooling device and then save a pointer in the per cpu struct
> cpuidle_cooling_tsk ?
> Then, you can use wake_up_interruptible_all() to wake up all threads
> instead of using for_each_cpu ... wake_up_process() loop in
> cpuidle_cooling_wakeup() ?
Yes, that should do the trick. I will give it a try.



 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
