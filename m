Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933870AbeCGRJd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:09:33 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41006 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeCGRJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:09:29 -0500
X-Google-Smtp-Source: AG47ELuhaDLUCIuv9iKx/kdmflsOiuWJ4pmiNeMN5AuXW2rg4PGTq1BxNsTa8NUrBGwfv6vsIxdcJA==
Date: Wed, 7 Mar 2018 09:09:25 -0800
From: Eduardo Valentin <edubezval@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH V2 0/7] CPU cooling device new strategies
Message-ID: <20180307170923.GA6543@localhost.localdomain>
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w27H9bxX015612

Hello Daniel,

On Wed, Feb 21, 2018 at 04:29:21PM +0100, Daniel Lezcano wrote:
> Changelog:
>   V2:
>      - Dropped the cpu combo cooling device
>      - Added the acked-by tags
>      - Replaced task array by a percpu structure
>      - Fixed the copyright dates
>      - Fixed the extra lines
>      - Fixed the compilation macros to be reused
>      - Fixed the list node removal
>      - Massaged a couple of function names
> 
> 
> The following series provides a new way to cool down a SoC by reducing
> the dissipated power on the CPUs. Based on the initial work from Kevin
> Wangtao, the series implements a CPU cooling device based on idle
> injection, relying on the cpuidle framework.

Nice! Glad to see that Linaro took this work again. I have a few
questions, as follows.

> 
> The patchset is designed to have the current DT binding for the
> cpufreq cooling device to be compatible with the new cooling devices.
> 
> Different cpu cooling devices can not co-exist on the system, the cpu
> cooling device is enabled or not, and one cooling strategy is selected
> (cpufreq or cpuidle). It is not possible to have all of them available
> at the same time. However, the goal is to enable them all and be able
> to switch from one to another at runtime but that needs a rework of the
> thermal framework which is orthogonal to the feature we are providing.
> 

Can you please elaborate on the limitations you found? Please be more
specific.

> This series is divided into two parts.
> 
> The first part just provides trivial changes for the copyright and
> removes an unused field in the cpu freq cooling device structure.
> 

Ok..

> The second part provides the idle injection cooling device, allowing a SoC
> without a cpufreq driver to use this cooling device as an alternative.
> 

which is awesome!


> The preliminary benchmarks show the following changes:
> 
> On the hikey6220, dhrystone shows a throughtput increase of 40% for an
> increase of the latency of 16% while sysbench shows a latency increase
> of 5%.

I don't follow these numbers. Throughput increase while injecting idle?
compared to what? percentages of what? Please be more specific to better
describer your work..

> 
> Initially, the first version provided also the cpuidle + cpufreq combo
> cooling device but regarding the latest comments, there is a misfit with
> how the cpufreq cooling device and suspend/resume/cpu hotplug/module
> loading|unloading behave together while the combo cooling device was
> designed assuming the cpufreq cooling device was always there. This
> dynamic is investigated and the combo cooling device will be posted
> separetely after this series gets merged.

Yeah, this is one of the confusing parts. Could you please
remind us of the limitations here? Why can't we enable CPUfreq
on higher trip points and CPUidle on lower trip points, for example?
Specially from a system design point of view, the system engineer
typically would benefit of idle injections to achieve overall
average CPU frequencies in a more granular fashion, for example,
achieving performance vs. cooling between available real
frequencies, avoiding real switches.

Also, there is a major design question here. After Linaro's attempt
to send a cpufreq+cpuidle cooling device(s), there was an attempt
to generalize and extend intel powerclamp driver. Do you mind
explaining why refactoring intel powerclamp is not possible? Basic
idea is the same, no?



> 
> Daniel Lezcano (7):
>   thermal/drivers/cpu_cooling: Fixup the header and copyright
>   thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
>   thermal/drivers/cpu_cooling: Remove pointless field
>   thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
>   thermal/drivers/cpu_cooling: Add idle cooling device documentation
>   thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
>   cpuidle/drivers/cpuidle-arm: Register the cooling device
> 
>  Documentation/thermal/cpu-idle-cooling.txt | 165 ++++++++++
>  drivers/cpuidle/cpuidle-arm.c              |   5 +
>  drivers/thermal/Kconfig                    |  30 +-
>  drivers/thermal/cpu_cooling.c              | 480 +++++++++++++++++++++++++++--
>  include/linux/cpu_cooling.h                |  15 +-
>  5 files changed, 668 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/thermal/cpu-idle-cooling.txt
> 
> -- 
> 2.7.4
> 
