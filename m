Return-Path: <rrajk@nvidia.com>
X-Google-Smtp-Source: AG47ELvOtpSdUagtLg3rWijsFJuVQPwjmqrktIooEi25kFoNCdG9+cw+9HuH9g7MM+iZglB9uzWb
ARC-Seal: i=1; a=rsa-sha256; t=1519196413; cv=none;
        d=google.com; s=arc-20160816;
        b=uGUzZ0iAKoj5PEhN2JmOxRdzaf2abf3oYUVLtPc05taSY9cokxpCwBtmq3hzYQL1I2
         +e0G/nhQ3rVM4EofhvWavA539Qm+Sgh1kD4wRW8BZpLCJpba6Qx01T2D5v6c5EtvBrsv
         xfbKdluitiC497WO+HYPCHAB9G7ltfjIXIDtEK2IgJYI2zYvm+V7ZSGwKfoqsLGLOPLt
         7iTp9GNsGwEdi2nlKjeTGJdKhOJwUT5uLOXzGNz+qzsfRtXj1OG9qNEyS9wRzti52B/H
         kr8p+Lc1QrAQcTh5DsC+9MONYy+wEKd5sAIq+KjFJp91+SPI+RQkGT6njjqbDH8z8jgT
         ixyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:arc-authentication-results;
        bh=K+PUTUp8fG1drdiCpqVkLrrHj6xG9xiWkmI20nlF0dI=;
        b=JENNYggGpGVGQjPBjL9pVHG9PE3nOIQNx+pj0oJ9pIlTQTWWWsMrQOcwWjQDZH6sKa
         K5TAqdUyYlGoahOz/NewWu5QtamzEhSPqUw641lXQCtjTu/nxDHuT1Jzi0sk7vccAdQm
         gFCrPxKcusXLiCLviY5byTmM14eq/2rDZvvQmI1Ow4cBzfmrS0BRJLx3yVfvb8xla+SA
         o0z++nMzQHFF2pJ5i2k15vKFjwJEqag/+LQ5nGuq5yKcx5UfsabpN6rqvxOfUzCAxYm1
         p6j4JROMB9fqmYQG+JNGB3jnHiIOarRJ2CbQFa8KFhqN6xGuCiwxDSnW7oR0enHe24DH
         CKXg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of rrajk@nvidia.com designates 216.228.121.64 as permitted sender) smtp.mailfrom=rrajk@nvidia.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nvidia.com
X-PGP-Universal: processed;
	by hqpgpgate101.nvidia.com on Tue, 20 Feb 2018 23:00:11 -0800
From: Rajkumar Rampelli <rrajk@nvidia.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <jdelvare@suse.com>, <linux@roeck-us.net>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
	<kstewart@linuxfoundation.org>, <gregkh@linuxfoundation.org>,
	<pombredanne@nexb.com>, <mmaddireddy@nvidia.com>, <mperttunen@nvidia.com>,
	<arnd@arndb.de>, <gregory.clement@free-electrons.com>,
	<timur@codeaurora.org>, <andy.gross@linaro.org>, <xuwei5@hisilicon.com>,
	<elder@linaro.org>, <heiko@sntech.de>, <krzk@kernel.org>,
	<ard.biesheuvel@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <ldewangan@nvidia.com>,
	<rrajk@nvidia.com>
Subject: [PATCH 05/10] hwmon: generic-pwm-tachometer: Add generic PWM based tachometer
Date: Wed, 21 Feb 2018 12:28:54 +0530
Message-ID: <1519196339-9377-6-git-send-email-rrajk@nvidia.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
References: <1519196339-9377-1-git-send-email-rrajk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592992898629636853?=
X-GMAIL-MSGID: =?utf-8?q?1592992898629636853?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add generic PWM based tachometer driver via HWMON interface
to report the RPM of motor. This drivers get the period/duty
cycle from PWM IP which captures the motor PWM output.

This driver implements a simple interface for monitoring the speed of
a fan and exposes it in roatations per minute (RPM) to the user space
by using the hwmon's sysfs interface

Signed-off-by: Rajkumar Rampelli <rrajk@nvidia.com>
---
 Documentation/hwmon/generic-pwm-tachometer |  17 +++++
 drivers/hwmon/Kconfig                      |  10 +++
 drivers/hwmon/Makefile                     |   1 +
 drivers/hwmon/generic-pwm-tachometer.c     | 112 +++++++++++++++++++++++++++++
 4 files changed, 140 insertions(+)
 create mode 100644 Documentation/hwmon/generic-pwm-tachometer
 create mode 100644 drivers/hwmon/generic-pwm-tachometer.c

diff --git a/Documentation/hwmon/generic-pwm-tachometer b/Documentation/hwmon/generic-pwm-tachometer
new file mode 100644
index 0000000..e0713ee
--- /dev/null
+++ b/Documentation/hwmon/generic-pwm-tachometer
@@ -0,0 +1,17 @@
+Kernel driver generic-pwm-tachometer
+====================================
+
+This driver enables the use of a PWM module to monitor a fan. It uses the
+generic PWM interface and can be used on SoCs as along as the SoC supports
+Tachometer controller that moniors the Fan speed in periods.
+
+Author: Rajkumar Rampelli <rrajk@nvidia.com>
+
+Description
+-----------
+
+The driver implements a simple interface for monitoring the Fan speed using
+PWM module and Tachometer controller. It requests period value through PWM
+capture interface to Tachometer and measures the Rotations per minute using
+received period value. It exposes the Fan speed in RPM to the user space by
+using the hwmon's sysfs interface.
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index ef23553..8912dcb 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1878,6 +1878,16 @@ config SENSORS_XGENE
 	  If you say yes here you get support for the temperature
 	  and power sensors for APM X-Gene SoC.
 
+config GENERIC_PWM_TACHOMETER
+	tristate "Generic PWM based tachometer driver"
+	depends on PWM
+	help
+	  Enables a driver to use PWM signal from motor to use
+	  for measuring the motor speed. The RPM is captured by
+	  PWM modules which has PWM capture capability and this
+	  drivers reads the captured data from PWM IP to convert
+	  it to speed in RPM.
+
 if ACPI
 
 comment "ACPI drivers"
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index f814b4a..9dcc374 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 obj-$(CONFIG_SENSORS_XGENE)	+= xgene-hwmon.o
 
 obj-$(CONFIG_PMBUS)		+= pmbus/
+obj-$(CONFIG_GENERIC_PWM_TACHOMETER) += generic-pwm-tachometer.o
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
 
diff --git a/drivers/hwmon/generic-pwm-tachometer.c b/drivers/hwmon/generic-pwm-tachometer.c
new file mode 100644
index 0000000..9354d43
--- /dev/null
+++ b/drivers/hwmon/generic-pwm-tachometer.c
@@ -0,0 +1,112 @@
+/*
+ * Copyright (c) 2017-2018, NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/pwm.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+
+struct pwm_hwmon_tach {
+	struct device		*dev;
+	struct pwm_device	*pwm;
+	struct device		*hwmon;
+};
+
+static ssize_t show_rpm(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct pwm_hwmon_tach *ptt = dev_get_drvdata(dev);
+	struct pwm_device *pwm = ptt->pwm;
+	struct pwm_capture result;
+	int err;
+	unsigned int rpm = 0;
+
+	err = pwm_capture(pwm, &result, 0);
+	if (err < 0) {
+		dev_err(ptt->dev, "Failed to capture PWM: %d\n", err);
+		return err;
+	}
+
+	if (result.period)
+		rpm = DIV_ROUND_CLOSEST_ULL(60ULL * NSEC_PER_SEC,
+					    result.period);
+
+	return sprintf(buf, "%u\n", rpm);
+}
+
+static SENSOR_DEVICE_ATTR(rpm, 0444, show_rpm, NULL, 0);
+
+static struct attribute *pwm_tach_attrs[] = {
+	&sensor_dev_attr_rpm.dev_attr.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(pwm_tach);
+
+static int pwm_tach_probe(struct platform_device *pdev)
+{
+	struct pwm_hwmon_tach *ptt;
+	int err;
+
+	ptt = devm_kzalloc(&pdev->dev, sizeof(*ptt), GFP_KERNEL);
+	if (!ptt)
+		return -ENOMEM;
+
+	ptt->dev = &pdev->dev;
+
+	platform_set_drvdata(pdev, ptt);
+	dev_set_drvdata(&pdev->dev, ptt);
+
+	ptt->pwm = devm_of_pwm_get(&pdev->dev, pdev->dev.of_node, NULL);
+	if (IS_ERR(ptt->pwm)) {
+		err = PTR_ERR(ptt->pwm);
+		dev_err(&pdev->dev, "Failed to get pwm handle, err: %d\n",
+			err);
+		return err;
+	}
+
+	ptt->hwmon = devm_hwmon_device_register_with_groups(&pdev->dev,
+					 "pwm_tach", ptt, pwm_tach_groups);
+	if (IS_ERR(ptt->hwmon)) {
+		err = PTR_ERR_OR_ZERO(ptt->hwmon);
+		dev_err(&pdev->dev, "Failed to register hwmon device: %d\n",
+			err);
+		return err;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id pwm_tach_of_match[] = {
+	{ .compatible = "generic-pwm-tachometer" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pwm_tach_of_match);
+
+static struct platform_driver pwm_tach_driver = {
+	.driver = {
+		.name = "generic-pwm-tachometer",
+		.of_match_table = pwm_tach_of_match,
+	},
+	.probe = pwm_tach_probe,
+};
+
+module_platform_driver(pwm_tach_driver);
+
+MODULE_DESCRIPTION("PWM based Generic Tachometer driver");
+MODULE_AUTHOR("Laxman Dewangan <ldewangan@nvidia.com>");
+MODULE_AUTHOR("Rajkumar Rampelli <rrajk@nvidia.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4
