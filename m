Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBWKYH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:07 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:39969 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeBWKYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:06 -0500
X-Google-Smtp-Source: AH8x227nubmZpfxzKzrDNWb52D8zLNaIoSoJYumSZctF9Er9QvHgYQek2VsxA4FUxVJ9QPv8lCfnBg==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 00/13] drivers: Boot Constraint core
Date: Fri, 23 Feb 2018 15:53:39 +0530
Message-Id: <cover.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

The V7 version incorporates the organizational changes suggested by Olof
earlier. Everything else is same otherwise.

I have tested the Hisilicon patches (again) on hikey 9660 board, IMX stuff was
earlier tested by Sascha (Pengutronix) on i.MX6 and Qualcomm stuff was earlier
tested by Rajendra (Qualcomm) on Dragonboard 410C (This required some more
patches related to display driver which Rajendra should be sending separately
later on).


Problem statement:

Some devices are powered ON by the bootloader before the bootloader
handovers control to Linux. It maybe important for some of those devices
to keep working until the time a Linux device driver probes the device
and reconfigure its resources.

A typical example of that can be the LCD controller, which is used by
the bootloaders to show image(s) while the platform is booting into
Linux.  The LCD controller can be using some resources, like clk,
regulators, etc, that are shared between several devices. These shared
resources should be configured to satisfy need of all the users.  If
another device's (X) driver gets probed before the LCD controller driver
in this case, then it may end up disabling or reconfiguring these
resources to ranges satisfying the current users (only device X) and
that can make the LCD screen unstable.

Another case can be a debug serial port enabled from the bootloader.

Of course we can have more complex cases where the same resource is
getting used by two devices while the kernel boots and the order in
which devices get probed wouldn't matter as the other device will surely
break then.

There are also cases where the resources may not be shared, but the
kernel will disable them forcefully as no users may have appeared until
a certain point in kernel boot. This makes sure that the resources stay
enabled. A wide variety of constraints can be satisfied using the new
framework.

Proposed solution:

This series introduces the concept of "boot-constraint", which are set
by platform specific drivers (for now at least) at early init (like
subsys_initcall) and the kernel will keep satisfying them until the time
driver for such a device is probed (successfully or unsuccessfully).
Once the driver is probed, the driver core removes the constraints set
for the device. This series implements clk, regulator and PM domain
constraints currently.

Pushed here:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git boot-constraint

More documentation on it can be found here:
https://lwn.net/Articles/747250/

V6->V7:
- s/drivers\/boot_constraint/drivers\/bootconstraint/ (Olof)
- Moved platform drivers to drivers/soc/<platform>/boot_constraint.c
- Changed year in file copyrights: s/2017/2018

V5->V6:
- Fix a build error reported by build bot for !CONFIG_OF_ADDRESS. This
  was already sent on 15th December.
- Rebased over latest driver-core-next.

V4->V5:
- SPDX Licence format used.
- arm,primecell stuff removed from boot constraint core and added a
  helper in OF core (which already handles amba and platform devices).
- Removed a bunch of BUG_ON(), pr_fmt(), comments.
- Changed directory and other names from
  boot_constraints/boot_constraint.
- Removed serial.o file and moved the code to hikey and imx files.
- Don't return error from dummy helper.
- Added documentation and corresponding kernel doc comments in the code.
- Updated MAINTAINERS.

V3->V4:
- Added support for imx, hikey and Qcom usecases.
- Enhanced boot constraints core to make drivers code easy and handle
  complex cases.
- Two new patches for OF included to provide APIs to boot constraint
  core.
- Removed the kernel parameter patch for now.
- Don't check return values of debugfs routines.
- Moved the boot constraints core from drivers/base/ to drivers/.

V2->V3:
- Removed DT support as we aren't sure about how to define the bindings
  yet.
- Added CLK and PM domain constraint types.
- A new directory is added for boot constraints, which will also contain
  platform specific drivers in future.
- Deferred devices are still supported, just that it wouldn't be called
  from generic code anymore but platform specific code.
- Tested on Qcom 410c dragonboard with display flash screen (Rajendra).
- Usual renaming/commit-log-updates/etc changes done.

V1->V2:
- Add support for setting constraints for devices created from DT.
- Allow handling deferred devices earlier then late_init.
- Remove 'default y' line from kconfig.
- Drop '=" after boot_constraints_disable kernel param.
- Dropped the dummy testing patch now.

--
viresh


*** BLURB HERE ***

Viresh Kumar (13):
  of: platform: Add of_find_any_device_by_node()
  of: platform: Make of_platform_bus_create() global
  drivers: Add boot constraints core
  boot_constraint: Add support for supply constraints
  boot_constraint: Add support for clk constraints
  boot_constraint: Add support for PM constraints
  boot_constraint: Add debugfs support
  boot_constraint: Manage deferrable constraints
  boot_constraint: Add support for Hisilicon platforms
  boot_constraint: Add support for IMX platform
  boot_constraint: Add Qualcomm display controller constraints
  boot_constraint: Update MAINTAINERS
  boot_constraint: Add documentation

 .../driver-api/boot-constraint/constraints.rst     |  98 +++++++
 Documentation/driver-api/boot-constraint/index.rst |   4 +
 Documentation/driver-api/index.rst                 |   1 +
 MAINTAINERS                                        |   9 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/dd.c                                  |  32 ++-
 drivers/bootconstraint/Kconfig                     |   9 +
 drivers/bootconstraint/Makefile                    |   3 +
 drivers/bootconstraint/clk.c                       |  70 +++++
 drivers/bootconstraint/core.c                      | 290 +++++++++++++++++++++
 drivers/bootconstraint/core.h                      |  47 ++++
 drivers/bootconstraint/deferrable_dev.c            | 241 +++++++++++++++++
 drivers/bootconstraint/pm.c                        |  28 ++
 drivers/bootconstraint/supply.c                    | 104 ++++++++
 drivers/clk/imx/clk-imx25.c                        |  12 -
 drivers/clk/imx/clk-imx27.c                        |  13 -
 drivers/clk/imx/clk-imx31.c                        |  12 -
 drivers/clk/imx/clk-imx35.c                        |  10 -
 drivers/clk/imx/clk-imx51-imx53.c                  |  16 --
 drivers/clk/imx/clk-imx6q.c                        |   8 -
 drivers/clk/imx/clk-imx6sl.c                       |   8 -
 drivers/clk/imx/clk-imx6sx.c                       |   8 -
 drivers/clk/imx/clk-imx7d.c                        |  14 -
 drivers/clk/imx/clk.c                              |  38 ---
 drivers/clk/imx/clk.h                              |   1 -
 drivers/of/platform.c                              |  63 ++++-
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/hisilicon/Kconfig                      |  15 ++
 drivers/soc/hisilicon/Makefile                     |   3 +
 drivers/soc/hisilicon/boot_constraint.c            | 158 +++++++++++
 drivers/soc/imx/Kconfig                            |   8 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/boot_constraint.c                  | 126 +++++++++
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/boot_constraint.c                 | 122 +++++++++
 include/linux/boot_constraint.h                    | 121 +++++++++
 include/linux/of_platform.h                        |  16 ++
 40 files changed, 1572 insertions(+), 151 deletions(-)
 create mode 100644 Documentation/driver-api/boot-constraint/constraints.rst
 create mode 100644 Documentation/driver-api/boot-constraint/index.rst
 create mode 100644 drivers/bootconstraint/Kconfig
 create mode 100644 drivers/bootconstraint/Makefile
 create mode 100644 drivers/bootconstraint/clk.c
 create mode 100644 drivers/bootconstraint/core.c
 create mode 100644 drivers/bootconstraint/core.h
 create mode 100644 drivers/bootconstraint/deferrable_dev.c
 create mode 100644 drivers/bootconstraint/pm.c
 create mode 100644 drivers/bootconstraint/supply.c
 create mode 100644 drivers/soc/hisilicon/Kconfig
 create mode 100644 drivers/soc/hisilicon/Makefile
 create mode 100644 drivers/soc/hisilicon/boot_constraint.c
 create mode 100644 drivers/soc/imx/boot_constraint.c
 create mode 100644 drivers/soc/qcom/boot_constraint.c
 create mode 100644 include/linux/boot_constraint.h

-- 
2.15.0.194.g9af6a3dea062
