Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeB0OHn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:07:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:52118 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753133AbeB0OHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:07:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29F9060285
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sricharan@codeaurora.org
From: Sricharan R <sricharan@codeaurora.org>
To: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, robh@kernel.org, sricharan@codeaurora.org,
        linux@arm.linux.org.uk
Subject: [PATCH v8 00/15] Krait clocks + Krait CPUfreq
Date: Tue, 27 Feb 2018 19:36:47 +0530
Message-Id: <1519740422-3835-1-git-send-email-sricharan@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v8]
  * Fixed a bug in path#14 pointed out by Viresh and also added tags.
    No change in any other patch.

[v7]
  * Fixed comments from Viresh for cleaning up the error handling
    in qcom-cpufreq.c. Also changed the init function to lateinit
    call. This is required because nvmem which gets initialised with
    module_init needs to go first.
  * Fixed Rob's comments for bindings documentation
  * Fixed kbuild build issue in clk-lpc32xx.c
  * Rebased on top of clk-next

[v6]
  * Adrressed comments from Viresh for patch #14 in v5 [5]
  * Introduced a new binding operating-points-v2-krait-cpu
    as per discussion with Rob
  * Added Review tags

[v5]
  * Addressed comments from Rob for bindings
  * Addressed comments from Viresh to use dev_pm_opp_set_prop_name, accordingly
    dropped patch #12 and corrected patch #11 from previous patch set in [4]
  * Converted to use #spdx tags for newly introduced files

Mostly a resend of the v3 posted by Stephen quite some time back [1]
except for few changes.
  Based on reading some feedback from list,
  * Dropped the patch "clk: Add safe switch hook" from v3 [2].
    Now this is taken care by patch#10 in this series only for Krait.
  * Dropped the path "clk: Avoid sending high rates to downstream
		      clocks during set_rate" from v3 [3].
  * Rebased on top of clk-next.
  * Dropped the DT update from the series. Will send separately
  * Now with cpufreq-dt+opp supporting voltage scaling, registering the
    krait cpu supplies in DT should be sufficient. But one issue is,
    the qcom-cpufreq drivers reads the efuse and based on that registers
    the opp data and then registers the cpufreq-dt device. So when
    cpufreq-dt driver probes and registers the regulator to the OPP framework,
    it expects that the opp data for the device should not be registered before
    the regulator. Will send a RFC patch removing that check, to find out the
    right way of doing it.

These patches provide cpufreq scaling on devices with Krait CPUs.
In Krait CPU designs there's one PLL and two muxes per CPU, allowing
us to switch CPU frequencies independently.

				 secondary
	 +-----+                    +
	 | QSB |-------+------------|\
	 +-----+       |            | |-+
		       |    +-------|/  |
		       |    |       +   |
	 +-----+       |    |           |
	 | PLL |----+-------+           |   primary
	 +-----+    |  |                |     +
		    |  |                +-----|\       +------+
	 +-------+  |  |                      | \      |      |
	 | HFPLL |----------+-----------------|  |-----| CPU0 |
	 +-------+  |  |    |                 |  |     |      |
		    |  |    | +-----+         | /      +------+
		    |  |    +-| / 2 |---------|/
		    |  |      +-----+         +
		    |  |         secondary
		    |  |            +
		    |  +------------|\
		    |               | |-+
		    +---------------|/  |   primary
				    +   |     +
					+-----|\       +------+
	 +-------+                            | \      |      |
	 | HFPLL |----------------------------|  |-----| CPU1 |
	 +-------+          |                 |  |     |      |
			    | +-----+         | /      +------+
			    +-| / 2 |---------|/
			      +-----+         +

To support this in the common clock framework we model the muxes,
dividers, and PLLs as different clocks. CPUfreq only interacts
with the primary mux (farthest right in the diagram). When CPUfreq
sets a rate, the mux code finds the best parent that can provide the rate.
Due to the design, QSB and the top PLL are always a fixed rate and thus
only support one frequency each. These sources provide the lowest
frequencies for the CPUs. The HFPLLs are where we can make the CPU go
faster (GHz range). Sometimes we need to run the HFPLL twice as
fast and divide it by two to get a particular frequency.

When switching rates we can't leave the CPU clocked by the HFPLL because
we need to turn off the output of the PLL when changing its frequency.
This means we have to switch over to the secondary mux and use one of the
fixed sources. This is why we need something like the safe parent patch.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332607.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332615.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332608.html
[4] https://lwn.net/Articles/740994/ 
[5] https://lkml.org/lkml/2017/12/19/537

Sricharan R (2):
  clk: qcom: Add safe switch hook for krait mux clocks
  dt-bindings: cpufreq: Document operating-points-v2-krait-cpu

Stephen Boyd (13):
  ARM: Add Krait L2 register accessor functions
  clk: mux: Split out register accessors for reuse
  clk: qcom: Add support for High-Frequency PLLs (HFPLLs)
  clk: qcom: Add HFPLL driver
  dt-bindings: clock: Document qcom,hfpll
  clk: qcom: Add MSM8960/APQ8064's HFPLLs
  clk: qcom: Add IPQ806X's HFPLLs
  clk: qcom: Add support for Krait clocks
  clk: qcom: Add KPSS ACC/GCC driver
  dt-bindings: arm: Document qcom,kpss-gcc
  clk: qcom: Add Krait clock controller driver
  dt-bindings: clock: Document qcom,krait-cc
  cpufreq: Add module to register cpufreq on Krait CPUs

 .../devicetree/bindings/arm/msm/qcom,kpss-acc.txt  |   7 +
 .../devicetree/bindings/arm/msm/qcom,kpss-gcc.txt  |  32 ++
 .../devicetree/bindings/clock/qcom,hfpll.txt       |  46 +++
 .../devicetree/bindings/clock/qcom,krait-cc.txt    |  22 ++
 .../devicetree/bindings/cpufreq/krait-cpufreq.txt  | 363 +++++++++++++++++++
 arch/arm/common/Kconfig                            |   3 +
 arch/arm/common/Makefile                           |   1 +
 arch/arm/common/krait-l2-accessors.c               |  48 +++
 arch/arm/include/asm/krait-l2-accessors.h          |  10 +
 drivers/clk/clk-mux.c                              |  74 ++--
 drivers/clk/nxp/clk-lpc32xx.c                      |  21 +-
 drivers/clk/qcom/Kconfig                           |  28 ++
 drivers/clk/qcom/Makefile                          |   5 +
 drivers/clk/qcom/clk-hfpll.c                       | 244 +++++++++++++
 drivers/clk/qcom/clk-hfpll.h                       |  45 +++
 drivers/clk/qcom/clk-krait.c                       | 126 +++++++
 drivers/clk/qcom/clk-krait.h                       |  41 +++
 drivers/clk/qcom/gcc-ipq806x.c                     |  82 +++++
 drivers/clk/qcom/gcc-msm8960.c                     | 172 +++++++++
 drivers/clk/qcom/hfpll.c                           |  96 +++++
 drivers/clk/qcom/kpss-xcc.c                        |  87 +++++
 drivers/clk/qcom/krait-cc.c                        | 397 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |  10 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   5 +
 drivers/cpufreq/qcom-cpufreq.c                     | 181 ++++++++++
 include/dt-bindings/clock/qcom,gcc-msm8960.h       |   2 +
 include/linux/clk-provider.h                       |   6 +
 28 files changed, 2111 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-gcc.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,hfpll.txt
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,krait-cc.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/krait-cpufreq.txt
 create mode 100644 arch/arm/common/krait-l2-accessors.c
 create mode 100644 arch/arm/include/asm/krait-l2-accessors.h
 create mode 100644 drivers/clk/qcom/clk-hfpll.c
 create mode 100644 drivers/clk/qcom/clk-hfpll.h
 create mode 100644 drivers/clk/qcom/clk-krait.c
 create mode 100644 drivers/clk/qcom/clk-krait.h
 create mode 100644 drivers/clk/qcom/hfpll.c
 create mode 100644 drivers/clk/qcom/kpss-xcc.c
 create mode 100644 drivers/clk/qcom/krait-cc.c
 create mode 100644 drivers/cpufreq/qcom-cpufreq.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
