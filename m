Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753325AbeFASU6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 14:20:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:54241 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752631AbeFASUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 14:20:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="45725373"
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
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
        Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Julia Cartwright <juliac@eso.teric.us>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Stef van Os <stef.van.os@prodrive-technologies.com>,
        Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH linux-next v5 00/13] PECI device driver introduction
Date: Fri,  1 Jun 2018 11:20:46 -0700
Message-Id: <20180601182046.23587-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Changes since v4:
* Fixed an incorrect endianness handling in peci-aspeed.
* Added a comment to explain about the asm/intel-family.h inclusion.
* Added an MFD module to support multi-function PECI client devices.

Changes since v3:
* Made code more simple and compact.
* Removed unused header file inclusion.
* Fixed incorrect error return values and messages.
* Removed DTS margin temperature from the peci-cputemp.
* Made some magic numbers use defines.
* Moved peci_get_cpu_id() into peci-core as a common function.
* Replaced the cancel_delayed_work() call with a cancel_delayed_work_sync().
* Replaced AST and Aspeed uses with ASPEED.
* Simplified peci command timeout checking logic using
  regmap_read_poll_timeout().
* Simplified endian swap codes using endian handling macros.
* Dropped regmap read/write error checking except for the first access.
* Added a PECI reset setting in the device tree node.
* Removed unnecessary sleep from the probe context.
* Removed IRQF_SHARED flag from irq request code in the ASPEED PECI driver.
* Fixed typos in documents.
* Combined peci-bus.txt, peci-adapter.txt and peci-client.txt into peci.txt.
* Fixed and swept documents to drop some incorrect or unnecessary
  descriptions.
* Fixed device tree to make unit-address format use reg contents.
* Simplified bit manipulations using <linux/bitfield.h>.
* Made client CPU model checking use <asm/intel-family.h> if available.
* Modified adapter heap allocation method to use kobject reference count
  based.
* Added the low-level PECI xfer IOCTL again to support the Redfish
  requirement.
* Added PM domain attach/detach code.
* Added logic for device instantiation through sysfs.
* Fix a bug of interrupt status checking code in peci-aspeed driver.

Changes since v2:
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

Changes since v1:
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

Jae Hyun Yoo (13):
  dt-bindings: Add a document of PECI subsystem
  Documentation: ioctl: Add ioctl numbers for PECI subsystem
  drivers/peci: Add support for PECI bus driver core
  dt-bindings: Add a document of PECI adapter driver for ASPEED
    AST24xx/25xx SoCs
  ARM: dts: aspeed: peci: Add PECI node
  drivers/peci: Add a PECI adapter driver for Aspeed AST24xx/AST25xx
  dt-bindings: mfd: Add a document for PECI client mfd
  drivers/mfd: Add PECI client mfd driver
  dt-bindings: hwmon: Add documents for PECI hwmon client drivers
  Documentation: hwmon: Add documents for PECI hwmon client drivers
  drivers/hwmon: Add PECI cputemp driver
  drivers/hwmon: Add PECI dimmtemp driver
  Add maintainers for the PECI subsystem

 .../bindings/hwmon/peci-cputemp.txt           |   11 +
 .../bindings/hwmon/peci-dimmtemp.txt          |   13 +
 .../devicetree/bindings/mfd/peci-client.txt   |   23 +
 .../devicetree/bindings/peci/peci-aspeed.txt  |   57 +
 .../devicetree/bindings/peci/peci.txt         |   59 +
 Documentation/hwmon/peci-cputemp              |   78 +
 Documentation/hwmon/peci-dimmtemp             |   50 +
 Documentation/ioctl/ioctl-number.txt          |    2 +
 MAINTAINERS                                   |   12 +
 arch/arm/boot/dts/aspeed-g4.dtsi              |   26 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   26 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/hwmon/Kconfig                         |   28 +
 drivers/hwmon/Makefile                        |    2 +
 drivers/hwmon/peci-cputemp.c                  |  401 +++++
 drivers/hwmon/peci-dimmtemp.c                 |  295 ++++
 drivers/mfd/Kconfig                           |   11 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/peci-client.c                     |  205 +++
 drivers/peci/Kconfig                          |   40 +
 drivers/peci/Makefile                         |    9 +
 drivers/peci/peci-aspeed.c                    |  498 ++++++
 drivers/peci/peci-core.c                      | 1439 +++++++++++++++++
 include/linux/mfd/peci-client.h               |   60 +
 include/linux/peci.h                          |  104 ++
 include/uapi/linux/peci-ioctl.h               |  265 +++
 27 files changed, 3718 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-cputemp.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/peci-dimmtemp.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/peci-client.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci.txt
 create mode 100644 Documentation/hwmon/peci-cputemp
 create mode 100644 Documentation/hwmon/peci-dimmtemp
 create mode 100644 drivers/hwmon/peci-cputemp.c
 create mode 100644 drivers/hwmon/peci-dimmtemp.c
 create mode 100644 drivers/mfd/peci-client.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/peci-aspeed.c
 create mode 100644 drivers/peci/peci-core.c
 create mode 100644 include/linux/mfd/peci-client.h
 create mode 100644 include/linux/peci.h
 create mode 100644 include/uapi/linux/peci-ioctl.h

-- 
2.17.0
