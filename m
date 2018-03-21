Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELt1cjgD/eULkQB1dFro6c77ICMCKfn9fr8r8P/HIxijPsty5SqrkCx1/ExzCdyZdhMSKJxU
ARC-Seal: i=1; a=rsa-sha256; t=1521607240; cv=none;
        d=google.com; s=arc-20160816;
        b=quruyVLlUwq8sqQQxvF2b3/yCGq7IR1bUunhpATmNhkjf1DlE7zT/5rgzS9hxnzfDM
         Dm3NR6aEjN32EBsgkWb1FaBdqgMpi5P2Cw/lUYd5k+uzXu364XcVmppBeF6qzHuiMH1z
         nWPilG9amTUb6zaUgLVJJJE1cV8X35v4raEZwsb4SXvm3VKOdCbL8MoY237qm9Z+gw0j
         TMIoWKSVJrS51oANiVa2r4ujlHRRphxNe73QvwKJl4dXwBBz1yn9Ju1ERxX0c2xUEtGD
         EC0QjRWQ5ExOnnPukoGoUJt6pDnI/NI9Hp1/ag/qpVaOIUkArJIseBkBM1wTWuM4ZZK6
         e9lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=qyOnKlhxrW419nFhXBRhY0gYCEYeMz4DmCcYa5Uxgws=;
        b=WLaaF+6KPaFr56CMzFtEVUBzvK/NUScLJPeskJPAVfI+U4NXTPESw0ceRMJhbG+z2X
         ALMsaccwvonAyTlg9U+Azt+Qbv/bm9kbryIIoDPbZA4ogjFX8HXyr99gvDAtzBkwfJ4i
         Hf4HlbdFRtUKJKJfdfuHSvNmHnMTJIzEsgG6tHpBquMvXZT3AxVZS8BH4jMPYDN+BhOX
         y2lYHf3FyyIVDZrclX5EQawR8qOuG9qC/rWKT4FYiMohJYoW8UwxP39iW5a8mLcPXzHP
         AG/4iq93zx4qA7TFj2snIvuxc3ugY0tyLI+BDXlhTtLVXrbUqBoSUNM9b4fn3h65w5bn
         R5oA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 203.18.50.4 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 203.18.50.4 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hkpgpgate101.nvidia.com on Tue, 20 Mar 2018 21:40:37 -0700
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <timur@codeaurora.org>, <andy.gross@linaro.org>,
	<xuwei5@hisilicon.com>, <elder@linaro.org>, <heiko@sntech.de>,
	<krzk@kernel.org>, <ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH V2 0/9] Implementation of Tegra Tachometer driver
Date: Wed, 21 Mar 2018 10:10:35 +0530
Message-ID: <1521607244-29734-1-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595520834265494404?=
X-GMAIL-MSGID: =?utf-8?q?1595520834265494404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The following patches adds support for PWM based Tegra Tachometer driver
which implements PWM capture interface to analyze the PWM signal of a
electronic fan and reports it in periods and duty cycles.

Added fan device attribute fan1_input in pwm-fan driver to monitor the
speed of fan in rotations per minute using PWM interface.
RPM of Fan will be exposed to user interface through HWMON sysfs interface
avialable at location: /sys/class/hwmon/hwmon0/fan1_input

Steps to validate Tachometer on Tegra186 SoC:
A. push modules pwm-tegra.ko, pwm-tegra-tachometer.ko and pwm-fan.ko to
   linux device using scp command.
   scp build/tegra186/drivers/pwm/pwm-tegra.ko ubuntu@10.19.65.176:/tmp/
   scp build/tegra186/drivers/pwm/pwm-tegra-tachometer.ko ubuntu@10.19.65.176:/tmp/
   scp build/tegra186/drivers/hwmon/pwm-fan.ko ubuntu@10.19.65.176:/tmp/
B. On Linux device console, insert these modules using insmod command.
   insmod /tmp/pwm-tegra.ko
   insmod /tmp/pwm-tegra-tachometer.ko
   insmod /tmp/pwm-fan.ko
C. Read RPM value at below sysfs node
   cat /sys/calss/hwmon/hwmon0/fan1_input
D. Change the FAN speed using PWM sysfs interface. Follow below steps for the same:
   a. cd /sys/class/pwm/pwmchip0
   b. ls -la (make sure pwm controller is c340000.pwm)
      Output should be: device -> ../../../c340000.pwm
   c. echo 0 > export
   d. cd pwmchip0:0
   e. echo 8000 > period
   f. echo 1 > enable
   g. echo 8000 > duty_cycle # change duty_cycles from 0 to 8000 for FAN speed variation
   h. cat /sys/calss/hwmon/hwmon0/fan1_input
   i. echo 4000 > duty_cycle
   h. cat /sys/calss/hwmon/hwmon0/fan1_input
   i. echo 2000 > duty_cycle
   h. cat /sys/calss/hwmon/hwmon0/fan1_input
   i. echo 0 > duty_cycle
   h. cat /sys/calss/hwmon/hwmon0/fan1_input

Rajkumar Rampelli (9):
  pwm: core: Add support for PWM HW driver with pwm capture only
  arm64: tegra: Add PWM controller on Tegra186 soc
  dt-bindings: Tegra186 tachometer device tree bindings
  arm64: tegra: Add Tachometer Controller on Tegra186
  pwm: tegra: Add PWM based Tachometer driver
  arm64: tegra: Add pwm based fan support on Tegra186
  hwmon: pwm-fan: add sysfs node to read rpm of fan
  arm64: defconfig: enable Nvidia Tegra Tachometer as a module
  arm64: defconfig: enable pwm-fan as a loadable module

 .../bindings/pwm/pwm-tegra-tachometer.txt          |  31 +++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |   5 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  28 ++
 arch/arm64/configs/defconfig                       |   2 +
 drivers/hwmon/pwm-fan.c                            |  23 ++
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  21 +-
 drivers/pwm/pwm-tegra-tachometer.c                 | 303 +++++++++++++++++++++
 9 files changed, 418 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-tegra-tachometer.txt
 create mode 100644 drivers/pwm/pwm-tegra-tachometer.c

-- 
2.1.4
