Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeBFLfA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:35:00 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:54613 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752248AbeBFLew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:34:52 -0500
X-Google-Smtp-Source: AH8x227HMJ57qrZqQaLqSrP33AOfldcEs23CvVfJ08RkxsO0ZnYp4A9vkDXW90B283YQHlLSsZgYJg==
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To: Daniel Thompson <daniel.thompson@linaro.org>, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <d1cc42d4-f79a-e7ac-d8bb-42e889e8a4fe@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0b58fe4c-e505-f5b9-74a6-17ada2052cc0@linaro.org>
Date: Tue, 6 Feb 2018 12:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d1cc42d4-f79a-e7ac-d8bb-42e889e8a4fe@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 14:54, Daniel Thompson wrote:
> On 23/01/18 15:34, Daniel Lezcano wrote:
>> +/**
>> + * cpuidle_cooling_get_max_state - Get the maximum state
>> + * @cdev  : the thermal cooling device
>> + * @state : a pointer to the state variable to be filled
>> + *
>> + * The function gives always 100 as the injection ratio is percentile
>> + * based for consistency accros different platforms.
>> + *
>> + * The function can not fail, it returns always zero.
>> + */
>> +static int cpuidle_cooling_get_max_state(struct
>> thermal_cooling_device *cdev,
>> +                     unsigned long *state)
>> +{
>> +    /*
>> +     * Depending on the configuration or the hardware, the running
>> +     * cycle and the idle cycle could be different. We want unify
>> +     * that to an 0..100 interval, so the set state interface will
>> +     * be the same whatever the platform is.
>> +     *
>> +     * The state 100% will make the cluster 100% ... idle. A 0%
>> +     * injection ratio means no idle injection at all and 50%
>> +     * means for 10ms of idle injection, we have 10ms of running
>> +     * time.
>> +     */
>> +    *state = 100;
> 
> Doesn't this requires DTs to be changed?
> 
> Basically the existing bindings for cpu cooling dictate that
> cooling-max-levels == num OPPs - 1 .
>
> Likewise I think cooling-max-levels *defines* the scale used by the
> cooling maps in the DT. Introducing an alternative scale means that the
> OPP limits in the cooling-map will be misinterpreted when we bind the
> cooling device.

The DT binding for the cpuidle cooling device just need to bind to the
thermal-zone, it does not care about the cooling-max-levels which is a
binding for the cpufreq cooling device. That makes both cooling devices
to be able to co-exists with the same DT.

However, as you mentioned it in the previous emails, new DT bindings
will need to be defined in order to extend the features. That is
something I would like to put apart in the discussion in order to be
focused in the thermal mitigation aspect of the cooling device.

The DT bindings discussions can be long and end up as a non-removable
definition, so that is something IMO which should be discussed in a
specific series.

> Note that we get away with this on Hikey because its mainline cooling
> map is, AFAICT, deeply sub-optimal and doesn't set any cooling limits.
> If its cooling map has been tuned (as the Exynos ones are) then I
> suspect there could be overheating problems when the cpuidle (or combo)
> CPU coolers are enabled.

Yes, that's a good point but from my POV, if we select here the cpuidle
cooling device then we should also change the cooling mapping which is
optimized for the cpufreq cooling device, a cooling device we
deliberately disabled by choosing the cpuidle cooling device.

The DT aspect is complex to solve, that's why I propose this first
simple approach to introduce the feature with current DT bindings.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
