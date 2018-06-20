Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F98AC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20A020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HN4tGITL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20A020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754354AbeFTRWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:22:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38567 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754199AbeFTRWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so478913lfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=2rOnhZC3M8EvYQA2pnS1IS2IzGGNUg71SNxnGjjFgcI=;
        b=HN4tGITLriAPJBOwSUImCbB68VgiP2Xs07VoBelIjZQOv6yV5px2TyapLHwB9f8fRj
         E2obSd5hLORAYOW6hlWz9JUdtvMYnbI3/r07Rpl9vK614YRHNtFvJed12jNUBzdyz4va
         wtsSJKH3Cmv0rqRzccG+W/1zYzJfi+DjdVBxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2rOnhZC3M8EvYQA2pnS1IS2IzGGNUg71SNxnGjjFgcI=;
        b=WbYFo5Jk9zQhmWacOIDiqBQDxqbkX3TEcyCEx+860/ZyTjBtlfVt3NVA+yBfVbLSQP
         6xEPWQVFJ/Mu7pO4XZbXLoTixsmX85XWb6/lPXN4J2wXs+nVxYmLzX28tQ10B10+BJPg
         TLbm9bBSEeagPHqjC15FpDGTmGCkWhjqVoprPrMVgqq4sjzMiQ/WMJfKiUAhkw1/PODA
         5Jh21tmF5PgeLCncgM9HlxjmcdEkDr8XS6a0PbSWdzyNdcwrAO06yIoR/dEdHmc+ozXI
         +s9aKSmmpmgCr+XCRSih+JxJHSlhXV6ezE/YKhM9Oj51/wFsIMLc5FsR4+BP8Qic7Xmq
         pNbw==
X-Gm-Message-State: APt69E0oh847nDVZlAN7XWtBEpUYxzLjauqB23e2PjxirK+ak4xZy6xa
        H9cA6z+tvSnYzjMk5bXPDCj5DRQdP2w=
X-Google-Smtp-Source: ADUXVKIfzTehd4tkt5s4EsEdMBJEYy9Vy7O3YlRtXefLYSfaBNLk8MSa/yz+RiNRihX58JkJ7t6z+A==
X-Received: by 2002:a2e:2917:: with SMTP id u23-v6mr493044lje.130.1529515355349;
        Wed, 20 Jun 2018 10:22:35 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:34 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/26] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date:   Wed, 20 Jun 2018 19:22:00 +0200
Message-Id: <20180620172226.15012-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v8:
 - Added some tags for reviews and acks.
 - Cleanup timer patch (patch6) according to comments from Rafael.
 - Rebased series on top of v4.18rc1 - it applied cleanly, except for patch 5.
 - While adopting patch 5 to new genpd changes, I took the opportunity to
   improve the new function description a bit.
 - Corrected malformed SPDX-License-Identifier in patch20.

Changes in v7:
 - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
   the psci firmware driver to a new firmware subdir and change to force PSCI PC
   mode during boot to cope with kexec'ed booted kernels.
 - Added some maintainers in cc for the timer/nohz patches.
 - Minor update to the new genpd governor, taking into account the state's
   poweroff latency while validating the sleep duration time.
 - Addressed a problem pointed out by Geert Uytterhoeven, around calling
   pm_runtime_get|put() for CPUs that has not been attached to a CPU PM domain.
 - Re-based on Linus' latest master.

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

 - Patch 1 -> Patch 12: The first part are generic changes to genpd, cpu_pm,
   timers, cpuidle and DT. Of course the solution is based on an opt-in method,
   so no users should be affected of any of these changes.

 - Patch 13 -> Patch 26: The second part are changes to PSCI and ARM64, which
   deploys the support for CPU idle management, based upon the new generic
   changes from the first part.

The series is based on v4.18rc1 and the code has been tested on a QCOM 410c
dragonboard. You may find the code at:

git.linaro.org/people/ulf.hansson/linux-pm.git next

Kind regards
Ulf Hansson


Lina Iyer (6):
  PM / Domains: Add generic data pointer to genpd_power_state struct
  timer: Export next wakeup time of a CPU
  dt: psci: Update DT bindings to support hierarchical PSCI states
  cpuidle: dt: Support hierarchical CPU idle states
  drivers: firmware: psci: Support hierarchical CPU idle states
  arm64: dts: Convert to the hierarchical CPU topology layout for
    MSM8916

Ulf Hansson (20):
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
  drivers: firmware: psci: Move psci to separate directory
  MAINTAINERS: Update files for PSCI
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
  arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI

 .../devicetree/bindings/arm/psci.txt          | 156 +++++++++++++++
 MAINTAINERS                                   |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi         |  53 +++++-
 arch/arm64/kernel/setup.c                     |   3 +
 drivers/base/power/domain.c                   | 158 ++++++++++++++-
 drivers/base/power/domain_governor.c          |  67 ++++++-
 drivers/cpuidle/dt_idle_states.c              |   5 +-
 drivers/firmware/Kconfig                      |  15 +-
 drivers/firmware/Makefile                     |   3 +-
 drivers/firmware/psci/Kconfig                 |  13 ++
 drivers/firmware/psci/Makefile                |   4 +
 drivers/firmware/{ => psci}/psci.c            | 174 +++++++++++++----
 drivers/firmware/psci/psci.h                  |  19 ++
 drivers/firmware/{ => psci}/psci_checker.c    |   0
 drivers/firmware/psci/psci_pm_domain.c        | 180 ++++++++++++++++++
 drivers/of/base.c                             |  35 ++++
 include/linux/of.h                            |   8 +
 include/linux/pm_domain.h                     |  16 ++
 include/linux/psci.h                          |   2 +
 include/linux/tick.h                          |   8 +
 include/uapi/linux/psci.h                     |   5 +
 kernel/cpu_pm.c                               |  11 ++
 kernel/time/tick-sched.c                      |  10 +
 23 files changed, 877 insertions(+), 70 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (83%)
 create mode 100644 drivers/firmware/psci/psci.h
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)
 create mode 100644 drivers/firmware/psci/psci_pm_domain.c

-- 
2.17.1

