Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeC1Wmh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:42:37 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:20385 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753423AbeC1Wmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:42:35 -0400
Subject: Re: [PATCH v3 0/8] ARM: davinci: complete the conversion to using the
 reset framework
To: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180327092031.11251-1-brgl@bgdev.pl>
From: Suman Anna <s-anna@ti.com>
Message-ID: <c57f0342-3690-1d07-35c1-6e12beae9462@ti.com>
Date: Wed, 28 Mar 2018 17:41:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327092031.11251-1-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 03/27/2018 04:20 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> This series converts the only user of the handcoded, mach-specific reset
> routines in the davinci platform to using the reset framework.
> 
> Patches 1-3 add necessary lookups/DT-properties.
> 
> Patches 4-6 fix issues found in the remoteproc davinci driver.

Can you pick up patches 4 through 6 for 4.17 itself through the
remoteproc tree? They can be picked up independent of the CCF
conversion. Anyway, the actual CCF conversion and the reset framework
adaptation patch would need the dts patches to be picked up first to
maintain functionality, and I do not think Sekhar is picking up the dts
changes for 4.17 this late.

regards
Suman

> 
> Patch 7 converts the davinci-rproc driver to the reset framework.
> 
> Patch 8 removes now dead code.
> 
> Philipp: it turned out that it's indeed better to use the reset
> controller's device name for the entry lookup.
> 
> Tested both in DT and legacy modes by booting the examples from
> ti-ipc-rtos recipe in meta-ti.
> 
> This series applies on top of David Lechner's common-clk-v9 branch[1]
> with Philipp Zabel's reset/next branch[2] pulled in.
> 
> It can be found in my github tree as well[3].
> 
> [1] git://github.com/dlech/ev3dev-kernel.git common-clk-v9
> [2] git://git.pengutronix.de/git/pza/linux reset/next
> [3] git@github.com:brgl/linux.git topic/davinci-reset
> 
> v1 -> v2:
> - fixed the device tree patches the descriptions of which were mixed up
> - return -EPROBE_DEFER from davinci-rproc's probe() if we can't get the
>   reset provider, since it's possible that the lookup table was not yet
>   registered
> - made the local variable naming consistent in the davinci-rproc driver
> - fixed a typo in PATCH 5/8
> 
> v2 -> v3:
> - reworded the commit messages (s/remoteproc: da8xx/remoteproc\/davinci/)
> - call clk_disable_unprepare() if reset_control_deassert() fails in
>   da8xx_rproc_start()
> - added a patch fixing the S_IRUGO checkpatch warning, since we're
>   already modifying this driver anyway
> - added a temp variable for code brevity in da8xx_rproc_stop()
> - removed patch 1/8 (already applied to reset/next)
> 
> Bartosz Golaszewski (8):
>   ARM: davinci: dts: make psc0 a reset provider
>   ARM: davinci: dts: add a reset control to the dsp node
>   clk: davinci: add a reset lookup table for psc0
>   remoteproc/davinci: add the missing retval check for clk_enable()
>   remoteproc/davinci: prepare and unprepare the clock where needed
>   remoteproc/davinci: use octal permissions for module_param()
>   remoteproc/davinci: use the reset framework
>   clk: davinci: kill davinci_clk_reset_assert/deassert()
> 
>  arch/arm/boot/dts/da850.dtsi               |  2 ++
>  arch/arm/mach-davinci/include/mach/clock.h | 21 --------------
>  drivers/clk/davinci/psc-da850.c            |  7 +++++
>  drivers/clk/davinci/psc.c                  | 19 +------------
>  drivers/remoteproc/da8xx_remoteproc.c      | 45 ++++++++++++++++++++++++------
>  5 files changed, 47 insertions(+), 47 deletions(-)
>  delete mode 100644 arch/arm/mach-davinci/include/mach/clock.h
> 
