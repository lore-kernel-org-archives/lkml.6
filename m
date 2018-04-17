Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751878AbeDQHRm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:17:42 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:45153 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbeDQHRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:17:39 -0400
X-Google-Smtp-Source: AIpwx49FqWlH0SJq/C4TxJ/o18EKF3X5uSreYUubDCC6pUCH0yBmhoYL+jhvnDnTFv6rP8O13lR8yw==
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
 <20180416095006.GC4244@vireshk-i7>
 <b0e7ff16-c947-89a0-6bd9-56ee9a76e7ad@linaro.org>
 <20180416101021.GD4244@vireshk-i7>
 <1c61128a-dea6-b12c-4cd8-ef53a5c8628d@linaro.org>
 <20180416123019.GA9341@e107981-ln.cambridge.arm.com>
 <633cdc63-ce6d-89af-26dd-bdc3a27556ed@linaro.org>
 <20180416142243.GB32565@red-moon>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <845fafa3-f0ab-2050-fe32-1780dc61b8a8@linaro.org>
Date: Tue, 17 Apr 2018 09:17:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416142243.GB32565@red-moon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 16:22, Lorenzo Pieralisi wrote:
> On Mon, Apr 16, 2018 at 03:57:03PM +0200, Daniel Lezcano wrote:
>> On 16/04/2018 14:30, Lorenzo Pieralisi wrote:
>>> On Mon, Apr 16, 2018 at 02:10:30PM +0200, Daniel Lezcano wrote:
>>>> On 16/04/2018 12:10, Viresh Kumar wrote:
>>>>> On 16-04-18, 12:03, Daniel Lezcano wrote:
>>>>>> On 16/04/2018 11:50, Viresh Kumar wrote:
>>>>>>> On 16-04-18, 11:45, Daniel Lezcano wrote:
>>>>>>>> Can you elaborate a bit ? I'm not sure to get the point.
>>>>>>>
>>>>>>> Sure. With your current code on Hikey960 (big/LITTLE), you end up
>>>>>>> creating two cooling devices, one for the big cluster and one for
>>>>>>> small cluster. Which is the right thing to do, as we also have two
>>>>>>> cpufreq cooling devices.
>>>>>>>
>>>>>>> But with the change Sudeep is referring to, the helper you used to get
>>>>>>> cluster id will return 0 (SoC id) for all the 8 CPUs. So your code
>>>>>>> will end up creating a single cpuidle cooling device for all the CPUs.
>>>>>>> Which would be wrong.
>>>>>>
>>>>>> Is the semantic of topology_physical_package_id changing ?
>>>>>
>>>>> That's what I understood from his email.
>>>>>
>>>>>> I don't
>>>>>> understand the change Sudeep is referring to.
>>>>
>>>> Actually there is no impact with the change Sudeep is referring to. It
>>>> is for ACPI, we are DT based. Confirmed with Jeremy.
>>>>
>>>> So AFAICT, it is not a problem.
>>>
>>> It is a problem - DT or ACPI alike. Sudeep was referring to the notion
>>> of "cluster" that has no architectural meaning whatsoever and using
>>> topology_physical_package_id() to detect a "cluster" was/is/will always
>>> be the wrong thing to do. The notion of cluster must not appear in the
>>> kernel at all, it has no architectural meaning. I understand you need
>>> to group CPUs but that has to be done in a different way, through
>>> cooling devices, thermal domains or power domains DT/ACPI bindings but
>>> not by using topology masks.
>>
>> I don't get it. What is the cluster concept defined in the ARM
>> documentation?
>>
>> ARM Cortex-A53 MPCore Processor Technical Reference Manual
>>
>> 4.5.2. Multiprocessor Affinity Register
>>
>> I see the documentation says:
>>
>> A cluster with two cores, three cores, ...
>>
>> How the kernel can represent that if you kill the
>> topology_physical_package_id() ?
> 
> From an Arm ARM perspective (ARM v8 reference manual), the MPIDR_EL1 has
> no notion of cluster which means that a cluster is not architecturally
> defined on Arm systems.

Sorry, I'm lost :/ You say the MPIDR_EL1 has no notion of cluster but
the documentation describing this register is all talking about cluster.

http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0500g/BABHBJCI.html

> Currently, as Morten explained today, topology_physical_package_id()
> is supposed to represent a "cluster" and that's completely wrong
> because a "cluster" cannot be defined from an architectural perspective.
> 
> It was a bodge used as a shortcut, wrongly. We should have never used
> that API for that purpose and there must be no code in the kernel
> relying on:
> 
> topology_physical_package_id()
> 
> to define a cluster; the information you require to group CPUs must
> come from something else, which is firmware bindings(DT or ACPI) as
> I mentioned.

Why not ?

diff --git a/arch/arm64/include/asm/topology.h
b/arch/arm64/include/asm/topology.h
index c4f2d50..ac0776d 100644
--- a/arch/arm64/include/asm/topology.h
+++ b/arch/arm64/include/asm/topology.h
@@ -14,7 +14,8 @@ struct cpu_topology {

 extern struct cpu_topology cpu_topology[NR_CPUS];

-#define topology_physical_package_id(cpu)
(cpu_topology[cpu].cluster_id)
+#define topology_physical_package_id(cpu)      (0)
+#define topology_physical_cluster_id(cpu)
(cpu_topology[cpu].cluster_id)
 #define topology_core_id(cpu)          (cpu_topology[cpu].core_id)
 #define topology_core_cpumask(cpu)     (&cpu_topology[cpu].core_sibling)
 #define topology_sibling_cpumask(cpu)  (&cpu_topology[cpu].thread_sibling)


> Please speak to Sudeep who will fill you on the reasoning above.

Yes, Sudeep is next to me but I would prefer to keep the discussion on
the mailing list so everyone can get the reasoning.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
