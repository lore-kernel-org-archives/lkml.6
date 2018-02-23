Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELuzslhX6TiBVYYOjolkuaAOi0qGori5x55mR/wuIb3XyaPp7GKoi9GBrdMJVxjK8WsWJURi
ARC-Seal: i=1; a=rsa-sha256; t=1519403058; cv=none;
        d=google.com; s=arc-20160816;
        b=SZuYFdsnLp3CvLTd9PgkJh1o04JDqN99SE1yxLoj0wOmLHzoIQVzfYU1qK2SfoZ+Qu
         ikc5SWwEvJneL00hT6B0O+JHq0wOoS5nK1CLMgAbIdhe+dtfJBPKjBtk23VJGFpePp9m
         Y89cbbAxUoJW390VTVFdHKCeOX98ZKUezT5BdNcuVaHDTjam54UQq6qJRC92PVIP/pif
         IHYMr+Vlt+784XeOGHdPt9RQFIb7mGgdIs8N0GLBY7JVDuWfwYNt9U7a+ONbAqM+bEio
         KTN3JoDsEy+tzzPvIvhNk8vpo5hAtcSGcl7ERO9img34vRyyebG5wGRmQ8FNZro3viPT
         mdvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=UUpL9SwWfmn3htrfRjZTOp5qis5yLTDaugZ7aZJFk6g=;
        b=PWfkd3Dl8YnDOrl/G51crgI33Gnbpm5xgtLDX2UfWWrbAGLpufkcky+jYLXgD6Mcfj
         CLa45RzGOx5enJAHaHSbD4h7EejZNYLbqSm/7jPOTgLL+9+zaJOIzU/pJOboh3KEcU3/
         E8RIWfcEWUq9w0UKiDo+WrD0baY0KqaToaJ4vc8DA/W/aGJEdbNrJV+I22tLjx59tSxF
         3IUtz723GexLedcSE7cF1z5hTvUM3JeIkZ5dMbgnlCHsqPPusfhY3EaGJApm/NxLA5wr
         FJtRfzv7ML1fzlnhMpPCQ5VXcEBlxZiBnyz6w+nGHgpzIp6WhCNZoDFSMzF+3wzDCrM3
         TLVw==
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
Subject: [PATCH v6 06/20] firmware: arm_scmi: add initial support for performance protocol
Date: Fri, 23 Feb 2018 16:23:36 +0000
Message-Id: <1519403030-21189-7-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209580825368561?=
X-GMAIL-MSGID: =?utf-8?q?1593209580825368561?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The performance protocol is intended for the performance management of
group(s) of device(s) that run in the same performance domain. It
includes even the CPUs. A performance domain is defined by a set of
devices that always have to run at the same performance level.
For example, a set of CPUs that share a voltage domain, and have a
common frequency control, is said to be in the same performance domain.

The commands in this protocol provide functionality to describe the
protocol version, describe various attribute flags, set and get the
performance level of a domain. It also supports discovery of the list
of performance levels supported by a performance domain, and the
properties of each performance level.

This patch adds basic support for the performance protocol.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/common.h |   1 +
 drivers/firmware/arm_scmi/perf.c   | 489 +++++++++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  42 ++++
 4 files changed, 533 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/perf.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 5f4ec2613db6..687cbbfb3af6 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,4 +1,4 @@
 obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o
-scmi-protocols-y = base.o
+scmi-protocols-y = base.o perf.o
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index f1eeacaef57b..b045a3f268e7 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -30,6 +30,7 @@
 #define PROTOCOL_REV_MAJOR(x)	((x) >> PROTOCOL_REV_MINOR_BITS)
 #define PROTOCOL_REV_MINOR(x)	((x) & PROTOCOL_REV_MINOR_MASK)
 #define MAX_PROTOCOLS_IMP	16
+#define MAX_OPPS		16
 
 enum scmi_common_cmd {
 	PROTOCOL_VERSION = 0x0,
diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
new file mode 100644
index 000000000000..c189c5a3163f
--- /dev/null
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -0,0 +1,489 @@
+/*
+ * System Control and Management Interface (SCMI) Performance Protocol
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
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <linux/sort.h>
+
+#include "common.h"
+
+enum scmi_performance_protocol_cmd {
+	PERF_DOMAIN_ATTRIBUTES = 0x3,
+	PERF_DESCRIBE_LEVELS = 0x4,
+	PERF_LIMITS_SET = 0x5,
+	PERF_LIMITS_GET = 0x6,
+	PERF_LEVEL_SET = 0x7,
+	PERF_LEVEL_GET = 0x8,
+	PERF_NOTIFY_LIMITS = 0x9,
+	PERF_NOTIFY_LEVEL = 0xa,
+};
+
+struct scmi_opp {
+	u32 perf;
+	u32 power;
+	u32 trans_latency_us;
+};
+
+struct scmi_msg_resp_perf_attributes {
+	__le16 num_domains;
+	__le16 flags;
+#define POWER_SCALE_IN_MILLIWATT(x)	((x) & BIT(0))
+	__le32 stats_addr_low;
+	__le32 stats_addr_high;
+	__le32 stats_size;
+};
+
+struct scmi_msg_resp_perf_domain_attributes {
+	__le32 flags;
+#define SUPPORTS_SET_LIMITS(x)		((x) & BIT(31))
+#define SUPPORTS_SET_PERF_LVL(x)	((x) & BIT(30))
+#define SUPPORTS_PERF_LIMIT_NOTIFY(x)	((x) & BIT(29))
+#define SUPPORTS_PERF_LEVEL_NOTIFY(x)	((x) & BIT(28))
+	__le32 rate_limit_us;
+	__le32 sustained_freq_khz;
+	__le32 sustained_perf_level;
+	    u8 name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_msg_perf_describe_levels {
+	__le32 domain;
+	__le32 level_index;
+};
+
+struct scmi_perf_set_limits {
+	__le32 domain;
+	__le32 max_level;
+	__le32 min_level;
+};
+
+struct scmi_perf_get_limits {
+	__le32 max_level;
+	__le32 min_level;
+};
+
+struct scmi_perf_set_level {
+	__le32 domain;
+	__le32 level;
+};
+
+struct scmi_perf_notify_level_or_limits {
+	__le32 domain;
+	__le32 notify_enable;
+};
+
+struct scmi_msg_resp_perf_describe_levels {
+	__le16 num_returned;
+	__le16 num_remaining;
+	struct {
+		__le32 perf_val;
+		__le32 power;
+		__le16 transition_latency_us;
+		__le16 reserved;
+	} opp[0];
+};
+
+struct perf_dom_info {
+	bool set_limits;
+	bool set_perf;
+	bool perf_limit_notify;
+	bool perf_level_notify;
+	u32 opp_count;
+	u32 sustained_freq_khz;
+	u32 sustained_perf_level;
+	u32 mult_factor;
+	char name[SCMI_MAX_STR_SIZE];
+	struct scmi_opp opp[MAX_OPPS];
+};
+
+struct scmi_perf_info {
+	int num_domains;
+	bool power_scale_mw;
+	u64 stats_addr;
+	u32 stats_size;
+	struct perf_dom_info *dom_info;
+};
+
+static int scmi_perf_attributes_get(const struct scmi_handle *handle,
+				    struct scmi_perf_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_perf_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_PERF, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		u16 flags = le16_to_cpu(attr->flags);
+
+		pi->num_domains = le16_to_cpu(attr->num_domains);
+		pi->power_scale_mw = POWER_SCALE_IN_MILLIWATT(flags);
+		pi->stats_addr = le32_to_cpu(attr->stats_addr_low) |
+				(u64)le32_to_cpu(attr->stats_addr_high) << 32;
+		pi->stats_size = le32_to_cpu(attr->stats_size);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_perf_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
+				struct perf_dom_info *dom_info)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_perf_domain_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, PERF_DOMAIN_ATTRIBUTES,
+				 SCMI_PROTOCOL_PERF, sizeof(domain),
+				 sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+	attr = t->rx.buf;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		u32 flags = le32_to_cpu(attr->flags);
+
+		dom_info->set_limits = SUPPORTS_SET_LIMITS(flags);
+		dom_info->set_perf = SUPPORTS_SET_PERF_LVL(flags);
+		dom_info->perf_limit_notify = SUPPORTS_PERF_LIMIT_NOTIFY(flags);
+		dom_info->perf_level_notify = SUPPORTS_PERF_LEVEL_NOTIFY(flags);
+		dom_info->sustained_freq_khz =
+					le32_to_cpu(attr->sustained_freq_khz);
+		dom_info->sustained_perf_level =
+					le32_to_cpu(attr->sustained_perf_level);
+		dom_info->mult_factor =	(dom_info->sustained_freq_khz * 1000) /
+					dom_info->sustained_perf_level;
+		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int opp_cmp_func(const void *opp1, const void *opp2)
+{
+	const struct scmi_opp *t1 = opp1, *t2 = opp2;
+
+	return t1->perf - t2->perf;
+}
+
+static int
+scmi_perf_describe_levels_get(const struct scmi_handle *handle, u32 domain,
+			      struct perf_dom_info *perf_dom)
+{
+	int ret, cnt;
+	u32 tot_opp_cnt = 0;
+	u16 num_returned, num_remaining;
+	struct scmi_xfer *t;
+	struct scmi_opp *opp;
+	struct scmi_msg_perf_describe_levels *dom_info;
+	struct scmi_msg_resp_perf_describe_levels *level_info;
+
+	ret = scmi_one_xfer_init(handle, PERF_DESCRIBE_LEVELS,
+				 SCMI_PROTOCOL_PERF, sizeof(*dom_info), 0, &t);
+	if (ret)
+		return ret;
+
+	dom_info = t->tx.buf;
+	level_info = t->rx.buf;
+
+	do {
+		dom_info->domain = cpu_to_le32(domain);
+		/* Set the number of OPPs to be skipped/already read */
+		dom_info->level_index = cpu_to_le32(tot_opp_cnt);
+
+		ret = scmi_do_xfer(handle, t);
+		if (ret)
+			break;
+
+		num_returned = le16_to_cpu(level_info->num_returned);
+		num_remaining = le16_to_cpu(level_info->num_remaining);
+		if (tot_opp_cnt + num_returned > MAX_OPPS) {
+			dev_err(handle->dev, "No. of OPPs exceeded MAX_OPPS");
+			break;
+		}
+
+		opp = &perf_dom->opp[tot_opp_cnt];
+		for (cnt = 0; cnt < num_returned; cnt++, opp++) {
+			opp->perf = le32_to_cpu(level_info->opp[cnt].perf_val);
+			opp->power = le32_to_cpu(level_info->opp[cnt].power);
+			opp->trans_latency_us = le16_to_cpu
+				(level_info->opp[cnt].transition_latency_us);
+
+			dev_dbg(handle->dev, "Level %d Power %d Latency %dus\n",
+				opp->perf, opp->power, opp->trans_latency_us);
+		}
+
+		tot_opp_cnt += num_returned;
+		/*
+		 * check for both returned and remaining to avoid infinite
+		 * loop due to buggy firmware
+		 */
+	} while (num_returned && num_remaining);
+
+	perf_dom->opp_count = tot_opp_cnt;
+	scmi_one_xfer_put(handle, t);
+
+	sort(perf_dom->opp, tot_opp_cnt, sizeof(*opp), opp_cmp_func, NULL);
+	return ret;
+}
+
+static int scmi_perf_limits_set(const struct scmi_handle *handle, u32 domain,
+				u32 max_perf, u32 min_perf)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_perf_set_limits *limits;
+
+	ret = scmi_one_xfer_init(handle, PERF_LIMITS_SET, SCMI_PROTOCOL_PERF,
+				 sizeof(*limits), 0, &t);
+	if (ret)
+		return ret;
+
+	limits = t->tx.buf;
+	limits->domain = cpu_to_le32(domain);
+	limits->max_level = cpu_to_le32(max_perf);
+	limits->min_level = cpu_to_le32(min_perf);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_perf_limits_get(const struct scmi_handle *handle, u32 domain,
+				u32 *max_perf, u32 *min_perf)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_perf_get_limits *limits;
+
+	ret = scmi_one_xfer_init(handle, PERF_LIMITS_GET, SCMI_PROTOCOL_PERF,
+				 sizeof(__le32), 0, &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		limits = t->rx.buf;
+
+		*max_perf = le32_to_cpu(limits->max_level);
+		*min_perf = le32_to_cpu(limits->min_level);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_perf_level_set(const struct scmi_handle *handle, u32 domain, u32 level)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_perf_set_level *lvl;
+
+	ret = scmi_one_xfer_init(handle, PERF_LEVEL_SET, SCMI_PROTOCOL_PERF,
+				 sizeof(*lvl), 0, &t);
+	if (ret)
+		return ret;
+
+	lvl = t->tx.buf;
+	lvl->domain = cpu_to_le32(domain);
+	lvl->level = cpu_to_le32(level);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_perf_level_get(const struct scmi_handle *handle, u32 domain, u32 *level)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = scmi_one_xfer_init(handle, PERF_LEVEL_GET, SCMI_PROTOCOL_PERF,
+				 sizeof(u32), sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		*level = le32_to_cpu(*(__le32 *)t->rx.buf);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+/* Device specific ops */
+static int scmi_dev_domain_id(struct device *dev)
+{
+	struct of_phandle_args clkspec;
+
+	if (of_parse_phandle_with_args(dev->of_node, "clocks", "#clock-cells",
+				       0, &clkspec))
+		return -EINVAL;
+
+	return clkspec.args[0];
+}
+
+static int scmi_dvfs_add_opps_to_device(const struct scmi_handle *handle,
+					struct device *dev)
+{
+	int idx, ret, domain;
+	unsigned long freq;
+	struct scmi_opp *opp;
+	struct perf_dom_info *dom;
+	struct scmi_perf_info *pi = handle->perf_priv;
+
+	domain = scmi_dev_domain_id(dev);
+	if (domain < 0)
+		return domain;
+
+	dom = pi->dom_info + domain;
+	if (!dom)
+		return -EIO;
+
+	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
+		freq = opp->perf * dom->mult_factor;
+
+		ret = dev_pm_opp_add(dev, freq, 0);
+		if (ret) {
+			dev_warn(dev, "failed to add opp %luHz\n", freq);
+
+			while (idx-- > 0) {
+				freq = (--opp)->perf * dom->mult_factor;
+				dev_pm_opp_remove(dev, freq);
+			}
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int scmi_dvfs_get_transition_latency(const struct scmi_handle *handle,
+					    struct device *dev)
+{
+	struct perf_dom_info *dom;
+	struct scmi_perf_info *pi = handle->perf_priv;
+	int domain = scmi_dev_domain_id(dev);
+
+	if (domain < 0)
+		return domain;
+
+	dom = pi->dom_info + domain;
+	if (!dom)
+		return -EIO;
+
+	/* uS to nS */
+	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
+}
+
+static int scmi_dvfs_freq_set(const struct scmi_handle *handle, u32 domain,
+			      unsigned long freq)
+{
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	return scmi_perf_level_set(handle, domain, freq / dom->mult_factor);
+}
+
+static int scmi_dvfs_freq_get(const struct scmi_handle *handle, u32 domain,
+			      unsigned long *freq)
+{
+	int ret;
+	u32 level;
+	struct scmi_perf_info *pi = handle->perf_priv;
+	struct perf_dom_info *dom = pi->dom_info + domain;
+
+	ret = scmi_perf_level_get(handle, domain, &level);
+	if (!ret)
+		*freq = level * dom->mult_factor;
+
+	return ret;
+}
+
+static struct scmi_perf_ops perf_ops = {
+	.limits_set = scmi_perf_limits_set,
+	.limits_get = scmi_perf_limits_get,
+	.level_set = scmi_perf_level_set,
+	.level_get = scmi_perf_level_get,
+	.device_domain_id = scmi_dev_domain_id,
+	.get_transition_latency = scmi_dvfs_get_transition_latency,
+	.add_opps_to_device = scmi_dvfs_add_opps_to_device,
+	.freq_set = scmi_dvfs_freq_set,
+	.freq_get = scmi_dvfs_freq_get,
+};
+
+static int scmi_perf_protocol_init(struct scmi_handle *handle)
+{
+	int domain;
+	u32 version;
+	struct scmi_perf_info *pinfo;
+
+	scmi_version_get(handle, SCMI_PROTOCOL_PERF, &version);
+
+	dev_dbg(handle->dev, "Performance Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	scmi_perf_attributes_get(handle, pinfo);
+
+	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+				       sizeof(*pinfo->dom_info), GFP_KERNEL);
+	if (!pinfo->dom_info)
+		return -ENOMEM;
+
+	for (domain = 0; domain < pinfo->num_domains; domain++) {
+		struct perf_dom_info *dom = pinfo->dom_info + domain;
+
+		scmi_perf_domain_attributes_get(handle, domain, dom);
+		scmi_perf_describe_levels_get(handle, domain, dom);
+	}
+
+	handle->perf_ops = &perf_ops;
+	handle->perf_priv = pinfo;
+
+	return 0;
+}
+
+static int __init scmi_perf_init(void)
+{
+	return scmi_protocol_register(SCMI_PROTOCOL_PERF,
+				      &scmi_perf_protocol_init);
+}
+subsys_initcall(scmi_perf_init);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index db995126134d..d80f4c9a0fad 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -44,15 +44,57 @@ struct scmi_revision_info {
 	char sub_vendor_id[SCMI_MAX_STR_SIZE];
 };
 
+struct scmi_handle;
+
+/**
+ * struct scmi_perf_ops - represents the various operations provided
+ *	by SCMI Performance Protocol
+ *
+ * @limits_set: sets limits on the performance level of a domain
+ * @limits_get: gets limits on the performance level of a domain
+ * @level_set: sets the performance level of a domain
+ * @level_get: gets the performance level of a domain
+ * @device_domain_id: gets the scmi domain id for a given device
+ * @get_transition_latency: gets the DVFS transition latency for a given device
+ * @add_opps_to_device: adds all the OPPs for a given device
+ * @freq_set: sets the frequency for a given device using sustained frequency
+ *	to sustained performance level mapping
+ * @freq_get: gets the frequency for a given device using sustained frequency
+ *	to sustained performance level mapping
+ */
+struct scmi_perf_ops {
+	int (*limits_set)(const struct scmi_handle *handle, u32 domain,
+			  u32 max_perf, u32 min_perf);
+	int (*limits_get)(const struct scmi_handle *handle, u32 domain,
+			  u32 *max_perf, u32 *min_perf);
+	int (*level_set)(const struct scmi_handle *handle, u32 domain,
+			 u32 level);
+	int (*level_get)(const struct scmi_handle *handle, u32 domain,
+			 u32 *level);
+	int (*device_domain_id)(struct device *dev);
+	int (*get_transition_latency)(const struct scmi_handle *handle,
+				      struct device *dev);
+	int (*add_opps_to_device)(const struct scmi_handle *handle,
+				  struct device *dev);
+	int (*freq_set)(const struct scmi_handle *handle, u32 domain,
+			unsigned long rate);
+	int (*freq_get)(const struct scmi_handle *handle, u32 domain,
+			unsigned long *rate);
+};
+
 /**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
+ * @perf_ops: pointer to set of performance protocol operations
  */
 struct scmi_handle {
 	struct device *dev;
 	struct scmi_revision_info *version;
+	struct scmi_perf_ops *perf_ops;
+	/* for protocol internal use */
+	void *perf_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.7.4
