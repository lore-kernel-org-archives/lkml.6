Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932190AbeENNMN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:12:13 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43238 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932123AbeENNMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:12:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D4F1560A00
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilialin@codeaurora.org
From: Ilia Lin <ilialin@codeaurora.org>
To: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, viresh.kumar@linaro.org, nm@ti.com,
        lgirdwood@gmail.com, broonie@kernel.org, andy.gross@linaro.org,
        david.brown@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com,
        rjw@rjwysocki.net, linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rnayak@codeaurora.org, ilialin@codeaurora.org,
        amit.kucheria@linaro.org, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Subject: [PATCH v6 00/14] CPU scaling support for msm8996
Date: Mon, 14 May 2018 16:11:46 +0300
Message-Id: <1526303520-5843-1-git-send-email-ilialin@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[v6]
 * Addressed comments from Viresh about:
 ** Comments style
 ** Kconfig bool instead of tristate
 ** DT and documentation style
 ** Resourses deallocation on an error
 ** Typos

[v5]
 * Rebased
 * Addressed comments from Bjorn about SPDX style,
   functions and parameters naming
 * Addressed comments from Viresh DT properties and style, comments style,
   resourses deallocation, documentation placement
 * Addressed comments from Sricharan about unnessesary include
 * Addressed comments from Nicolas
 * Addressed comments from Rob about the commit messages and acks
 * Addressed comments from Mark

[v4]
 * Adressed all comments from Stephen
 * Added CPU regulator support
 * Added qcom-cpufreq-kryo driver

[v3]
 * Rebased on top of the latest PLL driver changes
 * Addressed comment from Rob Herring for bindings

[v2]
 * Addressed comments from Rob Herring for bindings
 * Addressed comments from Mark Rutland for memory barrier
 * Addressed comments from Julien Thierry for clock reenabling condition
 * Tuned the HW configuration for clock frequencies below 600MHz

Clocks:
This series adds support for the CPU clocks on msm8996 devices.
The driver uses the existing PLL drivers and is required to control
the CPU frequency scaling on the MSM8996.

Regulators:
Added SAW regulator support to the SPMI regulator driver. The SAW regulators
will be controlled through special CPU registers instead of direct
SPMI accesses.

Cpufreq:
The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
The driver reads eFuse information and chooses the required OPP subset
by passing the OPP supported-hw parameter.

A previous post of RFC can be found here:
https://patchwork.kernel.org/patch/10377887/

Ilia Lin (11):
  soc: qcom: Separate kryo l2 accessors from PMU driver
  clk: qcom: Add CPU clock driver for msm8996
  clk: qcom: Add DT bindings for CPU clock driver for msm8996
  clk: qcom: Add ACD path to CPU clock driver for msm8996
  dt: qcom: Add opp and thermal to the msm8996
  regulator: qcom_spmi: Add support for SAW
  dt-bindings: qcom_spmi: Add support for SAW documentation
  dt: qcom: Add SAW regulator for 8x96 CPUs
  cpufreq: Add Kryo CPU scaling driver
  dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu
  dt: qcom: Add qcom-cpufreq-kryo driver configuration

Rajendra Nayak (3):
  clk: qcom: Make clk_alpha_pll_configure available to modules
  clk: qcom: cpu-8996: Add support to switch to alternate PLL
  clk: qcom: cpu-8996: Add support to switch below 600Mhz

 .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
 .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
 .../bindings/regulator/qcom,spmi-regulator.txt     |  45 ++
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |   2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 650 +++++++++++++++++++-
 drivers/clk/clk-fixed-factor.c                     |   2 +-
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clk-alpha-pll.c                   |   1 +
 drivers/clk/qcom/clk-alpha-pll.h                   |   6 +
 drivers/clk/qcom/clk-cpu-8996.c                    | 519 ++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
 drivers/cpufreq/qcom-cpufreq-kryo.c                | 148 +++++
 drivers/perf/Kconfig                               |   1 +
 drivers/perf/qcom_l2_pmu.c                         |  90 +--
 drivers/regulator/qcom_spmi-regulator.c            | 133 +++-
 drivers/soc/qcom/Kconfig                           |   3 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/kryo-l2-accessors.c               |  65 ++
 include/soc/qcom/kryo-l2-accessors.h               |  21 +
 22 files changed, 2329 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
 create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
 create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
 create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
 create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
 create mode 100644 include/soc/qcom/kryo-l2-accessors.h

-- 
1.9.1
