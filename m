Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938274AbeBUP3l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:29:41 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46654 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935044AbeBUP3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:29:39 -0500
X-Google-Smtp-Source: AH8x226my6UrBhk3veFmJ4Bh8hpiGyrZ7EcGJHESh2AJ/Emfzf1zEu4XIbQituBLHmx+9TQKz/Tf8Q==
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, daniel.thompson@linaro.org,
        linux-pm@vger.kernel.org
Subject: [PATCH V2 0/7] CPU cooling device new strategies
Date: Wed, 21 Feb 2018 16:29:21 +0100
Message-Id: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:
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
to switch from one to another at runtime but that needs a rework of the
thermal framework which is orthogonal to the feature we are providing.

This series is divided into two parts.

The first part just provides trivial changes for the copyright and
removes an unused field in the cpu freq cooling device structure.

The second part provides the idle injection cooling device, allowing a SoC
without a cpufreq driver to use this cooling device as an alternative.

The preliminary benchmarks show the following changes:

On the hikey6220, dhrystone shows a throughtput increase of 40% for an
increase of the latency of 16% while sysbench shows a latency increase
of 5%.

Initially, the first version provided also the cpuidle + cpufreq combo
cooling device but regarding the latest comments, there is a misfit with
how the cpufreq cooling device and suspend/resume/cpu hotplug/module
loading|unloading behave together while the combo cooling device was
designed assuming the cpufreq cooling device was always there. This
dynamic is investigated and the combo cooling device will be posted
separetely after this series gets merged.

Daniel Lezcano (7):
  thermal/drivers/cpu_cooling: Fixup the header and copyright
  thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
  thermal/drivers/cpu_cooling: Remove pointless field
  thermal/drivers/Kconfig: Convert the CPU cooling device to a choice
  thermal/drivers/cpu_cooling: Add idle cooling device documentation
  thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver
  cpuidle/drivers/cpuidle-arm: Register the cooling device

 Documentation/thermal/cpu-idle-cooling.txt | 165 ++++++++++
 drivers/cpuidle/cpuidle-arm.c              |   5 +
 drivers/thermal/Kconfig                    |  30 +-
 drivers/thermal/cpu_cooling.c              | 480 +++++++++++++++++++++++++++--
 include/linux/cpu_cooling.h                |  15 +-
 5 files changed, 668 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/thermal/cpu-idle-cooling.txt

-- 
2.7.4
