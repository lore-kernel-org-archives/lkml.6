Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeBWKYp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:45 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36949 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbeBWKYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:40 -0500
X-Google-Smtp-Source: AH8x227imSka2VRMFskrF7A/zwSmDyC9X4xwb3euugyFAfMT8pdqEopnjyg6U3ZmCrhzpsLMLccgpQ==
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
Subject: [PATCH V7 13/13] boot_constraint: Add documentation
Date: Fri, 23 Feb 2018 15:53:52 +0530
Message-Id: <6b17ffecd9917ff4a1fad848839ea667e92d715f.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds boot constraint documentation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../driver-api/boot-constraint/constraints.rst     | 98 ++++++++++++++++++++++
 Documentation/driver-api/boot-constraint/index.rst |  4 +
 Documentation/driver-api/index.rst                 |  1 +
 3 files changed, 103 insertions(+)
 create mode 100644 Documentation/driver-api/boot-constraint/constraints.rst
 create mode 100644 Documentation/driver-api/boot-constraint/index.rst

diff --git a/Documentation/driver-api/boot-constraint/constraints.rst b/Documentation/driver-api/boot-constraint/constraints.rst
new file mode 100644
index 000000000000..6da2df33f2c9
--- /dev/null
+++ b/Documentation/driver-api/boot-constraint/constraints.rst
@@ -0,0 +1,98 @@
+.. include:: <isonum.txt>
+
+=========================
+Boot Constraint Subsystem
+=========================
+
+:Copyright: |copy| 2017 Viresh Kumar <vireshk@kernel.org>, Linaro Ltd.
+
+Introduction
+============
+
+A lot of devices are configured and powered ON by the bootloader before passing
+on control to the operating system, Linux in our case.  It is important for some
+of them to keep working until the time a Linux device driver probes the device
+and reconfigure it.
+
+A typical example of that can be the LCD controller, which is used by the
+bootloaders to show image(s) while the platform boots Linux.  The LCD controller
+can be using resources like clk, regulators, etc, that are shared with other
+devices. These shared resources should be configured in such a way that they
+satisfy need of all the user devices.  If another device's (X) driver gets
+probed before the LCD controller driver, then it may end up disabling or
+reconfiguring these resources to ranges satisfying only the current user (device
+X) and that may make the LCD screen unstable and present a bad user experience.
+
+Another case can be a debug serial port (earlycon) enabled from the bootloader,
+which may be used to debug early kernel oops.
+
+There are also cases where the resources may not be shared, but the kernel will
+disable them forcefully as no users may have appeared until a certain point in
+the kernel boot.
+
+Of course we can have more complex cases where the same resource is getting used
+by multiple devices while the kernel boots and the order in which the devices
+get probed wouldn't matter as the other devices may break because of the chosen
+configuration of the first probed device.
+
+Adding boot constraints
+=======================
+
+A boot constraint defines a configuration requirement set for the device by the
+boot loader. For example, if a clock is enabled for a device by the bootloader
+and we want the device to be working as is until the time the device is probed
+by its driver, then keeping this clock enabled is one of the boot constraint.
+
+Following are the different type of boot constraints supported currently by the
+core:
+
+.. kernel-doc:: include/linux/boot_constraint.h
+   :functions: dev_boot_constraint_type
+
+
+A single boot constraint can be added using the following helper:
+
+.. kernel-doc:: drivers/bootconstraint/core.c
+   :functions: dev_boot_constraint_add
+
+
+The second parameter to this routine describes the constraint to add and is
+represented by following structures:
+
+.. kernel-doc:: include/linux/boot_constraint.h
+   :functions: dev_boot_constraint dev_boot_constraint_info
+
+The power domain boot constraint doesn't need any data, while the clock and
+power supply boot constraint specific data is represented by following
+structures:
+
+.. kernel-doc:: include/linux/boot_constraint.h
+   :functions: dev_boot_constraint_supply_info dev_boot_constraint_clk_info
+
+
+In order to simplify adding multiple boot constraints for a platform, the boot
+constraints core supplies another helper which can be used to add all
+constraints for the platform.
+
+.. kernel-doc:: drivers/bootconstraint/deferrable_dev.c
+   :functions: dev_boot_constraint_add_deferrable_of
+
+
+The argument of this routine is described by following structure:
+
+.. kernel-doc:: include/linux/boot_constraint.h
+   :functions: dev_boot_constraint_of
+
+
+Removing boot constraints
+=========================
+
+Once the boot constraints are added, they will be honored by the boot constraint
+core until the time a driver tries to probe the device. The constraints are
+removed by the driver core if either the driver successfully probed the device
+or failed with an error value other than -EPROBE_DEFER. The constraints are kept
+as is for deferred probe. The driver core removes the constraints using the
+following helper, which must not be called directly by the platforms:
+
+.. kernel-doc:: drivers/bootconstraint/core.c
+   :functions: dev_boot_constraints_remove
diff --git a/Documentation/driver-api/boot-constraint/index.rst b/Documentation/driver-api/boot-constraint/index.rst
new file mode 100644
index 000000000000..d6fce17626a2
--- /dev/null
+++ b/Documentation/driver-api/boot-constraint/index.rst
@@ -0,0 +1,4 @@
+.. toctree::
+   :maxdepth: 1
+
+   constraints
diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index e9b41b1634f3..f982e71efb73 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -49,6 +49,7 @@ available subsections can be seen below.
    dmaengine/index
    slimbus
    soundwire/index
+   boot-constraint/index
 
 .. only::  subproject and html
 
-- 
2.15.0.194.g9af6a3dea062
