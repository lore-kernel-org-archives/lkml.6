Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbeCJWHi (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 17:07:38 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38939 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeCJWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 17:07:34 -0500
X-Google-Smtp-Source: AG47ELsGSa2fKL7uU9635GNEgo63bRgwVovEkXexikz311iTA5C2X+66HNKT5PFcZnDarocnZ9XXJQ==
Message-ID: <58a6dcdc4097d60e7bcee61ec1d0cbdf8ad3ae49.camel@elementarea.net>
Subject: [PATCH v2 2/2] iio: chemical: sgp30: Support Sensirion SGPxx sensors
From: Andreas Brauchli <a.brauchli@elementarea.net>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Date: Sat, 10 Mar 2018 23:07:30 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support Sensirion SGP30 and SGPC3 multi-pixel I2C gas sensors

Supported Features:

* Indoor Air Quality (IAQ) concentrations for
  - tVOC (in_concentration_voc_input)
  - CO2eq (in_concentration_co2_input) - SGP30 only
  IAQ concentrations are periodically read out by a background thread
  to allow the sensor to maintain its internal baseline.
* Baseline support for IAQ (in_iaq_baseline, set_iaq_baseline)
* Gas concentration signals
  - Ethanol (in_concentration_ethanol_raw)
  - H2 (in_concentration_h2_raw) - SGP30 only
* On-chip self test (in_selftest)
* Sensor interface version (in_feature_set_version)
* Sensor serial number (in_serial_id)
* Humidity compensation
  With the help of an external humidity signal, the gas signals can be
  humidity-compensated. The sensor performs the compensation on-chip.
* Power mode switching between low power mode (1/2Hz) and
  ultra low power mode (1/30Hz) sampling - SGPC3 only
* Checksummed I2C communication

For all features, refer to the data sheet or the documentation in
Documentation/iio/chemical/sgp30.txt for more details.

The ABI is documented in
Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30

Signed-off-by: Andreas Brauchli <andreas.brauchli@sensirion.com>
---
 .../ABI/testing/sysfs-bus-iio-chemical-sgp30       |   62 ++
 .../bindings/iio/chemical/sensirion,sgp30.txt      |   15 +
 Documentation/iio/chemical/sgp30.txt               |   97 ++
 drivers/iio/chemical/Kconfig                       |   13 +
 drivers/iio/chemical/Makefile                      |    1 +
 drivers/iio/chemical/sgp30.c                       | 1120 ++++++++++++++++++++
 6 files changed, 1308 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 create mode 100644 Documentation/iio/chemical/sgp30.txt
 create mode 100644 drivers/iio/chemical/sgp30.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30 b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
new file mode 100644
index 000000000000..3b97c0bd5878
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
@@ -0,0 +1,62 @@
+what:		/sys/bus/iio/devices/iio:devicex/in_featureset_version
+date:		March 2018
+kernelversion:	4.17
+contact:	andreas brauchli <andreas.brauchli@sensirion.com>
+description:
+		Retrieve the sensor interface version. The sensor-interface should
+		remain forward-compatible across minor versions.
+
+what:		/sys/bus/iio/devices/iio:devicex/in_iaq_baseline
+date:		March 2018
+kernelversion:	4.17
+contact:	andreas brauchli <andreas.brauchli@sensirion.com>
+description:
+		Retrieve the on-chip iaq baseline state. the baseline is an internal
+		state that should not be modified.
+
+What:		/sys/bus/iio/devices/iio:deviceX/set_iaq_baseline
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andreas Brauchli <andreas.brauchli@sensirion.com>
+Description:
+		Restore the on-chip IAQ baseline state to a previous state. Useful for
+		fast-resuming after a restart. A baseline is valid for one week when the
+		sensor is not operated.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_selftest
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andreas Brauchli <andreas.brauchli@sensirion.com>
+Description:
+		Run the on-chip self test. Output values:
+		* OK
+		* FAILED
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_serial_id
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andreas Brauchli <andreas.brauchli@sensirion.com>
+Description:
+		Retrieve the unique sensor serial number. May be useful to associate
+		with the IAQ baseline when the baseline is stored remotely or the sensor
+		is on a plug-and-play device.
+
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andreas Brauchli <andreas.brauchli@sensirion.com>
+Description:
+		Set the absolute humidity in milligrams per cubic meter (mg/m^3) to
+		enable on-sensor humidity compensation. Affects all gas signals and IAQ
+		values. Accepted values:
+		* 0 (disables humidity compensation)
+		* 1..256000 (mg/m^3)
+
+What:		/sys/bus/iio/devices/iio:deviceX/set_power_mode
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Andreas Brauchli <andreas.brauchli@sensirion.com>
+Description:
+		Change the power mode on an SGPC3 with ultra-low power mode support.
+		Accepted values:
+		* "low" (default/startup mode)
+		* "ultra-low" (default/startup mode)
diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
new file mode 100644
index 000000000000..bb909b0f1aba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
@@ -0,0 +1,15 @@
+* Sensirion SGPxx multi-pixel Gas Sensor
+
+Required properties:
+
+  - compatible: must be one of
+    "sensirion,sgp30"
+    "sensirion,sgpc3"
+  - reg: the I2C address of the sensor
+
+Example:
+
+sgpxx@58 {
+	compatible = "sensirion,sgp30";
+	reg = <0x58>;
+};
diff --git a/Documentation/iio/chemical/sgp30.txt b/Documentation/iio/chemical/sgp30.txt
new file mode 100644
index 000000000000..c236f7d0fa80
--- /dev/null
+++ b/Documentation/iio/chemical/sgp30.txt
@@ -0,0 +1,97 @@
+sgp30: Industrial IO driver for Sensirion I2C Multi-Pixel Gas Sensors
+
+1. Overview
+
+The sgp30 driver supports the Sensirion SGP30 and SGPC3 multi-pixel gas sensors.
+
+2. Modes of Operation
+
+Postprocessed Indoor Air Quality (IAQ) gas concentrations as well as raw gas
+signals are available. Both signals can be humidity-compensated by the sensor.
+
+2.1. IAQ Gas Concentrations
+
+* tVOC (in_concentration_voc_input) at ppb precision (1e-9)
+* CO2eq (in_concentration_co2_input) at ppm precision (1e-6) -- SGP30 only
+
+2.1.1. IAQ Initialization
+Before Indoor Air Quality (IAQ) values can be read, the IAQ mode must be
+initialized by sending the "iaq_init" command from the data sheet to the sensor.
+The sgp30 driver performs this initialization automatically on instantiation.
+
+After initializing IAQ, at least one IAQ signal must be read out every second
+(SGP30) / every two seconds (SGPC3) for the sensor to correctly maintain its
+internal baseline. The driver continuously performs this task in a background
+thread and caches the latest measurement for retrieval.
+
+For the first 15s of operation after "iaq_init", default values are returned by
+the sensor. Default values are not returned by the driver, instead an -EBUSY
+error is returned.
+
+2.1.2. Pausing and Resuming IAQ
+
+For best performance and faster subsequent startup times, the baseline should be
+saved once every hour, after 12h of operation. The baseline is restored by
+writing the last known baseline back to set_iaq_baseline.
+
+    Saving the baseline:
+    $ baseline=$(cat in_iaq_baseline)
+
+    Restoring the baseline:
+    $ echo -n $baseline > set_iaq_baseline
+
+2.2. Humidity Compensation
+
+The SGP features an on-chip humidity compensation that requires the (in-device)
+environment's absolute humidity.
+
+Set the absolute humidity by writing the absolute humidity concentration (in
+mg/m^3) to set_absolute_humidity. The absolute humidity is obtained by
+converting the relative humidity and temperature. The following units are used:
+AH in mg/m^3, RH in percent (0..100), T in degrees Celsius, and exp() being the
+base-e exponential function.
+
+                  RH            exp(17.62 * T)
+                ----- * 6.112 * --------------
+                100.0            243.12 + T
+  AH = 216.7 * ------------------------------- * 1000
+                        273.15 + T
+
+Writing a value of 0 to set_absolute_humidity disables the humidity
+compensation. Devices not supporting humidity compensation (SGPC3 with feature
+set < 0.6) will report an error (-EINVAL) when setting the humidity.
+
+2.3. On-chip self test
+
+    $ cat in_selftest
+
+in_selftest returns OK or FAILED.
+
+On the SGP30, self test interferes with IAQ operations and requires a
+re-initialization thereof. If a valid baseline is available (after 12h of
+operation), the driver will take care of resuming the operation after the
+selftest, otherwise the "iaq_init" procedure will be restarted.
+
+2.4 SGPC3 Low Power Gas Sensor Features
+
+2.4.1 Accelerated Startup
+
+The SGPC3 can be pre-heated differently by writing a duration to the
+set_iaq_preheat_seconds attribute. Pre-heating causes the sensor to draw more
+power but results in more accurate readings, thus also marketed as accelerated
+startup mode. Sensors prior to feature set 0.6 allow pre-heating durations of 0,
+16, 64 and 184s (other values rounded to the next higher setting). Feature set
+0.6 allows pre-heating for all integer durations up to 300s (a software limit).
+
+Pre-heating occurs on IAQ initialization, thus after changing the power mode or
+setting an IAQ baseline. When the sensor has been operated for a duration of
+12h or more, it is not necessary to pre-heat after short down periods (e.g.
+reboots of < 5min.)
+
+2.4.2 Ultra Low Power Mode (SGPC3 Feature Set 0.6+)
+
+The SGPC3 with feature set 0.6+ features an ultra-low-power mode in which the
+sensor is only polled every 30s instead of every 2s. The polling interval in the
+background thread is adjusted by the driver when changing the power mode with
+set_power_mode. Supported options: {"low", "ultra-low"}. Changing the power mode
+on sensors without power-mode switching results in an -EINVAL error.
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 5cb5be7612b4..6f0e2d1240bd 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -38,6 +38,19 @@ config IAQCORE
 	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
 	  sensors
 
+config SENSIRION_SGP30
+	tristate "Sensirion SGPxx gas sensors"
+	depends on I2C
+	select CRC8
+	help
+	  Say Y here to build I2C interface support for the following
+	  Sensirion SGP gas sensors:
+	    * SGP30 gas sensor
+	    * SGPC3 low power gas sensor
+
+	  To compile this driver as module, choose M here: the
+	  module will be called sgp30.
+
 config VZ89X
 	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index a629b29d1e0b..9aeb3fce1408 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -6,4 +6,5 @@
 obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
 obj-$(CONFIG_CCS811)		+= ccs811.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
+obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/sgp30.c b/drivers/iio/chemical/sgp30.c
new file mode 100644
index 000000000000..f336a89ad906
--- /dev/null
+++ b/drivers/iio/chemical/sgp30.c
@@ -0,0 +1,1120 @@
+/*
+ * sgp30.c - Support for Sensirion SGP Gas Sensors
+ *
+ * Copyright (C) 2017 Andreas Brauchli <andreas.brauchli@sensirion.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * Datasheets:
+ * https://www.sensirion.com/file/datasheet_sgp30
+ * https://www.sensirion.com/file/datasheet_sgpc3
+ */
+
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/string.h>
+#include <linux/version.h>
+
+#define SGP_WORD_LEN				2
+#define SGP_CRC8_POLYNOMIAL			0x31
+#define SGP_CRC8_INIT				0xff
+#define SGP_CRC8_LEN				1
+#define SGP_CMD(cmd_word)			cpu_to_be16(cmd_word)
+#define SGP_CMD_DURATION_US			12000
+#define SGP_MEASUREMENT_DURATION_US		50000
+#define SGP_SELFTEST_DURATION_US		220000
+#define SGP_CMD_HANDLING_DURATION_US		10000
+#define SGP_CMD_LEN				SGP_WORD_LEN
+#define SGP_CMD_MAX_BUF_SIZE			(SGP_CMD_LEN + 2 * SGP_WORD_LEN)
+#define SGP_MEASUREMENT_LEN			2
+#define SGP30_MEASURE_INTERVAL_HZ		1
+#define SGPC3_MEASURE_INTERVAL_HZ		2
+#define SGPC3_MEASURE_ULP_INTERVAL_HZ		30
+#define SGPC3_POWER_MODE_ULTRA_LOW_POWER	0
+#define SGPC3_POWER_MODE_LOW_POWER		1
+#define SGPC3_DEFAULT_IAQ_INIT_DURATION_HZ	64
+#define SGP_SELFTEST_OK				0xd400
+#define SGP_VERS_PRODUCT(data)	((((data)->feature_set) & 0xf000) >> 12)
+#define SGP_VERS_RESERVED(data)	((((data)->feature_set) & 0x0e00) >> 9)
+#define SGP_VERS_ENG_BIT(data)	((((data)->feature_set) & 0x0100) >> 8)
+#define SGP_VERS_MAJOR(data)	((((data)->feature_set) & 0x00e0) >> 5)
+#define SGP_VERS_MINOR(data)	(((data)->feature_set) & 0x001f)
+
+DECLARE_CRC8_TABLE(sgp_crc8_table);
+
+enum sgp_product_id {
+	SGP30 = 0,
+	SGPC3,
+};
+
+enum sgp30_channel_idx {
+	SGP30_IAQ_TVOC_IDX = 0,
+	SGP30_IAQ_CO2EQ_IDX,
+	SGP30_SIG_ETOH_IDX,
+	SGP30_SIG_H2_IDX,
+};
+
+enum sgpc3_channel_idx {
+	SGPC3_IAQ_TVOC_IDX = 10,
+	SGPC3_SIG_ETOH_IDX,
+};
+
+enum sgp_cmd {
+	SGP_CMD_IAQ_INIT		= SGP_CMD(0x2003),
+	SGP_CMD_IAQ_MEASURE		= SGP_CMD(0x2008),
+	SGP_CMD_GET_BASELINE		= SGP_CMD(0x2015),
+	SGP_CMD_SET_BASELINE		= SGP_CMD(0x201e),
+	SGP_CMD_GET_FEATURE_SET		= SGP_CMD(0x202f),
+	SGP_CMD_GET_SERIAL_ID		= SGP_CMD(0x3682),
+	SGP_CMD_SELFTEST		= SGP_CMD(0x2032),
+	SGP_CMD_SET_ABSOLUTE_HUMIDITY	= SGP_CMD(0x2061),
+
+	SGP30_CMD_MEASURE_SIGNAL	= SGP_CMD(0x2050),
+
+	SGPC3_CMD_IAQ_INIT_0		= SGP_CMD(0x2089),
+	SGPC3_CMD_IAQ_INIT_16		= SGP_CMD(0x2024),
+	SGPC3_CMD_IAQ_INIT_64		= SGP_CMD(0x2003),
+	SGPC3_CMD_IAQ_INIT_184		= SGP_CMD(0x206a),
+	SGPC3_CMD_IAQ_INIT_CONTINUOUS	= SGP_CMD(0x20ae),
+	SGPC3_CMD_MEASURE_RAW		= SGP_CMD(0x2046),
+	SGPC3_CMD_SET_POWER_MODE	= SGP_CMD(0x209f),
+};
+
+struct sgp_version {
+	u8 major;
+	u8 minor;
+};
+
+struct sgp_crc_word {
+	__be16 value;
+	u8 crc8;
+} __attribute__((__packed__));
+
+union sgp_reading {
+	u8 start;
+	struct sgp_crc_word raw_words[4];
+};
+
+enum _iaq_buffer_state {
+	IAQ_BUFFER_EMPTY = 0,
+	IAQ_BUFFER_DEFAULT_VALS,
+	IAQ_BUFFER_VALID,
+};
+
+struct sgp_data {
+	struct i2c_client *client;
+	struct task_struct *iaq_thread;
+	struct mutex data_lock;
+	unsigned long iaq_init_start_jiffies;
+	unsigned long iaq_init_duration_jiffies;
+	unsigned long iaq_defval_skip_jiffies;
+	u64 serial_id;
+	void (*iaq_init_fn)(struct sgp_data *data);
+	u32 iaq_init_user_duration;
+	u16 product_id;
+	u16 feature_set;
+	unsigned long measure_interval_jiffies;
+	enum sgp_cmd iaq_init_cmd;
+	enum sgp_cmd measure_iaq_cmd;
+	enum sgp_cmd measure_gas_signals_cmd;
+	u8 baseline_len;
+	u16 user_baseline[2];
+	u16 power_mode;
+	union sgp_reading buffer;
+	union sgp_reading iaq_buffer;
+	enum _iaq_buffer_state iaq_buffer_state;
+	bool supports_humidity_compensation;
+	bool supports_power_mode;
+};
+
+struct sgp_device {
+	const struct iio_chan_spec *channels;
+	int num_channels;
+};
+
+static const struct sgp_version supported_versions_sgp30[] = {
+	{
+		.major = 1,
+		.minor = 0,
+	},
+};
+
+static const struct sgp_version supported_versions_sgpc3[] = {
+	{
+		.major = 0,
+		.minor = 4,
+	},
+};
+
+static const struct iio_chan_spec sgp30_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.datasheet_name = "TVOC signal",
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.address = SGP30_IAQ_TVOC_IDX,
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.datasheet_name = "CO2eq signal",
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.address = SGP30_IAQ_CO2EQ_IDX,
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_ETHANOL,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.address = SGP30_SIG_ETOH_IDX,
+		.datasheet_name = "Ethanol signal",
+		.modified = 1,
+		.scan_type = {
+			.endianness = IIO_BE,
+		},
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_H2,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.address = SGP30_SIG_H2_IDX,
+		.datasheet_name = "H2 signal",
+		.modified = 1,
+		.scan_type = {
+			.endianness = IIO_BE,
+		},
+	},
+};
+
+static const struct iio_chan_spec sgpc3_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.datasheet_name = "TVOC signal",
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.address = SGPC3_IAQ_TVOC_IDX,
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_ETHANOL,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.address = SGPC3_SIG_ETOH_IDX,
+		.datasheet_name = "Ethanol signal",
+		.modified = 1,
+		.scan_type = {
+			.endianness = IIO_BE,
+		},
+	},
+};
+
+static const struct sgp_device sgp_devices[] = {
+	[SGP30] = {
+		.channels = sgp30_channels,
+		.num_channels = ARRAY_SIZE(sgp30_channels),
+	},
+	[SGPC3] = {
+		.channels = sgpc3_channels,
+		.num_channels = ARRAY_SIZE(sgpc3_channels),
+	},
+};
+
+/**
+ * sgp_verify_buffer() - verify the checksums of the data buffer words
+ *
+ * @data:       SGP data
+ * @buf:        Raw data buffer
+ * @word_count: Num data words stored in the buffer, excluding CRC bytes
+ *
+ * Return:      0 on success, negative error otherwise.
+ */
+static int sgp_verify_buffer(const struct sgp_data *data,
+			     union sgp_reading *buf, size_t word_count)
+{
+	size_t size = word_count * (SGP_WORD_LEN + SGP_CRC8_LEN);
+	int i;
+	u8 crc;
+	u8 *data_buf = &buf->start;
+
+	for (i = 0; i < size; i += SGP_WORD_LEN + SGP_CRC8_LEN) {
+		crc = crc8(sgp_crc8_table, &data_buf[i], SGP_WORD_LEN,
+			   SGP_CRC8_INIT);
+		if (crc != data_buf[i + SGP_WORD_LEN]) {
+			dev_err(&data->client->dev, "CRC error\n");
+			return -EIO;
+		}
+	}
+	return 0;
+}
+
+/**
+ * sgp_read_cmd() - reads data from sensor after issuing a command
+ * The caller must hold data->data_lock for the duration of the call.
+ * @data:        SGP data
+ * @cmd:         SGP Command to issue
+ * @buf:         Raw data buffer to use
+ * @word_count:  Num words to read, excluding CRC bytes
+ *
+ * Return:       0 on success, negative error otherwise.
+ */
+static int sgp_read_cmd(struct sgp_data *data, enum sgp_cmd cmd,
+			union sgp_reading *buf, size_t word_count,
+			unsigned long duration_us)
+{
+	int ret;
+	struct i2c_client *client = data->client;
+	size_t size = word_count * (SGP_WORD_LEN + SGP_CRC8_LEN);
+	u8 *data_buf;
+
+	ret = i2c_master_send(client, (const char *)&cmd, SGP_CMD_LEN);
+	if (ret != SGP_CMD_LEN)
+		return -EIO;
+	usleep_range(duration_us, duration_us + 1000);
+
+	if (word_count == 0)
+		return 0;
+
+	data_buf = &buf->start;
+	ret = i2c_master_recv(client, data_buf, size);
+	if (ret < 0)
+		return ret;
+	if (ret != size)
+		return -EIO;
+
+	return sgp_verify_buffer(data, buf, word_count);
+}
+
+/**
+ * sgp_i2c_write_cmd() - write data to SGP sensor with a command
+ * @data:       SGP data
+ * @cmd:        SGP Command to issue
+ * @buf:        Data to write
+ * @buf_size:   Data size of the buffer
+ *
+ * Return:      0 on success, negative error otherwise.
+ */
+static int sgp_write_cmd(struct sgp_data *data, enum sgp_cmd cmd, u16 *buf,
+			 size_t buf_size, unsigned long duration_us)
+{
+	int ret, ix;
+	u16 buf_idx;
+	u8 buffer[SGP_CMD_MAX_BUF_SIZE];
+
+	/* assemble buffer */
+	*((__be16 *)&buffer[0]) = cmd;
+	buf_idx = SGP_CMD_LEN;
+	for (ix = 0; ix < buf_size; ix++) {
+		*((__be16 *)&buffer[buf_idx]) = cpu_to_be16(buf[ix]);
+		buf_idx += SGP_WORD_LEN;
+		buffer[buf_idx] = crc8(sgp_crc8_table,
+				       &buffer[buf_idx - SGP_WORD_LEN],
+				       SGP_WORD_LEN, SGP_CRC8_INIT);
+		buf_idx += SGP_CRC8_LEN;
+	}
+	ret = i2c_master_send(data->client, buffer, buf_idx);
+	if (ret != buf_idx)
+		return -EIO;
+	ret = 0;
+	usleep_range(duration_us, duration_us + 1000);
+
+	return ret;
+}
+
+/**
+ * sgp_measure_iaq() - measure and retrieve IAQ values from sensor
+ * The caller must hold data->data_lock for the duration of the call.
+ * @data:       SGP data
+ *
+ * Return:      0 on success, -EBUSY on default values, negative error
+ *              otherwise.
+ */
+
+static int sgp_measure_iaq(struct sgp_data *data)
+{
+	int ret;
+	/* data contains default values */
+	bool default_vals = !time_after(jiffies, data->iaq_init_start_jiffies +
+						 data->iaq_defval_skip_jiffies);
+
+	ret = sgp_read_cmd(data, data->measure_iaq_cmd, &data->iaq_buffer,
+			   SGP_MEASUREMENT_LEN, SGP_MEASUREMENT_DURATION_US);
+	if (ret < 0)
+		return ret;
+
+	data->iaq_buffer_state = IAQ_BUFFER_DEFAULT_VALS;
+
+	if (default_vals)
+		return -EBUSY;
+
+	data->iaq_buffer_state = IAQ_BUFFER_VALID;
+	return 0;
+}
+
+static void sgp_iaq_thread_sleep_until(const struct sgp_data *data,
+				       unsigned long sleep_jiffies)
+{
+	const long IAQ_POLL = 50000;
+
+	while (!time_after(jiffies, sleep_jiffies)) {
+		usleep_range(IAQ_POLL, IAQ_POLL + 10000);
+		if (kthread_should_stop() || data->iaq_init_start_jiffies == 0)
+			return;
+	}
+}
+
+static int sgp_iaq_threadfn(void *p)
+{
+	struct sgp_data *data = (struct sgp_data *)p;
+	unsigned long next_update_jiffies;
+	int ret;
+
+	while (!kthread_should_stop()) {
+		mutex_lock(&data->data_lock);
+		if (data->iaq_init_start_jiffies == 0) {
+			if (data->iaq_init_fn)
+				data->iaq_init_fn(data);
+			ret = sgp_read_cmd(data, data->iaq_init_cmd, NULL, 0,
+					   SGP_CMD_DURATION_US);
+			if (ret < 0)
+				goto unlock_sleep_continue;
+			data->iaq_init_start_jiffies = jiffies;
+			if (data->user_baseline[0]) {
+				ret = sgp_write_cmd(data, SGP_CMD_SET_BASELINE,
+						    data->user_baseline,
+						    data->baseline_len,
+						    SGP_CMD_DURATION_US);
+				if (ret < 0) {
+					dev_err(&data->client->dev,
+						"IAQ set baseline failed [%d]\n",
+						ret);
+					goto unlock_sleep_continue;
+				}
+			}
+			if (data->iaq_init_duration_jiffies) {
+				mutex_unlock(&data->data_lock);
+				sgp_iaq_thread_sleep_until(data,
+					    data->iaq_init_start_jiffies +
+					    data->iaq_init_duration_jiffies);
+				continue;
+			}
+		}
+
+		ret = sgp_measure_iaq(data);
+		if (ret && ret != -EBUSY) {
+			dev_warn(&data->client->dev, "IAQ measurement error [%d]\n",
+				 ret);
+		}
+unlock_sleep_continue:
+		next_update_jiffies = jiffies + data->measure_interval_jiffies;
+		mutex_unlock(&data->data_lock);
+		sgp_iaq_thread_sleep_until(data, next_update_jiffies);
+	}
+	return 0;
+}
+
+static ssize_t sgp_absolute_humidity_store(struct device *dev,
+					   __attribute__((unused))
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+	u32 ah;
+	u16 ah_scaled;
+	int ret;
+
+	if (!data->supports_humidity_compensation)
+		return -EINVAL;
+
+	ret = kstrtou32(buf, 10, &ah);
+	if (ret != 1 || ah < 0 || ah > 256000)
+		return -EINVAL;
+
+	/* ah_scaled = (u16)((ah / 1000.0) * 256.0) */
+	ah_scaled = (u16)(((u64)ah * 256 * 16777) >> 24);
+
+	/* don't disable AH compensation due to rounding */
+	if (ah > 0 && ah_scaled == 0)
+		ah_scaled = 1;
+
+	mutex_lock(&data->data_lock);
+	ret = sgp_write_cmd(data, SGP_CMD_SET_ABSOLUTE_HUMIDITY,
+			    &ah_scaled, 1, SGP_CMD_DURATION_US);
+	mutex_unlock(&data->data_lock);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static int sgp_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan, int *val,
+			int *val2, long mask)
+{
+	struct sgp_data *data = iio_priv(indio_dev);
+	struct sgp_crc_word *words;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->data_lock);
+		if (data->iaq_buffer_state != IAQ_BUFFER_VALID) {
+			mutex_unlock(&data->data_lock);
+			return -EBUSY;
+		}
+		words = data->iaq_buffer.raw_words;
+		switch (chan->address) {
+		case SGP30_IAQ_TVOC_IDX:
+		case SGPC3_IAQ_TVOC_IDX:
+			*val = 0;
+			*val2 = be16_to_cpu(words[1].value);
+			ret = IIO_VAL_INT_PLUS_NANO;
+			break;
+		case SGP30_IAQ_CO2EQ_IDX:
+			*val = 0;
+			*val2 = be16_to_cpu(words[0].value);
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		mutex_unlock(&data->data_lock);
+		break;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->data_lock);
+		if (chan->address == SGPC3_SIG_ETOH_IDX) {
+			if (data->iaq_buffer_state == IAQ_BUFFER_EMPTY)
+				ret = -EBUSY;
+			else
+				ret = 0;
+			words = data->iaq_buffer.raw_words;
+		} else {
+			ret = sgp_read_cmd(data, data->measure_gas_signals_cmd,
+					   &data->buffer, SGP_MEASUREMENT_LEN,
+					   SGP_MEASUREMENT_DURATION_US);
+			words = data->buffer.raw_words;
+		}
+		if (ret) {
+			mutex_unlock(&data->data_lock);
+			return ret;
+		}
+
+		switch (chan->address) {
+		case SGP30_SIG_ETOH_IDX:
+			*val = be16_to_cpu(words[1].value);
+			ret = IIO_VAL_INT;
+			break;
+		case SGPC3_SIG_ETOH_IDX:
+		case SGP30_SIG_H2_IDX:
+			*val = be16_to_cpu(words[0].value);
+			ret = IIO_VAL_INT;
+			break;
+		}
+		mutex_unlock(&data->data_lock);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		case SGP30_SIG_ETOH_IDX:
+		case SGPC3_SIG_ETOH_IDX:
+		case SGP30_SIG_H2_IDX:
+			*val = 0;
+			*val2 = 1953125;
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static void sgp_restart_iaq_thread(struct sgp_data *data)
+{
+	mutex_lock(&data->data_lock);
+	data->iaq_buffer_state = IAQ_BUFFER_EMPTY;
+	data->iaq_init_start_jiffies = 0;
+	mutex_unlock(&data->data_lock);
+}
+
+static void sgpc3_iaq_init(struct sgp_data *data)
+{
+	int skip_cycles;
+
+	data->iaq_init_duration_jiffies = data->iaq_init_user_duration * HZ;
+	if (data->supports_power_mode) {
+		data->iaq_init_cmd = SGPC3_CMD_IAQ_INIT_CONTINUOUS;
+
+		if (data->power_mode == SGPC3_POWER_MODE_ULTRA_LOW_POWER) {
+			data->measure_interval_jiffies =
+				SGPC3_MEASURE_ULP_INTERVAL_HZ * HZ;
+		} else {
+			data->measure_interval_jiffies =
+				SGPC3_MEASURE_INTERVAL_HZ * HZ;
+		}
+
+		if (data->user_baseline[0])
+			skip_cycles = 1;
+		else if (data->power_mode == SGPC3_POWER_MODE_ULTRA_LOW_POWER)
+			skip_cycles = 2;
+		else
+			skip_cycles = 11;
+	} else {
+		switch (data->iaq_init_user_duration) {
+		case 0:
+			data->iaq_init_cmd = SGPC3_CMD_IAQ_INIT_0;
+			skip_cycles = 1;
+			break;
+		case 16:
+			data->iaq_init_cmd = SGPC3_CMD_IAQ_INIT_16;
+			skip_cycles = 9;
+			break;
+		case 64:
+			data->iaq_init_cmd = SGPC3_CMD_IAQ_INIT_64;
+			skip_cycles = 33;
+			break;
+		case 184:
+			data->iaq_init_cmd = SGPC3_CMD_IAQ_INIT_184;
+			skip_cycles = 93;
+			break;
+		default:
+			data->iaq_init_cmd = SGPC3_CMD_IAQ_INIT_64;
+			skip_cycles = 33;
+			break;
+		}
+		if (!data->user_baseline[0])
+			skip_cycles += 10;
+	}
+	data->iaq_defval_skip_jiffies = data->iaq_init_duration_jiffies +
+					(skip_cycles *
+					 data->measure_interval_jiffies);
+}
+
+static ssize_t sgp_iaq_preheat_store(struct device *dev,
+				     __attribute__((unused))
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+	u32 init_duration;
+	int ret;
+
+	if (SGP_VERS_PRODUCT(data) != SGPC3)
+		return -EINVAL;
+
+	mutex_lock(&data->data_lock);
+	ret = kstrtou32(buf, 10, &init_duration);
+	if (ret) {
+		ret = -EINVAL;
+		goto unlock_fail;
+	}
+
+	if (data->supports_power_mode) {
+		if (init_duration > 300) {
+			ret = -EINVAL;
+			goto unlock_fail;
+		}
+	} else {
+		if (init_duration == 0) {
+		} else if (init_duration <= 16) {
+			init_duration = 16;
+		} else if (init_duration <= 64) {
+			init_duration = 64;
+		} else if (init_duration <= 184) {
+			init_duration = 184;
+		} else {
+			ret = -EINVAL;
+			goto unlock_fail;
+		}
+	}
+
+	data->iaq_init_user_duration = init_duration;
+	mutex_unlock(&data->data_lock);
+
+	return count;
+
+unlock_fail:
+	mutex_unlock(&data->data_lock);
+	return ret;
+}
+
+static ssize_t sgp_power_mode_store(struct device *dev,
+				    __attribute__((unused))
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+	u16 power_mode;
+	int ret;
+	const char ULTRA_LOW[] = "ultra-low";
+	const char LOW[] = "low";
+
+	if (!data->supports_power_mode)
+		return -EINVAL;
+
+	if (strncmp(buf, ULTRA_LOW, sizeof(ULTRA_LOW) - 1) == 0)
+		power_mode = SGPC3_POWER_MODE_ULTRA_LOW_POWER;
+	else if (strncmp(buf, LOW, sizeof(LOW) - 1) == 0)
+		power_mode = SGPC3_POWER_MODE_LOW_POWER;
+	else
+		return -EINVAL;
+
+	mutex_lock(&data->data_lock);
+	if (power_mode == data->power_mode) {
+		mutex_unlock(&data->data_lock);
+		return count;
+	}
+
+	/* Switching power mode invalidates any set baselines */
+	if (power_mode != data->power_mode) {
+		data->user_baseline[0] = 0;
+		data->user_baseline[1] = 0;
+	}
+
+	ret = sgp_write_cmd(data, SGPC3_CMD_SET_POWER_MODE,
+			    &power_mode, 1, SGP_CMD_DURATION_US);
+	if (ret) {
+		mutex_unlock(&data->data_lock);
+		return ret;
+	}
+	data->power_mode = power_mode;
+	mutex_unlock(&data->data_lock);
+
+	sgp_restart_iaq_thread(data);
+	return count;
+}
+
+static int sgp_get_baseline(struct sgp_data *data, u16 *baseline_words)
+{
+	u16 baseline_word;
+	int ret, ix, jx;
+
+	mutex_lock(&data->data_lock);
+	ret = sgp_read_cmd(data, SGP_CMD_GET_BASELINE, &data->buffer,
+			   data->baseline_len, SGP_CMD_DURATION_US);
+	if (ret < 0)
+		goto unlock_fail;
+
+	for (ix = 0, jx = data->baseline_len - 1; ix < data->baseline_len;
+	     ix++, jx--) {
+		baseline_word = be16_to_cpu(data->buffer.raw_words[jx].value);
+		baseline_words[ix] = baseline_word;
+	}
+
+	if (!baseline_words[0])
+		ret = -EBUSY;
+
+unlock_fail:
+	mutex_unlock(&data->data_lock);
+	return ret;
+}
+
+static ssize_t sgp_iaq_baseline_show(struct device *dev,
+				     __attribute__((unused))
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	int ret;
+	u16 baseline_words[2];
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	ret = sgp_get_baseline(data, baseline_words);
+	if (ret < 0)
+		return ret;
+
+	if (data->baseline_len == 1)
+		return sprintf(buf, "%04hx\n", baseline_words[0]);
+
+	return sprintf(buf, "%04hx%04hx\n", baseline_words[0],
+		       baseline_words[1]);
+}
+
+/**
+ * Retrieve the sensor's baseline and report whether it's valid for persistence
+ * @baseline:   sensor's current baseline
+ *
+ * Return:      1 if the baseline was set manually or the sensor has been
+ *              operating for at least 12h, -EBUSY if the baseline is not yet
+ *              valid, another negative error otherwise.
+ */
+static int sgp_is_baseline_valid(struct sgp_data *data, u16 *baseline_words)
+{
+	int ret;
+
+	ret = sgp_get_baseline(data, baseline_words);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&data->data_lock);
+	ret = (data->user_baseline[0] ||
+	       time_after(jiffies,
+			  data->iaq_init_start_jiffies + 60 * 60 * 12 * HZ));
+	mutex_unlock(&data->data_lock);
+
+	return ret;
+}
+
+static void sgp_set_baseline(struct sgp_data *data, u16 *baseline_words)
+{
+	mutex_lock(&data->data_lock);
+	data->user_baseline[0] = baseline_words[0];
+	if (data->baseline_len == 2)
+		data->user_baseline[1] = baseline_words[1];
+	mutex_unlock(&data->data_lock);
+	sgp_restart_iaq_thread(data);
+}
+
+static ssize_t sgp_iaq_baseline_store(struct device *dev,
+				      __attribute__((unused))
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+	int newline = (count > 0 && buf[count - 1] == '\n');
+	u16 words[2];
+	int ret = 0;
+
+	if (count - newline == (data->baseline_len * 4)) {
+		if (data->baseline_len == 1)
+			ret = sscanf(buf, "%04hx", &words[0]);
+		else
+			ret = sscanf(buf, "%04hx%04hx", &words[0], &words[1]);
+	}
+
+	if (ret != data->baseline_len) {
+		dev_err(&data->client->dev, "invalid baseline format\n");
+		return -EINVAL;
+	}
+
+	sgp_set_baseline(data, words);
+	return count;
+}
+
+static ssize_t sgp_selftest_show(struct device *dev,
+				 __attribute__((unused))
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+	u16 baseline_words[2];
+	u16 measure_test;
+	int baseline_valid = 0;
+	int ret;
+
+	if (data->product_id == SGP30) {
+		/* On the SGP30, the self-test interferes with iaq_init */
+		baseline_valid = sgp_is_baseline_valid(data, baseline_words);
+	}
+
+	mutex_lock(&data->data_lock);
+	ret = sgp_read_cmd(data, SGP_CMD_SELFTEST, &data->buffer,
+			   1, SGP_SELFTEST_DURATION_US);
+	if (ret < 0) {
+		mutex_unlock(&data->data_lock);
+		return ret;
+	}
+
+	measure_test = be16_to_cpu(data->buffer.raw_words[0].value);
+	mutex_unlock(&data->data_lock);
+
+	if (data->product_id == SGP30) {
+		if (baseline_valid > 0)
+			sgp_set_baseline(data, baseline_words);
+		else
+			sgp_restart_iaq_thread(data);
+	}
+
+	return sprintf(buf, "%s\n",
+		       measure_test ^ SGP_SELFTEST_OK ? "FAILED" : "OK");
+}
+
+static ssize_t sgp_serial_id_show(struct device *dev,
+				 __attribute__((unused))
+				 struct device_attribute *attr,
+				 char *buf)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%llu\n", data->serial_id);
+}
+
+static ssize_t sgp_feature_set_version_show(struct device *dev,
+					    __attribute__((unused))
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct sgp_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%hu.%hu\n", (data->feature_set & 0x00e0) >> 5,
+		       data->feature_set & 0x001f);
+}
+
+static int sgp_get_serial_id(struct sgp_data *data)
+{
+	int ret;
+	struct sgp_crc_word *words;
+
+	mutex_lock(&data->data_lock);
+	ret = sgp_read_cmd(data, SGP_CMD_GET_SERIAL_ID, &data->buffer, 3,
+			   SGP_CMD_DURATION_US);
+	if (ret < 0)
+		goto unlock_fail;
+
+	words = data->buffer.raw_words;
+	data->serial_id = (u64)(be16_to_cpu(words[2].value) & 0xffff)       |
+			  (u64)(be16_to_cpu(words[1].value) & 0xffff) << 16 |
+			  (u64)(be16_to_cpu(words[0].value) & 0xffff) << 32;
+
+unlock_fail:
+	mutex_unlock(&data->data_lock);
+	return ret;
+}
+
+static int sgp_check_compat(struct sgp_data *data,
+			    unsigned int product_id)
+{
+	struct sgp_version *supported_versions;
+	u16 ix, num_fs;
+	u16 product = SGP_VERS_PRODUCT(data);
+	u16 reserved = SGP_VERS_RESERVED(data);
+	u16 major = SGP_VERS_MAJOR(data);
+	u16 minor = SGP_VERS_MINOR(data);
+
+	/* driver does not match product */
+	if (product != product_id) {
+		dev_err(&data->client->dev,
+			"sensor reports a different product: 0x%04hx\n",
+			product);
+		return -ENODEV;
+	}
+	if (reserved) {
+		dev_warn(&data->client->dev, "reserved bits set: 0x%04hx\n",
+			 reserved);
+	}
+	/* engineering samples are not supported: no interface guarantees */
+	if (SGP_VERS_ENG_BIT(data))
+		return -ENODEV;
+
+	switch (product) {
+	case SGP30:
+		supported_versions =
+			(struct sgp_version *)supported_versions_sgp30;
+		num_fs = ARRAY_SIZE(supported_versions_sgp30);
+		break;
+	case SGPC3:
+		supported_versions =
+			(struct sgp_version *)supported_versions_sgpc3;
+		num_fs = ARRAY_SIZE(supported_versions_sgpc3);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	for (ix = 0; ix < num_fs; ix++) {
+		if (major == supported_versions[ix].major &&
+		    minor >= supported_versions[ix].minor)
+			return 0;
+	}
+	dev_err(&data->client->dev, "unsupported sgp version: %d.%d\n",
+		major, minor);
+	return -ENODEV;
+}
+
+static void sgp_init(struct sgp_data *data)
+{
+	data->iaq_init_cmd = SGP_CMD_IAQ_INIT;
+	data->iaq_init_start_jiffies = 0;
+	data->iaq_init_duration_jiffies = 0;
+	data->iaq_init_user_duration = 0;
+	data->iaq_init_fn = NULL;
+	data->iaq_buffer_state = IAQ_BUFFER_EMPTY;
+	data->user_baseline[0] = 0;
+	data->user_baseline[1] = 0;
+	switch (SGP_VERS_PRODUCT(data)) {
+	case SGP30:
+		data->measure_interval_jiffies = SGP30_MEASURE_INTERVAL_HZ * HZ;
+		data->measure_iaq_cmd = SGP_CMD_IAQ_MEASURE;
+		data->measure_gas_signals_cmd = SGP30_CMD_MEASURE_SIGNAL;
+		data->product_id = SGP30;
+		data->baseline_len = 2;
+		data->supports_humidity_compensation = true;
+		data->iaq_defval_skip_jiffies = 15 * HZ;
+		break;
+	case SGPC3:
+		data->measure_interval_jiffies = SGPC3_MEASURE_INTERVAL_HZ * HZ;
+		data->measure_iaq_cmd = SGPC3_CMD_MEASURE_RAW;
+		data->measure_gas_signals_cmd = SGPC3_CMD_MEASURE_RAW;
+		data->product_id = SGPC3;
+		data->baseline_len = 1;
+		data->power_mode = SGPC3_POWER_MODE_LOW_POWER;
+		data->iaq_init_user_duration =
+			SGPC3_DEFAULT_IAQ_INIT_DURATION_HZ;
+		if (SGP_VERS_MAJOR(data) == 0 && SGP_VERS_MINOR(data) >= 6) {
+			data->supports_humidity_compensation = true;
+			data->supports_power_mode = true;
+		}
+		data->iaq_init_fn = &sgpc3_iaq_init;
+		break;
+	};
+	data->iaq_thread = kthread_run(sgp_iaq_threadfn, data,
+				       "%s-iaq", data->client->name);
+}
+
+static IIO_DEVICE_ATTR(in_serial_id, 0444, sgp_serial_id_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_feature_set_version, 0444,
+		       sgp_feature_set_version_show, NULL, 0);
+static IIO_DEVICE_ATTR(in_selftest, 0444, sgp_selftest_show, NULL, 0);
+static IIO_DEVICE_ATTR(set_iaq_preheat_seconds, 0220, NULL,
+		       sgp_iaq_preheat_store, 0);
+static IIO_DEVICE_ATTR(in_iaq_baseline, 0444, sgp_iaq_baseline_show, NULL, 0);
+static IIO_DEVICE_ATTR(set_iaq_baseline, 0220, NULL, sgp_iaq_baseline_store, 0);
+static IIO_DEVICE_ATTR(set_absolute_humidity, 0220, NULL,
+		       sgp_absolute_humidity_store, 0);
+static IIO_DEVICE_ATTR(set_power_mode, 0220, NULL,
+		       sgp_power_mode_store, 0);
+
+static struct attribute *sgp_attributes[] = {
+	&iio_dev_attr_in_serial_id.dev_attr.attr,
+	&iio_dev_attr_in_feature_set_version.dev_attr.attr,
+	&iio_dev_attr_in_selftest.dev_attr.attr,
+	&iio_dev_attr_in_iaq_baseline.dev_attr.attr,
+	&iio_dev_attr_set_iaq_baseline.dev_attr.attr,
+	&iio_dev_attr_set_iaq_preheat_seconds.dev_attr.attr,
+	&iio_dev_attr_set_absolute_humidity.dev_attr.attr,
+	&iio_dev_attr_set_power_mode.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sgp_attr_group = {
+	.attrs = sgp_attributes,
+};
+
+static const struct iio_info sgp_info = {
+	.attrs		= &sgp_attr_group,
+	.read_raw	= sgp_read_raw,
+};
+
+static const struct of_device_id sgp_dt_ids[] = {
+	{ .compatible = "sensirion,sgp30", .data = (void *)SGP30 },
+	{ .compatible = "sensirion,sgpc3", .data = (void *)SGPC3 },
+	{ }
+};
+
+static int sgp_probe(struct i2c_client *client,
+		     const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct sgp_data *data;
+	const struct sgp_device *chip;
+	const struct of_device_id *of_id;
+	unsigned long product_id;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	of_id = of_match_device(sgp_dt_ids, &client->dev);
+	if (of_id)
+		product_id = (unsigned long)of_id->data;
+	else
+		product_id = id->driver_data;
+
+	chip = &sgp_devices[product_id];
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	crc8_populate_msb(sgp_crc8_table, SGP_CRC8_POLYNOMIAL);
+	mutex_init(&data->data_lock);
+
+	/* get serial id and write it to client data */
+	ret = sgp_get_serial_id(data);
+	if (ret < 0)
+		return ret;
+
+	/* get feature set version and write it to client data */
+	ret = sgp_read_cmd(data, SGP_CMD_GET_FEATURE_SET, &data->buffer, 1,
+			   SGP_CMD_DURATION_US);
+	if (ret < 0)
+		return ret;
+
+	data->feature_set = be16_to_cpu(data->buffer.raw_words[0].value);
+
+	ret = sgp_check_compat(data, product_id);
+	if (ret)
+		return ret;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &sgp_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	indio_dev->channels = chip->channels;
+	indio_dev->num_channels = chip->num_channels;
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "failed to register iio device\n");
+		return ret;
+	}
+
+	sgp_init(data);
+	return ret;
+}
+
+static int sgp_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct sgp_data *data = iio_priv(indio_dev);
+
+	if (data->iaq_thread)
+		kthread_stop(data->iaq_thread);
+	return 0;
+}
+
+static const struct i2c_device_id sgp_id[] = {
+	{ "sgp30", SGP30 },
+	{ "sgpc3", SGPC3 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, sgp_id);
+MODULE_DEVICE_TABLE(of, sgp_dt_ids);
+
+static struct i2c_driver sgp_driver = {
+	.driver = {
+		.name	= "sgp30",
+		.of_match_table = of_match_ptr(sgp_dt_ids),
+	},
+	.probe = sgp_probe,
+	.remove = sgp_remove,
+	.id_table = sgp_id,
+};
+module_i2c_driver(sgp_driver);
+
+MODULE_AUTHOR("Andreas Brauchli <andreas.brauchli@sensirion.com>");
+MODULE_AUTHOR("Pascal Sachs <pascal.sachs@sensirion.com>");
+MODULE_DESCRIPTION("Sensirion SGP gas sensors");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.6.0");
-- 
2.15.1
