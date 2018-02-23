Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELstan+6Uj6l7oBpBuraci9Wev4Dk+0tRZzYNepjMksF0i2WHYGD8hJ4Uzh5ApMZ2HnJK7MD
ARC-Seal: i=1; a=rsa-sha256; t=1519403061; cv=none;
        d=google.com; s=arc-20160816;
        b=bxu5itOrluAnKhMNLiozEzuvvWw6CiKSCnqphiaWovAlgpcUDgUL4r5QFCipGNg1oh
         Yf5IomFBE6f+9PyuodtH2pYqyIZQAqqryd9ljEBAEYHgZrDUUBBXD9m+y2zA8HKHHtu0
         JDpiz3VaZpq1yLqufmI4IujYT2+0XJJ4gd+PJDJB+o5d1bczcNa9pwotSyVTMaWGkWK5
         XmwQhgZVEY6esPQGQqgZFbtjhp75Nl1+8WH+ttAFUHcszuysvFntWv1VWRCQiu/2ZbCf
         LjIA+EjQmGex72CPZzZm2ZD8FE8RCCiWZ5sYmyXjOdmgEn/2GgtKgZXURyisNa+HQci0
         pHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=3GmZEi3lns+p9T32SCCsfqIL0isFyukHwENEACiaDX0=;
        b=M7ZauroxwuQIjzrCVbg0CubSEnyAy0590tkATUnTjrWms5p7wIpHZaOFUumhgDxgtH
         EXVvmvEGuhjrOdoPsI1QY5bZXkGaLCso9L53wUH7eVrAv26g0+HFLIS1bEskxwzvWVwB
         I6uyUQbE7eoEDVzs4ICMTBf/arOwjVYLNXV5YvvIPgv1ooPKOJKsTjXAPNrI0prtNfj9
         FM5q3VrIzruSgaHCcC5NlqEP5hFhWs5IF4A2djK9Z/OCk2mxAOJY+vUHKsbXOe63uqRF
         cbIV1zIBVPnhmYtj4s0XvSrOuqbCOG1GnpGxZNRsZzXnL47LV5VmrpTWJpKkgDwr1u3n
         02jw==
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
Subject: [PATCH v6 08/20] firmware: arm_scmi: add initial support for power protocol
Date: Fri, 23 Feb 2018 16:23:38 +0000
Message-Id: <1519403030-21189-9-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209584550204919?=
X-GMAIL-MSGID: =?utf-8?q?1593209584550204919?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The power protocol is intended for management of power states of various
power domains. The power domain management protocol provides commands to
describe the protocol version, discover the implementation specific
attributes, set and get the power state of a domain.

This patch adds support for the above mention features of the protocol.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
--
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/power.c  | 242 +++++++++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  28 +++++
 3 files changed, 271 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/power.c
---
 drivers/firmware/arm_scmi/Makefile |   2 +-
 drivers/firmware/arm_scmi/power.c  | 232 +++++++++++++++++++++++++++++++++++++
 include/linux/scmi_protocol.h      |  28 +++++
 3 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/power.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 2130ee9ac825..420c761ced94 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,4 +1,4 @@
 obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o
-scmi-protocols-y = base.o clock.o perf.o
+scmi-protocols-y = base.o clock.o perf.o power.o
diff --git a/drivers/firmware/arm_scmi/power.c b/drivers/firmware/arm_scmi/power.c
new file mode 100644
index 000000000000..baf92a15b7e9
--- /dev/null
+++ b/drivers/firmware/arm_scmi/power.c
@@ -0,0 +1,232 @@
+/*
+ * System Control and Management Interface (SCMI) Power Protocol
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
+enum scmi_power_protocol_cmd {
+	POWER_DOMAIN_ATTRIBUTES = 0x3,
+	POWER_STATE_SET = 0x4,
+	POWER_STATE_GET = 0x5,
+	POWER_STATE_NOTIFY = 0x6,
+};
+
+struct scmi_msg_resp_power_attributes {
+	__le16 num_domains;
+	__le16 reserved;
+	__le32 stats_addr_low;
+	__le32 stats_addr_high;
+	__le32 stats_size;
+};
+
+struct scmi_msg_resp_power_domain_attributes {
+	__le32 flags;
+#define SUPPORTS_STATE_SET_NOTIFY(x)	((x) & BIT(31))
+#define SUPPORTS_STATE_SET_ASYNC(x)	((x) & BIT(30))
+#define SUPPORTS_STATE_SET_SYNC(x)	((x) & BIT(29))
+	    u8 name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_power_set_state {
+	__le32 flags;
+#define STATE_SET_ASYNC		BIT(0)
+	__le32 domain;
+	__le32 state;
+};
+
+struct scmi_power_state_notify {
+	__le32 domain;
+	__le32 notify_enable;
+};
+
+struct power_dom_info {
+	bool state_set_sync;
+	bool state_set_async;
+	bool state_set_notify;
+	char name[SCMI_MAX_STR_SIZE];
+};
+
+struct scmi_power_info {
+	int num_domains;
+	u64 stats_addr;
+	u32 stats_size;
+	struct power_dom_info *dom_info;
+};
+
+static int scmi_power_attributes_get(const struct scmi_handle *handle,
+				     struct scmi_power_info *pi)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_power_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_POWER, 0, sizeof(*attr), &t);
+	if (ret)
+		return ret;
+
+	attr = t->rx.buf;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		pi->num_domains = le16_to_cpu(attr->num_domains);
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
+scmi_power_domain_attributes_get(const struct scmi_handle *handle, u32 domain,
+				 struct power_dom_info *dom_info)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_power_domain_attributes *attr;
+
+	ret = scmi_one_xfer_init(handle, POWER_DOMAIN_ATTRIBUTES,
+				 SCMI_PROTOCOL_POWER, sizeof(domain),
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
+		dom_info->state_set_notify = SUPPORTS_STATE_SET_NOTIFY(flags);
+		dom_info->state_set_async = SUPPORTS_STATE_SET_ASYNC(flags);
+		dom_info->state_set_sync = SUPPORTS_STATE_SET_SYNC(flags);
+		memcpy(dom_info->name, attr->name, SCMI_MAX_STR_SIZE);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_power_state_set(const struct scmi_handle *handle, u32 domain, u32 state)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_power_set_state *st;
+
+	ret = scmi_one_xfer_init(handle, POWER_STATE_SET, SCMI_PROTOCOL_POWER,
+				 sizeof(*st), 0, &t);
+	if (ret)
+		return ret;
+
+	st = t->tx.buf;
+	st->flags = cpu_to_le32(0);
+	st->domain = cpu_to_le32(domain);
+	st->state = cpu_to_le32(state);
+
+	ret = scmi_do_xfer(handle, t);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int
+scmi_power_state_get(const struct scmi_handle *handle, u32 domain, u32 *state)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = scmi_one_xfer_init(handle, POWER_STATE_GET, SCMI_PROTOCOL_POWER,
+				 sizeof(u32), sizeof(u32), &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(domain);
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		*state = le32_to_cpu(*(__le32 *)t->rx.buf);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+static int scmi_power_num_domains_get(const struct scmi_handle *handle)
+{
+	struct scmi_power_info *pi = handle->power_priv;
+
+	return pi->num_domains;
+}
+
+static char *scmi_power_name_get(const struct scmi_handle *handle, u32 domain)
+{
+	struct scmi_power_info *pi = handle->power_priv;
+	struct power_dom_info *dom = pi->dom_info + domain;
+
+	return dom->name;
+}
+
+static struct scmi_power_ops power_ops = {
+	.num_domains_get = scmi_power_num_domains_get,
+	.name_get = scmi_power_name_get,
+	.state_set = scmi_power_state_set,
+	.state_get = scmi_power_state_get,
+};
+
+static int scmi_power_protocol_init(struct scmi_handle *handle)
+{
+	int domain;
+	u32 version;
+	struct scmi_power_info *pinfo;
+
+	scmi_version_get(handle, SCMI_PROTOCOL_POWER, &version);
+
+	dev_dbg(handle->dev, "Power Version %d.%d\n",
+		PROTOCOL_REV_MAJOR(version), PROTOCOL_REV_MINOR(version));
+
+	pinfo = devm_kzalloc(handle->dev, sizeof(*pinfo), GFP_KERNEL);
+	if (!pinfo)
+		return -ENOMEM;
+
+	scmi_power_attributes_get(handle, pinfo);
+
+	pinfo->dom_info = devm_kcalloc(handle->dev, pinfo->num_domains,
+				       sizeof(*pinfo->dom_info), GFP_KERNEL);
+	if (!pinfo->dom_info)
+		return -ENOMEM;
+
+	for (domain = 0; domain < pinfo->num_domains; domain++) {
+		struct power_dom_info *dom = pinfo->dom_info + domain;
+
+		scmi_power_domain_attributes_get(handle, domain, dom);
+	}
+
+	handle->power_ops = &power_ops;
+	handle->power_priv = pinfo;
+
+	return 0;
+}
+
+static int __init scmi_power_init(void)
+{
+	return scmi_protocol_register(SCMI_PROTOCOL_POWER,
+				      &scmi_power_protocol_init);
+}
+subsys_initcall(scmi_power_init);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 981523620985..be5396537b91 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -124,10 +124,36 @@ struct scmi_perf_ops {
 };
 
 /**
+ * struct scmi_power_ops - represents the various operations provided
+ *	by SCMI Power Protocol
+ *
+ * @num_domains_get: get the count of power domains provided by SCMI
+ * @name_get: gets the name of a power domain
+ * @state_set: sets the power state of a power domain
+ * @state_get: gets the power state of a power domain
+ */
+struct scmi_power_ops {
+	int (*num_domains_get)(const struct scmi_handle *handle);
+	char *(*name_get)(const struct scmi_handle *handle, u32 domain);
+#define SCMI_POWER_STATE_TYPE_SHIFT	30
+#define SCMI_POWER_STATE_ID_MASK	(BIT(28) - 1)
+#define SCMI_POWER_STATE_PARAM(type, id) \
+	((((type) & BIT(0)) << SCMI_POWER_STATE_TYPE_SHIFT) | \
+		((id) & SCMI_POWER_STATE_ID_MASK))
+#define SCMI_POWER_STATE_GENERIC_ON	SCMI_POWER_STATE_PARAM(0, 0)
+#define SCMI_POWER_STATE_GENERIC_OFF	SCMI_POWER_STATE_PARAM(1, 0)
+	int (*state_set)(const struct scmi_handle *handle, u32 domain,
+			 u32 state);
+	int (*state_get)(const struct scmi_handle *handle, u32 domain,
+			 u32 *state);
+};
+
+/**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
  * @dev: pointer to the SCMI device
  * @version: pointer to the structure containing SCMI version information
+ * @power_ops: pointer to set of power protocol operations
  * @perf_ops: pointer to set of performance protocol operations
  * @clk_ops: pointer to set of clock protocol operations
  */
@@ -136,9 +162,11 @@ struct scmi_handle {
 	struct scmi_revision_info *version;
 	struct scmi_perf_ops *perf_ops;
 	struct scmi_clk_ops *clk_ops;
+	struct scmi_power_ops *power_ops;
 	/* for protocol internal use */
 	void *perf_priv;
 	void *clk_priv;
+	void *power_priv;
 };
 
 enum scmi_std_protocol {
-- 
2.7.4
