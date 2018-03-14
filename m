Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751873AbeCNQ7G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:59:06 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44420 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeCNQ7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:04 -0400
X-Google-Smtp-Source: AG47ELug+m+uqycA7Xh6vcyn0tL8bJlgPnyi22XSxNTokedbyPyIwBNtckMsR+IA3Mw+NPvmLMVO9Q==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/25] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date: Wed, 14 Mar 2018 17:58:10 +0100
Message-Id: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a re-worked version from Lina Iyer's two series [1] that got
posted more than a year ago by now. I have picked up the series and done a
significant re-work of it and here's the result. All patches have been changed,
some have been dropped, some are entirely new. For this reason I decided to not
include a version history, as I think people need a fresh start anyway.

For those few changes that are kind of similar, I have kept Lina's authorship,
the rest are now authored by me.

 - Lina (or anybody else for that matter) please tell if you think I should
   change, in regards to what tag/authorship should be for each commit!

Some background:

Overall this series have been discussed over years at various Linux conferences
and LKML, although let me give a brief introduction and then the rest can be
read in each changelog.

For ARM, the PSCI firmware interface may be managing the power to the CPUs.
Depending on the SoC, CPUs may also be arranged in hierarchical manner, which
could add another level of complexity from a CPU idle management point of view.

PSCI v1.0+ adds support for the so called OS initiated CPU suspend mode, which
enables a more fine grained method, allowing Linux to get more control, in
regards to being energy efficient. This is typically useful for these kind of
complex battery driven platforms.

Now, in principle what is missing today around CPU idle management for these
SoCs arranging CPUs in a hierarchical manner, that is what this series intends
to address.

I could potentially have split the series into two parts, but for completeness
I decided to post it as one. Please tell if want me to change!

 - The first part are changes to generic PM code (genpd, cpu_pm and timers):
   Patch 1 -> Patch 9.

 - The second part, which depends on the first, are changes specific to
   PSCI/ARM64 (psci, of, arm64): Patch 10 -> Patch 25.

The series is based on v4.16-rc5, but applies also as of today to Rafael's
linux-pm.git next branch. The code has been tested on a QCOM 410c dragonboard
and I except that test coverage should be increased by some more boards
shortly (for ARM64 with PSCI OSI support - only a few DT changes are needed).
You may find the code at:

git.linaro.org/people/ulf.hansson/linux-pm.git next


Kind regards
Ulf Hansson

[1]
https://lwn.net/Articles/716300/
https://www.spinics.net/lists/arm-kernel/msg566200.html


Lina Iyer (6):
  PM / Domains: Add generic data pointer to genpd_power_state struct
  timer: Export next wakeup time of a CPU
  dt: psci: Update DT bindings to support hierarchical PSCI states
  cpuidle: dt: Support hierarchical CPU idle states
  drivers: firmware: psci: Support hierarchical CPU idle states
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

Ulf Hansson (19):
  PM / Domains: Don't treat zero found compatible idle states as an
    error
  PM / Domains: Deal with multiple states but no governor in genpd
  PM / Domains: Add support for CPU devices to genpd
  PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
  PM / Domains: Add genpd governor for CPUs
  PM / Domains: Extend genpd CPU governor to cope with QoS constraints
  kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
  of: base: Add of_get_cpu_state_node() to get idle states for a CPU
    node
  drivers: firmware: psci: Split psci_dt_cpu_init_idle()
  drivers: firmware: psci: Simplify error path of psci_dt_init()
  drivers: firmware: psci: Announce support for OS initiated suspend
    mode
  drivers: firmware: psci: Prepare to use OS initiated suspend mode
  drivers: firmware: psci: Share a few internal PSCI functions
  drivers: firmware: psci: Add support for PM domains using genpd
  drivers: firmware: psci: Introduce psci_dt_topology_init()
  drivers: firmware: psci: Try to attach CPU devices to their PM domains
  drivers: firmware: psci: Deal with CPU hotplug when using OSI mode
  MAINTAINERS: Update files for PSCI
  arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI

 Documentation/devicetree/bindings/arm/psci.txt | 156 +++++++++++++++++++++
 MAINTAINERS                                    |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi          |  53 +++++++-
 arch/arm64/kernel/setup.c                      |   3 +
 drivers/base/power/domain.c                    | 156 ++++++++++++++++++++-
 drivers/base/power/domain_governor.c           |  65 ++++++++-
 drivers/cpuidle/dt_idle_states.c               |   5 +-
 drivers/firmware/Makefile                      |   2 +-
 drivers/firmware/psci.c                        | 169 +++++++++++++++++------
 drivers/firmware/psci.h                        |  19 +++
 drivers/firmware/psci_pm_domain.c              | 180 +++++++++++++++++++++++++
 drivers/of/base.c                              |  35 +++++
 include/linux/of.h                             |   8 ++
 include/linux/pm_domain.h                      |  16 +++
 include/linux/psci.h                           |   2 +
 include/linux/tick.h                           |  10 ++
 include/uapi/linux/psci.h                      |   5 +
 kernel/cpu_pm.c                                |  11 ++
 kernel/time/tick-sched.c                       |  11 ++
 19 files changed, 853 insertions(+), 55 deletions(-)
 create mode 100644 drivers/firmware/psci.h
 create mode 100644 drivers/firmware/psci_pm_domain.c

-- 
2.7.4
