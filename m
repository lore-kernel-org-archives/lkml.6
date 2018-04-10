Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+KE1y2kbR2GjlXSfZT+6WO0tyfBAB6CyInIJy7VxMZntrieLAv4s496Ep+WboQ5QCtqtAY
ARC-Seal: i=1; a=rsa-sha256; t=1523385163; cv=none;
        d=google.com; s=arc-20160816;
        b=FWy34QyTnlIYNVERZyT3KzgO88FNLp3wYkwUaTkFdSiRRhNc3Ug8hWvknzMJ5pmSdJ
         dwch4idzVdtBrtlVahwvF74D6hKxirxiYF2lZ49iyoUiPCRXkY8F+RSuWb0asZ4z1eKC
         UNpL4i5qN+DGBIwIUc63nKpM9N3FRtL7BGP9t/qon51q57GD19iwB95GnI0cDcONu0AL
         hsiUXQcpSLFaEtTYRczDGKrSKw2DkHskoWQGqjllvwfxlUf/YLcqVf0nttyudrXrGoby
         bBKP2wfIOIRSvfoq2Yavl+lwxXc6qGf0WVC6XCwcHuHU9Svj/oq0WBtrxsxnjipEqEby
         qY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=vqeBPi7dogQUkn5SYwoBUUXC9dUqElb3WLjdzCwEJE8=;
        b=UvyjUyf+znQ87lvdksCDySCVfCd6zEZsGjNg6FDXLLV6aSyd+g/pRtMevyLGMofKCf
         FRBzv22y91ep+ae6nWTrz9iJHqMRpMdHwVhygAizy+uB698R2C2EtOEaLrOkHmBMt76w
         SpKaXDPVEtbb19cHJ73qIL8vdYCew/d88Z/90MgD9KxolZxSZ0r1Z2WAX5k8mizpNOsc
         gjY3g18sWQxhne52HWXOC0aReO8bszQtyCKoxU1L7EsYsrF9puk4QHTi07cihAbwvn8T
         D6a2yEPuVmGUx+aD7x7LGMg9uvVpiZBOqVaFF2cnv0KdNRgTf8tajW1G7KRPJhVaAr/S
         fbAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.115 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,433,1517904000";
   d="scan'208";a="219323698"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Alan Cox <alan@linux.intel.com>,
	Andrew Jeffery <andrew@aj.id.au>,
	Andrew Lunn <andrew@lunn.ch>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Haiyue Wang <haiyue.wang@linux.intel.com>,
	James Feist <james.feist@linux.intel.com>,
	Jason M Biils <jason.m.bills@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Joel Stanley <joel@jms.id.au>,
	Julia Cartwright <juliac@eso.teric.us>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Milton Miller II <miltonm@us.ibm.com>,
	Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stef van Os <stef.van.os@prodrive-technologies.com>,
	Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
	Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	openbmc@lists.ozlabs.org,
	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v3 00/10] PECI device driver introduction
Date: Tue, 10 Apr 2018 11:32:02 -0700
Message-Id: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385121331251394?=
X-GMAIL-MSGID: =?utf-8?q?1597385121331251394?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Introduction of the Platform Environment Control Interface (PECI) bus
device driver. PECI is a one-wire bus interface that provides a
communication channel between an Intel processor and chipset components to
external monitoring or control devices. PECI is designed to support the
following sideband functions:

* Processor and DRAM thermal management
  - Processor fan speed control is managed by comparing Digital Thermal
    Sensor (DTS) thermal readings acquired via PECI against the
    processor-specific fan speed control reference point, or TCONTROL. Both
    TCONTROL and DTS thermal readings are accessible via the processor PECI
    client. These variables are referenced to a common temperature, the TCC
    activation point, and are both defined as negative offsets from that
    reference.
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
    (Intel Interconnect BIST). The processors Intel Interconnect Built In
    Self Test (Intel IBIST) allows for infield diagnostic capabilities in
    the Intel UPI and memory controller interfaces. PECI provides a port to
    execute these diagnostics via its PCI Configuration read and write
    capabilities.

* Failure Analysis
  - Output the state of the processor after a failure for analysis via
    Crashdump.

PECI uses a single wire for self-clocking and data transfer. The bus
requires no additional control lines. The physical layer is a self-clocked
one-wire bus that begins each bit with a driven, rising edge from an idle
level near zero volts. The duration of the signal driven high depends on
whether the bit value is a logic '0' or logic '1'. PECI also includes
variable data transfer rate established with every message. In this way, it
is highly flexible even though underlying logic is simple.

The interface design was optimized for interfacing between an Intel
processor and chipset components in both single processor and multiple
processor environments. The single wire interface provides low board
routing overhead for the multiple load connections in the congested routing
area near the processor and chipset components. Bus speed, error checking,
and low protocol overhead provides adequate link bandwidth and reliability
to transfer critical device operating conditions and configuration
information.

This implementation provides the basic framework to add PECI extensions to
the Linux bus and device models. A hardware specific 'Adapter' driver can
be attached to the PECI bus to provide sideband functions described above.
It is also possible to access all devices on an adapter from userspace
through the /dev interface. A device specific 'Client' driver also can be
attached to the PECI bus so each processor client's features can be
supported by the 'Client' driver through an adapter connection in the bus.
This patch set includes Aspeed 24xx/25xx PECI driver and PECI
cputemp/dimmtemp drivers as the first implementation for both adapter and
client drivers on the PECI bus framework.

Please review.

Thanks,

-Jae

Changes from v2:
* Divided peci-hwmon driver into two drivers, peci-cputemp and
  peci-dimmtemp.
* Added generic dt binding documents for PECI bus, adapter and client.
* Removed in_atomic() call from the PECI core driver.
* Improved PECI commands masking logic.
* Added permission check logic for PECI ioctls.
* Removed unnecessary type casts.
* Fixed some invalid error return codes.
* Added the mark_updated() function to improve update interval checking
  logic.
* Fixed a bug in populated DIMM checking function.
* Fixed some typo, grammar and style issues in documents.
* Rewrote hwmon drivers to use devm_hwmon_device_register_with_info API.
* Made peci_match_id() function as a static.
* Replaced a deprecated create_singlethread_workqueue() call with an
  alloc_ordered_workqueue() call.
* Reordered local variable definitions in reversed xmas tree notation.
* Listed up client CPUs that can be supported by peci-cputemp and
  peci-dimmtemp hwmon drivers.
* Added CPU generation detection logic which checks CPUID signature through
  PECI connection.
* Improved interrupt handling logic in the Aspeed PECI adapter driver.
* Fixed SPDX license identifier style in header files.
* Changed some macros in peci.h to static inline functions.
* Dropped sleepable context checking code in peci-core.
* Adjusted rt_mutex protection scope in peci-core.
* Moved adapter->xfer() checking code into peci_register_adapter().
* Improved PECI command retry checking logic.
* Changed ioctl base from 'P' to 0xb6 to avoid confiliction and updated
  ioctl-number.txt to reflect the ioctl number of PECI subsystem.
* Added a comment to describe PECI retry action.
* Simplified return code handling of peci_ioctl_ping().
* Changed type of peci_ioctl_fn[] to static const.
* Fixed range checking code for valid PECI commands.
* Fixed the error return code on invalid PECI commands.
* Fixed incorrect definitions of PECI ioctl and its handling logic.

Changes from v1:
* Additionally implemented a core driver to support PECI linux bus driver
  model.
* Modified Aspeed PECI driver to make that to be an adapter driver in PECI
  bus.
* Modified PECI hwmon driver to make that to be a client driver in PECI
  bus.
* Simplified hwmon driver attribute labels and removed redundant strings.
* Removed core_nums from device tree setting of hwmon driver and modified
  core number detection logic to check the resolved_core register in client
  CPU's local PCI configuration area.
* Removed dimm_nums from device tree setting of hwmon driver and added
  populated DIMM detection logic to support dynamic creation.
* Removed indexing gap on core temperature and DIMM temperature attributes.
* Improved hwmon registration and dynamic attribute creation logic.
* Fixed structure definitions in PECI uapi header to make that use __u8,
  __u16 and etc.
* Modified wait_for_completion_interruptible_timeout error handling logic
  in Aspeed PECI driver to deliver errors correctly.
* Removed low-level xfer command from ioctl and kept only high-level PECI
  command suite as ioctls.
* Fixed I/O timeout logic in Aspeed PECI driver using ktime.
* Added a function into hwmon driver to simplify update delay checking.
* Added a function into hwmon driver to convert 10.6 to millidegree.
* Dropped non-standard attributes in hwmon driver.
* Fixed OF table for hwmon to make it indicate as a PECI client of Intel
  CPU target.
* Added a maintainer of PECI subsystem into MAINTAINERS document.

Fengguang Wu (1):
  drivers/peci: Add support for PECI bus driver core


Jae Hyun Yoo (10):
  Documentations: dt-bindings: Add documents of generic PECI bus,
    adapter and client drivers
  Documentations: ioctl: Add ioctl numbers for PECI subsystem
  drivers/peci: Add support for PECI bus driver core
  Documentations: dt-bindings: Add a document of PECI adapter driver for
    Aspeed AST24xx/25xx SoCs
  ARM: dts: aspeed: peci: Add PECI node
  drivers/peci: Add a PECI adapter driver for Aspeed AST24xx/AST25xx
  Documentation: dt-bindings: Add documents for PECI hwmon client
    drivers
  Documentation: hwmon: Add documents for PECI hwmon client drivers
  drivers/hwmon: Add PECI hwmon client drivers
  Add a maintainer for the PECI subsystem

 .../devicetree/bindings/hwmon/peci-cputemp.txt     |   24 +
 .../devicetree/bindings/hwmon/peci-dimmtemp.txt    |   25 +
 .../devicetree/bindings/peci/peci-adapter.txt      |   23 +
 .../devicetree/bindings/peci/peci-aspeed.txt       |   60 +
 .../devicetree/bindings/peci/peci-bus.txt          |   15 +
 .../devicetree/bindings/peci/peci-client.txt       |   25 +
 Documentation/hwmon/peci-cputemp                   |   88 ++
 Documentation/hwmon/peci-dimmtemp                  |   50 +
 Documentation/ioctl/ioctl-number.txt               |    2 +
 MAINTAINERS                                        |   10 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   25 +
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   25 +
 drivers/Kconfig                                    |    2 +
 drivers/Makefile                                   |    1 +
 drivers/hwmon/Kconfig                              |   28 +
 drivers/hwmon/Makefile                             |    2 +
 drivers/hwmon/peci-cputemp.c                       |  783 ++++++++++++
 drivers/hwmon/peci-dimmtemp.c                      |  432 +++++++
 drivers/peci/Kconfig                               |   45 +
 drivers/peci/Makefile                              |    9 +
 drivers/peci/peci-aspeed.c                         |  504 ++++++++
 drivers/peci/peci-core.c                           | 1291 ++++++++++++++++++++
 include/linux/peci.h                               |  107 ++
 include/uapi/linux/peci-ioctl.h                    |  200 +++
 24 files changed, 3776 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-adapter.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-bus.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-client.txt
 create mode 100644 Documentation/hwmon/peci-cputemp
 create mode 100644 Documentation/hwmon/peci-dimmtemp
 create mode 100644 drivers/hwmon/peci-cputemp.c
 create mode 100644 drivers/hwmon/peci-dimmtemp.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/peci-aspeed.c
 create mode 100644 drivers/peci/peci-core.c
 create mode 100644 include/linux/peci.h
 create mode 100644 include/uapi/linux/peci-ioctl.h

-- 
2.16.2
