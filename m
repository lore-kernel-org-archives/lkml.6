Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeDJHTb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 03:19:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:35045 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbeDJHT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 03:19:28 -0400
X-Google-Smtp-Source: AIpwx4/WbL+W0P9oERLk1644EXGlvCZGARrGiUUnb6g3mX1K6306mYcQ37H5Pl4CMmgN1sJcYg/8aEz7FC9KbrQhg5A=
MIME-Version: 1.0
In-Reply-To: <20180314173833.dyu7jtweu233rfi4@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-21-git-send-email-ulf.hansson@linaro.org> <20180314173833.dyu7jtweu233rfi4@lakrids.cambridge.arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Apr 2018 09:19:26 +0200
Message-ID: <CAPDyKFpJQZ87ViwZxX_yBnKPzgRv5YxbLz=qxScBTMCvY6e2vw@mail.gmail.com>
Subject: Re: [PATCH v6 20/25] drivers: firmware: psci: Introduce psci_dt_topology_init()
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 March 2018 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
> On Wed, Mar 14, 2018 at 05:58:30PM +0100, Ulf Hansson wrote:
>> In case the hierarchical layout is used in DT, we want to initialize the
>> corresponding PM domain topology for the CPUs, by using the generic PM
>> domain (aka genpd) infrastructure.
>>
>> At first glance, it may seem feasible to hook into the existing
>> psci_dt_init() function, although because it's called quite early in the
>> boot sequence, allocating the dynamic data structure for a genpd doesn't
>> work.
>>
>> Therefore, let's export a new init function for PSCI,
>> psci_dt_topology_init(), which the ARM machine code should call from a
>> suitable initcall.
>>
>> Succeeding to initialize the PM domain topology, which means at least one
>> instance of a genpd becomes created, allows us to continue to enable the
>> PSCI OS initiated mode for the platform. If everything turns out fine,
>> let's print a message in log to inform the user about the changed mode.
>>
>> In case of any failures, we stick to the default PSCI Platform Coordinated
>> mode.
>
> For kexec/kdump we'll need to explicitly set the suspend mode to
> platform coordinated if for whatever reason we choose not to use OSI.

Could you please elaborate on this? I am not really understanding what
you are suggesting me to do and why.

>
>>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/firmware/psci.c | 31 +++++++++++++++++++++++++++++++
>>  include/linux/psci.h    |  2 ++
>>  2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 463f78c..45d55fc 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -723,6 +723,37 @@ int __init psci_dt_init(void)
>>       return ret;
>>  }
>>
>> +int __init psci_dt_topology_init(void)
>> +{
>> +     struct device_node *np;
>> +     int ret;
>> +
>> +     if (!psci_has_osi_support())
>> +             return 0;
>> +
>> +     np = of_find_matching_node_and_match(NULL, psci_of_match, NULL);
>> +     if (!np)
>> +             return -ENODEV;
>> +
>> +     /* Initialize the CPU PM domains based on topology described in DT. */
>> +     ret = psci_dt_init_pm_domains(np);
>> +     if (ret <= 0)
>> +             goto out;
>> +
>> +     /* Enable OSI mode. */
>> +     ret = invoke_psci_fn(PSCI_1_0_FN_SET_SUSPEND_MODE,
>> +                          PSCI_1_0_SUSPEND_MODE_OSI, 0, 0);
>
> IIUC, this patch will need to be moved after the subsequent two patches
> to ensure that this series bisects cleanly.

Actually not.

$subject patch adds a new init function, which purpose is to
initialize the PSCI PM domains. At this point none is calling it.

The following changes, builds on top, making it possible to add CPU
devices to the PSCI PM domains (if the PM domains has been created and
OSI mode successfully enabled) and also to properly deal CPU hotplug
when OSI mode is enabled.

The purpose doing it this way is to keep changes small and
review-able, but in principle I can squash 20, 21 and 22 - if you
prefer.

Again, thanks for reviewing!

Kind regards
Uffe
