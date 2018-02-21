Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELtVsHNQjaEP+jbDnKIn9F9MDh/Hru0HlMTXlCRXJFaXSiZiprOWWNhYMDEK7BWdYdJ+qv9/
ARC-Seal: i=1; a=rsa-sha256; t=1519196358; cv=none;
        d=google.com; s=arc-20160816;
        b=qJvCwmDmdeCd01ElnrYWriBBJoD4YmeXMVNxHK/mE4WgRyDnqNXPdkrCI6NBtDmlmV
         4biPgSOYWKPC8tUB7ONeM6QiqJzH6AglwunE7Fd6I4OG0d4fhlHWoOPRgCIoeGXtH4Vd
         dP2lJwGAvqxeoQF0xzSnc5/k1QsCw2XjcXwluo1FUVxO4pYblVd9lnHKYOlI8OdV/9MM
         sXACB8bNz/AyuOU2ZNfCIPm3CUkXQkdAA6aujfN9w3+m/Sxzvu1o2ac5zbPgg5l90Uzm
         PRkt1KHutRb/4bOXeSLdgarfz0t49Esl0FUBZ6WBHq1jLcpeKj8bRdPEs9mUHkyoGrJN
         O8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=08pxwqlhYD+9IoV0DNT5WDgqnOpnehFqxonQ5r8AMgw=;
        b=ir5O3dsRAMYsPGZjDw6mUtQ4HPnZAOaYspAYQ6+v6GuAQonW3puZ9q4Ak+Facv7C1d
         h4p9nhxFztOVx9APMOOQOH/R9TbV6J+EE8/wmtSr8uGPpKc1pUZkvJf+0JzLfJfTW//W
         t67mYz6Jp2AQR86WAxXW9MfYNHo/dvHw7q+R/r9Eh8yg9lr4bQ9P3cloAH4FMkAnURzi
         Q3RmGDa72kl3rbDye1wEGEZXK3wX9d1gcIegRkpS4KC9t5H+kK33hjuVxjf/b4p5eZAE
         vlIIVYRMrmneDmuYlwD/GqcNJfwe/wyt2v334DLLgScVBv4PEW5PH36L+BF68BNc5if7
         5Mtg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.143 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 22:59:16 -0800
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <gregory.clement@free-electrons.com>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH 00/10] Implementation of Tegra Tachometer driver
Date: Wed, 21 Feb 2018 12:28:49 +0530
Message-ID: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992841266774003?=
X-GMAIL-MSGID: =?utf-8?q?1592992841266774003?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following patches adds support for PWM based Tegra Tachometer driver
which implements PWM capture interface to analyze the PWM signal of a
electronic fan and reports it in periods and duty cycles.

Generic PWM Tachometer implemented to monitor the speed of fan in rpms
using PWM interface. RPM of Fan will be exposed to user interface through
HWMON sysfs interface avialable at below location
/sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm

Steps to validate Tachometer:
A. push modules pwm-tegra.ko, pwm-tegra-tachometer.ko and
   generic-pwm-tachometer.ko to linux device using scp command.
   scp build/tegra186/drivers/pwm/pwm-tegra.ko ubuntu@10.19.65.176:/tmp/
   scp build/tegra186/drivers/pwm/pwm-tegra-tachometer.ko ubuntu@10.19.65.176:/tmp/
   scp build/tegra186/drivers/hwmon/generic-pwm-tachometer.ko ubuntu@10.19.65.176:/tmp/
B. On Linux device console, insert these modules using insmod command.
   insmod /tmp/pwm-tegra.ko
   insmod /tmp/pwm-tegra-tachometer.ko
   insmod /tmp/generic-pwm-tachometer.ko
C. Read RPM value at below sysfs node
   cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
D. Change the FAN speed using PWM sysfs interface. Follow below steps for the same:
   a. cd /sys/class/pwm/pwmchip0
   b. ls -la (make sure pwm controller is c340000.pwm)
      Output should be: device -> ../../../c340000.pwm
   c. echo 0 > export
   d. cd pwmchip0:0
   e. echo 8000 > period
   f. echo 1 > enable
   g. echo 7000 > duty_cycle # change duty_cycles from 0 to 7000 and see FAN speed
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
   i. echo 4000 > duty_cycle
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
   i. echo 2000 > duty_cycle
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm
   i. echo 0 > duty_cycle
   h. cat /sys/devices/platform/generic_pwm_tachometer/hwmon/hwmon0/rpm

Rajkumar Rampelli (10):
  pwm: core: Add support for PWM HW driver with pwm capture only
  dt-bindings: Tegra186 tachometer device tree bindings
  pwm: tegra: Add PWM based Tachometer driver
  hwmon: generic-pwm-tachometer: Add DT binding details
  hwmon: generic-pwm-tachometer: Add generic PWM based tachometer
  arm64: tegra: Add Tachometer Controller on Tegra186
  arm64: tegra: Add PWM based Tachometer support on Tegra186
  arm64: defconfig: enable Nvidia Tegra Tachometer as a module
  arm64: defconfig: Enable Generic PWM based Tachometer driver
  arm64: tegra: Add PWM controller on Tegra186 soc

 .../bindings/hwmon/generic-pwm-tachometer.txt      |  25 ++
 .../bindings/pwm/pwm-tegra-tachometer.txt          |  31 +++
 Documentation/hwmon/generic-pwm-tachometer         |  17 ++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   5 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  28 ++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/generic-pwm-tachometer.c             | 112 ++++++++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |   4 +
 drivers/pwm/pwm-tegra-tachometer.c                 | 303 +++++++++++++++++++++
 13 files changed, 549 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/generic-pwm-tachometer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
 create mode 100644 Documentation/hwmon/generic-pwm-tachometer
 create mode 100644 drivers/hwmon/generic-pwm-tachometer.c
 create mode 100644 drivers/pwm/pwm-tegra-tachometer.c

-- 
2.1.4
