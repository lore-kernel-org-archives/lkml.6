Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELuL3Opm/ycIc5lOcacSub3D2Uwmdj7khx1QlILQl7DEkqvSsrKK2Tc2NOHnl1YCce9P0Phn
ARC-Seal: i=1; a=rsa-sha256; t=1519403046; cv=none;
        d=google.com; s=arc-20160816;
        b=Py7IrXhFKtu+qEsqFUMA/ptKEN8uJ9H/F/oF8M/hIj2aHJgPfzVJjhs4u44RDfTP2J
         5Xtt2MgVWuL+rH/6FPD59otUMSCMh0JzS1mMt7aaajZL0guuD9xAHgwLlvNEvzOoIWVO
         A0K1Lc1RazHDhl+P1ycOMWSnhohGLV51zyBCTAYPTfO+cm/rKnsSN/CZ//fVJBAtKlTu
         8oPa6lHDUiRjjsVHK7eTfJrjHy2ar2DMIOf+gCOQhGXVo2FumtxwQDDcybFjKu/gTci7
         lVAD5K7PIL5A5g02mS5hYPZdm7OI/XzVXi6fx25s32WcYshYvvWePqV0bu2nqrV7mI2r
         QFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=EcAN94cvDkFyRdtKh7kFKfUfxoNLvHpqkv9MgYYvt1E=;
        b=eTa9d41FrjfXcyGH1KjK9eWt+noCJpAaVJGxdGFZwDsxzmlMVmop9phsSyeEpX+XOU
         0MY8AvgUTBj+0ZFQxxrkQLgw1HthyiDqqYCEepP9C7okHpNVT5f/HwhiV+T1k0SCbb/5
         OY+yYwEbczD8+0Mvn+tA2DI+31TC2F/8b+YHVoZzCMJXbOvFQUtiku7k05BEz74eMEEw
         kyKYnlUx2BdbSJ/Vq0GgGWg/+6Efq6fgqWOYeOVF3XDtADvlwTAFmhky2zA4Pm+Omuaf
         Obk0ANdywVKUI7TadzY2sVOhNGDzhQkqXVDgbM4EqGts8fAiwU+X5hnOuJmytfeBtxdW
         0/KA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 00/20] firmware: ARM System Control and Management Interface(SCMI) support
Date: Fri, 23 Feb 2018 16:23:30 +0000
Message-Id: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209568480854235?=
X-GMAIL-MSGID: =?utf-8?q?1593209568480854235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

ARM System Control and Management Interface(SCMI) is more flexible and
easily extensible than any of the existing interfaces. Many vendors were
involved in the making of this formal specification and is now published[1].

There is a strong trend in the industry to provide micro-controllers in
systems to abstract various power, or other system management tasks.
These controllers usually have similar interfaces, both in terms of the
functions that are provided by them, and in terms of how requests are
communicated to them.

This specification is to standardise and avoid (any further)
fragmentation in the design of such interface by various vendors.

It currently doesn't support notification, asynchronous/delayed response,
perf/power statistics region and sensor register region to name a few.
Some of the ideas of message allocation/management are borrowed from TI SCI.

Changes:

v5[7]->v6:
	- Dropped notification APIs as it's not fully supported, leftovers
	  from development
	- Removed unnecessary mutex usage for allocation
	- Replace udelay with cpu_relax, found nice helper spin_until_cond
	- Added inline to couple of functions in header files
	- Fixed few checkpatch errors

v4[6]->v5:
	- Rebased to v4.15-rc6
	- Updated all the gathered Ack/Reviewed-by tags(which includes
	  all the drivers using SCMI protocol)

v3[5]->v4[6]:
	- Added SCMI protocol bus to enumerate supported protocols as
	  suggested by Arnd
	- Dropped the abstraction to mailbox as it may be optional

v2[4]->v3:
	- Addressed various comments received so far(clock, hwmon and
	  cpufreq drivers along with scmi drivers)
	- Hwmon driver now uses core layer to create and manage sysfs
	  attributes
	- Added a shim layer to abstract the mailbox interface to support
	  any custom adaptation required by the controller driver
	- Simple ARM MHU shim layer using newly added abstraction

v1[3]->v2[4]:
	- Additional support for polling based DVFS and per protocol
	  channels
	- Dependent drivers(clock, hwmon, cpufreq and power domains)
	- Various other review comments and issued found during testing
	  addressed
	- Explicit binding for method dropped as even SMC based method
	  are adviertised as mailbox

RFC[2]->v1[3]:
	- Add generic mailbox binding for shared memory(Rob H)
	- Dropped compatibles per protocol(Suggested by Matt S)
	- Dropped lot of unnecessary pointer casting(Arnd B)
	- Dropped packing of structures(Arnd B)
	- Few other changes/additions based initial testing with firmware
	  providing SCMI interface to OSPM

--
Regards,
Sudeep

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0056a/index.html
[2] https://marc.info/?l=linux-kernel&m=149685193627620&w=2
[3] https://marc.info/?l=linux-arm-kernel&m=149849482623492&w=2
[4] https://marc.info/?l=devicetree&m=150185763105926&w=2
[5] https://marc.info/?l=devicetree&m=150660452015351&w=2
[6] https://marc.info/?l=devicetree&m=150972061408961&w=2
[7] https://marc.info/?l=devicetree&m=151846114506163&w=2

Sudeep Holla (20):
  dt-bindings: mailbox: add support for mailbox client shared memory
  dt-bindings: arm: add support for ARM System Control and Management
    Interface(SCMI) protocol
  firmware: arm_scmi: add basic driver infrastructure for SCMI
  firmware: arm_scmi: add common infrastructure and support for base
    protocol
  firmware: arm_scmi: add scmi protocol bus to enumerate protocol
    devices
  firmware: arm_scmi: add initial support for performance protocol
  firmware: arm_scmi: add initial support for clock protocol
  firmware: arm_scmi: add initial support for power protocol
  firmware: arm_scmi: add initial support for sensor protocol
  firmware: arm_scmi: probe and initialise all the supported protocols
  firmware: arm_scmi: add support for polling based SCMI transfers
  firmware: arm_scmi: add option for polling based performance domain
    operations
  firmware: arm_scmi: refactor in preparation to support per-protocol
    channels
  firmware: arm_scmi: add per-protocol channels support using idr
    objects
  firmware: arm_scmi: add device power domain support using genpd
  clk: add support for clocks provided by SCMI
  hwmon: (core) Add hwmon_max to hwmon_sensor_types enumeration
  hwmon: add support for sensors exported via ARM SCMI
  cpufreq: add support for CPU DVFS based on SCMI message protocol
  cpufreq: scmi: add support for fast frequency switching

 Documentation/devicetree/bindings/arm/arm,scmi.txt | 179 +++++
 .../devicetree/bindings/mailbox/mailbox.txt        |  28 +
 MAINTAINERS                                        |  11 +-
 drivers/clk/Kconfig                                |  10 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-scmi.c                             | 213 +++++
 drivers/cpufreq/Kconfig.arm                        |  11 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/scmi-cpufreq.c                     | 272 +++++++
 drivers/firmware/Kconfig                           |  34 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/arm_scmi/Makefile                 |   5 +
 drivers/firmware/arm_scmi/base.c                   | 264 ++++++
 drivers/firmware/arm_scmi/bus.c                    | 232 ++++++
 drivers/firmware/arm_scmi/clock.c                  | 353 +++++++++
 drivers/firmware/arm_scmi/common.h                 | 116 +++
 drivers/firmware/arm_scmi/driver.c                 | 882 +++++++++++++++++++++
 drivers/firmware/arm_scmi/perf.c                   | 492 ++++++++++++
 drivers/firmware/arm_scmi/power.c                  | 232 ++++++
 drivers/firmware/arm_scmi/scmi_pm_domain.c         | 140 ++++
 drivers/firmware/arm_scmi/sensors.c                | 302 +++++++
 drivers/hwmon/Kconfig                              |  12 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/scmi-hwmon.c                         | 233 ++++++
 include/linux/hwmon.h                              |   1 +
 include/linux/scmi_protocol.h                      | 288 +++++++
 26 files changed, 4309 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,scmi.txt
 create mode 100644 drivers/clk/clk-scmi.c
 create mode 100644 drivers/cpufreq/scmi-cpufreq.c
 create mode 100644 drivers/firmware/arm_scmi/Makefile
 create mode 100644 drivers/firmware/arm_scmi/base.c
 create mode 100644 drivers/firmware/arm_scmi/bus.c
 create mode 100644 drivers/firmware/arm_scmi/clock.c
 create mode 100644 drivers/firmware/arm_scmi/common.h
 create mode 100644 drivers/firmware/arm_scmi/driver.c
 create mode 100644 drivers/firmware/arm_scmi/perf.c
 create mode 100644 drivers/firmware/arm_scmi/power.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_pm_domain.c
 create mode 100644 drivers/firmware/arm_scmi/sensors.c
 create mode 100644 drivers/hwmon/scmi-hwmon.c
 create mode 100644 include/linux/scmi_protocol.h

-- 
2.7.4
