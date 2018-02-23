Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELusW1cBo0NdElOI7b2fhtZRtFTnPELAXPEVH33gwVTUed7RfxX8iCpTaKzx9nDhsDLi+kp1
ARC-Seal: i=1; a=rsa-sha256; t=1519403055; cv=none;
        d=google.com; s=arc-20160816;
        b=ruODe3fQinlvZ4LEZY4HKjgw9VNH2muwpni2+6VhsejKWR8dtIQYN7qHLgLmA0dT3U
         3maANnNMMyqCurrb4cpZMgS7U20nODqQ82GbQyKwXF7QUkxwptoG64LWkuq7HCF6cVsh
         hWx/ETBhyEnQs8QjHjpG5A1J+vsX2IEauQRfhatCTbySbxGoRGntLkaEidc98M32oFOq
         UGuNyTBVfU5WENTDpmLpmoEAQJ3A9RMVTGyB7WtzzKeSHWhz5q62OlWJbVQX7mjPL+pc
         w+X8ggf1/ytLUwM2QEm/wjTah+EfKYdk+kl4m0AwOae5Bc1GNRCsAtC/PdugyWfS0fRu
         kzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=lk4ndxlErwQitmTFMKefFNUpRt7NbrFPfGhFI0xqzt8=;
        b=UCJJ7LftqW9afKZk1UDsySvYcVpFl3uclnW3RC1bVtbohqr1S/AGoM7AuTonTJC0dx
         lxlTUBmlMvUXrcoDZb6V2SBnWaj/C/zmGEPqLUEkVGMlvf6Q49RD9OMOgNSzw9vZmzR3
         GrjXNJPJaLBeLookAISumXIGGAxQWrOCCj0Cie8ptu+US38nWV+kVSGQ1QsuxjuUGwhl
         GyudI8c7ZKKUeTw5+S0XPrZu9tV6c/vRDsLRBhO+cL28ZGJWggzpTQTIeFwlbfdn3fVB
         ewNWLD5Fnw8296lvyS0P/yqoo6Y5b62FxFOqkfC0A3Uy4brsLi6R4T3sfbZlQy1FKc+C
         iBWQ==
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
Subject: [PATCH v6 04/20] firmware: arm_scmi: add common infrastructure and support for base protocol
Date: Fri, 23 Feb 2018 16:23:34 +0000
Message-Id: <1519403030-21189-5-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593209578298526460?=
X-GMAIL-MSGID: =?utf-8?q?1593209578298526460?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The base protocol describes the properties of the implementation and
provide generic error management. The base protocol provides commands
to describe protocol version, discover implementation specific
attributes and vendor/sub-vendor identification, list of protocols
implemented and the various agents are in the system including OSPM
and the platform. It also supports registering for notifications of
platform errors.

This protocol is mandatory. This patch adds support for the same along
with some basic infrastructure to add support for other protocols.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/Makefile |   3 +-
 drivers/firmware/arm_scmi/base.c   | 264 +++++++++++++++++++++++++++++++++++++
 drivers/firmware/arm_scmi/common.h |  37 ++++++
 drivers/firmware/arm_scmi/driver.c |  53 ++++++++
 include/linux/scmi_protocol.h      |  37 ++++++
 5 files changed, 393 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/arm_scmi/base.c

diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index b2a24ba2b636..5d9c7ef35f0f 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -1,2 +1,3 @@
-obj-y	= scmi-driver.o
+obj-y	= scmi-driver.o scmi-protocols.o
 scmi-driver-y = driver.o
+scmi-protocols-y = base.o
diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
new file mode 100644
index 000000000000..708a21f85a12
--- /dev/null
+++ b/drivers/firmware/arm_scmi/base.c
@@ -0,0 +1,264 @@
+/*
+ * System Control and Management Interface (SCMI) Base Protocol
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
+enum scmi_base_protocol_cmd {
+	BASE_DISCOVER_VENDOR = 0x3,
+	BASE_DISCOVER_SUB_VENDOR = 0x4,
+	BASE_DISCOVER_IMPLEMENT_VERSION = 0x5,
+	BASE_DISCOVER_LIST_PROTOCOLS = 0x6,
+	BASE_DISCOVER_AGENT = 0x7,
+	BASE_NOTIFY_ERRORS = 0x8,
+};
+
+struct scmi_msg_resp_base_attributes {
+	u8 num_protocols;
+	u8 num_agents;
+	__le16 reserved;
+};
+
+/**
+ * scmi_base_attributes_get() - gets the implementation details
+ *	that are associated with the base protocol.
+ *
+ * @handle - SCMI entity handle
+ *
+ * Return: 0 on success, else appropriate SCMI error.
+ */
+static int scmi_base_attributes_get(const struct scmi_handle *handle)
+{
+	int ret;
+	struct scmi_xfer *t;
+	struct scmi_msg_resp_base_attributes *attr_info;
+	struct scmi_revision_info *rev = handle->version;
+
+	ret = scmi_one_xfer_init(handle, PROTOCOL_ATTRIBUTES,
+				 SCMI_PROTOCOL_BASE, 0, sizeof(*attr_info), &t);
+	if (ret)
+		return ret;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		attr_info = t->rx.buf;
+		rev->num_protocols = attr_info->num_protocols;
+		rev->num_agents = attr_info->num_agents;
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+/**
+ * scmi_base_vendor_id_get() - gets vendor/subvendor identifier ASCII string.
+ *
+ * @handle - SCMI entity handle
+ * @sub_vendor - specify true if sub-vendor ID is needed
+ *
+ * Return: 0 on success, else appropriate SCMI error.
+ */
+static int
+scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
+{
+	u8 cmd;
+	int ret, size;
+	char *vendor_id;
+	struct scmi_xfer *t;
+	struct scmi_revision_info *rev = handle->version;
+
+	if (sub_vendor) {
+		cmd = BASE_DISCOVER_SUB_VENDOR;
+		vendor_id = rev->sub_vendor_id;
+		size = ARRAY_SIZE(rev->sub_vendor_id);
+	} else {
+		cmd = BASE_DISCOVER_VENDOR;
+		vendor_id = rev->vendor_id;
+		size = ARRAY_SIZE(rev->vendor_id);
+	}
+
+	ret = scmi_one_xfer_init(handle, cmd, SCMI_PROTOCOL_BASE, 0, size, &t);
+	if (ret)
+		return ret;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		memcpy(vendor_id, t->rx.buf, size);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+/**
+ * scmi_base_implementation_version_get() - gets a vendor-specific
+ *	implementation 32-bit version. The format of the version number is
+ *	vendor-specific
+ *
+ * @handle - SCMI entity handle
+ *
+ * Return: 0 on success, else appropriate SCMI error.
+ */
+static int
+scmi_base_implementation_version_get(const struct scmi_handle *handle)
+{
+	int ret;
+	__le32 *impl_ver;
+	struct scmi_xfer *t;
+	struct scmi_revision_info *rev = handle->version;
+
+	ret = scmi_one_xfer_init(handle, BASE_DISCOVER_IMPLEMENT_VERSION,
+				 SCMI_PROTOCOL_BASE, 0, sizeof(*impl_ver), &t);
+	if (ret)
+		return ret;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		impl_ver = t->rx.buf;
+		rev->impl_ver = le32_to_cpu(*impl_ver);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+/**
+ * scmi_base_implementation_list_get() - gets the list of protocols it is
+ *	OSPM is allowed to access
+ *
+ * @handle - SCMI entity handle
+ * @protocols_imp - pointer to hold the list of protocol identifiers
+ *
+ * Return: 0 on success, else appropriate SCMI error.
+ */
+static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
+					     u8 *protocols_imp)
+{
+	u8 *list;
+	int ret, loop;
+	struct scmi_xfer *t;
+	__le32 *num_skip, *num_ret;
+	u32 tot_num_ret = 0, loop_num_ret;
+	struct device *dev = handle->dev;
+
+	ret = scmi_one_xfer_init(handle, BASE_DISCOVER_LIST_PROTOCOLS,
+				 SCMI_PROTOCOL_BASE, sizeof(*num_skip), 0, &t);
+	if (ret)
+		return ret;
+
+	num_skip = t->tx.buf;
+	num_ret = t->rx.buf;
+	list = t->rx.buf + sizeof(*num_ret);
+
+	do {
+		/* Set the number of protocols to be skipped/already read */
+		*num_skip = cpu_to_le32(tot_num_ret);
+
+		ret = scmi_do_xfer(handle, t);
+		if (ret)
+			break;
+
+		loop_num_ret = le32_to_cpu(*num_ret);
+		if (tot_num_ret + loop_num_ret > MAX_PROTOCOLS_IMP) {
+			dev_err(dev, "No. of Protocol > MAX_PROTOCOLS_IMP");
+			break;
+		}
+
+		for (loop = 0; loop < loop_num_ret; loop++)
+			protocols_imp[tot_num_ret + loop] = *(list + loop);
+
+		tot_num_ret += loop_num_ret;
+	} while (loop_num_ret);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+/**
+ * scmi_base_discover_agent_get() - discover the name of an agent
+ *
+ * @handle - SCMI entity handle
+ * @id - Agent identifier
+ * @name - Agent identifier ASCII string
+ *
+ * An agent id of 0 is reserved to identify the platform itself.
+ * Generally operating system is represented as "OSPM"
+ *
+ * Return: 0 on success, else appropriate SCMI error.
+ */
+static int scmi_base_discover_agent_get(const struct scmi_handle *handle,
+					int id, char *name)
+{
+	int ret;
+	struct scmi_xfer *t;
+
+	ret = scmi_one_xfer_init(handle, BASE_DISCOVER_AGENT,
+				 SCMI_PROTOCOL_BASE, sizeof(__le32),
+				 SCMI_MAX_STR_SIZE, &t);
+	if (ret)
+		return ret;
+
+	*(__le32 *)t->tx.buf = cpu_to_le32(id);
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret)
+		memcpy(name, t->rx.buf, SCMI_MAX_STR_SIZE);
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+int scmi_base_protocol_init(struct scmi_handle *h)
+{
+	int id, ret;
+	u8 *prot_imp;
+	u32 version;
+	char name[SCMI_MAX_STR_SIZE];
+	const struct scmi_handle *handle = h;
+	struct device *dev = handle->dev;
+	struct scmi_revision_info *rev = handle->version;
+
+	ret = scmi_version_get(handle, SCMI_PROTOCOL_BASE, &version);
+	if (ret)
+		return ret;
+
+	prot_imp = devm_kcalloc(dev, MAX_PROTOCOLS_IMP, sizeof(u8), GFP_KERNEL);
+	if (!prot_imp)
+		return -ENOMEM;
+
+	rev->major_ver = PROTOCOL_REV_MAJOR(version),
+	rev->minor_ver = PROTOCOL_REV_MINOR(version);
+
+	scmi_base_attributes_get(handle);
+	scmi_base_vendor_id_get(handle, false);
+	scmi_base_vendor_id_get(handle, true);
+	scmi_base_implementation_version_get(handle);
+	scmi_base_implementation_list_get(handle, prot_imp);
+	scmi_setup_protocol_implemented(handle, prot_imp);
+
+	dev_info(dev, "SCMI Protocol v%d.%d '%s:%s' Firmware version 0x%x\n",
+		 rev->major_ver, rev->minor_ver, rev->vendor_id,
+		 rev->sub_vendor_id, rev->impl_ver);
+	dev_dbg(dev, "Found %d protocol(s) %d agent(s)\n", rev->num_protocols,
+		rev->num_agents);
+
+	for (id = 0; id < rev->num_agents; id++) {
+		scmi_base_discover_agent_get(handle, id, name);
+		dev_dbg(dev, "Agent %d: %s\n", id, name);
+	}
+
+	return 0;
+}
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index cdfc43427c3c..bc767f4997e0 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -19,9 +19,41 @@
  */
 
 #include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
 #include <linux/scmi_protocol.h>
 #include <linux/types.h>
 
+#define PROTOCOL_REV_MINOR_BITS	16
+#define PROTOCOL_REV_MINOR_MASK	((1U << PROTOCOL_REV_MINOR_BITS) - 1)
+#define PROTOCOL_REV_MAJOR(x)	((x) >> PROTOCOL_REV_MINOR_BITS)
+#define PROTOCOL_REV_MINOR(x)	((x) & PROTOCOL_REV_MINOR_MASK)
+#define MAX_PROTOCOLS_IMP	16
+
+enum scmi_common_cmd {
+	PROTOCOL_VERSION = 0x0,
+	PROTOCOL_ATTRIBUTES = 0x1,
+	PROTOCOL_MESSAGE_ATTRIBUTES = 0x2,
+};
+
+/**
+ * struct scmi_msg_resp_prot_version - Response for a message
+ *
+ * @major_version: Major version of the ABI that firmware supports
+ * @minor_version: Minor version of the ABI that firmware supports
+ *
+ * In general, ABI version changes follow the rule that minor version increments
+ * are backward compatible. Major revision changes in ABI may not be
+ * backward compatible.
+ *
+ * Response to a generic message with message type SCMI_MSG_VERSION
+ */
+struct scmi_msg_resp_prot_version {
+	__le16 minor_version;
+	__le16 major_version;
+};
+
 /**
  * struct scmi_msg_hdr - Message(Tx/Rx) header
  *
@@ -75,3 +107,8 @@ int scmi_one_xfer_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
 		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
 int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
+int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
+void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
+				     u8 *prot_imp);
+
+int scmi_base_protocol_init(struct scmi_handle *h);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index fa0e9cf31f4c..ba784b8ec170 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -105,21 +105,27 @@ struct scmi_desc {
  * @dev: Device pointer
  * @desc: SoC description for this instance
  * @handle: Instance of SCMI handle to send to clients
+ * @version: SCMI revision information containing protocol version,
+ *	implementation version and (sub-)vendor identification.
  * @cl: Mailbox Client
  * @tx_chan: Transmit mailbox channel
  * @tx_payload: Transmit mailbox channel payload area
  * @minfo: Message info
+ * @protocols_imp: list of protocols implemented, currently maximum of
+ *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
  * @node: list head
  * @users: Number of users of this instance
  */
 struct scmi_info {
 	struct device *dev;
 	const struct scmi_desc *desc;
+	struct scmi_revision_info version;
 	struct scmi_handle handle;
 	struct mbox_client cl;
 	struct mbox_chan *tx_chan;
 	void __iomem *tx_payload;
 	struct scmi_xfers_info minfo;
+	u8 *protocols_imp;
 	struct list_head node;
 	int users;
 };
@@ -433,6 +439,45 @@ int scmi_one_xfer_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 }
 
 /**
+ * scmi_version_get() - command to get the revision of the SCMI entity
+ *
+ * @handle: Handle to SCMI entity information
+ *
+ * Updates the SCMI information in the internal data structure.
+ *
+ * Return: 0 if all went fine, else return appropriate error.
+ */
+int scmi_version_get(const struct scmi_handle *handle, u8 protocol,
+		     u32 *version)
+{
+	int ret;
+	__le32 *rev_info;
+	struct scmi_xfer *t;
+
+	ret = scmi_one_xfer_init(handle, PROTOCOL_VERSION, protocol, 0,
+				 sizeof(*version), &t);
+	if (ret)
+		return ret;
+
+	ret = scmi_do_xfer(handle, t);
+	if (!ret) {
+		rev_info = t->rx.buf;
+		*version = le32_to_cpu(*rev_info);
+	}
+
+	scmi_one_xfer_put(handle, t);
+	return ret;
+}
+
+void scmi_setup_protocol_implemented(const struct scmi_handle *handle,
+				     u8 *prot_imp)
+{
+	struct scmi_info *info = handle_to_scmi_info(handle);
+
+	info->protocols_imp = prot_imp;
+}
+
+/**
  * scmi_handle_get() - Get the  SCMI handle for a device
  *
  * @dev: pointer to device for which we want SCMI handle
@@ -660,11 +705,19 @@ static int scmi_probe(struct platform_device *pdev)
 
 	handle = &info->handle;
 	handle->dev = info->dev;
+	handle->version = &info->version;
 
 	ret = scmi_mbox_chan_setup(info);
 	if (ret)
 		return ret;
 
+	ret = scmi_base_protocol_init(handle);
+	if (ret) {
+		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
+		scmi_mbox_free_channel(info);
+		return ret;
+	}
+
 	mutex_lock(&scmi_list_mutex);
 	list_add_tail(&info->node, &scmi_list);
 	mutex_unlock(&scmi_list_mutex);
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 854ed2479993..664da3d763f2 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -17,11 +17,48 @@
  */
 #include <linux/types.h>
 
+#define SCMI_MAX_STR_SIZE	16
+
+/**
+ * struct scmi_revision_info - version information structure
+ *
+ * @major_ver: Major ABI version. Change here implies risk of backward
+ *	compatibility break.
+ * @minor_ver: Minor ABI version. Change here implies new feature addition,
+ *	or compatible change in ABI.
+ * @num_protocols: Number of protocols that are implemented, excluding the
+ *	base protocol.
+ * @num_agents: Number of agents in the system.
+ * @impl_ver: A vendor-specific implementation version.
+ * @vendor_id: A vendor identifier(Null terminated ASCII string)
+ * @sub_vendor_id: A sub-vendor identifier(Null terminated ASCII string)
+ */
+struct scmi_revision_info {
+	u16 major_ver;
+	u16 minor_ver;
+	u8 num_protocols;
+	u8 num_agents;
+	u32 impl_ver;
+	char vendor_id[SCMI_MAX_STR_SIZE];
+	char sub_vendor_id[SCMI_MAX_STR_SIZE];
+};
+
 /**
  * struct scmi_handle - Handle returned to ARM SCMI clients for usage.
  *
  * @dev: pointer to the SCMI device
+ * @version: pointer to the structure containing SCMI version information
  */
 struct scmi_handle {
 	struct device *dev;
+	struct scmi_revision_info *version;
+};
+
+enum scmi_std_protocol {
+	SCMI_PROTOCOL_BASE = 0x10,
+	SCMI_PROTOCOL_POWER = 0x11,
+	SCMI_PROTOCOL_SYSTEM = 0x12,
+	SCMI_PROTOCOL_PERF = 0x13,
+	SCMI_PROTOCOL_CLOCK = 0x14,
+	SCMI_PROTOCOL_SENSOR = 0x15,
 };
-- 
2.7.4
