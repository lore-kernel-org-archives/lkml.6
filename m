Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x226GgHJhE+5iQrt98uArwIGiEagChvZJhGlvBJtru6HL11D9UE7HcAccaC4qntA0cy65/ixf
ARC-Seal: i=1; a=rsa-sha256; t=1519403063; cv=none;
        d=google.com; s=arc-20160816;
        b=ufmw5wwfD5KUrWa98MSQ0ulCvgziWGaLRMffRCfOmy+vy/ASgfr3q85vBNDLX9klvg
         Dy/O9G+ePEH4oquKia6wGQQbkUDiCwqRrJNpMPfhWnoC06vno7Imx4ztDuneb9LyvO1e
         ezqubkNrqT9LHfbnmJ0S5h+jUMK6y6zhS0MkrfzwOa0t8Oj8VP0F5quK6xUjV+B4Ex02
         4BOf5ACksbmKhopwmszLvx0IFq7MKogHL3HMQd2awyZeYW9yC6cwgbVL8InCGAiI64Hw
         HLyZC5fjCDbtXhpRXJkugqo8d0E5XpXHr7ycWEEabUzYzMaCPtK2Oa4PArxxiDhmWzkj
         zVuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=fxoX5R62hurW/1yX48M1PzdFJKuwHCOZg/oPlqIUCKg=;
        b=0MwXpgVekuIFzqlhdcZaO5Ji8fLKcYUnPEuxy/vfvtL63gtxJCq11Misqg3xPEVQu9
         aUh3+1srnrSOrhvqdfsHMCnvJ16WjycgiiSlIrH7r0uYZzz//InYklgr3utQRcDJs7SE
         LrB8KT7wKOD4FTin18EiglzIBwyhNcjeC3K5YoxHdsxBkkB9/7Oh5pN5Czo7LAwRhhjB
         RYe/3Ikzny3jMDnaxc3o8CLq1n29gbkFGtJL0Nk02vnfAuuJXgXUVatLcsQaeDDgPN8B
         QHL3jQhqLUMso7cDdclrzlyQY3IO4mcwjOLejm7yKu/+fXW8zdGXDOEiKMDOKR/tGb/W
         ugQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 09/20] firmware: arm_scmi: add initial support for sensor protocol
Date: Fri, 23 Feb 2018 16:23:39 +0000
Message-Id: <1519403030-21189-10-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209586353652925?=
X-GMAIL-MSGID: =?utf-8?q?1593209586353652925?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The sensor protocol provides functions to manage platform sensors, and
provides the commands to describe the protocol version and the various
attribute flags. It also provides commands to discover various sensors
implemented and managed by the platform, read any sensor synchronously
or asynchronously as allowed by the platform, program sensor attributes
and/or configurations, if applicable.

This patch adds support for most of the above features.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile  |   2 +-
 drivers/firmware/arm_scmi/sensors.c | 302 ++++++++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h       |  46 ++++++
 3 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/sensors.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 420c761ced94..3236890905b9 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,4 +1,4 @@
 obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o
-scmi-protocols-y = base.o clock.o perf.o power.o
+scmi-protocols-y = base.o clock.o perf.o power.o sensors.o
diff --git a/drivers/firmware/arm_scmi/sensors.c b/drivers/firmware/arm_scmi/sensors.c
new file mode 100644
index 000000000000..3daba3c96062
--- /dev/null
+++ b/drivers/firmware/arm_scmi/sensors.c
@@ -0,0 +1,302 @@
+/*
+ * System Control and Management Interface (SCMI) Sensor Protocol
+ *
+ * Copyright (C) 2017 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "common.h"
+
+enum scmi_sensor_protocol_cmd {
+	SENSOR_DESCRIPTION_GET = 0x3,
+	SENSOR_CONFIG_SET = 0x4,
+	SENSOR_TRIP_POINT_SET = 0x5,
+	SENSOR_READING_GET = 0x6,
+};
+
+struct scmi_msg_resp_sensor_attributes {
+	__le16 num_sensors;
+	u8 max_requests;
+	u8 reserved;
+	__le32 reg_addr_low;
+	__le32 reg_addr_high;
+	__le32 reg_size;
+};
+
+struct scmi_msg_resp_sensor_description {
+	__le16 num_returned;
+	__le16 num_remaining;
+	struct {
+		__le32 id;
+		__le32 attributes_low;
+#define SUPPORTS_ASYNC_READ(x)	((x) & BIT(31))
+#define NUM_TRIP_POINTS(x)	(((x) >> 4) & 0xff)
+		__le32 attributes_high;
+#define SENSOR_TYPE(x)		((x) & 0xff)
+#define SENSOR_SCALE(x)		(((x) >> 11) & 0x3f)
+#define SENSOR_UPDATE_SCALE(x)	(((x) >> 22) & 0x1f)
+#define SENSOR_UPDATE_BASE(x)	(((x) >> 27) & 0x1f)
+		    u8 name[SCMI_MAX_STR_SIZE];
+	} desc[0];
+};
+
+struct scmi_msg_set_sensor_config {
+	__le32 id;
+	__le32 event_control;
+};
+
+struct scmi_msg_set_sensor_trip_point {
+	__le32 id;
+	__le32 event_control;
+#define SENSOR_TP_EVENT_MASK	(0x3)
+#define SENSOR_TP_DISABLED	0x0
+#define SENSOR_TP_POSITIVE	0x1
+#define SENSOR_TP_NEGATIVE	0x2
+#define SENSOR_TP_BOTH		0x3
+#define SENSOR_TP_ID(x)		(((x) & 0xff) << 4)
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct scmi_msg_sensor_reading_get {
+	__le32 id;
+	__le32 flags;
+#define SENSOR_READ_ASYNC	BIT(0)
+};
+
+struct sensors_info {
+	int num_sensors;
+	int max_requests;
+	u64 reg_addr;
+	u32 reg_size;
+	struct scmi_sensor_info *sensors;
+};
+
+static int scmi_sensor_attributes_get(const struct scmi_handle *handle,
+				      struct sensors_info *si)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_sensor_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_SENSOR, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		si->num_sensors = le16_to_cpu(attr->num_sensors);
+		si->max_requests = attr->max_requests;
+		si->reg_addr = le32_to_cpu(attr->reg_addr_low) |
+				(u64)le32_to_cpu(attr->reg_addr_high) << 32;
+		si->reg_size = le32_to_cpu(attr->reg_size);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_sensor_description_get(const struct scmi_handle *handle,
+				       struct sensors_info *si)
+{
+	int ret, cnt;
+	u32 desc_index = 0;
+	u16 num_returned, num_remaining;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_sensor_description *buf;
+
+	ret = scmi_one_xfer_init(handle, SENSOR_DESCRIPTION_GET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	buf = t->rx.buf;
+
+	do {
+		/* Set the number of sensors to be skipped/already read */
+		*(__le32 *)t->tx.buf = cpu_to_le32(desc_index);
+
+		ret = scmi_do_xfer(handle, t);
+		if (ret)
+			break;
+
+		num_returned = le16_to_cpu(buf->num_returned);
+		num_remaining = le16_to_cpu(buf->num_remaining);
+
+		if (desc_index + num_returned > si->num_sensors) {
+			dev_err(handle->dev, "No. of sensors can't exceed %d",
+				si->num_sensors);
+			break;
+		}
+
+		for (cnt = 0; cnt < num_returned; cnt++) {
+			u32 attrh;
+			struct scmi_sensor_info *s;
+
+			attrh = le32_to_cpu(buf->desc[cnt].attributes_high);
+			s = &si->sensors[desc_index + cnt];
+			s->id = le32_to_cpu(buf->desc[cnt].id);
+			s->type = SENSOR_TYPE(attrh);
+			memcpy(s->name, buf->desc[cnt].name, SCMI_MAX_STR_SIZE);
+		}
+
+		desc_index += num_returned;
+		/*
+		 * check for both returned and remaining to avoid infinite
+		 * loop due to buggy firmware
+		 */
+	} while (num_returned && num_remaining);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_sensor_configuration_set(const struct scmi_handle *handle, u32 sensor_id)
+{
+	int ret;
+	u32 evt_cntl = BIT(0);
+	struct scmi_xfer *t;
+	struct scmi_msg_set_sensor_config *cfg;
+
+	ret = scmi_one_xfer_init(handle, SENSOR_CONFIG_SET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(sensor_id);
+	cfg->event_control = cpu_to_le32(evt_cntl);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_sensor_trip_point_set(const struct scmi_handle *handle,
+				      u32 sensor_id, u8 trip_id, u64 trip_value)
+{
+	int ret;
+	u32 evt_cntl = SENSOR_TP_BOTH;
+	struct scmi_xfer *t;
+	struct scmi_msg_set_sensor_trip_point *trip;
+
+	ret = scmi_one_xfer_init(handle, SENSOR_TRIP_POINT_SET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*trip), 0, &t);
+	if (ret)
+		return ret;
+
+	trip = t->tx.buf;
+	trip->id = cpu_to_le32(sensor_id);
+	trip->event_control = cpu_to_le32(evt_cntl | SENSOR_TP_ID(trip_id));
+	trip->value_low = cpu_to_le32(trip_value & 0xffffffff);
+	trip->value_high = cpu_to_le32(trip_value >> 32);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_sensor_reading_get(const struct scmi_handle *handle,
+				   u32 sensor_id, bool async, u64 *value)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_sensor_reading_get *sensor;
+
+	ret = scmi_one_xfer_init(handle, SENSOR_READING_GET,
+				 SCMI_PROTOCOL_SENSOR, sizeof(*sensor),
+				 sizeof(u64), &t);
+	if (ret)
+		return ret;
+
+	sensor = t->tx.buf;
+	sensor->id = cpu_to_le32(sensor_id);
+	sensor->flags = cpu_to_le32(async ? SENSOR_READ_ASYNC : 0);
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		__le32 *pval = t->rx.buf;
+
+		*value = le32_to_cpu(*pval);
+		*value |= (u64)le32_to_cpu(*(pval + 1)) << 32;
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static const struct scmi_sensor_info *
+scmi_sensor_info_get(const struct scmi_handle *handle, u32 sensor_id)
+{
+	struct sensors_info *si = handle->sensor_priv;
+
+	return si->sensors + sensor_id;
+}
+
+static int scmi_sensor_count_get(const struct scmi_handle *handle)
+{
+	struct sensors_info *si = handle->sensor_priv;
+
+	return si->num_sensors;
+}
+
+static struct scmi_sensor_ops sensor_ops = {
+	.count_get = scmi_sensor_count_get,
+	.info_get = scmi_sensor_info_get,
+	.configuration_set = scmi_sensor_configuration_set,
+	.trip_point_set = scmi_sensor_trip_point_set,
+	.reading_get = scmi_sensor_reading_get,
+};
+
+static int scmi_sensors_protocol_init(struct scmi_handle *handle)
+{
+	u32 version;
+	struct sensors_info *sinfo;
+
+	scmi_version_get(handle, SCMI_PROTOCOL_SENSOR, &version);
+
+	dev_dbg(handle->dev, "Sensor Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	sinfo = devm_kzalloc(handle->dev, sizeof(*sinfo), GFP_KERNEL);
+	if (!sinfo)
+		return -ENOMEM;
+
+	scmi_sensor_attributes_get(handle, sinfo);
+
+	sinfo->sensors = devm_kcalloc(handle->dev, sinfo->num_sensors,
+				      sizeof(*sinfo->sensors), GFP_KERNEL);
+	if (!sinfo->sensors)
+		return -ENOMEM;
+
+	scmi_sensor_description_get(handle, sinfo);
+
+	handle->sensor_ops = &sensor_ops;
+	handle->sensor_priv = sinfo;
+
+	return 0;
+}
+
+static int __init scmi_sensors_init(void)
+{
+	return scmi_protocol_register(SCMI_PROTOCOL_SENSOR,
+				      &scmi_sensors_protocol_init);
+}
+subsys_initcall(scmi_sensors_init);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index be5396537b91..0bb12f822f12 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -148,6 +148,49 @@ struct scmi_power_ops {
 			 u32 *state);
 };
 
+struct scmi_sensor_info {
+	u32 id;
+	u8 type;
+	char name[SCMI_MAX_STR_SIZE];
+};
+
+/*
+ * Partial list from Distributed Management Task Force (DMTF) specification:
+ * DSP0249 (Platform Level Data Model specification)
+ */
+enum scmi_sensor_class {
+	NONE = 0x0,
+	TEMPERATURE_C = 0x2,
+	VOLTAGE = 0x5,
+	CURRENT = 0x6,
+	POWER = 0x7,
+	ENERGY = 0x8,
+};
+
+/**
+ * struct scmi_sensor_ops - represents the various operations provided
+ *	by SCMI Sensor Protocol
+ *
+ * @count_get: get the count of sensors provided by SCMI
+ * @info_get: get the information of the specified sensor
+ * @configuration_set: control notifications on cross-over events for
+ *	the trip-points
+ * @trip_point_set: selects and configures a trip-point of interest
+ * @reading_get: gets the current value of the sensor
+ */
+struct scmi_sensor_ops {
+	int (*count_get)(const struct scmi_handle *handle);
+
+	const struct scmi_sensor_info *(*info_get)
+		(const struct scmi_handle *handle, u32 sensor_id);
+	int (*configuration_set)(const struct scmi_handle *handle,
+				 u32 sensor_id);
+	int (*trip_point_set)(const struct scmi_handle *handle, u32 sensor_id,
+			      u8 trip_id, u64 trip_value);
+	int (*reading_get)(const struct scmi_handle *handle, u32 sensor_id,
+			   bool async, u64 *value);
+};
+
 /**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
@@ -156,6 +199,7 @@ struct scmi_power_ops {
  * @power_ops: pointer to set of power protocol operations
  * @perf_ops: pointer to set of performance protocol operations
  * @clk_ops: pointer to set of clock protocol operations
+ * @sensor_ops: pointer to set of sensor protocol operations
  */
 struct scmi_handle {
 	struct device *dev;
@@ -163,10 +207,12 @@ struct scmi_handle {
 	struct scmi_perf_ops *perf_ops;
 	struct scmi_clk_ops *clk_ops;
 	struct scmi_power_ops *power_ops;
+	struct scmi_sensor_ops *sensor_ops;
 	/* for protocol internal use */
 	void *perf_priv;
 	void *clk_priv;
 	void *power_priv;
+	void *sensor_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.7.4
