Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x225AEUhREg1YyQbIt2+cOE78rrZ+MDIDn82DeEIAkeLvib9k7QuS49MjK3afyf3hHSVHnHan
ARC-Seal: i=1; a=rsa-sha256; t=1519229783; cv=none;
        d=google.com; s=arc-20160816;
        b=Ar8mN1X/5UaxOh0Pj0WdAl11TEmIruguzVQ6dBAn/hW5zDVA7d1akNAHVSRwf9jWcy
         KlkNVQgrWIioWZsPdiZZ1zhTA+TW7lqEqea4g6o7fLnwW1ag1HQ3XYwFtnKd82lIGHdI
         opWkpaSH/GdLOv8XAKjG9jHp5CK7VTQ5c4vTLFski4iLlupwvu2+4PuqPwWmrwsuy6jU
         J/KteLqIpIe/wzVOmbeHna7QMnwugI1y3GcQVAP/phSMKR8gJbz3/7/fM4iF/Re/r0Kw
         uLJQ1iTymsOOKl4tjDSE6Wk8qUUisKZ2fZYAO70gdktca3dJP2+gs8f91W4oN67tFPgF
         GSqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=nGXqX0nw3LnLgY8Izi6V6VspBDW2C3w8ypHrDcDlUvQ=;
        b=RNmvpGe818DdlwpAfipP16psqCWEqyBknF8qH0sBgW2CaF82NgC/ktO+5V0+RdvbYC
         cYhxzTx5yRMA08KB9di7QH9tz+4o9UFg83fmiFQbazHfLdfDCqYON2Nrq9zeJRT7sfye
         WYivFyYSl9xSneXS0tzyuwj+6XoEQiE+JH+fTT7IYSWE3HXeQ0V+MuRkeuqnJwVunFw2
         t2PQeh3s/T/a932W8cnTO4ty+QczxzTrlUoE+RTBXk51jxjlfzf5p0/+S6zQ9H/gK1R7
         fBF/1rT8mF6mt5DjFpuwr/1oMVLmMRQbIjgwr+9Dcj89a49RD61jT3K9z34e7iYpAUHa
         LDiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,543,1511856000";
   d="scan'208";a="29617854"
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
Subject: [PATCH v2 6/8] [PATCH 6/8] Documentation: hwmon: Add a document for PECI hwmon client driver
Date: Wed, 21 Feb 2018 08:16:04 -0800
Message-Id: <20180221161606.32247-7-jae.hyun.yoo@linux.intel.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027890051239231?=
X-GMAIL-MSGID: =?utf-8?q?1593027890051239231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This commit adds a hwmon document for a generic PECI hwmon client driver.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
---
 Documentation/hwmon/peci-hwmon | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/hwmon/peci-hwmon

diff --git a/Documentation/hwmon/peci-hwmon b/Documentation/hwmon/peci-hwmon
new file mode 100644
index 000000000000..93e587498536
--- /dev/null
+++ b/Documentation/hwmon/peci-hwmon
@@ -0,0 +1,73 @@
+Kernel driver peci-hwmon
+===============================
+
+Supported chips:
+	Any recent Intel CPU which is connected through a PECI bus.
+	Addresses scanned: PECI client address 0x30 - 0x37
+	Datasheet: Available from http://www.intel.com/design/literature.htm
+
+Author:
+	Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
+
+Description
+-----------
+
+This driver implements a generic PECI hwmon feature which provides Digital
+Thermal Sensor (DTS) thermal readings of the CPU package, CPU cores and DIMM
+components that are accessible using the PECI Client Command Suite via the
+processor PECI client.
+
+All temperature values are given in millidegree Celsius and will be measurable
+only when the target CPU is powered on.
+
+sysfs attributes
+----------------
+
+temp1_input		Provides current die temperature of the CPU package.
+temp1_max		Provides thermal control temperature of the CPU package
+			which is also known as Tcontrol.
+temp1_crit		Provides shutdown temperature of the CPU package which
+			is also known as the maximum processor junction
+			temperature, Tjmax or Tprochot.
+temp1_crit_hyst		Provides the hysteresis value from Tcontrol to Tjmax of
+			the CPU package.
+
+temp2_input		Provides current DTS thermal margin to Tcontrol of the
+			CPU package. Value 0 means it reaches to Tcontrol
+			temperature. Sub-zero value means the die temperature
+			goes across Tconrtol to Tjmax.
+temp2_min		Provides the minimum DTS thermal margin to Tcontrol of
+			the CPU package.
+temp2_lcrit		Provides the value when the CPU package temperature
+			reaches to Tjmax.
+
+temp3_input		Provides current Tcontrol temperature of the CPU
+			package which is also known as Fan Temperature target.
+			Indicates the relative value from thermal monitor trip
+			temperature at which fans should be engaged.
+temp3_crit		Provides Tcontrol critical value of the CPU package
+			which is same to Tjmax.
+
+temp4_input		Provides current Tthrottle temperature of the CPU
+			package. Used for throttling temperature. If this value
+			is allowed and lower than Tjmax - the throttle will
+			occur and reported at lower than Tjmax.
+
+temp5_input		Provides the maximum junction temperature, Tjmax of the
+			CPU package.
+
+temp<n>_label		Provides core temperature if this label indicates
+			'Core #'.
+temp[n]_input		Provides current temperature of each core.
+temp[n]_max		Provides thermal control temperature of the core.
+temp[n]_crit		Provides shutdown temperature of the core.
+temp[n]_crit_hyst	Provides the hysteresis value from Tcontrol to Tjmax of
+			the core.
+
+temp<n>_label		Provides DDR DIMM temperature if this label indicates
+			'DIMM #'.
+temp<n>_input		Provides current temperature of the DDR DIMM.
+
+Note:
+	DIMM temperature group will be appeared when the client CPU's BIOS
+	completes memory training and testing.
-- 
2.16.1
