Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeDEQQ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:16:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44746 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeDEQQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:16:55 -0400
X-Google-Smtp-Source: AIpwx4/H16jAfGZGlmq89C1fN0hQardthYWqKU5f0PAf5dbyy2jZGQicW6ugsU+eZl2ahIA+R2EWLw==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: viresh.kumar@linaro.org, edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/7] CPU cooling device new strategies
Date: Thu,  5 Apr 2018 18:16:37 +0200
Message-Id: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
  V3:
    - Changed this description to be more clear with the numbers
    - Took into account the comments for the documentation
    - Switched to the smpboot threads to use the hotplug API
    - Removed usage of the waitq as the code relies on the smpboot
    - Removed the macro DEFAULT_IDLE_TIME_US and use directly TICK_USEC
    - Removed the list to store the cooling devices
    - Fixed static for the percpu cpuidle_cooling_tsk
    - Removed the BUG_ON in the cpuidle_cooling_runtime function and return 0
    - Used this_cpu_ptr instead of per_cpu_ptr(smp_processor_id())
    - Moved the function cpuidle_cooling_release closer to its caller
    - Fixed spaces instead of tab
    - Fixed function description log
    - Cancel timer on release
    - Fixed return value doc
    - Changed the initialization so the cpu numbering is no longer a problem
    - Removed useless atomic_set(0)
    - Moved the thermal cooling device creation after the cpuidle cooling device
    - Let the refcount to zero at init
    - Moved the initialization message at the end of the function
    - Changed the cpuidle_cooling_register to return void
    - Removed message in the cpuidle-arm driver if cpuidle_cooling_register fails

  V2:
     - Dropped the cpu combo cooling device
     - Added the acked-by tags
     - Replaced task array by a percpu structure
     - Fixed the copyright dates
     - Fixed the extra lines
     - Fixed the compilation macros to be reused
     - Fixed the list node removal
     - Massaged a couple of function names


The following series provides a new way to cool down a SoC by reducing
the dissipated power on the CPUs. Based on the initial work from Kevin
Wangtao, the series implements a CPU cooling device based on idle
injection, relying on the cpuidle framework.

The patchset is designed to have the current DT binding for the
cpufreq cooling device to be compatible with the new cooling devices.

Different cpu cooling devices can not co-exist on the system, the cpu
cooling device is enabled or not, and one cooling strategy is selected
(cpufreq or cpuidle). It is not possible to have all of them available
at the same time. However, the goal is to enable them all and be able
to switch from one to another at runtime but the thermal framework may
need some attention regarding the mitigation vs switching the cooling
device at runtime.

This series is divided into two parts.

The first part just provides trivial changes for the copyright and
removes an unused field in the cpu freq cooling device structure.

The second part provides the idle injection cooling device, allowing a SoC
without a cpufreq driver to use this cooling device as an alternative.

The cpuidle cooling device has been tested against the cpufreq cooling
in the same conditions: same board and a fan on top of the SoC. For
optimal trade-off between perf vs cooling effect the cpuidle cooling
device acts on one cluster only, for the bL SoC, the big cluster is
idle-mitigated. The targetted temperature is 75°C.

Command:
--------
 time ./dhrystone -t 8 -l 100

                   ------------------------------------------------------
                  |       hikey6220         |         hikey3660          |
                   ------------------------------------------------------
                  |   cpuidle  | cpufreq   ||   cpuidle   |   cpufreq    |
  -----------------------------------------------------------------------
 | DMIPS avg      |       1007 |     922   ||     2279    |       2250   |
  -----------------------------------------------------------------------
 | rtime (sec)    |      1.21  |    1.19   ||       49    |         51   |
  -----------------------------------------------------------------------
 | temp avg (mC)  |      75043 |   74862   ||    75640    |      75978   |
  -----------------------------------------------------------------------
 | temp stddev    |    309.357 |    6205   ||     3258    |       1950   |
  -----------------------------------------------------------------------
 | temp min (mC)  |      74235 |   71880   ||    66395    |      71315   |
  -----------------------------------------------------------------------
 | temp max (mC)  |      75805 |   77375   ||    84640    |      81360   |
  -----------------------------------------------------------------------

We can see the both cooling method have similar behavior in this
configuration.


Daniel Lezcano (7):
  thermal/drivers/cpu_cooling: Fixup the header and copyright
  thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
  thermal/drivers/cpu_cooling: Remove pointless field
  thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
  thermal/drivers/cpu_cooling: Add idle cooling device documentation
  thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
  cpuidle/drivers/cpuidle-arm: Register the cooling device

 Documentation/thermal/cpu-idle-cooling.txt | 166 ++++++++++
 drivers/cpuidle/cpuidle-arm.c              |   3 +
 drivers/thermal/Kconfig                    |  30 +-
 drivers/thermal/cpu_cooling.c              | 508 +++++++++++++++++++++++++++--
 include/linux/cpu_cooling.h                |  12 +-
 5 files changed, 692 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/thermal/cpu-idle-cooling.txt

-- 
2.7.4
