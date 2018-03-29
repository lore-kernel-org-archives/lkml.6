Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeC2LLE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 07:11:04 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:16339 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751179AbeC2LLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 07:11:03 -0400
X-IronPort-AV: E=Sophos;i="5.48,376,1517900400";
   d="scan'208";a="10628981"
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <thierry.reding@gmail.com>, <shc_work@mail.ru>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <corbet@lwn.net>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>
CC: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 0/9] extend PWM framework to support PWM modes
Date: Thu, 29 Mar 2018 14:10:26 +0300
Message-ID: <1522321835-6460-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please give feedback on these patches which extends the PWM framework in
order to support multiple PWM modes of operations. This series is a rework
of [1] and [2].

The current patch series add the following PWM modes:
- PWM mode normal
- PWM mode complementary
- PWM mode push-pull

Normal mode - for PWM channels with one output; output waveforms looks like
this:
             __    __    __    __
    PWM   __|  |__|  |__|  |__|  |__
            <--T-->

    Where T is the signal period

Since PWMs with more than one output per channel could be used as one
output PWM the normal mode is the default mode for all PWMs (if not
specified otherwise).

Complementary mode - for PWM channels with two outputs; output waveforms
for a PWM channel in complementary mode looks line this:
             __    __    __    __
    PWMH1 __|  |__|  |__|  |__|  |__
          __    __    __    __    __
    PWML1   |__|  |__|  |__|  |__|
            <--T-->

    Where T is the signal period.

Push-pull mode - for PWM channels with two outputs; output waveforms for a
PWM channel in push-pull mode with normal polarity looks like this:
            __          __
    PWMH __|  |________|  |________
                  __          __
    PWML ________|  |________|  |__
           <--T-->

    If polarity is inversed:
         __    ________    ________
    PWMH   |__|        |__|
         ________    ________    __
    PWML         |__|        |__|
           <--T-->

    Where T is the signal period.

The PWM working modes are per PWM channel registered as PWM's capabilities.
The driver registers itself to PWM core a get_caps() function, in
struct pwm_ops, that will be used by PWM core to retrieve PWM capabilities.
If this function is not registered in driver's probe, a default function
will be used to retrieve PWM capabilities. Currently, the default
capabilities includes only PWM normal mode.

PWM state has been updated to keep PWM mode. PWM mode could be configured
via sysfs or via DT. pwm_apply_state() will do the preliminary validation
for PWM mode to be applied.

In sysfs, user could get PWM modes by reading mode file of PWM device:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# ls -l
total 0
-r--r--r-- 1 root root 4096 Oct  9 09:07 capture
lrwxrwxrwx 1 root root    0 Oct  9 09:07 device -> ../../pwmchip0
-rw-r--r-- 1 root root 4096 Oct  9 08:42 duty_cycle
-rw-r--r-- 1 root root 4096 Oct  9 08:44 enable
--w------- 1 root root 4096 Oct  9 09:07 export
-rw-r--r-- 1 root root 4096 Oct  9 08:43 mode
-r--r--r-- 1 root root 4096 Oct  9 09:07 npwm
-rw-r--r-- 1 root root 4096 Oct  9 08:42 period
-rw-r--r-- 1 root root 4096 Oct  9 08:44 polarity
drwxr-xr-x 2 root root    0 Oct  9 09:07 power
lrwxrwxrwx 1 root root    0 Oct  9 09:07 subsystem -> ../../../../../../../../class/pwm
-rw-r--r-- 1 root root 4096 Oct  9 08:42 uevent
--w------- 1 root root 4096 Oct  9 09:07 unexport
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
normal complementary [push-pull]

The mode enclosed in bracket is the currently active mode.

The mode could be set, via sysfs, by writing to mode file one of the modes
displayed at read:
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# echo normal > mode
root@sama5d2-xplained:/sys/class/pwm/pwmchip0/pwm2# cat mode
[normal] complementary push-pull 

The PWM push-pull mode could be usefull in applications like half bridge
converters.

This series also add PWM modes support for Atmel/Microchip SoCs.

Thank you,
Claudiu Beznea

[1] https://www.spinics.net/lists/arm-kernel/msg580275.html
[2] https://lkml.org/lkml/2018/1/12/359

Changes in v4:
- removed changes related to pwm_config() as per maintainer proposals
- added pwm_mode_get_valid() to retrieve a valid PWM mode fror PWM device
  instead of using BIT(ffs(caps.mode) - 1) and changed drivers to use
  pwm_mode_get_valid() instead of pwm_get_caps() + BIT(ffs(caps.mode) - 1)
  (patches 2, 3, 4 from this series)
- renamed PWM_MODE() macro in PWMC_MODE() to avoid conflicts with
  pwm-sun4i.c driver ('C' stands for capability)
- removed pwm_caps_valid() function
- renamed PWM_DTMODE_COMPLEMENTARY and PWM_DTMODE_PUSH_PULL macros in
  PWM_MODE_COMPLEMENTARY and PWM_MODE_PUSH_PULL

Changes in v3:
- removed changes related to only one of_xlate function for all PWM drivers
- switch to PWM capabilities per PWM channel nor per PWM chip
- squash documentation and bindings patches as requeted by reviewer
- introduced PWM_MODE(name) macro and used a bit enum for pwm modes
- related to DT bindings, used flags cell also for PWM modes
- updated of_xlate specific functions with "state->mode = mode;"
  instructions to avoid pwm_apply_state() failures
- use available modes for PWM channel in pwm_config() by first calling
  pwm_get_caps() to get caps.modes
- use loops through available modes in mode_store()/mode_show() and also in
  of_pwm_xlate_with_flags() instead of "if else" instructions; in this way,
  the addition of a new mode is independent of this code sections
- use DTLI=1, DTHI=0 register settings to obtain push-pull mode waveforms
  for Atmel/Microchip PWM controller.

Changes in v2:
- remove of_xlate and of_pwm_n_cells and use generic functions to pharse DT
  inputs; this is done in patches 1, 2, 3, 4, 5, 6, 7 of this series; this will
  make easy the addition of PWM mode support from DT
- add PWM mode normal
- register PWM modes as capabilities of PWM chips at driver probe and, in case
  driver doesn't provide these capabilities use default ones
- change the way PWM mode is pharsed via DT by using a new input for pwms
  binding property


Claudiu Beznea (9):
  pwm: extend PWM framework with PWM modes
  pwm: clps711x: populate PWM mode in of_xlate function
  pwm: cros-ec: populate PWM mode in of_xlate function
  pwm: pxa: populate PWM mode in of_xlate function
  pwm: add PWM modes
  pwm: atmel: add pwm capabilities
  pwm: add push-pull mode support
  pwm: add documentation for pwm push-pull mode
  pwm: atmel: add push-pull mode support

 Documentation/devicetree/bindings/pwm/pwm.txt |  11 ++-
 Documentation/pwm.txt                         |  42 ++++++++-
 drivers/pwm/core.c                            | 125 +++++++++++++++++++++++++-
 drivers/pwm/pwm-atmel.c                       | 118 +++++++++++++++++-------
 drivers/pwm/pwm-clps711x.c                    |  10 ++-
 drivers/pwm/pwm-cros-ec.c                     |   1 +
 drivers/pwm/pwm-pxa.c                         |   1 +
 drivers/pwm/sysfs.c                           |  61 +++++++++++++
 include/dt-bindings/pwm/pwm.h                 |   2 +
 include/linux/pwm.h                           |  64 +++++++++++++
 10 files changed, 395 insertions(+), 40 deletions(-)

-- 
2.7.4
