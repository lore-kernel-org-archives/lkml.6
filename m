Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932611AbeEWLbL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:31:11 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37807 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932071AbeEWLbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:31:08 -0400
X-Google-Smtp-Source: ADUXVKKjWxE66Wdn5f4aQ4fvvuBCbR5GSn1NFCknssIzC2Xsfjnp7RfD6DzD0TFdG/Uu/PjWufXOIm5dwwIB0Q5VYMw=
MIME-Version: 1.0
In-Reply-To: <002901d3f286$198878b0$4c996a10$@codeaurora.org>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org>
 <1527068454-28921-2-git-send-email-ilialin@codeaurora.org>
 <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com> <002901d3f286$198878b0$4c996a10$@codeaurora.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 23 May 2018 17:01:07 +0530
Message-ID: <CAKohponbpErCeTYu9iQm_-dupz5SUr+TKsYXzqmmARB-pq95iA@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2018 at 16:36,  <ilialin@codeaurora.org> wrote:
>
>
>> -----Original Message-----
>> From: Sudeep Holla <sudeep.holla@arm.com>
>> Sent: Wednesday, May 23, 2018 13:40
>> To: Ilia Lin <ilialin@codeaurora.org>; vireshk@kernel.org; nm@ti.com;
>> sboyd@kernel.org; robh@kernel.org; mark.rutland@arm.com;
>> rjw@rjwysocki.net; linux-pm@vger.kernel.org; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
>>
>>
>>
>> On 23/05/18 10:40, Ilia Lin wrote:
>> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
>> > processors, the CPU frequency subset and voltage value of each OPP
>> > varies based on the silicon variant in use. Qualcomm Process Voltage
>> > Scaling Tables defines the voltage and frequency value based on the
>> > msm-id in SMEM and speedbin blown in the efuse combination.
>> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the
>> > SoC to provide the OPP framework with required information.
>> > This is used to determine the voltage and frequency value for each OPP
>> > of
>> > operating-points-v2 table when it is parsed by the OPP framework.
>> >
>> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
>>
>> [...]
>>
>> > +   pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
>> > +   if (!IS_ERR(pdev))
>> > +           return 0;
>> > +
>> > +   ret = PTR_ERR(pdev);
>> > +   dev_err(cpu_dev, "Failed to register platform device\n");
>> > +
>> > +free_opp:
>> > +   for_each_possible_cpu(cpu) {
>> > +           if (IS_ERR_OR_NULL(opp_tables[cpu]))
>> > +                   break;
>> > +           dev_pm_opp_put_supported_hw(opp_tables[cpu]);
>> > +   }
>> > +free_np:
>> > +   of_node_put(np);
>> > +
>> > +   return ret;
>> > +}
>> > +late_initcall(qcom_cpufreq_kryo_driver_init);
>>
>> Any particular reason why this *has* to be late initcall ?
>> Please change it to module_initcall otherwise.
>
> The purpose is to give the cpufreq-dt the time to register the driver and only then my driver will add the platform device.

That isn't required, the device and its driver can be registered in any order.
