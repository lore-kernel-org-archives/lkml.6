Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbeDQOak (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:30:40 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38796 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751230AbeDQO3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:29:22 -0400
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <lee.jones@linaro.org>, <linus.walleij@linaro.org>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>
CC: <patches@opensource.cirrus.com>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 8/9] pinctrl: madera: Add driver for Cirrus Logic Madera codecs
Date: Tue, 17 Apr 2018 15:29:14 +0100
Message-ID: <20180417142915.15772-9-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180417142915.15772-1-rf@opensource.cirrus.com>
References: <20180417142915.15772-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1804170130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These codecs have a variable number of I/O lines each of which
is individually selectable to a wide range of possible functions.

The functionality is slightly different from the traditional muxed
GPIO since most of the functions can be mapped to any pin (and even
the same function to multiple pins). Most pins have a dedicated
"alternate" function that is only available on that pin. The
alternate functions are usually a group of signals, though it is
not always necessary to enable the full group, depending on the
alternate function and how it is to be used. The mapping between
alternate functions and GPIO pins varies between codecs depending
on the number of alternate functions and available pins.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
There are some minor changes since LinusW last reviewed this patch but as
they are trivial I have carried forward Linus's Reviewed-by:

Changed since v9:
- Fixed build failure on non-DT systems by wrapping the dt function pointer
  setup in a #if. We want to allow this driver to be used on systems without DT.
- Added a __maybe_unused to the pin_dbg_show function

Changed since Linus's reviewed-by:
- SPDX license headers
- can now build it as a module
- avoided a minor checkpatch warning about an unnecessary else {} in
    madera_get_group_name()
---
 MAINTAINERS                                  |    2 +
 drivers/pinctrl/Kconfig                      |    1 +
 drivers/pinctrl/Makefile                     |    1 +
 drivers/pinctrl/cirrus/Kconfig               |   15 +
 drivers/pinctrl/cirrus/Makefile              |   13 +
 drivers/pinctrl/cirrus/pinctrl-cs47l35.c     |   45 ++
 drivers/pinctrl/cirrus/pinctrl-cs47l85.c     |   59 ++
 drivers/pinctrl/cirrus/pinctrl-cs47l90.c     |   57 ++
 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 1076 ++++++++++++++++++++++++++
 drivers/pinctrl/cirrus/pinctrl-madera.h      |   41 +
 10 files changed, 1310 insertions(+)
 create mode 100644 drivers/pinctrl/cirrus/Kconfig
 create mode 100644 drivers/pinctrl/cirrus/Makefile
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l35.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l85.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs47l90.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera-core.c
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-madera.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f8bde8b1f62..716c4743892d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3485,9 +3485,11 @@ T:	git https://github.com/CirrusLogic/linux-drivers.git
 W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
+F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
 F:	include/linux/mfd/madera/*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
+F:	drivers/pinctrl/cirrus/*
 
 CLEANCACHE API
 M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 01fe8e0455a0..bc3bd2075ed0 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -359,6 +359,7 @@ source "drivers/pinctrl/vt8500/Kconfig"
 source "drivers/pinctrl/mediatek/Kconfig"
 source "drivers/pinctrl/zte/Kconfig"
 source "drivers/pinctrl/meson/Kconfig"
+source "drivers/pinctrl/cirrus/Kconfig"
 
 config PINCTRL_XWAY
 	bool
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 657332b121fb..e9aa4f913376 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -63,3 +63,4 @@ obj-$(CONFIG_PINCTRL_UNIPHIER)	+= uniphier/
 obj-$(CONFIG_ARCH_VT8500)	+= vt8500/
 obj-y				+= mediatek/
 obj-$(CONFIG_PINCTRL_ZX)	+= zte/
+obj-y				+= cirrus/
diff --git a/drivers/pinctrl/cirrus/Kconfig b/drivers/pinctrl/cirrus/Kconfig
new file mode 100644
index 000000000000..a86e354bb62a
--- /dev/null
+++ b/drivers/pinctrl/cirrus/Kconfig
@@ -0,0 +1,15 @@
+# This is all selected by the Madera MFD driver Kconfig options
+config PINCTRL_MADERA
+	tristate
+	select PINMUX
+	select GENERIC_PINCONF
+
+config PINCTRL_CS47L35
+	bool
+
+config PINCTRL_CS47L85
+	bool
+
+config PINCTRL_CS47L90
+	bool
+
diff --git a/drivers/pinctrl/cirrus/Makefile b/drivers/pinctrl/cirrus/Makefile
new file mode 100644
index 000000000000..6e4938cde9e3
--- /dev/null
+++ b/drivers/pinctrl/cirrus/Makefile
@@ -0,0 +1,13 @@
+# Cirrus Logic pinctrl drivers
+pinctrl-madera-objs		:= pinctrl-madera-core.o
+ifeq ($(CONFIG_PINCTRL_CS47L35),y)
+pinctrl-madera-objs		+= pinctrl-cs47l35.o
+endif
+ifeq ($(CONFIG_PINCTRL_CS47L85),y)
+pinctrl-madera-objs		+= pinctrl-cs47l85.o
+endif
+ifeq ($(CONFIG_PINCTRL_CS47L90),y)
+pinctrl-madera-objs		+= pinctrl-cs47l90.o
+endif
+
+obj-$(CONFIG_PINCTRL_MADERA)	+= pinctrl-madera.o
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs47l35.c b/drivers/pinctrl/cirrus/pinctrl-cs47l35.c
new file mode 100644
index 000000000000..06b59160783d
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-cs47l35.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl for Cirrus Logic CS47L35
+ *
+ * Copyright (C) 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/madera/core.h>
+
+#include "pinctrl-madera.h"
+
+/*
+ * The alt func groups are the most commonly used functions we place these at
+ * the lower function indexes for convenience, and the less commonly used gpio
+ * functions at higher indexes.
+ *
+ * To stay consistent with the datasheet the function names are the same as
+ * the group names for that function's pins
+ *
+ * Note - all 1 less than in datasheet because these are zero-indexed
+ */
+static const unsigned int cs47l35_aif3_pins[] = { 0, 1, 2, 3 };
+static const unsigned int cs47l35_spk_pins[] = { 4, 5 };
+static const unsigned int cs47l35_aif1_pins[] = { 7, 8, 9, 10 };
+static const unsigned int cs47l35_aif2_pins[] = { 11, 12, 13, 14 };
+static const unsigned int cs47l35_mif1_pins[] = { 6, 15 };
+
+static const struct madera_pin_groups cs47l35_pin_groups[] = {
+	{ "aif1", cs47l35_aif1_pins, ARRAY_SIZE(cs47l35_aif1_pins) },
+	{ "aif2", cs47l35_aif2_pins, ARRAY_SIZE(cs47l35_aif2_pins) },
+	{ "aif3", cs47l35_aif3_pins, ARRAY_SIZE(cs47l35_aif3_pins) },
+	{ "mif1", cs47l35_mif1_pins, ARRAY_SIZE(cs47l35_mif1_pins) },
+	{ "pdmspk1", cs47l35_spk_pins, ARRAY_SIZE(cs47l35_spk_pins) },
+};
+
+const struct madera_pin_chip cs47l35_pin_chip = {
+	.n_pins = CS47L35_NUM_GPIOS,
+	.pin_groups = cs47l35_pin_groups,
+	.n_pin_groups = ARRAY_SIZE(cs47l35_pin_groups),
+};
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs47l85.c b/drivers/pinctrl/cirrus/pinctrl-cs47l85.c
new file mode 100644
index 000000000000..0a322e2a0fde
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-cs47l85.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl for Cirrus Logic CS47L85
+ *
+ * Copyright (C) 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/madera/core.h>
+
+#include "pinctrl-madera.h"
+
+/*
+ * The alt func groups are the most commonly used functions we place these at
+ * the lower function indexes for convenience, and the less commonly used gpio
+ * functions at higher indexes.
+ *
+ * To stay consistent with the datasheet the function names are the same as
+ * the group names for that function's pins
+ *
+ * Note - all 1 less than in datasheet because these are zero-indexed
+ */
+static const unsigned int cs47l85_mif1_pins[] = { 8, 9 };
+static const unsigned int cs47l85_mif2_pins[] = { 10, 11 };
+static const unsigned int cs47l85_mif3_pins[] = { 12, 13 };
+static const unsigned int cs47l85_aif1_pins[] = { 14, 15, 16, 17 };
+static const unsigned int cs47l85_aif2_pins[] = { 18, 19, 20, 21 };
+static const unsigned int cs47l85_aif3_pins[] = { 22, 23, 24, 25 };
+static const unsigned int cs47l85_aif4_pins[] = { 26, 27, 28, 29 };
+static const unsigned int cs47l85_dmic4_pins[] = { 30, 31 };
+static const unsigned int cs47l85_dmic5_pins[] = { 32, 33 };
+static const unsigned int cs47l85_dmic6_pins[] = { 34, 35 };
+static const unsigned int cs47l85_spk1_pins[] = { 36, 38 };
+static const unsigned int cs47l85_spk2_pins[] = { 37, 39 };
+
+static const struct madera_pin_groups cs47l85_pin_groups[] = {
+	{ "aif1", cs47l85_aif1_pins, ARRAY_SIZE(cs47l85_aif1_pins) },
+	{ "aif2", cs47l85_aif2_pins, ARRAY_SIZE(cs47l85_aif2_pins) },
+	{ "aif3", cs47l85_aif3_pins, ARRAY_SIZE(cs47l85_aif3_pins) },
+	{ "aif4", cs47l85_aif4_pins, ARRAY_SIZE(cs47l85_aif4_pins) },
+	{ "mif1", cs47l85_mif1_pins, ARRAY_SIZE(cs47l85_mif1_pins) },
+	{ "mif2", cs47l85_mif2_pins, ARRAY_SIZE(cs47l85_mif2_pins) },
+	{ "mif3", cs47l85_mif3_pins, ARRAY_SIZE(cs47l85_mif3_pins) },
+	{ "dmic4", cs47l85_dmic4_pins, ARRAY_SIZE(cs47l85_dmic4_pins) },
+	{ "dmic5", cs47l85_dmic5_pins, ARRAY_SIZE(cs47l85_dmic5_pins) },
+	{ "dmic6", cs47l85_dmic6_pins, ARRAY_SIZE(cs47l85_dmic6_pins) },
+	{ "pdmspk1", cs47l85_spk1_pins, ARRAY_SIZE(cs47l85_spk1_pins) },
+	{ "pdmspk2", cs47l85_spk2_pins, ARRAY_SIZE(cs47l85_spk2_pins) },
+};
+
+const struct madera_pin_chip cs47l85_pin_chip = {
+	.n_pins = CS47L85_NUM_GPIOS,
+	.pin_groups = cs47l85_pin_groups,
+	.n_pin_groups = ARRAY_SIZE(cs47l85_pin_groups),
+};
diff --git a/drivers/pinctrl/cirrus/pinctrl-cs47l90.c b/drivers/pinctrl/cirrus/pinctrl-cs47l90.c
new file mode 100644
index 000000000000..fc38f579f492
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-cs47l90.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl for Cirrus Logic CS47L90
+ *
+ * Copyright (C) 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#include <linux/err.h>
+#include <linux/mfd/madera/core.h>
+
+#include "pinctrl-madera.h"
+
+/*
+ * The alt func groups are the most commonly used functions we place these at
+ * the lower function indexes for convenience, and the less commonly used gpio
+ * functions at higher indexes.
+ *
+ * To stay consistent with the datasheet the function names are the same as
+ * the group names for that function's pins
+ *
+ * Note - all 1 less than in datasheet because these are zero-indexed
+ */
+static const unsigned int cs47l90_mif1_pins[] = { 8, 9 };
+static const unsigned int cs47l90_mif2_pins[] = { 10, 11 };
+static const unsigned int cs47l90_mif3_pins[] = { 12, 13 };
+static const unsigned int cs47l90_aif1_pins[] = { 14, 15, 16, 17 };
+static const unsigned int cs47l90_aif2_pins[] = { 18, 19, 20, 21 };
+static const unsigned int cs47l90_aif3_pins[] = { 22, 23, 24, 25 };
+static const unsigned int cs47l90_aif4_pins[] = { 26, 27, 28, 29 };
+static const unsigned int cs47l90_dmic4_pins[] = { 30, 31 };
+static const unsigned int cs47l90_dmic5_pins[] = { 32, 33 };
+static const unsigned int cs47l90_dmic3_pins[] = { 34, 35 };
+static const unsigned int cs47l90_spk1_pins[] = { 36, 37 };
+
+static const struct madera_pin_groups cs47l90_pin_groups[] = {
+	{ "aif1", cs47l90_aif1_pins, ARRAY_SIZE(cs47l90_aif1_pins) },
+	{ "aif2", cs47l90_aif2_pins, ARRAY_SIZE(cs47l90_aif2_pins) },
+	{ "aif3", cs47l90_aif3_pins, ARRAY_SIZE(cs47l90_aif3_pins) },
+	{ "aif4", cs47l90_aif4_pins, ARRAY_SIZE(cs47l90_aif4_pins) },
+	{ "mif1", cs47l90_mif1_pins, ARRAY_SIZE(cs47l90_mif1_pins) },
+	{ "mif2", cs47l90_mif2_pins, ARRAY_SIZE(cs47l90_mif2_pins) },
+	{ "mif3", cs47l90_mif3_pins, ARRAY_SIZE(cs47l90_mif3_pins) },
+	{ "dmic3", cs47l90_dmic3_pins, ARRAY_SIZE(cs47l90_dmic3_pins) },
+	{ "dmic4", cs47l90_dmic4_pins, ARRAY_SIZE(cs47l90_dmic4_pins) },
+	{ "dmic5", cs47l90_dmic5_pins, ARRAY_SIZE(cs47l90_dmic5_pins) },
+	{ "pdmspk1", cs47l90_spk1_pins, ARRAY_SIZE(cs47l90_spk1_pins) },
+};
+
+const struct madera_pin_chip cs47l90_pin_chip = {
+	.n_pins = CS47L90_NUM_GPIOS,
+	.pin_groups = cs47l90_pin_groups,
+	.n_pin_groups = ARRAY_SIZE(cs47l90_pin_groups),
+};
diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
new file mode 100644
index 000000000000..ece41fb2848f
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -0,0 +1,1076 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl for Cirrus Logic Madera codecs
+ *
+ * Copyright (C) 2016-2018 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinconf-generic.h>
+
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/registers.h>
+
+#include "../pinctrl-utils.h"
+
+#include "pinctrl-madera.h"
+
+/*
+ * Use pin GPIO names for consistency
+ * NOTE: IDs are zero-indexed for coding convenience
+ */
+static const struct pinctrl_pin_desc madera_pins[] = {
+	PINCTRL_PIN(0, "gpio1"),
+	PINCTRL_PIN(1, "gpio2"),
+	PINCTRL_PIN(2, "gpio3"),
+	PINCTRL_PIN(3, "gpio4"),
+	PINCTRL_PIN(4, "gpio5"),
+	PINCTRL_PIN(5, "gpio6"),
+	PINCTRL_PIN(6, "gpio7"),
+	PINCTRL_PIN(7, "gpio8"),
+	PINCTRL_PIN(8, "gpio9"),
+	PINCTRL_PIN(9, "gpio10"),
+	PINCTRL_PIN(10, "gpio11"),
+	PINCTRL_PIN(11, "gpio12"),
+	PINCTRL_PIN(12, "gpio13"),
+	PINCTRL_PIN(13, "gpio14"),
+	PINCTRL_PIN(14, "gpio15"),
+	PINCTRL_PIN(15, "gpio16"),
+	PINCTRL_PIN(16, "gpio17"),
+	PINCTRL_PIN(17, "gpio18"),
+	PINCTRL_PIN(18, "gpio19"),
+	PINCTRL_PIN(19, "gpio20"),
+	PINCTRL_PIN(20, "gpio21"),
+	PINCTRL_PIN(21, "gpio22"),
+	PINCTRL_PIN(22, "gpio23"),
+	PINCTRL_PIN(23, "gpio24"),
+	PINCTRL_PIN(24, "gpio25"),
+	PINCTRL_PIN(25, "gpio26"),
+	PINCTRL_PIN(26, "gpio27"),
+	PINCTRL_PIN(27, "gpio28"),
+	PINCTRL_PIN(28, "gpio29"),
+	PINCTRL_PIN(29, "gpio30"),
+	PINCTRL_PIN(30, "gpio31"),
+	PINCTRL_PIN(31, "gpio32"),
+	PINCTRL_PIN(32, "gpio33"),
+	PINCTRL_PIN(33, "gpio34"),
+	PINCTRL_PIN(34, "gpio35"),
+	PINCTRL_PIN(35, "gpio36"),
+	PINCTRL_PIN(36, "gpio37"),
+	PINCTRL_PIN(37, "gpio38"),
+	PINCTRL_PIN(38, "gpio39"),
+	PINCTRL_PIN(39, "gpio40"),
+};
+
+/*
+ * All single-pin functions can be mapped to any GPIO, however pinmux applies
+ * functions to pin groups and only those groups declared as supporting that
+ * function. To make this work we must put each pin in its own dummy group so
+ * that the functions can be described as applying to all pins.
+ * Since these do not correspond to anything in the actual hardware - they are
+ * merely an adaptation to pinctrl's view of the world - we use the same name
+ * as the pin to avoid confusion when comparing with datasheet instructions
+ */
+static const char * const madera_pin_single_group_names[] = {
+	"gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",  "gpio7",
+	"gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
+	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
+	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
+	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
+	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40",
+};
+
+/* set of pin numbers for single-pin groups, zero-indexed */
+static const unsigned int madera_pin_single_group_pins[] = {
+	  0,  1,  2,  3,  4,  5,  6,
+	  7,  8,  9, 10, 11, 12, 13,
+	 14, 15, 16, 17, 18, 19, 20,
+	 21, 22, 23, 24, 25, 26, 27,
+	 28, 29, 30, 31, 32, 33, 34,
+	 35, 36, 37, 38, 39,
+};
+
+static const char * const madera_aif1_group_names[] = { "aif1" };
+static const char * const madera_aif2_group_names[] = { "aif2" };
+static const char * const madera_aif3_group_names[] = { "aif3" };
+static const char * const madera_aif4_group_names[] = { "aif4" };
+static const char * const madera_mif1_group_names[] = { "mif1" };
+static const char * const madera_mif2_group_names[] = { "mif2" };
+static const char * const madera_mif3_group_names[] = { "mif3" };
+static const char * const madera_dmic3_group_names[] = { "dmic3" };
+static const char * const madera_dmic4_group_names[] = { "dmic4" };
+static const char * const madera_dmic5_group_names[] = { "dmic5" };
+static const char * const madera_dmic6_group_names[] = { "dmic6" };
+static const char * const madera_spk1_group_names[] = { "pdmspk1" };
+static const char * const madera_spk2_group_names[] = { "pdmspk2" };
+
+/*
+ * alt-functions always apply to a single pin group, other functions always
+ * apply to all pins
+ */
+static const struct {
+	const char *name;
+	const char * const *group_names;
+	u32 func;
+} madera_mux_funcs[] = {
+	{
+		.name = "aif1",
+		.group_names = madera_aif1_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "aif2",
+		.group_names = madera_aif2_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "aif3",
+		.group_names = madera_aif3_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "aif4",
+		.group_names = madera_aif4_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "mif1",
+		.group_names = madera_mif1_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "mif2",
+		.group_names = madera_mif2_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "mif3",
+		.group_names = madera_mif3_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "dmic3",
+		.group_names = madera_dmic3_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "dmic4",
+		.group_names = madera_dmic4_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "dmic5",
+		.group_names = madera_dmic5_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "dmic6",
+		.group_names = madera_dmic6_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "pdmspk1",
+		.group_names = madera_spk1_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "pdmspk2",
+		.group_names = madera_spk2_group_names,
+		.func = 0x000
+	},
+	{
+		.name = "io",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x001
+	},
+	{
+		.name = "dsp-gpio",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x002
+	},
+	{
+		.name = "irq1",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x003
+	},
+	{
+		.name = "irq2",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x004
+	},
+	{
+		.name = "fll1-clk",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x010
+	},
+	{
+		.name = "fll2-clk",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x011
+	},
+	{
+		.name = "fll3-clk",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x012
+	},
+	{
+		.name = "fllao-clk",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x013
+	},
+	{
+		.name = "fll1-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x018
+	},
+	{
+		.name = "fll2-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x019
+	},
+	{
+		.name = "fll3-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x01a
+	},
+	{
+		.name = "fllao-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x01b
+	},
+	{
+		.name = "opclk",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x040
+	},
+	{
+		.name = "opclk-async",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x041
+	},
+	{
+		.name = "pwm1",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x048
+	},
+	{
+		.name = "pwm2",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x049
+	},
+	{
+		.name = "spdif",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x04c
+	},
+	{
+		.name = "asrc1-in1-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x088
+	},
+	{
+		.name = "asrc1-in2-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x089
+	},
+	{
+		.name = "asrc2-in1-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x08a
+	},
+	{
+		.name = "asrc2-in2-lock",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x08b
+	},
+	{
+		.name = "spkl-short-circuit",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x0b6
+	},
+	{
+		.name = "spkr-short-circuit",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x0b7
+	},
+	{
+		.name = "spk-shutdown",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x0e0
+	},
+	{
+		.name = "spk-overheat-shutdown",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x0e1
+	},
+	{
+		.name = "spk-overheat-warn",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x0e2
+	},
+	{
+		.name = "timer1-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x140
+	},
+	{
+		.name = "timer2-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x141
+	},
+	{
+		.name = "timer3-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x142
+	},
+	{
+		.name = "timer4-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x143
+	},
+	{
+		.name = "timer5-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x144
+	},
+	{
+		.name = "timer6-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x145
+	},
+	{
+		.name = "timer7-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x146
+	},
+	{
+		.name = "timer8-sts",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x147
+	},
+	{
+		.name = "log1-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x150
+	},
+	{
+		.name = "log2-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x151
+	},
+	{
+		.name = "log3-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x152
+	},
+	{
+		.name = "log4-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x153
+	},
+	{
+		.name = "log5-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x154
+	},
+	{
+		.name = "log6-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x155
+	},
+	{
+		.name = "log7-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x156
+	},
+	{
+		.name = "log8-fifo-ne",
+		.group_names = madera_pin_single_group_names,
+		.func = 0x157
+	},
+};
+
+static u16 madera_pin_make_drv_str(struct madera_pin_private *priv,
+				      unsigned int milliamps)
+{
+	switch (milliamps) {
+	case 4:
+		return 0;
+	case 8:
+		return 2 << MADERA_GP1_DRV_STR_SHIFT;
+	default:
+		break;
+	}
+
+	dev_warn(priv->dev, "%u mA not a valid drive strength", milliamps);
+
+	return 0;
+}
+
+static unsigned int madera_pin_unmake_drv_str(struct madera_pin_private *priv,
+					      u16 regval)
+{
+	regval = (regval & MADERA_GP1_DRV_STR_MASK) >> MADERA_GP1_DRV_STR_SHIFT;
+
+	switch (regval) {
+	case 0:
+		return 4;
+	case 2:
+		return 8;
+	default:
+		return 0;
+	}
+}
+
+static int madera_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	/* Number of alt function groups plus number of single-pin groups */
+	return priv->chip->n_pin_groups + priv->chip->n_pins;
+}
+
+static const char *madera_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector < priv->chip->n_pin_groups)
+		return priv->chip->pin_groups[selector].name;
+
+	selector -= priv->chip->n_pin_groups;
+	return madera_pin_single_group_names[selector];
+}
+
+static int madera_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector < priv->chip->n_pin_groups) {
+		*pins = priv->chip->pin_groups[selector].pins;
+		*num_pins = priv->chip->pin_groups[selector].n_pins;
+	} else {
+		/* return the dummy group for a single pin */
+		selector -= priv->chip->n_pin_groups;
+		*pins = &madera_pin_single_group_pins[selector];
+		*num_pins = 1;
+	}
+	return 0;
+}
+
+static void madera_pin_dbg_show_fn(struct madera_pin_private *priv,
+				   struct seq_file *s,
+				   unsigned int pin, unsigned int fn)
+{
+	const struct madera_pin_chip *chip = priv->chip;
+	int i, g_pin;
+
+	if (fn != 0) {
+		for (i = 0; i < ARRAY_SIZE(madera_mux_funcs); ++i) {
+			if (madera_mux_funcs[i].func == fn) {
+				seq_printf(s, " FN=%s",
+					   madera_mux_funcs[i].name);
+				return;
+			}
+		}
+		return;	/* ignore unknown function values */
+	}
+
+	/* alt function */
+	for (i = 0; i < chip->n_pin_groups; ++i) {
+		for (g_pin = 0; g_pin < chip->pin_groups[i].n_pins; ++g_pin) {
+			if (chip->pin_groups[i].pins[g_pin] == pin) {
+				seq_printf(s, " FN=%s",
+					   chip->pin_groups[i].name);
+				return;
+			}
+		}
+	}
+}
+
+static void __maybe_unused madera_pin_dbg_show(struct pinctrl_dev *pctldev,
+					       struct seq_file *s,
+					       unsigned int pin)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int conf[2];
+	unsigned int reg = MADERA_GPIO1_CTRL_1 + (2 * pin);
+	unsigned int fn;
+	int ret;
+
+	ret = regmap_read(priv->madera->regmap, reg, &conf[0]);
+	if (ret)
+		return;
+
+	ret = regmap_read(priv->madera->regmap, reg + 1, &conf[1]);
+	if (ret)
+		return;
+
+	seq_printf(s, "%04x:%04x", conf[0], conf[1]);
+
+	fn = (conf[0] & MADERA_GP1_FN_MASK) >> MADERA_GP1_FN_SHIFT;
+	madera_pin_dbg_show_fn(priv, s, pin, fn);
+
+	/* State of direction bit is only relevant if function==1 */
+	if (fn == 1) {
+		if (conf[1] & MADERA_GP1_DIR_MASK)
+			seq_puts(s, " IN");
+		else
+			seq_puts(s, " OUT");
+	}
+
+	if (conf[1] & MADERA_GP1_PU_MASK)
+		seq_puts(s, " PU");
+
+	if (conf[1] & MADERA_GP1_PD_MASK)
+		seq_puts(s, " PD");
+
+	if (conf[0] & MADERA_GP1_DB_MASK)
+		seq_puts(s, " DB");
+
+	if (conf[0] & MADERA_GP1_OP_CFG_MASK)
+		seq_puts(s, " OD");
+	else
+		seq_puts(s, " CMOS");
+
+	seq_printf(s, " DRV=%umA", madera_pin_unmake_drv_str(priv, conf[1]));
+
+	if (conf[0] & MADERA_GP1_IP_CFG_MASK)
+		seq_puts(s, "SCHMITT");
+}
+
+
+static const struct pinctrl_ops madera_pin_group_ops = {
+	.get_groups_count = madera_get_groups_count,
+	.get_group_name = madera_get_group_name,
+	.get_group_pins = madera_get_group_pins,
+#if IS_ENABLED(CONFIG_OF)
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_all,
+	.dt_free_map = pinctrl_utils_free_map,
+#endif
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+	.pin_dbg_show = madera_pin_dbg_show,
+#endif
+};
+
+static int madera_mux_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(madera_mux_funcs);
+}
+
+static const char *madera_mux_get_func_name(struct pinctrl_dev *pctldev,
+					    unsigned int selector)
+{
+	return madera_mux_funcs[selector].name;
+}
+
+static int madera_mux_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	*groups = madera_mux_funcs[selector].group_names;
+
+	if (madera_mux_funcs[selector].func == 0) {
+		/* alt func always maps to a single group */
+		*num_groups = 1;
+	} else {
+		/* other funcs map to all available gpio pins */
+		*num_groups = priv->chip->n_pins;
+	}
+
+	return 0;
+}
+
+static int madera_mux_set_mux(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct madera *madera = priv->madera;
+	const struct madera_pin_groups *pin_group = priv->chip->pin_groups;
+	unsigned int n_chip_groups = priv->chip->n_pin_groups;
+	const char *func_name = madera_mux_funcs[selector].name;
+	unsigned int reg;
+	int i, ret;
+
+	dev_dbg(priv->dev, "%s selecting %u (%s) for group %u (%s)\n",
+		__func__, selector, func_name, group,
+		madera_get_group_name(pctldev, group));
+
+	if (madera_mux_funcs[selector].func == 0) {
+		/* alt func pin assignments are codec-specific */
+		for (i = 0; i < n_chip_groups; ++i) {
+			if (strcmp(func_name, pin_group->name) == 0)
+				break;
+
+			++pin_group;
+		}
+
+		if (i == n_chip_groups)
+			return -EINVAL;
+
+		for (i = 0; i < pin_group->n_pins; ++i) {
+			reg = MADERA_GPIO1_CTRL_1 + (2 * pin_group->pins[i]);
+
+			dev_dbg(priv->dev, "%s setting 0x%x func bits to 0\n",
+				__func__, reg);
+
+			ret = regmap_update_bits(madera->regmap, reg,
+						 MADERA_GP1_FN_MASK, 0);
+			if (ret)
+				break;
+
+		}
+	} else {
+		/*
+		 * for other funcs the group will be the gpio number and will
+		 * be offset by the number of chip-specific functions at the
+		 * start of the group list
+		 */
+		group -= n_chip_groups;
+		reg = MADERA_GPIO1_CTRL_1 + (2 * group);
+
+		dev_dbg(priv->dev, "%s setting 0x%x func bits to 0x%x\n",
+			__func__, reg, madera_mux_funcs[selector].func);
+
+		ret = regmap_update_bits(madera->regmap,
+					 reg,
+					 MADERA_GP1_FN_MASK,
+					 madera_mux_funcs[selector].func);
+	}
+
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static int madera_gpio_set_direction(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned int offset,
+				     bool input)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct madera *madera = priv->madera;
+	unsigned int reg = MADERA_GPIO1_CTRL_2 + (2 * offset);
+	unsigned int val;
+	int ret;
+
+	if (input)
+		val = MADERA_GP1_DIR;
+	else
+		val = 0;
+
+	ret = regmap_update_bits(madera->regmap, reg, MADERA_GP1_DIR_MASK, val);
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static int madera_gpio_request_enable(struct pinctrl_dev *pctldev,
+				      struct pinctrl_gpio_range *range,
+				      unsigned int offset)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct madera *madera = priv->madera;
+	unsigned int reg = MADERA_GPIO1_CTRL_1 + (2 * offset);
+	int ret;
+
+	/* put the pin into GPIO mode */
+	ret = regmap_update_bits(madera->regmap, reg, MADERA_GP1_FN_MASK, 1);
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static void madera_gpio_disable_free(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned int offset)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	struct madera *madera = priv->madera;
+	unsigned int reg = MADERA_GPIO1_CTRL_1 + (2 * offset);
+	int ret;
+
+	/* disable GPIO by setting to GPIO IN */
+	madera_gpio_set_direction(pctldev, range, offset, true);
+
+	ret = regmap_update_bits(madera->regmap, reg, MADERA_GP1_FN_MASK, 1);
+	if (ret)
+		dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);
+}
+
+static const struct pinmux_ops madera_pin_mux_ops = {
+	.get_functions_count = madera_mux_get_funcs_count,
+	.get_function_name = madera_mux_get_func_name,
+	.get_function_groups = madera_mux_get_groups,
+	.set_mux = madera_mux_set_mux,
+	.gpio_request_enable = madera_gpio_request_enable,
+	.gpio_disable_free = madera_gpio_disable_free,
+	.gpio_set_direction = madera_gpio_set_direction,
+	.strict = true, /* GPIO and other functions are exclusive */
+};
+
+static int madera_pin_conf_get(struct pinctrl_dev *pctldev, unsigned int pin,
+			       unsigned long *config)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	unsigned int param = pinconf_to_config_param(*config);
+	unsigned int result = 0;
+	unsigned int reg = MADERA_GPIO1_CTRL_1 + (2 * pin);
+	unsigned int conf[2];
+	int ret;
+
+	ret = regmap_read(priv->madera->regmap, reg, &conf[0]);
+	if (!ret)
+		ret = regmap_read(priv->madera->regmap, reg + 1, &conf[1]);
+
+	if (ret) {
+		dev_err(priv->dev, "Failed to read GP%d conf (%d)\n",
+			pin + 1, ret);
+		return ret;
+	}
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_BUS_HOLD:
+		conf[1] &= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+		if (conf[1] == (MADERA_GP1_PU | MADERA_GP1_PD))
+			result = 1;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		conf[1] &= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+		if (!conf[1])
+			result = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		conf[1] &= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+		if (conf[1] == MADERA_GP1_PD_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		conf[1] &= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+		if (conf[1] == MADERA_GP1_PU_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (conf[0] & MADERA_GP1_OP_CFG_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (!(conf[0] & MADERA_GP1_OP_CFG_MASK))
+			result = 1;
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		result = madera_pin_unmake_drv_str(priv, conf[1]);
+		break;
+	case PIN_CONFIG_INPUT_DEBOUNCE:
+		if (conf[0] & MADERA_GP1_DB_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		if (conf[0] & MADERA_GP1_DIR_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_INPUT_SCHMITT:
+	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+		if (conf[0] & MADERA_GP1_IP_CFG_MASK)
+			result = 1;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		if ((conf[1] & MADERA_GP1_DIR_MASK) &&
+		    (conf[0] & MADERA_GP1_LVL_MASK))
+			result = 1;
+		break;
+	default:
+		break;
+	}
+
+	*config = pinconf_to_config_packed(param, result);
+
+	return 0;
+}
+
+static int madera_pin_conf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			       unsigned long *configs, unsigned int num_configs)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	u16 conf[2] = {0, 0};
+	u16 mask[2] = {0, 0};
+	unsigned int reg = MADERA_GPIO1_CTRL_1 + (2 * pin);
+	unsigned int val;
+	int ret;
+
+	while (num_configs) {
+		dev_dbg(priv->dev, "%s config 0x%lx\n", __func__, *configs);
+
+		switch (pinconf_to_config_param(*configs)) {
+		case PIN_CONFIG_BIAS_BUS_HOLD:
+			mask[1] |= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+			conf[1] |= MADERA_GP1_PU | MADERA_GP1_PD;
+			break;
+		case PIN_CONFIG_BIAS_DISABLE:
+			mask[1] |= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+			conf[1] &= ~(MADERA_GP1_PU | MADERA_GP1_PD);
+			break;
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			mask[1] |= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+			conf[1] |= MADERA_GP1_PD;
+			conf[1] &= ~MADERA_GP1_PU;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			mask[1] |= MADERA_GP1_PU_MASK | MADERA_GP1_PD_MASK;
+			conf[1] |= MADERA_GP1_PU;
+			conf[1] &= ~MADERA_GP1_PD;
+			break;
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			mask[0] |= MADERA_GP1_OP_CFG_MASK;
+			conf[0] |= MADERA_GP1_OP_CFG;
+			break;
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			mask[0] |= MADERA_GP1_OP_CFG_MASK;
+			conf[0] &= ~MADERA_GP1_OP_CFG;
+			break;
+		case PIN_CONFIG_DRIVE_STRENGTH:
+			val = pinconf_to_config_argument(*configs);
+			mask[1] |= MADERA_GP1_DRV_STR_MASK;
+			conf[1] &= ~MADERA_GP1_DRV_STR_MASK;
+			conf[1] |= madera_pin_make_drv_str(priv, val);
+			break;
+		case PIN_CONFIG_INPUT_DEBOUNCE:
+			mask[0] |= MADERA_GP1_DB_MASK;
+
+			/*
+			 * we can't configure debounce time per-pin so value
+			 * is just a flag
+			 */
+			val = pinconf_to_config_argument(*configs);
+			if (val)
+				conf[0] |= MADERA_GP1_DB;
+			else
+				conf[0] &= ~MADERA_GP1_DB;
+			break;
+		case PIN_CONFIG_INPUT_ENABLE:
+			val = pinconf_to_config_argument(*configs);
+			mask[1] |= MADERA_GP1_DIR_MASK;
+			if (val)
+				conf[1] |= MADERA_GP1_DIR;
+			else
+				conf[1] &= ~MADERA_GP1_DIR;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT:
+			val = pinconf_to_config_argument(*configs);
+			mask[0] |= MADERA_GP1_IP_CFG;
+			if (val)
+				conf[0] |= MADERA_GP1_IP_CFG;
+			else
+				conf[0] &= ~MADERA_GP1_IP_CFG;
+
+			mask[1] |= MADERA_GP1_DIR_MASK;
+			conf[1] |= MADERA_GP1_DIR;
+			break;
+		case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
+			mask[0] |= MADERA_GP1_IP_CFG;
+			conf[0] |= MADERA_GP1_IP_CFG;
+			mask[1] |= MADERA_GP1_DIR_MASK;
+			conf[1] |= MADERA_GP1_DIR;
+			break;
+		case PIN_CONFIG_OUTPUT:
+			val = pinconf_to_config_argument(*configs);
+			mask[0] |= MADERA_GP1_LVL_MASK;
+			if (val)
+				conf[0] |= MADERA_GP1_LVL;
+			else
+				conf[0] &= ~MADERA_GP1_LVL;
+
+			mask[1] |= MADERA_GP1_DIR_MASK;
+			conf[1] &= ~MADERA_GP1_DIR;
+			break;
+		default:
+			break;
+		}
+
+		++configs;
+		--num_configs;
+	}
+
+	dev_dbg(priv->dev,
+		"%s gpio%d 0x%x:0x%x 0x%x:0x%x\n",
+		__func__, pin + 1, reg, conf[0], reg + 1, conf[1]);
+
+	ret = regmap_update_bits(priv->madera->regmap, reg, mask[0], conf[0]);
+	if (ret)
+		goto err;
+
+	++reg;
+	ret = regmap_update_bits(priv->madera->regmap, reg, mask[1], conf[1]);
+	if (ret)
+		goto err;
+
+	return 0;
+
+err:
+	dev_err(priv->dev,
+		"Failed to write GPIO%d conf (%d) reg 0x%x\n",
+		pin + 1, ret, reg);
+
+	return ret;
+}
+
+static int madera_pin_conf_group_set(struct pinctrl_dev *pctldev,
+				     unsigned int selector,
+				     unsigned long *configs,
+				     unsigned int num_configs)
+{
+	struct madera_pin_private *priv = pinctrl_dev_get_drvdata(pctldev);
+	const struct madera_pin_groups *pin_group;
+	unsigned int n_groups = priv->chip->n_pin_groups;
+	int i, ret;
+
+	dev_dbg(priv->dev, "%s setting group %s\n", __func__,
+		madera_get_group_name(pctldev, selector));
+
+	if (selector >= n_groups) {
+		/* group is a single pin, convert to pin number and set */
+		return madera_pin_conf_set(pctldev,
+					   selector - n_groups,
+					   configs,
+					   num_configs);
+	} else {
+		pin_group = &priv->chip->pin_groups[selector];
+
+		for (i = 0; i < pin_group->n_pins; ++i) {
+			ret = madera_pin_conf_set(pctldev,
+						  pin_group->pins[i],
+						  configs,
+						  num_configs);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static const struct pinconf_ops madera_pin_conf_ops = {
+	.pin_config_get = madera_pin_conf_get,
+	.pin_config_set = madera_pin_conf_set,
+	.pin_config_group_set = madera_pin_conf_group_set,
+
+};
+
+static struct pinctrl_desc madera_pin_desc = {
+	.name = "madera-pinctrl",
+	.pins = madera_pins,
+	.pctlops = &madera_pin_group_ops,
+	.pmxops = &madera_pin_mux_ops,
+	.confops = &madera_pin_conf_ops,
+	.owner = THIS_MODULE,
+};
+
+static int madera_pin_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	const struct madera_pdata *pdata = dev_get_platdata(madera->dev);
+	struct madera_pin_private *priv;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(madera_pin_single_group_names) !=
+		     ARRAY_SIZE(madera_pin_single_group_pins));
+
+	dev_dbg(&pdev->dev, "%s\n", __func__);
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	priv->madera = madera;
+	pdev->dev.of_node = madera->dev->of_node;
+
+	switch (madera->type) {
+	case CS47L35:
+		if (IS_ENABLED(CONFIG_PINCTRL_CS47L35))
+			priv->chip = &cs47l35_pin_chip;
+		break;
+	case CS47L85:
+	case WM1840:
+		if (IS_ENABLED(CONFIG_PINCTRL_CS47L85))
+			priv->chip = &cs47l85_pin_chip;
+		break;
+	case CS47L90:
+	case CS47L91:
+		if (IS_ENABLED(CONFIG_PINCTRL_CS47L90))
+			priv->chip = &cs47l90_pin_chip;
+		break;
+	default:
+		break;
+	}
+
+	if (!priv->chip)
+		return -ENODEV;
+
+	madera_pin_desc.npins = priv->chip->n_pins;
+
+	ret = devm_pinctrl_register_and_init(&pdev->dev,
+					     &madera_pin_desc,
+					     priv,
+					     &priv->pctl);
+	if (ret) {
+		dev_err(priv->dev, "Failed pinctrl register (%d)\n", ret);
+		return ret;
+	}
+
+	/* if the configuration is provided through pdata, apply it */
+	if (pdata) {
+		ret = pinctrl_register_mappings(pdata->gpio_configs,
+						pdata->n_gpio_configs);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to register pdata mappings (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
+	ret = pinctrl_enable(priv->pctl);
+	if (ret) {
+		dev_err(priv->dev, "Failed to enable pinctrl (%d)\n", ret);
+		return ret;
+	}
+
+	dev_dbg(priv->dev, "pinctrl probed ok\n");
+
+	return 0;
+}
+
+static struct platform_driver madera_pin_driver = {
+	.probe = madera_pin_probe,
+	.driver = {
+		.name = "madera-pinctrl",
+	},
+};
+
+module_platform_driver(madera_pin_driver);
+
+MODULE_DESCRIPTION("Madera pinctrl driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/pinctrl/cirrus/pinctrl-madera.h b/drivers/pinctrl/cirrus/pinctrl-madera.h
new file mode 100644
index 000000000000..8000f4f832a1
--- /dev/null
+++ b/drivers/pinctrl/cirrus/pinctrl-madera.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Pinctrl for Cirrus Logic Madera codecs
+ *
+ * Copyright (C) 2016-2017 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#ifndef PINCTRL_MADERA_H
+#define PINCTRL_MADERA_H
+
+struct madera_pin_groups {
+	const char *name;
+	const unsigned int *pins;
+	unsigned int n_pins;
+};
+
+struct madera_pin_chip {
+	unsigned int n_pins;
+
+	const struct madera_pin_groups *pin_groups;
+	unsigned int n_pin_groups;
+};
+
+struct madera_pin_private {
+	struct madera *madera;
+
+	const struct madera_pin_chip *chip; /* chip-specific groups */
+
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+};
+
+extern const struct madera_pin_chip cs47l35_pin_chip;
+extern const struct madera_pin_chip cs47l85_pin_chip;
+extern const struct madera_pin_chip cs47l90_pin_chip;
+
+#endif
-- 
2.11.0
