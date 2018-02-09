Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751034AbeBIKRR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 05:17:17 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40546 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeBIKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 05:17:15 -0500
X-Google-Smtp-Source: AH8x227fr+N8qCUofuZkO691We6Nklav+zKD2cYCeBQ3GsSHeXTFBpbdiBUXNIOFy2Adw2AjX+YWs9ykAVxxQXI8js4=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Feb 2018 11:17:14 +0100
X-Google-Sender-Auth: ruvl9VfcTVspWdLF2mdw_ZDANUI
Message-ID: <CAJZ5v0jnvkR9Px0FY5Wqk9N=1-u9p1sguwYQQmeByFaMMu-1tA@mail.gmail.com>
Subject: [GIT PULL] More power management updates for v4.16-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-part2-4.16-rc1

with top-most commit 616f16093d852215f6a1188de1bafdc1f8892924

 Merge branches 'pm-cpufreq', 'pm-cpuidle' and 'pm-domains'

on top of commit 7f3fdd40a7dfaa7405185250974b0fabd08c1f8b

 Merge tag 'pm-4.16-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional power management updates for 4.16-rc1.

These are mostly fixes and cleanups and removal of the no longer
needed at32ap-cpufreq driver.

Specifics:

 - Drop the at32ap-cpufreq driver which is useless after the
   removal of the corresponding arch (Corentin LABBE).

 - Fix a regression from the 4.14 cycle in the APM idle driver by
   making it initialize the polling state properly (Rafael Wysocki).

 - Fix a crash on failing system suspend due to a missing check in
   the cpufreq core (Bo Yan).

 - Make the intel_pstate driver initialize the hardware-managed
   P-state control (HWP) feature on CPU0 upon resume from system
   suspend if HWP had been enabled before the system was suspended
   (Chen Yu).

 - Fix up the SCPI cpufreq driver after recent changes (Sudeep Holla,
   Wei Yongjun).

 - Avoid pointer subtractions during frequency table walks in cpufreq
   (Dominik Brodowski).

 - Avoid the check for ProcFeedback in ST/CZ in the cpufreq driver
   for AMD processors and add a MODULE_ALIAS for cpufreq on ARM IMX
   (Akshu Agrawal, Nicolas Chauvet).

 - Fix the prototype of swsusp_arch_resume() on x86 (Arnd Bergmann).

 - Fix up the parsing of power domains DT data (Ulf Hansson).

Thanks!


---------------

Akshu Agrawal (1):
      cpufreq: AMD: Ignore the check for ProcFeedback in ST/CZ

Arnd Bergmann (1):
      x86: hibernate: fix swsusp_arch_resume() prototype

Bo Yan (1):
      cpufreq: Skip cpufreq resume if it's not suspended

Chen Yu (1):
      cpufreq: intel_pstate: Enable HWP during system resume on CPU0

Corentin LABBE (1):
      cpufreq: remove at32ap-cpufreq

Dominik Brodowski (1):
      cpufreq: Add and use cpufreq_for_each_{valid_,}entry_idx()

Nicolas Chauvet (1):
      arm: imx: Add MODULE_ALIAS for cpufreq

Rafael J. Wysocki (1):
      x86: PM: Make APM idle driver initialize polling state

Sudeep Holla (1):
      cpufreq: scpi: fix static checker warning cdev isn't an ERR_PTR

Ulf Hansson (1):
      PM / domains: Fix up domain-idle-states OF parsing

Wei Yongjun (1):
      cpufreq: scpi: fix error return code in scpi_cpufreq_init()

---------------

 Documentation/cpu-freq/cpu-drivers.txt |   4 ++
 arch/x86/kernel/apm_32.c               |   1 +
 arch/x86/power/hibernate_32.c          |   2 +-
 arch/x86/power/hibernate_64.c          |   2 +-
 drivers/base/power/domain.c            |  76 ++++++++++++--------
 drivers/cpufreq/Kconfig                |  10 ---
 drivers/cpufreq/Makefile               |   1 -
 drivers/cpufreq/amd_freq_sensitivity.c |  11 ++-
 drivers/cpufreq/at32ap-cpufreq.c       | 127 ---------------------------------
 drivers/cpufreq/cpufreq.c              |   3 +
 drivers/cpufreq/exynos5440-cpufreq.c   |   7 +-
 drivers/cpufreq/freq_table.c           |   8 +--
 drivers/cpufreq/imx6q-cpufreq.c        |   1 +
 drivers/cpufreq/intel_pstate.c         |   5 ++
 drivers/cpufreq/longhaul.c             |   4 +-
 drivers/cpufreq/pasemi-cpufreq.c       |   6 +-
 drivers/cpufreq/scpi-cpufreq.c         |   6 +-
 drivers/sh/clk/core.c                  |   5 +-
 drivers/staging/irda/drivers/sh_sir.c  |   4 +-
 include/linux/cpufreq.h                | 125 ++++++++++++++++++++------------
 include/linux/suspend.h                |   2 +
 kernel/power/power.h                   |   3 -
 22 files changed, 170 insertions(+), 243 deletions(-)
