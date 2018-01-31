Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752868AbeAaJ4z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 04:56:55 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:54380 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbeAaJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 04:56:52 -0500
X-Google-Smtp-Source: AH8x226enYXP8Q3fahTOMSDM0XSjNcFxlhAEPsMk+gEDi19laZFt9lMiW24N/Da6XETGqX5yuswA0/BF2xZG7bU4Vis=
MIME-Version: 1.0
In-Reply-To: <6e776e6c-6f1e-b33b-58b7-b95410ca1f95@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <CAKfTPtD-cUYoAJfhtuTr-E1=rttZvWxVv1Qv7b+Si4vSBy0JVg@mail.gmail.com>
 <11334876-ef8c-58fa-5e32-ab8499eebd7e@linaro.org> <CAKfTPtBXcLHNHEObpttCGtfCWXmR+kwmOW5aD+G23bnYTJi6Yg@mail.gmail.com>
 <6e776e6c-6f1e-b33b-58b7-b95410ca1f95@linaro.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 31 Jan 2018 10:56:31 +0100
Message-ID: <CAKfTPtAFNdOsNOBC8Qg3c=OB7P635gvePvfpDbc5QF10Tei-9Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Kevin Wangtao <kevin.wangtao@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0V9v1i6016807

On 31 January 2018 at 10:50, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On 31/01/2018 10:46, Vincent Guittot wrote:
>> On 31 January 2018 at 10:33, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>> On 31/01/2018 10:01, Vincent Guittot wrote:
>>>> Hi Daniel,
>>>>
>>>> On 23 January 2018 at 16:34, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>> [ ... ] (please trim :)
>>>
>>>>> +               /*
>>>>> +                * Each cooling device is per package. Each package
>>>>> +                * has a set of cpus where the physical number is
>>>>> +                * duplicate in the kernel namespace. We need a way to
>>>>> +                * address the waitq[] and tsk[] arrays with index
>>>>> +                * which are not Linux cpu numbered.
>>>>> +                *
>>>>> +                * One solution is to use the
>>>>> +                * topology_core_id(cpu). Other solution is to use the
>>>>> +                * modulo.
>>>>> +                *
>>>>> +                * eg. 2 x cluster - 4 cores.
>>>>> +                *
>>>>> +                * Physical numbering -> Linux numbering -> % nr_cpus
>>>>> +                *
>>>>> +                * Pkg0 - Cpu0 -> 0 -> 0
>>>>> +                * Pkg0 - Cpu1 -> 1 -> 1
>>>>> +                * Pkg0 - Cpu2 -> 2 -> 2
>>>>> +                * Pkg0 - Cpu3 -> 3 -> 3
>>>>> +                *
>>>>> +                * Pkg1 - Cpu0 -> 4 -> 0
>>>>> +                * Pkg1 - Cpu1 -> 5 -> 1
>>>>> +                * Pkg1 - Cpu2 -> 6 -> 2
>>>>> +                * Pkg1 - Cpu3 -> 7 -> 3
>>>>
>>>>
>>>> I'm not sure that the assumption above for the CPU numbering is safe.
>>>> Can't you use a per cpu structure to point to resources that are per
>>>> cpu instead ? so you will not have to rely on CPU ordering
>>>
>>> Can you elaborate ? I don't get the part with the percpu structure.
>>
>> Something like:
>>
>> struct cpuidle_cooling_cpu {
>>        struct task_struct *tsk;
>>        wait_queue_head_t waitq;
>> };
>>
>> DECLARE_PER_CPU(struct cpuidle_cooling_cpu *, cpu_data);
>
> I got this part but I don't get how that fixes the ordering thing.

Because you don't care of the CPU ordering to retrieve the data as
they are stored per cpu directly

>
>
> --
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
