Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454692184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfADJFy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:05:54 -0500
Received: from mx01.hxt-semitech.com ([223.203.96.7]:46852 "EHLO
        barracuda.hxt-semitech.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726227AbfADJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:05:53 -0500
X-ASG-Debug-ID: 1546592732-093b7e2d8806e40001-xx1T2L
Received: from HXTBJIDCEMVIW02.hxtcorp.net ([10.128.0.15]) by barracuda.hxt-semitech.com with ESMTP id oSRiYDxuaajOOtxM (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 04 Jan 2019 17:05:32 +0800 (CST)
X-Barracuda-Envelope-From: xiaoting.liu@hxt-semitech.com
Received: from openbmc001.localdomain (10.5.21.169) by
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 4 Jan 2019 17:05:28 +0800
From:   Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
To:     <linux@roeck-us.net>, <jdelvare@suse.com>
CC:     <openbmc@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>, <shunyong.yang@hxt-semitech.com>,
        <dongsheng.wang@hxt-semitech.com>,
        Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
Subject: [PATCH 4/4] pmbus (dps650ab): add power supply driver
Date:   Fri, 4 Jan 2019 17:05:27 +0800
X-ASG-Orig-Subj: [PATCH 4/4] pmbus (dps650ab): add power supply driver
Message-ID: <e0ad8b6bb620f9fc2f818cbda66825c297f73d67.1546591275.git.xiaoting.liu@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1546591275.git.xiaoting.liu@hxt-semitech.com>
References: <cover.1546591275.git.xiaoting.liu@hxt-semitech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.169]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
Content-Transfer-Encoding: 8BIT
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1546592732
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA384
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Virus-Scanned: by bsmtpd at hxt-semitech.com
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5000 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65068
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Delta dps650ab provides main power and standby power to server.
dps650ab can be detected by MFR_ID and MFR_MODEL referring to
manufacturer's feedback. This patch adds driver to moniter power
supply status.

Signed-off-by: Xiaoting Liu <xiaoting.liu@hxt-semitech.com>
---
 drivers/hwmon/pmbus/Kconfig    |  10 +++++
 drivers/hwmon/pmbus/Makefile   |   1 +
 drivers/hwmon/pmbus/dps650ab.c | 100 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.c    |   3 ++
 4 files changed, 114 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 629cb45f8557..de4638396592 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -184,4 +184,14 @@ config SENSORS_ZL6100
          This driver can also be built as a module. If so, the module will
          be called zl6100.

+config SENSORS_DPS650AB
+       tristate "Delta DPS650AB"
+       default n
+       help
+         If you say yes here you get hardware monitoring support for the
+         Delta DPS650AB controller.
+
+         This driver can also be built as a module. If so, the module will
+         be called dps650ab.
+
 endif # PMBUS
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
index ea0e39518c21..414818230a26 100644
--- a/drivers/hwmon/pmbus/Makefile
+++ b/drivers/hwmon/pmbus/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_SENSORS_TPS53679)        += tps53679.o
 obj-$(CONFIG_SENSORS_UCD9000)  += ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)  += ucd9200.o
 obj-$(CONFIG_SENSORS_ZL6100)   += zl6100.o
+obj-$(CONFIG_SENSORS_DPS650AB) += dps650ab.o
diff --git a/drivers/hwmon/pmbus/dps650ab.c b/drivers/hwmon/pmbus/dps650ab.c
new file mode 100644
index 000000000000..3c300e621f5a
--- /dev/null
+++ b/drivers/hwmon/pmbus/dps650ab.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hardware monitoring driver for DELTA DPS650AB
+ *
+ * Copyright (c) 2018 Huaxintong Semiconductor Technology Co., Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include "pmbus.h"
+
+#define DPS650AB_MFR_ID                        "DELTA"
+#define DPS650AB_MFR_MODEL             "DPS-650AB-16 A"
+
+static int dps650ab_probe(struct i2c_client *client,
+                        const struct i2c_device_id *id)
+{
+       struct pmbus_driver_info *info;
+       u8 buf[I2C_SMBUS_BLOCK_MAX];
+       int ret;
+
+       memset(buf, 0, I2C_SMBUS_BLOCK_MAX);
+
+       if (!i2c_check_functionality(client->adapter,
+                                    I2C_FUNC_SMBUS_READ_BYTE_DATA
+                               | I2C_FUNC_SMBUS_READ_WORD_DATA
+                               | I2C_FUNC_SMBUS_READ_BLOCK_DATA))
+               return -ENODEV;
+
+       ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, buf);
+       if (ret < 0) {
+               dev_err(&client->dev, "Failed to read PMBUS_MFR_ID\n");
+               return ret;
+       }
+
+       if (strncmp(buf, DPS650AB_MFR_ID, strlen(DPS650AB_MFR_ID))) {
+               dev_err(&client->dev, "DPS650AB_MFR_ID unrecognised\n");
+               return -ENODEV;
+       }
+
+       ret = i2c_smbus_read_block_data(client, PMBUS_MFR_MODEL, buf);
+       if (ret < 0) {
+               dev_err(&client->dev, "Failed to read PMBUS_MFR_MODEL\n");
+               return ret;
+       }
+
+       if (strncmp(buf, DPS650AB_MFR_MODEL, strlen(DPS650AB_MFR_MODEL))) {
+               dev_err(&client->dev, "DPS650AB_MFR_MODEL unrecognised\n");
+               return -ENODEV;
+       }
+
+       info = devm_kzalloc(&client->dev, sizeof(*info), GFP_KERNEL);
+       if (!info)
+               return -ENOMEM;
+
+       info->pages = 1;
+       info->format[PSC_VOLTAGE_IN] = linear;
+       info->format[PSC_VOLTAGE_OUT] = linear;
+       info->format[PSC_CURRENT_IN] = linear;
+       info->format[PSC_CURRENT_OUT] = linear;
+       info->format[PSC_POWER] = linear;
+       info->format[PSC_TEMPERATURE] = linear;
+
+       info->func[0] = PMBUS_HAVE_VIN
+               | PMBUS_HAVE_IIN | PMBUS_HAVE_PIN
+               | PMBUS_HAVE_STATUS_INPUT
+               | PMBUS_HAVE_POUT | PMBUS_HAVE_FAN12
+               | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
+               | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+               | PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
+               | PMBUS_HAVE_STATUS_TEMP;
+       info->func[1] = info->func[0];
+
+       return pmbus_do_probe(client, id, info);
+}
+
+static const struct i2c_device_id dps650ab_id[] = {
+       {"dps650ab", 1},
+       {}
+};
+
+MODULE_DEVICE_TABLE(i2c, dps650ab_id);
+
+static struct i2c_driver dps650ab_driver = {
+       .driver = {
+               .name   = "dps650ab",
+       },
+       .probe          = dps650ab_probe,
+       .remove         = pmbus_do_remove,
+       .id_table       = dps650ab_id,
+};
+
+module_i2c_driver(dps650ab_driver);
+
+MODULE_AUTHOR("Liuxiaoting <xiaoting.liu@hxt-semitech.com");
+MODULE_DESCRIPTION("PMBus driver for DPS650AB");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
index aa4cf9636e99..930e8a3e2366 100644
--- a/drivers/hwmon/pmbus/pmbus.c
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -204,6 +204,8 @@ static int pmbus_probe(struct i2c_client *client,
 static const struct pmbus_device_info sgd009_pmbus_info = {
                                1, PMBUS_SKIP_STATUS_CHECK};
 static const struct pmbus_device_info pmbus_info = {0, 0};
+static const struct pmbus_device_info dps650ab_pmbus_info = {
+                               1, PMBUS_SKIP_STATUS_CHECK};
 /*
  * Use driver_data to set the number of pages supported by the chip.
  */
@@ -227,6 +229,7 @@ static int pmbus_probe(struct i2c_client *client,
        {"tps544c20", (kernel_ulong_t)&default_pmbus_info},
        {"tps544c25", (kernel_ulong_t)&default_pmbus_info},
        {"udt020", (kernel_ulong_t)&default_pmbus_info},
+       {"dps650ab", (kernel_ulong_t)&dps650ab_pmbus_info},
        {}
 };

--
1.8.3.1




This email is intended only for the named addressee. It may contain information that is confidential/private, legally privileged, or copyright-protected, and you should handle it accordingly. If you are not the intended recipient, you do not have legal rights to retain, copy, or distribute this email or its contents, and should promptly delete the email and all electronic copies in your system; do not retain copies in any media. If you have received this email in error, please notify the sender promptly. Thank you.


