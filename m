Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754088AbeDPMtk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 08:49:40 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39103 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbeDPMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 08:49:38 -0400
X-Google-Smtp-Source: AIpwx4+6ICyiIANW85AtPpGOxOrrJrQHR7thsKldGaw71I11IY4m8XxCTvzyHRVVnyOTUZkGSg8VQA==
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
 <20180416095006.GC4244@vireshk-i7>
 <b0e7ff16-c947-89a0-6bd9-56ee9a76e7ad@linaro.org>
 <20180416101021.GD4244@vireshk-i7>
 <1c61128a-dea6-b12c-4cd8-ef53a5c8628d@linaro.org>
 <20180416123102.GD3706@e107533-lin>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <1d4ce2d7-cc24-83e1-dbf9-2c1cd2f5ca74@linaro.org>
Date: Mon, 16 Apr 2018 14:49:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416123102.GD3706@e107533-lin>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 14:31, Sudeep Holla wrote:
> On Mon, Apr 16, 2018 at 02:10:30PM +0200, Daniel Lezcano wrote:
>> On 16/04/2018 12:10, Viresh Kumar wrote:
>>> On 16-04-18, 12:03, Daniel Lezcano wrote:
>>>> On 16/04/2018 11:50, Viresh Kumar wrote:
>>>>> On 16-04-18, 11:45, Daniel Lezcano wrote:
>>>>>> Can you elaborate a bit ? I'm not sure to get the point.
>>>>>
>>>>> Sure. With your current code on Hikey960 (big/LITTLE), you end up
>>>>> creating two cooling devices, one for the big cluster and one for
>>>>> small cluster. Which is the right thing to do, as we also have two
>>>>> cpufreq cooling devices.
>>>>>
>>>>> But with the change Sudeep is referring to, the helper you used to get
>>>>> cluster id will return 0 (SoC id) for all the 8 CPUs. So your code
>>>>> will end up creating a single cpuidle cooling device for all the CPUs.
>>>>> Which would be wrong.
>>>>
>>>> Is the semantic of topology_physical_package_id changing ?
>>>
>>> That's what I understood from his email.
>>>
>>>> I don't
>>>> understand the change Sudeep is referring to.
>>
>> Actually there is no impact with the change Sudeep is referring to. It
>> is for ACPI, we are DT based. Confirmed with Jeremy.
>>
> 
> No, it will change for DT. The aim is to be consistent irrespective of
> h/w or f/w description(i.e ADCPI or DT)

What will happen with the code using topology_physical_package_id ?

drivers/acpi/processor_thermal.c:       int id =
topology_physical_package_id(cpu);

drivers/acpi/processor_thermal.c:               if
(topology_physical_package_id(i) == id)

drivers/acpi/processor_thermal.c:               if
(topology_physical_package_id(i) ==

drivers/acpi/processor_thermal.c:
topology_physical_package_id(cpu))

drivers/block/mtip32xx/mtip32xx.c:
topology_physical_package_id(cpumask_first(node_mask)),

drivers/cpufreq/arm_big_little.c:       return
topology_physical_package_id(cpu);

drivers/crypto/qat/qat_common/adf_common_drv.h: return
topology_physical_package_id(smp_processor_id());

drivers/crypto/virtio/virtio_crypto_common.h:   node =
topology_physical_package_id(cpu);

kernel/events/core.c:           event_pkg =
topology_physical_package_id(event_cpu);

kernel/events/core.c:           local_pkg =
topology_physical_package_id(local_cpu);





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
