Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELscDgK301KcK4pgyHi1v61eKN3aLqPo8tMjCmTh/hgUC44NU/5I1tcrUBSEEjT5m9B9jvRw
ARC-Seal: i=1; a=rsa-sha256; t=1519403059; cv=none;
        d=google.com; s=arc-20160816;
        b=VlnNGaE/jtLFeXOX7BOcQ8uZEofUz8sJUsT6CtFOPtsNdhAq07NZJfuABilkkrzg0h
         oMIOcnChw7+LRIVePLj1ostNgCQquj9dQbaWq5IaI6AZERX2zp7b5FWMbpFb30nssSq6
         TGT/30Dd5qIMriH8LGxabFQ4a4m0WQQbXdYUf8uxsTjWDYb0l5JzNaakp10lwoWfgvZN
         RHkpIYeEuMNCIwYs0LG24FZergUFIBtSvsJfphnGgJ03TnzUJTUZ42rdbHNoM/L+XBgB
         SLMrrl9INQwxhB0wneFKE4kpzLAOm7LYf5dsyUd8UrSRSqaANUYT3xh7vrgAOYfwDGWS
         IC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=NXXFxuT8izlccyhL/3IVm1GJGuI4fFKdNdMsX/G0TDE=;
        b=fK6hItJAaJ0rIZwy4M0cgnkFj2IOANXmn42vvVpKRAIsVsJJ52a4Wz8y4g2aAoBmP6
         uTjuwoaKF3snmMzcJJRWjjqaYyKF5Izwx2mzrXGIwORyF6zGXvk4F2JtQXmE7qbvIaVZ
         WBGz3dE8emVeqKiWMzULwWCa9IxCetaxqxUnwnTXpXBGkeeZs+E/U58MArVX/vW93sPM
         5fS0vM0Ft3ulnPIhrRxgBj4e41L740bjHoH1gpQhKHA3NrrCtuLcYOhnEEGczL2ncpNC
         54Vi2pVhhKHn8zMe9WxMdWkCua0JmAQfmnzI2oMs8QeuuZJeEVoTEQI4gRR6i582sJAw
         kRPQ==
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
Subject: [PATCH v6 07/20] firmware: arm_scmi: add initial support for clock protocol
Date: Fri, 23 Feb 2018 16:23:37 +0000
Message-Id: <1519403030-21189-8-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209583153656472?=
X-GMAIL-MSGID: =?utf-8?q?1593209583153656472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The clock protocol is intended for management of clocks. It is used to
enable or disable clocks, and to set and get the clock rates. This
protocol provides commands to describe the protocol version, discover
various implementation specific attributes, describe a clock, enable
and disable a clock and get/set the rate of the clock synchronously or
asynchronously.

This patch adds initial support for the clock protocol.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/clock.c  | 353 +++++++++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  44 +++++
 3 files changed, 398 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/clock.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 687cbbfb3af6..2130ee9ac825 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,4 +1,4 @@
 obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o
-scmi-protocols-y = base.o perf.o
+scmi-protocols-y = base.o clock.o perf.o
diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
new file mode 100644
index 000000000000..34bc15e766c4
--- /dev/null
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -0,0 +1,353 @@
+/*
+ * System Control and Management Interface (SCMI) Clock Protocol
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
+enum scmi_clock_protocol_cmd {
+	CLOCK_ATTRIBUTES = 0x3,
+	CLOCK_DESCRIBE_RATES = 0x4,
+	CLOCK_RATE_SET = 0x5,
+	CLOCK_RATE_GET = 0x6,
+	CLOCK_CONFIG_SET = 0x7,
+};
+
+struct scmi_msg_resp_clock_protocol_attributes {
+	__le16 num_clocks;
+	u8 max_async_req;
+	u8 reserved;
+};
+
+struct scmi_msg_resp_clock_attributes {
+	__le32 attributes;
+#define	CLOCK_ENABLE	BIT(0)
+	    u8 name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_clock_set_config {
+	__le32 id;
+	__le32 attributes;
+};
+
+struct scmi_msg_clock_describe_rates {
+	__le32 id;
+	__le32 rate_index;
+};
+
+struct scmi_msg_resp_clock_describe_rates {
+	__le32 num_rates_flags;
+#define NUM_RETURNED(x)		((x) & 0xfff)
+#define RATE_DISCRETE(x)	!((x) & BIT(12))
+#define NUM_REMAINING(x)	((x) >> 16)
+	struct {
+		__le32 value_low;
+		__le32 value_high;
+	} rate[0];
+#define RATE_TO_U64(X)		\
+({				\
+	typeof(X) x = (X);	\
+	le32_to_cpu((x).value_low) | (u64)le32_to_cpu((x).value_high) << 32; \
+})
+};
+
+struct scmi_clock_set_rate {
+	__le32 flags;
+#define CLOCK_SET_ASYNC		BIT(0)
+#define CLOCK_SET_DELAYED	BIT(1)
+#define CLOCK_SET_ROUND_UP	BIT(2)
+#define CLOCK_SET_ROUND_AUTO	BIT(3)
+	__le32 id;
+	__le32 value_low;
+	__le32 value_high;
+};
+
+struct clock_info {
+	int num_clocks;
+	int max_async_req;
+	struct scmi_clock_info *clk;
+};
+
+static int scmi_clock_protocol_attributes_get(const struct scmi_handle *handle,
+					      struct clock_info *ci)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_clock_protocol_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_CLOCK, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		ci->num_clocks = le16_to_cpu(attr->num_clocks);
+		ci->max_async_req = attr->max_async_req;
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_clock_attributes_get(const struct scmi_handle *handle,
+				     u32 clk_id, struct scmi_clock_info *clk)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_clock_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, CLOCK_ATTRIBUTES, SCMI_PROTOCOL_CLOCK,
+				 sizeof(clk_id), sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
+	attr = t->rx.buf;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		memcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
+	else
+		clk->name[0] = '\0';
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
+			      struct scmi_clock_info *clk)
+{
+	u64 *rate;
+	int ret, cnt;
+	bool rate_discrete;
+	u32 tot_rate_cnt = 0, rates_flag;
+	u16 num_returned, num_remaining;
+	struct scmi_xfer *t;
+	struct scmi_msg_clock_describe_rates *clk_desc;
+	struct scmi_msg_resp_clock_describe_rates *rlist;
+
+	ret = scmi_one_xfer_init(handle, CLOCK_DESCRIBE_RATES,
+				 SCMI_PROTOCOL_CLOCK, sizeof(*clk_desc), 0, &t);
+	if (ret)
+		return ret;
+
+	clk_desc = t->tx.buf;
+	rlist = t->rx.buf;
+
+	do {
+		clk_desc->id = cpu_to_le32(clk_id);
+		/* Set the number of rates to be skipped/already read */
+		clk_desc->rate_index = cpu_to_le32(tot_rate_cnt);
+
+		ret = scmi_do_xfer(handle, t);
+		if (ret)
+			break;
+
+		rates_flag = le32_to_cpu(rlist->num_rates_flags);
+		num_remaining = NUM_REMAINING(rates_flag);
+		rate_discrete = RATE_DISCRETE(rates_flag);
+		num_returned = NUM_RETURNED(rates_flag);
+
+		if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
+			dev_err(handle->dev, "No. of rates > MAX_NUM_RATES");
+			break;
+		}
+
+		if (!rate_discrete) {
+			clk->range.min_rate = RATE_TO_U64(rlist->rate[0]);
+			clk->range.max_rate = RATE_TO_U64(rlist->rate[1]);
+			clk->range.step_size = RATE_TO_U64(rlist->rate[2]);
+			dev_dbg(handle->dev, "Min %llu Max %llu Step %llu Hz\n",
+				clk->range.min_rate, clk->range.max_rate,
+				clk->range.step_size);
+			break;
+		}
+
+		rate = &clk->list.rates[tot_rate_cnt];
+		for (cnt = 0; cnt < num_returned; cnt++, rate++) {
+			*rate = RATE_TO_U64(rlist->rate[cnt]);
+			dev_dbg(handle->dev, "Rate %llu Hz\n", *rate);
+		}
+
+		tot_rate_cnt += num_returned;
+		/*
+		 * check for both returned and remaining to avoid infinite
+		 * loop due to buggy firmware
+		 */
+	} while (num_returned && num_remaining);
+
+	if (rate_discrete)
+		clk->list.num_rates = tot_rate_cnt;
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_clock_rate_get(const struct scmi_handle *handle, u32 clk_id, u64 *value)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = scmi_one_xfer_init(handle, CLOCK_RATE_GET, SCMI_PROTOCOL_CLOCK,
+				 sizeof(__le32), sizeof(u64), &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(clk_id);
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
+static int scmi_clock_rate_set(const struct scmi_handle *handle, u32 clk_id,
+			       u32 config, u64 rate)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_clock_set_rate *cfg;
+
+	ret = scmi_one_xfer_init(handle, CLOCK_RATE_SET, SCMI_PROTOCOL_CLOCK,
+				 sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->flags = cpu_to_le32(config);
+	cfg->id = cpu_to_le32(clk_id);
+	cfg->value_low = cpu_to_le32(rate & 0xffffffff);
+	cfg->value_high = cpu_to_le32(rate >> 32);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_clock_config_set(const struct scmi_handle *handle, u32 clk_id, u32 config)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_clock_set_config *cfg;
+
+	ret = scmi_one_xfer_init(handle, CLOCK_CONFIG_SET, SCMI_PROTOCOL_CLOCK,
+				 sizeof(*cfg), 0, &t);
+	if (ret)
+		return ret;
+
+	cfg = t->tx.buf;
+	cfg->id = cpu_to_le32(clk_id);
+	cfg->attributes = cpu_to_le32(config);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_clock_enable(const struct scmi_handle *handle, u32 clk_id)
+{
+	return scmi_clock_config_set(handle, clk_id, CLOCK_ENABLE);
+}
+
+static int scmi_clock_disable(const struct scmi_handle *handle, u32 clk_id)
+{
+	return scmi_clock_config_set(handle, clk_id, 0);
+}
+
+static int scmi_clock_count_get(const struct scmi_handle *handle)
+{
+	struct clock_info *ci = handle->clk_priv;
+
+	return ci->num_clocks;
+}
+
+static const struct scmi_clock_info *
+scmi_clock_info_get(const struct scmi_handle *handle, u32 clk_id)
+{
+	struct clock_info *ci = handle->clk_priv;
+	struct scmi_clock_info *clk = ci->clk + clk_id;
+
+	if (!clk->name || !clk->name[0])
+		return NULL;
+
+	return clk;
+}
+
+static struct scmi_clk_ops clk_ops = {
+	.count_get = scmi_clock_count_get,
+	.info_get = scmi_clock_info_get,
+	.rate_get = scmi_clock_rate_get,
+	.rate_set = scmi_clock_rate_set,
+	.enable = scmi_clock_enable,
+	.disable = scmi_clock_disable,
+};
+
+static int scmi_clock_protocol_init(struct scmi_handle *handle)
+{
+	u32 version;
+	int clkid, ret;
+	struct clock_info *cinfo;
+
+	scmi_version_get(handle, SCMI_PROTOCOL_CLOCK, &version);
+
+	dev_dbg(handle->dev, "Clock Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	cinfo = devm_kzalloc(handle->dev, sizeof(*cinfo), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
+	scmi_clock_protocol_attributes_get(handle, cinfo);
+
+	cinfo->clk = devm_kcalloc(handle->dev, cinfo->num_clocks,
+				  sizeof(*cinfo->clk), GFP_KERNEL);
+	if (!cinfo->clk)
+		return -ENOMEM;
+
+	for (clkid = 0; clkid < cinfo->num_clocks; clkid++) {
+		struct scmi_clock_info *clk = cinfo->clk + clkid;
+
+		ret = scmi_clock_attributes_get(handle, clkid, clk);
+		if (!ret)
+			scmi_clock_describe_rates_get(handle, clkid, clk);
+	}
+
+	handle->clk_ops = &clk_ops;
+	handle->clk_priv = cinfo;
+
+	return 0;
+}
+
+static int __init scmi_clock_init(void)
+{
+	return scmi_protocol_register(SCMI_PROTOCOL_CLOCK,
+				      &scmi_clock_protocol_init);
+}
+subsys_initcall(scmi_clock_init);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index d80f4c9a0fad..981523620985 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 
 #define SCMI_MAX_STR_SIZE	16
+#define SCMI_MAX_NUM_RATES	16
 
 /**
  * struct scmi_revision_info - version information structure
@@ -44,9 +45,49 @@ struct scmi_revision_info {
 	char sub_vendor_id[SCMI_MAX_STR_SIZE];
 };
 
+struct scmi_clock_info {
+	char name[SCMI_MAX_STR_SIZE];
+	bool rate_discrete;
+	union {
+		struct {
+			int num_rates;
+			u64 rates[SCMI_MAX_NUM_RATES];
+		} list;
+		struct {
+			u64 min_rate;
+			u64 max_rate;
+			u64 step_size;
+		} range;
+	};
+};
+
 struct scmi_handle;
 
 /**
+ * struct scmi_clk_ops - represents the various operations provided
+ *	by SCMI Clock Protocol
+ *
+ * @count_get: get the count of clocks provided by SCMI
+ * @info_get: get the information of the specified clock
+ * @rate_get: request the current clock rate of a clock
+ * @rate_set: set the clock rate of a clock
+ * @enable: enables the specified clock
+ * @disable: disables the specified clock
+ */
+struct scmi_clk_ops {
+	int (*count_get)(const struct scmi_handle *handle);
+
+	const struct scmi_clock_info *(*info_get)
+		(const struct scmi_handle *handle, u32 clk_id);
+	int (*rate_get)(const struct scmi_handle *handle, u32 clk_id,
+			u64 *rate);
+	int (*rate_set)(const struct scmi_handle *handle, u32 clk_id,
+			u32 config, u64 rate);
+	int (*enable)(const struct scmi_handle *handle, u32 clk_id);
+	int (*disable)(const struct scmi_handle *handle, u32 clk_id);
+};
+
+/**
  * struct scmi_perf_ops - represents the various operations provided
  *	by SCMI Performance Protocol
  *
@@ -88,13 +129,16 @@ struct scmi_perf_ops {
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
  * @perf_ops: pointer to set of performance protocol operations
+ * @clk_ops: pointer to set of clock protocol operations
  */
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
 	struct scmi_perf_ops *perf_ops;
+	struct scmi_clk_ops *clk_ops;
 	/* for protocol internal use */
 	void *perf_priv;
+	void *clk_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.7.4
