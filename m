Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeBBOaV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:30:21 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:53074 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751653AbeBBOaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:30:14 -0500
X-Google-Smtp-Source: AH8x224f6nhu7MPLQh+AXb+7wunLs7coXu6KSOjt2jITJm8VMI6NVtReGIMDcUwYCM2ZZ+uKmCmHPg==
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        daniel.thompson@linaro.org
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
Date: Fri, 2 Feb 2018 15:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180202104259.GA28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2018 11:42, Viresh Kumar wrote:
> Hi Daniel,

Hi Viresh,


> I have gone through the other review comments, specially from Daniel T.. While I
> share some of his concerns, I have few more of mine.
> 
> On 23-01-18, 16:34, Daniel Lezcano wrote:
>> +late_initcall(cpu_cooling_init);
> 
> For example, this thing isn't going to fly nicely as you have assumed cpufreq
> and cpuidle drivers are going to be part of the kernel itself. What if they are
> modules and are inserted after late-init ? There are more cases like this where
> the cpufreq driver may unregister the cpufreq cooling device on the fly and then
> add it back. And so this stuff is a bit tricky.

The cpuidle driver can not be compiled as a module.

Agree the cpufreq driver can be unloaded and this part needs some
adjustments.

> Here is how I see the whole thing now:
> 
> - Yes we need individual support for both cpufreq and cpuidle cooling devices,
>   and no one disagrees on that I believe.
> 
> - There is nothing in the thermal framework that disallows both cpufreq and
>   cpuidle cooling devices to co-exist. Both would be part of the same thermal
>   zone and so will get throttled with the same thermal sensor event. And so we
>   will end up trying to cool down the SoC using both cpufreq and cpuidle
>   technique.

No. It does not work because we will need different state for each
cooling device and we need some logic behind.

> - Now I am just wondering if we really need the "combo" functionality or not.
>   Can we fine tune the DT cpu-cooling properties (existing ones) for a platform,
>   so that it automatically acts as a combo cooling device? I am not 100% sure
>   its gonna fly, but just wanted to make sure its not possible to work around
>   with and then only try the combo device thing.
> 
> For example, suppose that with just cpufreq-cooling device we need to take the
> CPU down to 1 GHz from 2 GHz if we cross temperature 'X'. What if we can change
> this policy from DT and say the cpufreq-cooling device goes to 1.5 GHz and
> cpuidle-cooling device takes us to idle for 'y' us, and the effect of
> combination of these two is >= the effect of the 1 GHz for just the
> cpufreq-cooling device.
> 
> Is there any possibility of this to work ?

It does not make sense. The combo does that automatically by computing
the power equivalence more precisely.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
