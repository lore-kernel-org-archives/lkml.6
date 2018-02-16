Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162273AbeBPRjn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 12:39:43 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35404 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162052AbeBPRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 12:39:39 -0500
X-Google-Smtp-Source: AH8x224+r/0ejp92neRf1YySVR0BmpHhUgmwwz2xce/VAuLRKZwnK9HnrOH1RoSA+fDwa4MOqZR7pA==
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <20180207091231.GQ28462@vireshk-i7>
 <54759b82-29e9-f376-bbe8-dcf683ed0cce@linaro.org>
 <20180209094100.GM28462@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <71c94b53-5945-bc91-18ce-b5ef7ba9ec3c@linaro.org>
Date: Fri, 16 Feb 2018 18:39:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209094100.GM28462@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Viresh,

sorry for the late reply.


On 09/02/2018 10:41, Viresh Kumar wrote:
> On 07-02-18, 11:34, Daniel Lezcano wrote:
>> On 07/02/2018 10:12, Viresh Kumar wrote:
>>> What about cpuidle_cooling_unregister() ?
>>
>> The unregister function is not needed because cpuidle can't be unloaded.
>> The cpuidle cooling device is registered after the cpuidle successfully
>> initialized itself, there is no error path.
> 
> Okay, then there are two more things here.
> 
> First, you don't need a kref in your patch and simple counter should
> be used instead, as kref is obviously more heavy to be used for the
> single error path here.

I prefer to keep the kref for its API.

And I disagree about the heavy aspect :)

struct kref {
        refcount_t refcount;
};


> Secondly, what about CPU hotplug ? For example, the cpu-freq cooling
> device gets removed currently if all CPUs of a cluster are
> hotplugged-out. But with your code, even if the CPUs are gone, their
> cpu-idle cooling device will stay.

Yes and it will continue to compute the state, so if new CPUs are
inserted the cooling device automatically uses the cooling state.
I don't see a problem with that.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
