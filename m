Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbeEWLfG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:35:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39852 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932541AbeEWLfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:35:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE1ED602BC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: <ilialin@codeaurora.org>
To: "'Viresh Kumar'" <viresh.kumar@linaro.org>,
        "'Sudeep Holla'" <sudeep.holla@arm.com>
Cc: "'Viresh Kumar'" <vireshk@kernel.org>, "'Nishanth Menon'" <nm@ti.com>,
        "'Stephen Boyd'" <sboyd@kernel.org>, "'Rob Herring'" <robh@kernel.org>,
        "'Mark Rutland'" <mark.rutland@arm.com>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <1527068454-28921-1-git-send-email-ilialin@codeaurora.org> <1527068454-28921-2-git-send-email-ilialin@codeaurora.org> <3f1ca60e-7aa8-fccc-ab1c-4b7c37731cce@arm.com> <002901d3f286$198878b0$4c996a10$@codeaurora.org> <CAKohponbpErCeTYu9iQm_-dupz5SUr+TKsYXzqmmARB-pq95iA@mail.gmail.com>
In-Reply-To: <CAKohponbpErCeTYu9iQm_-dupz5SUr+TKsYXzqmmARB-pq95iA@mail.gmail.com>
Subject: RE: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
Date: Wed, 23 May 2018 14:34:41 +0300
Message-ID: <002b01d3f28a$0d033900$2709ab00$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHGHkKLWrrdHode7ZinDUAwaNCKTQIQamVJAy14mKwB0DCraALLdumlpAoKy+A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4NBZAiu022478



> -----Original Message-----
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Sent: Wednesday, May 23, 2018 14:31
> To: Ilia Lin <ilialin@codeaurora.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>; Viresh Kumar
> <vireshk@kernel.org>; Nishanth Menon <nm@ti.com>; Stephen Boyd
> <sboyd@kernel.org>; Rob Herring <robh@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; linux-
> pm@vger.kernel.org; devicetree@vger.kernel.org; Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
> 
> On 23 May 2018 at 16:36,  <ilialin@codeaurora.org> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Sudeep Holla <sudeep.holla@arm.com>
> >> Sent: Wednesday, May 23, 2018 13:40
> >> To: Ilia Lin <ilialin@codeaurora.org>; vireshk@kernel.org; nm@ti.com;
> >> sboyd@kernel.org; robh@kernel.org; mark.rutland@arm.com;
> >> rjw@rjwysocki.net; linux-pm@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Cc: Sudeep Holla <sudeep.holla@arm.com>
> >> Subject: Re: [PATCH v10 1/2] cpufreq: Add Kryo CPU scaling driver
> >>
> >>
> >>
> >> On 23/05/18 10:40, Ilia Lin wrote:
> >> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> >> > processors, the CPU frequency subset and voltage value of each OPP
> >> > varies based on the silicon variant in use. Qualcomm Process
> >> > Voltage Scaling Tables defines the voltage and frequency value
> >> > based on the msm-id in SMEM and speedbin blown in the efuse
> combination.
> >> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from
> >> > the SoC to provide the OPP framework with required information.
> >> > This is used to determine the voltage and frequency value for each
> >> > OPP of
> >> > operating-points-v2 table when it is parsed by the OPP framework.
> >> >
> >> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> >>
> >> [...]
> >>
> >> > +   pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> >> > +   if (!IS_ERR(pdev))
> >> > +           return 0;
> >> > +
> >> > +   ret = PTR_ERR(pdev);
> >> > +   dev_err(cpu_dev, "Failed to register platform device\n");
> >> > +
> >> > +free_opp:
> >> > +   for_each_possible_cpu(cpu) {
> >> > +           if (IS_ERR_OR_NULL(opp_tables[cpu]))
> >> > +                   break;
> >> > +           dev_pm_opp_put_supported_hw(opp_tables[cpu]);
> >> > +   }
> >> > +free_np:
> >> > +   of_node_put(np);
> >> > +
> >> > +   return ret;
> >> > +}
> >> > +late_initcall(qcom_cpufreq_kryo_driver_init);
> >>
> >> Any particular reason why this *has* to be late initcall ?
> >> Please change it to module_initcall otherwise.
> >
> > The purpose is to give the cpufreq-dt the time to register the driver and
> only then my driver will add the platform device.
> 
> That isn't required, the device and its driver can be registered in any order.

You are right. I already checked that in the code...
However, with module_init() the driver fails on reading the nvmem.
