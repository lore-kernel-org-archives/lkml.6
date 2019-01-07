Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7EAC43444
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28682147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfAGVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:42:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:19765 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbfAGVmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:42:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 13:41:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,451,1539673200"; 
   d="scan'208";a="124046637"
Received: from maru.jf.intel.com ([10.54.51.77])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Jan 2019 13:41:45 -0800
From:   Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Wu Hao <hao.wu@intel.com>,
        Tomohiro Kusumi <kusumi.tomohiro@gmail.com>,
        "Bryant G . Ly" <bryantly@linux.vnet.ibm.com>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Vinod Koul <vkoul@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        David Kershner <david.kershner@unisys.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Johan Hovold <johan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Subject: [PATCH v10 00/12] PECI device driver introduction
Date:   Mon,  7 Jan 2019 13:41:24 -0800
Message-Id: <20190107214136.5256-1-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction of the Platform Environment Control Interface (PECI) bus
device driver. PECI is a one-wire bus interface that provides a
communication channel from Intel processors and chipset components to
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

Jae

Changes since v9:
- Updated license identifiers to incidate 2019.
- Removed unnecessary member variable and enum type from intel client driver.
- Removed 'type' argument from the access_ok() function call.

Changes since v8:
- Refined descriptions in PECI device tree documents.
- Fixed checking logic of supportable PECI commands using full revision
  number.
- Fixed DIB data size to u64 to make that can contain 8-bytes of information.
- Changed PECI cdev names from pecix to peci-x where x is bus number.
- Refined intel-peci-client driver and moved hwmon relating codes to
  peci-hwmon.h.
- Added missing core label strings into peci-cputemp driver.
- Added kerneldoc comments.

Changes since v7:
- Fixed a typo in the MFD_INTEL_PECI_CLIENT description.
- Made peci_unregister_device() NULL-aware.
- Converted to using %pOF instead of node full name in peci-core.
- Removed OF tables from peci-cputemp and peci-dimmtemp.
- Removed of_compatible strings from intel-peci-client.
- Added an access_ok() check into peci_ioctl in peci-core.
- Changed the DT node name of peci simple-bus from 'peci' to 'bus'.

Changes since v6:
- Dropped off unnecessary examples from dt-bindings document.
- Fixed a bug in DIMM index mask building logic.
- Modified DIMM temp label strings to match with the way in BIOS.
- Changed PECI ioctl base number from B6 to B7 to avoid conflict with
  fpga-dfl.
- Separated the PECI section in MAINTAINERS into two parts - PECI subsystem
  and ASPEED PECI driver.

Changes since v5:
- Added more detailed descriptions for PECI client MFD documents.
- Changed PECI client MFD souce file names.
- Fixed DT example of PECI client MFD.
- Removed unnecessary debug printings.
- Moved the asm/intel-family.h inclusion place.

Changes since v4:
- Fixed an incorrect endianness handling in peci-aspeed.
- Added a comment to explain about the asm/intel-family.h inclusion.
- Added an MFD module to support multi-function PECI client devices.

Changes since v3:
- Made code more simple and compact.
- Removed unused header file inclusion.
- Fixed incorrect error return values and messages.
- Removed DTS margin temperature from the peci-cputemp.
- Made some magic numbers use defines.
- Moved peci_get_cpu_id() into peci-core as a common function.
- Replaced the cancel_delayed_work() call with a cancel_delayed_work_sync().
- Replaced AST and Aspeed uses with ASPEED.
- Simplified peci command timeout checking logic using
  regmap_read_poll_timeout().
- Simplified endian swap codes using endian handling macros.
- Dropped regmap read/write error checking except for the first access.
- Added a PECI reset setting in the device tree node.
- Removed unnecessary sleep from the probe context.
- Removed IRQF_SHARED flag from irq request code in the ASPEED PECI driver.
- Fixed typos in documents.
- Combined peci-bus.txt, peci-adapter.txt and peci-client.txt into peci.txt.
- Fixed and swept documents to drop some incorrect or unnecessary
  descriptions.
- Fixed device tree to make unit-address format use reg contents.
- Simplified bit manipulations using <linux/bitfield.h>.
- Made client CPU model checking use <asm/intel-family.h> if available.
- Modified adapter heap allocation method to use kobject reference count
  based.
- Added the low-level PECI xfer IOCTL again to support the Redfish
  requirement.
- Added PM domain attach/detach code.
- Added logic for device instantiation through sysfs.
- Fix a bug of interrupt status checking code in peci-aspeed driver.

Changes since v2:
- Divided peci-hwmon driver into two drivers, peci-cputemp and
  peci-dimmtemp.
- Added generic dt binding documents for PECI bus, adapter and client.
- Removed in_atomic() call from the PECI core driver.
- Improved PECI commands masking logic.
- Added permission check logic for PECI ioctls.
- Removed unnecessary type casts.
- Fixed some invalid error return codes.
- Added the mark_updated() function to improve update interval checking
  logic.
- Fixed a bug in populated DIMM checking function.
- Fixed some typo, grammar and style issues in documents.
- Rewrote hwmon drivers to use devm_hwmon_device_register_with_info API.
- Made peci_match_id() function as a static.
- Replaced a deprecated create_singlethread_workqueue() call with an
  alloc_ordered_workqueue() call.
- Reordered local variable definitions in reversed xmas tree notation.
- Listed up client CPUs that can be supported by peci-cputemp and
  peci-dimmtemp hwmon drivers.
- Added CPU generation detection logic which checks CPUID signature through
  PECI connection.
- Improved interrupt handling logic in the Aspeed PECI adapter driver.
- Fixed SPDX license identifier style in header files.
- Changed some macros in peci.h to static inline functions.
- Dropped sleepable context checking code in peci-core.
- Adjusted rt_mutex protection scope in peci-core.
- Moved adapter->xfer() checking code into peci_register_adapter().
- Improved PECI command retry checking logic.
- Changed ioctl base from 'P' to 0xb6 to avoid confiliction and updated
  ioctl-number.txt to reflect the ioctl number of PECI subsystem.
- Added a comment to describe PECI retry action.
- Simplified return code handling of peci_ioctl_ping().
- Changed type of peci_ioctl_fn[] to static const.
- Fixed range checking code for valid PECI commands.
- Fixed the error return code on invalid PECI commands.
- Fixed incorrect definitions of PECI ioctl and its handling logic.

Changes since v1:
- Additionally implemented a core driver to support PECI linux bus driver
  model.
- Modified Aspeed PECI driver to make that to be an adapter driver in PECI
  bus.
- Modified PECI hwmon driver to make that to be a client driver in PECI
  bus.
- Simplified hwmon driver attribute labels and removed redundant strings.
- Removed core_nums from device tree setting of hwmon driver and modified
  core number detection logic to check the resolved_core register in client
  CPU's local PCI configuration area.
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

Jae Hyun Yoo (12):
  dt-bindings: Add a document of PECI subsystem
  Documentation: ioctl: Add ioctl numbers for PECI subsystem
  peci: Add support for PECI bus driver core
  dt-bindings: Add a document of PECI adapter driver for ASPEED
    AST24xx/25xx SoCs
  ARM: dts: aspeed: peci: Add PECI node
  peci: Add a PECI adapter driver for Aspeed AST24xx/AST25xx
  dt-bindings: mfd: Add a document for PECI client driver
  mfd: intel-peci-client: Add PECI client driver
  Documentation: hwmon: Add documents for PECI hwmon client drivers
  hwmon: Add PECI cputemp driver
  hwmon: Add PECI dimmtemp driver
  Add maintainers for the PECI subsystem

 .../bindings/mfd/intel-peci-client.txt        |   34 +
 .../devicetree/bindings/peci/peci-aspeed.txt  |   55 +
 .../devicetree/bindings/peci/peci.txt         |   43 +
 Documentation/hwmon/peci-cputemp              |   78 +
 Documentation/hwmon/peci-dimmtemp             |   50 +
 Documentation/ioctl/ioctl-number.txt          |    2 +
 MAINTAINERS                                   |   22 +
 arch/arm/boot/dts/aspeed-g4.dtsi              |   26 +
 arch/arm/boot/dts/aspeed-g5.dtsi              |   26 +
 drivers/Kconfig                               |    2 +
 drivers/Makefile                              |    1 +
 drivers/hwmon/Kconfig                         |   28 +
 drivers/hwmon/Makefile                        |    2 +
 drivers/hwmon/peci-cputemp.c                  |  394 +++++
 drivers/hwmon/peci-dimmtemp.c                 |  284 +++
 drivers/hwmon/peci-hwmon.h                    |   49 +
 drivers/mfd/Kconfig                           |   14 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/intel-peci-client.c               |  143 ++
 drivers/peci/Kconfig                          |   39 +
 drivers/peci/Makefile                         |    9 +
 drivers/peci/peci-aspeed.c                    |  505 ++++++
 drivers/peci/peci-core.c                      | 1527 +++++++++++++++++
 include/linux/mfd/intel-peci-client.h         |  108 ++
 include/linux/peci.h                          |  142 ++
 include/uapi/linux/peci-ioctl.h               |  403 +++++
 26 files changed, 3987 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/intel-peci-client.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.txt
 create mode 100644 Documentation/devicetree/bindings/peci/peci.txt
 create mode 100644 Documentation/hwmon/peci-cputemp
 create mode 100644 Documentation/hwmon/peci-dimmtemp
 create mode 100644 drivers/hwmon/peci-cputemp.c
 create mode 100644 drivers/hwmon/peci-dimmtemp.c
 create mode 100644 drivers/hwmon/peci-hwmon.h
 create mode 100644 drivers/mfd/intel-peci-client.c
 create mode 100644 drivers/peci/Kconfig
 create mode 100644 drivers/peci/Makefile
 create mode 100644 drivers/peci/peci-aspeed.c
 create mode 100644 drivers/peci/peci-core.c
 create mode 100644 include/linux/mfd/intel-peci-client.h
 create mode 100644 include/linux/peci.h
 create mode 100644 include/uapi/linux/peci-ioctl.h

-- 
2.20.1

