Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDJMZ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:25:56 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:51198 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752586AbeDJMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:25:53 -0400
X-Google-Smtp-Source: AIpwx4/kYFrqYQLuicrdOCO5ldrtkXUXj3vTKYIDv3Bvi/BAcTAwabSjdHz3uK3lVjs5n2/YlcRNeatpN1QzsYHWOs4=
MIME-Version: 1.0
In-Reply-To: <20180410111043.t577a43a3bvjpkc7@lakrids.cambridge.arm.com>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
 <1521046715-30683-21-git-send-email-ulf.hansson@linaro.org>
 <20180314173833.dyu7jtweu233rfi4@lakrids.cambridge.arm.com>
 <CAPDyKFpJQZ87ViwZxX_yBnKPzgRv5YxbLz=qxScBTMCvY6e2vw@mail.gmail.com> <20180410111043.t577a43a3bvjpkc7@lakrids.cambridge.arm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Apr 2018 14:25:52 +0200
Message-ID: <CAPDyKFrVNtv6Z3r5DkVXVooszyJTqaBxwg9wm94aw7v3SyA4tg@mail.gmail.com>
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

On 10 April 2018 at 13:10, Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, Apr 10, 2018 at 09:19:26AM +0200, Ulf Hansson wrote:
>> On 14 March 2018 at 18:38, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Wed, Mar 14, 2018 at 05:58:30PM +0100, Ulf Hansson wrote:
>> >> In case the hierarchical layout is used in DT, we want to initialize the
>> >> corresponding PM domain topology for the CPUs, by using the generic PM
>> >> domain (aka genpd) infrastructure.
>> >>
>> >> At first glance, it may seem feasible to hook into the existing
>> >> psci_dt_init() function, although because it's called quite early in the
>> >> boot sequence, allocating the dynamic data structure for a genpd doesn't
>> >> work.
>> >>
>> >> Therefore, let's export a new init function for PSCI,
>> >> psci_dt_topology_init(), which the ARM machine code should call from a
>> >> suitable initcall.
>> >>
>> >> Succeeding to initialize the PM domain topology, which means at least one
>> >> instance of a genpd becomes created, allows us to continue to enable the
>> >> PSCI OS initiated mode for the platform. If everything turns out fine,
>> >> let's print a message in log to inform the user about the changed mode.
>> >>
>> >> In case of any failures, we stick to the default PSCI Platform Coordinated
>> >> mode.
>> >
>> > For kexec/kdump we'll need to explicitly set the suspend mode to
>> > platform coordinated if for whatever reason we choose not to use OSI.
>>
>> Could you please elaborate on this? I am not really understanding what
>> you are suggesting me to do and why.
>
> Sorry for not being clear.
>
> What I'd like to see is that we always call SET_SUSPEND_MODE before
> invoking CPU_SUSPEND. Either deciding early if we can use OSI, or always
> setting it to platform co-ordinated early on in boot and later switching
> it over.
>
> That way we can be sure of the suspend mode, even if we've kexec'd from
> a kernel that had fiddled with it.

Right, good point. Let's me update the patch to deal with that.

One thing though, kexec from a "new" kernel having OSI mode enabled
into an "old" kernel that doesn't even have the new OSI mode support
in psci driver, is going to be difficult to deal with.
On the other hand I guess that isn't a very important usecase we need
to cover, or is it?

[...]

Kind regards
Uffe
