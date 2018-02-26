Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeBZBmr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 20:42:47 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:44848 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751928AbeBZBmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 20:42:44 -0500
X-Google-Smtp-Source: AG47ELvYKOjrRKjGpWIuV9gMN78P1uI/pgv6l6zHkO/tBFgK//R7FWsKGPcK86I+6/mbD8Iuip0a+dmkzcPNyNbjcxM=
MIME-Version: 1.0
In-Reply-To: <201802242125.tZtjoLkn%fengguang.wu@intel.com>
References: <b0c82288ac8594b501191dfc5b5b320c04079725.1519356443.git.baolin.wang@linaro.org>
 <201802242125.tZtjoLkn%fengguang.wu@intel.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 26 Feb 2018 09:42:43 +0800
Message-ID: <CAMz4kuJpMC=S0onkH2FE_bbA3SF5v5Ka6bj4P7QyODKh-MMqxw@mail.gmail.com>
Subject: Re: [PATCH v3] power: reset: Add Spreadtrum SC27xx PMIC power off support
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 24 February 2018 at 21:06, kbuild test robot <lkp@intel.com> wrote:
> Hi Baolin,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on power-supply/for-next]
> [also build test ERROR on v4.16-rc2 next-20180223]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/power-reset-Add-Spreadtrum-SC27xx-PMIC-power-off-support/20180224-195742
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git for-next
> config: tile-allmodconfig (attached as .config)
> compiler: tilegx-linux-gcc (GCC) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=tile
>
> All errors (new ones prefixed by >>):
>
>    drivers/power/reset/sc27xx-poweroff.c: In function 'sc27xx_poweroff_shutdown':
>>> drivers/power/reset/sc27xx-poweroff.c:32:2: error: implicit declaration of function 'freeze_secondary_cpus'; did you mean 'online_secondary'? [-Werror=implicit-function-declaration]
>      freeze_secondary_cpus(cpu);
>      ^~~~~~~~~~~~~~~~~~~~~
>      online_secondary
>    cc1: some warnings being treated as errors
>
> vim +32 drivers/power/reset/sc27xx-poweroff.c
>
>     18
>     19  /*
>     20   * On Spreadtrum platform, we need power off system through external SC27xx
>     21   * series PMICs, and it is one similar SPI bus mapped by regmap to access PMIC,
>     22   * which is not fast io access.
>     23   *
>     24   * So before stopping other cores, we need release other cores' resource by
>     25   * taking cpus down to avoid racing regmap or spi mutex lock when poweroff
>     26   * system through PMIC.
>     27   */
>     28  void sc27xx_poweroff_shutdown(void)
>     29  {
>     30          int cpu = smp_processor_id();
>     31
>   > 32          freeze_secondary_cpus(cpu);
>     33  }

Sorry, I understood the issue now, since the freeze_secondary_cpus()
is under CONFIG_PM_SLEEP_SMP macro. So I think I should add
CONFIG_PM_SLEEP_SMP macro in sc27xx_poweroff_shutdown() in next
version. Thanks.

-- 
Baolin.wang
Best Regards
