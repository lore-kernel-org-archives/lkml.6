Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x226+V8nmRKrZVBUUf8kp4UcPMof3aGNEboDo2Be3OnGhgrBZ7ZWpdlg2lKTU/VygtlPW/odY
ARC-Seal: i=1; a=rsa-sha256; t=1519229774; cv=none;
        d=google.com; s=arc-20160816;
        b=iqKmgLVqng8XQzmAkJM/Dz5L9y/M8Jthq+iy7ayDyTfQChvdk72HpBEVlQYXp6+Qn/
         8xCDVBiXxJ+kOmc78DSZmHVtQMMOXxJgrFbP/iYCD9jqm49rKPEINeXh6KLKo06vlDiR
         393GtoV12Em3MLYJk+YowGtAOJxn1v10UsOPKJKVdoSBK39t8XF0yQV4XS2QNWH4r7JT
         gJ8fDLcISq0OMpdaJgPjkGRF/tEl1ACsj82vlHUwdGdcH7F5BkCuBC8leNqv5PWe6le5
         JsGEwBBHMIBoNv5/lgAd2r+6mLkpSHlgqRPgWziTu+Bj42zVdvu/oa/uloJThgoFLSW1
         a6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WgWooP2Fzx3ivlOMkTdPAxuxatsCqd8s/15XvuYvmDM=;
        b=p+Xdx27PlWB3zTVauTng7F0BadujjG6VoMB0dfz79d4WqLMiu+i+TAXODJTwhx9goe
         gyaoOZ9l1TRZkPXpWKgLPjOltdBUweZFVV5ZLxjTPkfflOq5H/y4GKOYFoVVP5ykpx6+
         spZzSP1uKfw89LN6kSSKBH/EFJa848EzGtghZ2rBrmfsgLooxUjPHGHRPG45b+FrzGjM
         bmrs9dV1LAmvQ4uDFviYlLlN9vq/73zMsPMHi7v7DT50iFY84vVEe5SX/LDIDwRF9gGG
         cqqhGa12atZ7nE6gPG2cSCDUBKE4Z9jKdfbM5u2uksECU51YKyJWSvPk4MUz1XG1fzLH
         wgxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617833"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: joel@jms.id.au,
	andrew@aj.id.au,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	benh@kernel.crashing.org,
	andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v2 0/8] PECI device driver introduction
Date: Wed, 21 Feb 2018 08:15:58 -0800
Message-Id: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027880268986254?=
X-GMAIL-MSGID: =?utf-8?q?1593027880268986254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduction of the Platform Environment Control Interface (PECI) bus
device driver. PECI is a one-wire bus interface that provides a
communication channel between Intel processor and chipset components to
external monitoring or control devices. PECI is designed to support the
following sideband functions:

* Processor and DRAM thermal management
  - Processor fan speed control is managed by comparing Digital Thermal
    Sensor (DTS) thermal readings acquired via PECI against the
    processor-specific fan speed control reference point, or TCONTROL.
    Both TCONTROL and DTS thermal readings are accessible via the processor
    PECI client. These variables are referenced to a common temperature,
    the TCC activation point, and are both defined as negative offsets from
    that reference.
  - PECI based access to the processor package configuration space provides
    a means for Baseboard Management Controllers (BMC) or other platform
    management devices to actively manage the processor and memory power
    and thermal features.

* Platform Manageability
  - Platform manageability functions including thermal, power, and error
    monitoring. Note that platform 'power' management includes monitoring
    and control for both the processor and DRAM subsystem to assist with
    data center power limiting.
  - PECI allows read access to certain error registers in the processor MSR
    space and status monitoring registers in the PCI configuration space
    within the processor and downstream devices.
  - PECI permits writes to certain registers in the processor PCI
    configuration space.

* Processor Interface Tuning and Diagnostics
  - Processor interface tuning and diagnostics capabilities
    (Intel(c) Interconnect BIST). The processors Intel(c) Interconnect
    Built In Self Test (Intel(c) IBIST) allows for infield diagnostic
    capabilities in the Intel UPI and memory controller interfaces. PECI
    provides a port to execute these diagnostics via its PCI Configuration
    read and write capabilities.

* Failure Analysis
  - Output the state of the processor after a failure for analysis via
    Crashdump.

PECI uses a single wire for self-clocking and data transfer. The bus
requires no additional control lines. The physical layer is a self-clocked
one-wire bus that begins each bit with a driven, rising edge from an idle
level near zero volts. The duration of the signal driven high depends on
whether the bit value is a logic '0' or logic '1'. PECI also includes
variable data transfer rate established with every message. In this way,
it is highly flexible even though underlying logic is simple.

The interface design was optimized for interfacing to Intel processor and
chipset components in both single processor and multiple processor
environments. The single wire interface provides low board routing
overhead for the multiple load connections in the congested routing area
near the processor and chipset components. Bus speed, error checking, and
low protocol overhead provides adequate link bandwidth and reliability to
transfer critical device operating conditions and configuration
information.

This implementation provides the basic framework to add PECI extensions
to the Linux bus and device models. A hardware specific 'Adapter' driver
can be attached to the PECI bus to provide sideband functions described
above. It is also possible to access all devices on an adapter from
userspace through the /dev interface. A device specific 'Client' driver
also can be attached to the PECI bus so each processor client's features
can be supported by the 'Client' driver through an adapter connection in
the bus. This patch set includes Aspeed 24xx/25xx PECI driver and a generic
PECI hwmon driver as the first implementation for both adapter and client
drivers on the PECI bus framework.

v1 -> v2
- Additionally implemented a core driver to support PECI linux bus driver
  model.
- Modified Aspeed PECI driver to make that to be an adapter driver in PECI
  bus.
- Modified PECI hwmon driver to make that to be a client driver in PECI
  bus.
- Simplified hwmon driver attribute labels and removed redundant strings.
- Removed core_nums from device tree setting of hwmon driver and modified
  core number detection logic to check the resolved_core register in
  client CPU's local PCI configuration area.
- Removed dimm_nums from device tree setting of hwmon driver and added
  populated DIMM detection logic to support dynamic creation.
- Removed indexing gap on core temperature and DIMM temperature attributes.
- Improved hwmon registration and dynamic attribute creation logic.
- Fixed structure definitions in PECI uapi header to make that use __u8,
  __u16 and etc.
- Modified wait_for_completion_interruptible_timeout error handling logic
  in Aspeed PECI driver to deliver errors correctly.
- Removed low-level xfer command from ioctl and kept only high-level PECI
  command suite as ioctls.
- Fixed I/O timeout logic in Aspeed PECI driver using ktime.
- Added a function into hwmon driver to simplify update delay checking.
- Added a function into hwmon driver to convert 10.6 to millidegree.
- Dropped non-standard attributes in hwmon driver.
- Fixed OF table for hwmon to make it indicate as a PECI client of Intel
  CPU target.
- Added a maintainer of PECI subsystem into MAINTAINERS document.

Thanks,

-Jae

Jae Hyun Yoo (8):
  drivers/peci: Add support for PECI bus driver core
  Documentations: dt-bindings: Add a document of PECI adapter driver for
    Aspeed AST24xx/25xx SoCs
  ARM: dts: aspeed: peci: Add PECI node
  drivers/peci: Add a PECI adapter driver for Aspeed AST24xx/AST25xx
  Documentation: dt-bindings: Add a document for PECI hwmon client driver
  Documentation: hwmon: Add a document for a PECI hwmon client driver
  drivers/hwmon: Add a generic PECI hwmon client driver
  Add a maintainer for the PECI subsystem

 .../devicetree/bindings/hwmon/peci-hwmon.txt       |   27 +
 .../devicetree/bindings/peci/peci-aspeed.txt       |   73 ++
 Documentation/hwmon/peci-hwmon                     |   73 ++
 MAINTAINERS                                        |    9 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   25 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   25 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/hwmon/Kconfig                              |   10 +
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/peci-hwmon.c                         |  928 ++++++++++++++
 drivers/peci/Kconfig                               |   39 +
 drivers/peci/Makefile                              |    9 +
 drivers/peci/peci-aspeed.c                         |  510 ++++++++
 drivers/peci/peci-core.c                           | 1337 ++++++++++++++++
 include/linux/peci.h                               |   97 ++
 include/uapi/linux/peci-ioctl.h                    |  207 +++
 17 files changed, 3373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-hwmon.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
 create mode 100644 Documentation/hwmon/peci-hwmon
 create mode 100644 drivers/hwmon/peci-hwmon.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/peci-aspeed.c
 create mode 100644 drivers/peci/peci-core.c
 create mode 100644 include/linux/peci.h
 create mode 100644 include/uapi/linux/peci-ioctl.h

-- 
2.16.1
