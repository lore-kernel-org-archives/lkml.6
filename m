Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E36EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D921218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfBAJbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:31:09 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfBAJbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:31:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F08615BE;
        Fri,  1 Feb 2019 01:31:08 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B7513F71E;
        Fri,  1 Feb 2019 01:31:06 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     viresh.kumar@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        nm@ti.com, sboyd@kernel.org, mka@chromium.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dietmar.eggemann@arm.com,
        quentin.perret@arm.com
Subject: [PATCH v3 0/5] Register an Energy Model for Arm reference platforms
Date:   Fri,  1 Feb 2019 09:30:56 +0000
Message-Id: <20190201093101.31869-1-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Energy Model (EM) framework feeds interested subsystems (the
scheduler/EAS as of now) with power costs provided by drivers. Yet, no
driver is actually doing that upstream yet. This series updates a set of
CPUFreq drivers in order to register power costs in the EM framework for
some of the Arm reference platforms for EAS: Hikey960, Juno and TC2.

The series is split as follows:
 - Patch 01 introduces in PM_OPP a helper function which estimates the
   CPU power using the P=CV²f equation also used by IPA. It should be
   noted that this introduces duplicate code with IPA, which will
   eventually be fixed by migrating IPA to using PM_EM. The ideal plan
   would be to do so later, in a separate patch series. I would indeed
   prefer to keep the thermal and CPUFreq discussion separate at this
   stage, if deemed acceptable.
 - Patches 02-04 make use of that PM_OPP helper function from the
   following CPUFreq drivers: cpufreq-dt, scpi-cpufreq and
   arm_big_little.
 - Patch 05 modifies the SCMI cpufreq driver to pass the power costs
   obtained from firmware to PM_EM. This patch is independent from the
   rest of the series.

Changes since v2 (20190130170506.20450-1-quentin.perret@arm.com)
 - Added comment to explain why we check only the dynamic-power-coeff
   property and not voltages in dev_pm_opp_of_register_em() (Viresh)
 - Fixed comments/docstrings of new functions in opp/of.c (Matthias)
 - Added Matthias' Tested-by to patch 01

Changes since v1 (20190128165522.31749-1-quentin.perret@arm.com):
 - Dropped the DT patches that have been queued by Sudeep
 - Introduced dev_pm_opp_of_register_em() helper to check the presence
   of the DT coeff before calling PM_EM (Viresh, Matthias)
 - Coding-style improvements (Viresh, Matthias)

Thanks,
Quentin

Dietmar Eggemann (1):
  cpufreq: arm_big_little: Register an Energy Model

Quentin Perret (4):
  PM / OPP: Introduce a power estimation helper
  cpufreq: dt: Register an Energy Model
  cpufreq: scpi: Register an Energy Model
  cpufreq: scmi: Register an Energy Model

 drivers/cpufreq/arm_big_little.c |  8 +++
 drivers/cpufreq/cpufreq-dt.c     |  8 ++-
 drivers/cpufreq/scmi-cpufreq.c   | 39 ++++++++++++-
 drivers/cpufreq/scpi-cpufreq.c   |  9 ++-
 drivers/opp/of.c                 | 96 ++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h           |  6 ++
 6 files changed, 157 insertions(+), 9 deletions(-)

-- 
2.20.1

