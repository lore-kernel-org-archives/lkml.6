Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeEPNMA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:12:00 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35232 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752205AbeEPNLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:11:54 -0400
X-Google-Smtp-Source: AB8JxZqkrt2mC9hwdsP381ychQLGgym/opPD+O2stjv4NXjXSCbAlgnXGAIGs7wYPesLFjGMTC8noqDwEiUOzmuih/k=
MIME-Version: 1.0
In-Reply-To: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
References: <1526375616-16904-1-git-send-email-ilialin@codeaurora.org>
From: Amit Kucheria <amit.kucheria@linaro.org>
Date: Wed, 16 May 2018 16:11:52 +0300
X-Google-Sender-Auth: qErOgxdUe_NAl82mY9jNw8mUV-k
Message-ID: <CAHLCerOL1R=8jaHT-dKx3xwXVOZhCZMjZwqWYeQtYQsnUZ-NbQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/14] CPU scaling support for msm8996
To: Ilia Lin <ilialin@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>, nm@ti.com, lgirdwood@gmail.com,
        broonie@kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, catalin.marinas@arm.com,
        will.deacon@arm.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, nicolas.dechesne@linaro.org,
        celster@codeaurora.org, tfinkel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 12:13 PM, Ilia Lin <ilialin@codeaurora.org> wrote:
> [v7]
>  * Addressed comments from Viresh about resourses deallocation
>    and DT compatible

Hi Ilia,

Thanks for working on this series. Here a few comments regarding the
series as a whole.

- The series could use a better cover letter describing how the
various patches are grouped. e.g. 1-7 are clock related and probably
will get merged through the clk maintainers tree. The regulator bits
might get merged through the regulator maintainer tree and so forth.
If there are any dependencies, please outline those as well so
maintainers can decide how best to merge this.
- Please describe what features this series adds - just frequency
scaling or more. Please describe in more detail what the dependency on
the SAW regulator changes is.
- Please get rid of the GPL boiler plate since you already have the
SPDX tags. See comments on patch 1 for what I'm referring to.
- You also mention that ACD is not implemented in the earlier patches
and then there is a patch that seems to add ACD related features
(7/14).

A few other comments follow across the individual patches.

Regards,
Amit

> [v6]
>  * Addressed comments from Viresh about:
>  ** Comments style
>  ** Kconfig bool instead of tristate
>  ** DT and documentation style
>  ** Resourses deallocation on an error
>  ** Typos
>
> [v5]
>  * Rebased
>  * Addressed comments from Bjorn about SPDX style,
>    functions and parameters naming
>  * Addressed comments from Viresh DT properties and style, comments style,
>    resourses deallocation, documentation placement
>  * Addressed comments from Sricharan about unnessesary include
>  * Addressed comments from Nicolas
>  * Addressed comments from Rob about the commit messages and acks
>  * Addressed comments from Mark
>
> [v4]
>  * Adressed all comments from Stephen
>  * Added CPU regulator support
>  * Added qcom-cpufreq-kryo driver
>
> [v3]
>  * Rebased on top of the latest PLL driver changes
>  * Addressed comment from Rob Herring for bindings
>
> [v2]
>  * Addressed comments from Rob Herring for bindings
>  * Addressed comments from Mark Rutland for memory barrier
>  * Addressed comments from Julien Thierry for clock reenabling condition
>  * Tuned the HW configuration for clock frequencies below 600MHz
>
> Clocks:
> This series adds support for the CPU clocks on msm8996 devices.
> The driver uses the existing PLL drivers and is required to control
> the CPU frequency scaling on the MSM8996.
>
> Regulators:
> Added SAW regulator support to the SPMI regulator driver. The SAW regulators
> will be controlled through special CPU registers instead of direct
> SPMI accesses.
>
> Cpufreq:
> The qcom-cpufreq-kryo driver is aimed to support different SOC versions.
> The driver reads eFuse information and chooses the required OPP subset
> by passing the OPP supported-hw parameter.
>
> A previous post of RFC can be found here:
> https://patchwork.kernel.org/patch/10398455/
>
> Ilia Lin (11):
>   soc: qcom: Separate kryo l2 accessors from PMU driver
>   clk: qcom: Add CPU clock driver for msm8996
>   clk: qcom: Add DT bindings for CPU clock driver for msm8996
>   clk: qcom: Add ACD path to CPU clock driver for msm8996
>   dt: qcom: Add opp and thermal to the msm8996
>   regulator: qcom_spmi: Add support for SAW
>   dt-bindings: qcom_spmi: Add support for SAW documentation
>   dt: qcom: Add SAW regulator for 8x96 CPUs
>   cpufreq: Add Kryo CPU scaling driver
>   dt-bindings: cpufreq: Document operating-points-v2-kryo-cpu
>   dt: qcom: Add qcom-cpufreq-kryo driver configuration
>
> Rajendra Nayak (3):
>   clk: qcom: Make clk_alpha_pll_configure available to modules
>   clk: qcom: cpu-8996: Add support to switch to alternate PLL
>   clk: qcom: cpu-8996: Add support to switch below 600Mhz
>
>  .../devicetree/bindings/clock/qcom,kryocc.txt      |  17 +
>  .../devicetree/bindings/opp/kryo-cpufreq.txt       | 680 +++++++++++++++++++++
>  .../bindings/regulator/qcom,spmi-regulator.txt     |  45 ++
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 651 +++++++++++++++++++-
>  drivers/clk/clk-fixed-factor.c                     |   2 +-
>  drivers/clk/qcom/Kconfig                           |   9 +
>  drivers/clk/qcom/Makefile                          |   1 +
>  drivers/clk/qcom/clk-alpha-pll.c                   |   1 +
>  drivers/clk/qcom/clk-alpha-pll.h                   |   6 +
>  drivers/clk/qcom/clk-cpu-8996.c                    | 519 ++++++++++++++++
>  drivers/cpufreq/Kconfig.arm                        |  11 +
>  drivers/cpufreq/Makefile                           |   1 +
>  drivers/cpufreq/cpufreq-dt-platdev.c               |   3 +
>  drivers/cpufreq/qcom-cpufreq-kryo.c                | 150 +++++
>  drivers/perf/Kconfig                               |   1 +
>  drivers/perf/qcom_l2_pmu.c                         |  90 +--
>  drivers/regulator/qcom_spmi-regulator.c            | 133 +++-
>  drivers/soc/qcom/Kconfig                           |   3 +
>  drivers/soc/qcom/Makefile                          |   1 +
>  drivers/soc/qcom/kryo-l2-accessors.c               |  65 ++
>  include/soc/qcom/kryo-l2-accessors.h               |  21 +
>  22 files changed, 2332 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,kryocc.txt
>  create mode 100644 Documentation/devicetree/bindings/opp/kryo-cpufreq.txt
>  create mode 100644 drivers/clk/qcom/clk-cpu-8996.c
>  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
>  create mode 100644 drivers/soc/qcom/kryo-l2-accessors.c
>  create mode 100644 include/soc/qcom/kryo-l2-accessors.h
>
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
