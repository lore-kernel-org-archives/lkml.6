Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3D7C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BFA20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsxuVI6u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BFA20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729944AbeKAEoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:44:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbeKAEoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:44:08 -0400
Received: by mail-io1-f68.google.com with SMTP id p83-v6so10573342iod.12;
        Wed, 31 Oct 2018 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wULgG84P79529EN+ndAmlpiaieEt3ChnQAATLknKO24=;
        b=IsxuVI6u5BQ1AfQYxNWljMGz8Ms+f4Rnmvoc7cu/fB2QxD+8+iSZK1sHEZi6ndmzi/
         63yh0Rcqszy//PlDxxbou2dt9OOJJJ+G0pDPMNsZoFtaHTEc7OoBbo04wDL7iiAQ8fEh
         bg+cH0qdPD1QHC48ZwUlyIVK+nzzRK5ZZx4XINT2o9Z1PUWHEsHohh04Nl6mblDUP/za
         KHAPOEIINyXHLa48ZpYcyvV6ZTb4mLb6IVYInMnGGOELd98E/iJ7M6+DKaFM7s7ZCwyq
         7+oToDCmbzJygeds/eVbkCZ3W/OuM+5GRAEWHpmoa90hfiqEQ0v0RFm67FjwUOlcTSJw
         aFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wULgG84P79529EN+ndAmlpiaieEt3ChnQAATLknKO24=;
        b=c5Gey9HdSPVHcVMgp4JBt0+WeUavLCbj4iKGqXlVFD1jCnFfA0jUzeRn/3wFrqZg3C
         WLaY2YfhDfsYK01Ums4KcIwIrgmvXilRgPXcgUdPGIf9am1tLI6La8U1wV7Or9qgtTzu
         zUfSj/gtKI8ZsH+rkMbJ3dJZ/y9KbOxsToqzfAoNXA7hEdz0svY7OPx6iUm/NXF7TUDD
         jkzYrD55+zAx+4J0OOEnMn09rg1MU32nO3qtvkyNyyJkjE18A9uiU1JbG3E+NIYtoXId
         FI+TeRm+E9hXcYBGKjduegyLw8xr0sjiMPMp/BJDjs2n2eiyjg1GrWf7UdEY/McwCnSD
         Rvhg==
X-Gm-Message-State: AGRZ1gJS7Ca/ZeiW6Yogqyaqck0IIucCCOCiRZVeWDg0mVUm7y/1TRgT
        d/nKeR6HahsHJYlPWa7WmLY=
X-Google-Smtp-Source: AJdET5eJZTjAJrtkjt/UmwWDuXQM8Z3JsWmrFPUrFYMx03bhOuEHJwkisbHXOSnWUUHJBPPdUSUi5g==
X-Received: by 2002:a6b:9082:: with SMTP id s124-v6mr3056834iod.249.1541015077253;
        Wed, 31 Oct 2018 12:44:37 -0700 (PDT)
Received: from svens-asus.arcx.com ([184.94.50.30])
        by smtp.gmail.com with ESMTPSA id u142-v6sm7136606itb.13.2018.10.31.12.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 12:44:36 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, afaerber@suse.de, treding@nvidia.com,
        david@lechnology.com, noralf@tronnes.org, johan@kernel.org,
        monstr@monstr.eu, michal.vokac@ysoft.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, linus.walleij@linaro.org,
        maxime.ripard@bootlin.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH anybus v2 5/5] misc: support HMS Profinet IRT industrial controller.
Date:   Wed, 31 Oct 2018 15:44:25 -0400
Message-Id: <20181031194425.32132-6-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031194425.32132-1-TheSven73@googlemail.com>
References: <20181031194425.32132-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

The Anybus-S PROFINET IRT communication module provides instant integration
to any Ethernet based LAN via SMTP, FTP, HTTP as well as PROFINET and
Modbus-TCP. Additional protocols can be implemented on top of TCP/IP
or UDP using the transparent socket interface.

Official documentation:
https://www.anybus.com/docs/librariesprovider7/default-document-library
/manuals-design-guides/hms-hmsi-168-52.pdf

This implementation is an Anybus-S client driver, designed to be
instantiated by the Anybus-S bus driver when it discovers the Profinet
card.

If loaded successfully, the driver creates a /dev/profinet%d devnode,
and a /sys/class/misc/profinet%d sysfs subdir:
- the card can be configured with a single, atomic ioctl on the devnode;
- the card's internal dpram is accessed by calling read/write/seek
    on the devnode.
- the card's "fieldbus specific area" properties can be accessed via
    the sysfs dir.

Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 Documentation/ioctl/ioctl-number.txt |   1 +
 drivers/misc/Kconfig                 |  10 +
 drivers/misc/Makefile                |   1 +
 drivers/misc/hms-profinet.c          | 753 +++++++++++++++++++++++++++
 include/uapi/linux/hms-common.h      |  14 +
 include/uapi/linux/hms-profinet.h    | 102 ++++
 6 files changed, 881 insertions(+)
 create mode 100644 drivers/misc/hms-profinet.c
 create mode 100644 include/uapi/linux/hms-common.h
 create mode 100644 include/uapi/linux/hms-profinet.h

diff --git a/Documentation/ioctl/ioctl-number.txt b/Documentation/ioctl/ioctl-number.txt
index 13a7c999c04a..a389a4ec1429 100644
--- a/Documentation/ioctl/ioctl-number.txt
+++ b/Documentation/ioctl/ioctl-number.txt
@@ -241,6 +241,7 @@ Code  Seq#(hex)	Include File		Comments
 					<http://web.archive.org/web/*/http://mikonos.dia.unisa.it/tcfs>
 'l'	40-7F	linux/udf_fs_i.h	in development:
 					<http://sourceforge.net/projects/linux-udf/>
+'l'	80-9F	linux/hms-profinet.h	Anybus-S
 'm'	00-09	linux/mmtimer.h		conflict!
 'm'	all	linux/mtio.h		conflict!
 'm'	all	linux/soundcard.h	conflict!
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index dd7fdbf659b7..d17b581c06f7 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -406,6 +406,16 @@ config SPEAR13XX_PCIE_GADGET
 	 entry will be created for that controller. User can use these
 	 sysfs node to configure PCIe EP as per his requirements.
 
+config HMS_PROFINET
+	tristate "HMS Profinet IRT Controller (Anybus-S)"
+	select HMS_ANYBUSS_HOST
+	help
+	 If you say yes here you get support for the HMS Industrial
+	 Networks Profinet IRT Controller.
+	 This driver can also be built as a module. If so, the module
+	 will be called hms-profinet.
+	 If unsure, say N.
+
 config VMWARE_BALLOON
 	tristate "VMware Balloon Driver"
 	depends on VMWARE_VMCI && X86 && HYPERVISOR_GUEST
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 20c9fbfb100b..087c48273179 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
 obj-$(CONFIG_DS1682)		+= ds1682.o
 obj-$(CONFIG_C2PORT)		+= c2port/
 obj-$(CONFIG_HMC6352)		+= hmc6352.o
+obj-$(CONFIG_HMS_PROFINET)	+= hms-profinet.o
 obj-y				+= eeprom/
 obj-y				+= cb710/
 obj-$(CONFIG_SPEAR13XX_PCIE_GADGET)	+= spear13xx_pcie_gadget.o
diff --git a/drivers/misc/hms-profinet.c b/drivers/misc/hms-profinet.c
new file mode 100644
index 000000000000..dd6c0f715bf1
--- /dev/null
+++ b/drivers/misc/hms-profinet.c
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * HMS Profinet Client Driver
+ *
+ * Copyright (C) 2018 Arcx Inc
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/miscdevice.h>
+
+#include <linux/anybuss-client.h>
+#include <uapi/linux/hms-profinet.h>
+
+#define PROFI_DPRAM_SIZE	512
+
+/*
+ *  --------------------------------------------------------------
+ * Anybus Profinet mailbox messages - definitions
+ * --------------------------------------------------------------
+ */
+
+/*
+ * note that we're depending on the layout of these structures being
+ * exactly as advertised - which means they need to be packed.
+ */
+
+struct msgEthConfig {
+	u32 ip_addr, subnet_msk, gateway_addr;
+} __packed;
+
+struct msgMacAddr {
+	u8 addr[6];
+} __packed;
+
+struct msgStr {
+	char	s[128];
+} __packed;
+
+struct msgShortStr {
+	char	s[64];
+} __packed;
+
+struct msgHicp {
+	char	enable;
+} __packed;
+
+/*
+ * --------------------------------------------------------------
+ * Fieldbus Specific Area - memory locations
+ * --------------------------------------------------------------
+ */
+#define FSA_NETWORK_STATUS	0x700
+#define FSA_LAYER_STATUS	0x7B2
+#define FSA_IO_CTRL_STATUS	0x7B0
+#define FSA_LAYER_FAULT_CODE	0x7B4
+
+struct profi_priv {
+	struct anybuss_client *client;
+	int id;
+	atomic_t refcount;
+	char node_name[16];
+	struct miscdevice misc;
+	struct device *dev;	/* just a link to the misc device */
+	struct mutex enable_lock;
+};
+
+static int profinet_configure(struct anybuss_client *ab,
+				struct ProfinetConfig *cfg)
+{
+	int ret;
+
+	if (cfg->eth.is_valid) {
+		struct msgEthConfig msg = {
+			.ip_addr = cfg->eth.ip_addr,
+			.subnet_msk = cfg->eth.subnet_msk,
+			.gateway_addr = cfg->eth.gateway_addr,
+		};
+		ret = anybuss_send_msg(ab, 0x0001, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->dev_id.is_valid) {
+		u16 ext[2] = {
+			cpu_to_be16(cfg->dev_id.vendorid),
+			cpu_to_be16(cfg->dev_id.deviceid)
+		};
+		ret = anybuss_send_ext(ab, 0x0102, ext, sizeof(ext));
+		if (ret)
+			return ret;
+	}
+	if (cfg->station_name.is_valid) {
+		struct msgStr msg = { 0 };
+
+		strncpy(msg.s, cfg->station_name.name, sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0103, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->station_type.is_valid) {
+		struct msgShortStr msg = { 0 };
+
+		strncpy(msg.s, cfg->station_type.name, sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0104, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->mac_addr.is_valid) {
+		struct msgMacAddr msg = { 0 };
+
+		memcpy(msg.addr, cfg->mac_addr.addr, sizeof(msg.addr));
+		ret = anybuss_send_msg(ab, 0x0019, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->host_domain.is_valid) {
+		size_t len;
+		struct msgStr msg = { 0 };
+		/*
+		 * check if host and domain names fit in msg structure
+		 */
+		len =	strnlen(cfg->host_domain.hostname,
+				sizeof(cfg->host_domain.hostname))
+					+ 1 +
+			strnlen(cfg->host_domain.domainname,
+				sizeof(cfg->host_domain.domainname))
+					+ 1;
+		if (len > sizeof(msg.s))
+			return -ENAMETOOLONG;
+		strncpy(msg.s, cfg->host_domain.hostname,
+			sizeof(msg.s));
+		len = strnlen(msg.s, sizeof(msg.s)) + 1; /* NULL term */
+		strncpy(msg.s + len, cfg->host_domain.domainname,
+				sizeof(msg.s) - len);
+		ret = anybuss_send_msg(ab, 0x0032, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->hicp.is_valid) {
+		struct msgHicp msg = {
+			.enable = cfg->hicp.enable ? 1 : 0,
+		};
+		ret = anybuss_send_msg(ab, 0x0013, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->web_server.is_valid) {
+		ret = anybuss_send_msg(ab,
+			cfg->web_server.enable ? 0x0005 : 0x0004,
+			NULL, 0);
+		if (ret)
+			return ret;
+	}
+	if (cfg->ftp_server.disable) {
+		ret = anybuss_send_msg(ab, 0x0006, NULL, 0);
+		if (ret)
+			return ret;
+	}
+	if (cfg->global_admin_mode.enable) {
+		ret = anybuss_send_msg(ab, 0x000B, NULL, 0);
+		if (ret)
+			return ret;
+	}
+	if (cfg->vfs.disable) {
+		ret = anybuss_send_msg(ab, 0x0011, NULL, 0);
+		if (ret)
+			return ret;
+	}
+	if (cfg->stop_mode.is_valid) {
+		u16 action;
+
+		switch (cfg->stop_mode.action) {
+		case HMS_SMA_CLEAR:
+			action = 0;
+			break;
+		case HMS_SMA_FREEZE:
+			action = 1;
+			break;
+		case HMS_SMA_SET:
+			action = 2;
+			break;
+		default:
+			return -EINVAL;
+		}
+		action = cpu_to_be16(action);
+		ret = anybuss_send_ext(ab, 0x0101, &action,
+						sizeof(action));
+		if (ret)
+			return ret;
+	}
+	if (cfg->snmp_system_descr.is_valid) {
+		struct msgStr msg = { 0 };
+
+		strncpy(msg.s, cfg->snmp_system_descr.description,
+					sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0120, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->snmp_iface_descr.is_valid) {
+		struct msgStr msg = { 0 };
+
+		strncpy(msg.s, cfg->snmp_iface_descr.description,
+					sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0121, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->mib2_system_descr.is_valid) {
+		struct msgStr msg = { 0 };
+
+		strncpy(msg.s, cfg->mib2_system_descr.description,
+					sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0124, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->mib2_system_contact.is_valid) {
+		struct msgStr msg = { 0 };
+
+		strncpy(msg.s, cfg->mib2_system_contact.contact,
+					sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0125, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	if (cfg->mib2_system_location.is_valid) {
+		struct msgStr msg = { 0 };
+
+		strncpy(msg.s, cfg->mib2_system_location.location,
+					sizeof(msg.s));
+		ret = anybuss_send_msg(ab, 0x0126, &msg, sizeof(msg));
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int profinet_enable(struct profi_priv *priv,
+				struct ProfinetConfig *cfg)
+{
+	int ret;
+	struct anybuss_client *client = priv->client;
+
+	/* Initialization Sequence, Generic Anybus Mode */
+	const struct anybuss_memcfg mem_cfg = {
+		.input_io = 220,
+		.input_dpram = PROFI_DPRAM_SIZE,
+		.input_total = PROFI_DPRAM_SIZE,
+		.output_io = 220,
+		.output_dpram = PROFI_DPRAM_SIZE,
+		.output_total = PROFI_DPRAM_SIZE,
+		.offl_mode = AB_OFFL_MODE_CLEAR,
+	};
+	if (mutex_lock_interruptible(&priv->enable_lock))
+		return -ERESTARTSYS;
+	/*
+	 * switch anybus off then on, this ensures we can do a complete
+	 * configuration cycle in case anybus was already on.
+	 */
+	anybuss_set_power(client, false);
+	ret = anybuss_set_power(client, true);
+	if (ret)
+		goto err_init;
+	ret = anybuss_start_init(client, &mem_cfg);
+	if (ret)
+		goto err_init;
+	if (cfg)
+		ret = profinet_configure(client, cfg);
+	if (ret)
+		goto err_init;
+	ret = anybuss_finish_init(client);
+	if (ret)
+		goto err_init;
+	mutex_unlock(&priv->enable_lock);
+	return 0;
+err_init:
+	anybuss_set_power(client, false);
+	mutex_unlock(&priv->enable_lock);
+	return ret;
+}
+
+static int profinet_disable(struct profi_priv *priv)
+{
+	int ret;
+
+	if (mutex_lock_interruptible(&priv->enable_lock))
+		return -ERESTARTSYS;
+	ret = anybuss_set_power(priv->client, false);
+	mutex_unlock(&priv->enable_lock);
+	return ret;
+}
+
+static int fbctrl_readw(struct anybuss_client *client, u16 addr)
+{
+	int ret;
+	u16 val;
+
+	ret = anybuss_read_fbctrl(client, addr, &val, sizeof(val));
+	if (ret < 0)
+		return ret;
+	return (int)be16_to_cpu(val);
+}
+
+static ssize_t mac_addr_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	struct msgMacAddr response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0010, &response,
+						sizeof(response));
+	if (ret)
+		return ret;
+	return snprintf(buf, PAGE_SIZE, "%02X:%02X:%02X:%02X:%02X:%02X\n",
+		response.addr[0], response.addr[1],
+		response.addr[2], response.addr[3],
+		response.addr[4], response.addr[5]);
+}
+
+static DEVICE_ATTR_RO(mac_addr);
+
+static ssize_t start_defaults_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	unsigned long num;
+
+	if (kstrtoul(buf, 0, &num))
+		return -EINVAL;
+	if (num)
+		profinet_enable(priv, NULL);
+	return count;
+}
+
+static DEVICE_ATTR_WO(start_defaults);
+
+static ssize_t ip_addr_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	struct msgEthConfig response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0002, &response,
+						sizeof(response));
+	if (ret)
+		return ret;
+	return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+		response.ip_addr & 0xFF,
+		(response.ip_addr >>  8) & 0xFF,
+		(response.ip_addr >> 16) & 0xFF,
+		(response.ip_addr >> 24) & 0xFF);
+}
+
+static DEVICE_ATTR_RO(ip_addr);
+
+static ssize_t subnet_mask_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	struct msgEthConfig response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0002, &response,
+						sizeof(response));
+	if (ret)
+		return ret;
+	return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+		response.subnet_msk & 0xFF,
+		(response.subnet_msk >>  8) & 0xFF,
+		(response.subnet_msk >> 16) & 0xFF,
+		(response.subnet_msk >> 24) & 0xFF);
+}
+
+static DEVICE_ATTR_RO(subnet_mask);
+
+static ssize_t gateway_addr_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	struct msgEthConfig response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0002, &response,
+						sizeof(response));
+	if (ret)
+		return ret;
+	return snprintf(buf, PAGE_SIZE, "%d.%d.%d.%d\n",
+		response.gateway_addr & 0xFF,
+		(response.gateway_addr >>  8) & 0xFF,
+		(response.gateway_addr >> 16) & 0xFF,
+		(response.gateway_addr >> 24) & 0xFF);
+}
+
+static DEVICE_ATTR_RO(gateway_addr);
+
+static ssize_t hostname_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	struct msgStr response;
+	int ret;
+
+	ret = anybuss_recv_msg(priv->client, 0x0034, &response,
+						sizeof(response));
+	if (ret)
+		return ret;
+	return snprintf(buf, PAGE_SIZE, "%s\n", response.s);
+}
+
+static DEVICE_ATTR_RO(hostname);
+
+static ssize_t domainname_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	struct msgStr response;
+	int ret, pos;
+
+	ret = anybuss_recv_msg(priv->client, 0x0034, &response,
+						sizeof(response));
+	if (ret)
+		return ret;
+	/*
+	 * domain name string located right behind null-terminated
+	 * host name string.
+	 */
+	pos = strnlen(response.s, sizeof(response.s)) + 1;
+	if (pos >= sizeof(response.s))
+		return -ENAMETOOLONG;
+	return snprintf(buf, PAGE_SIZE, "%s\n", response.s + pos);
+}
+
+static DEVICE_ATTR_RO(domainname);
+
+static ssize_t network_link_on_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	int ns;
+
+	ns = fbctrl_readw(priv->client, FSA_NETWORK_STATUS);
+	if (ns < 0)
+		return ns;
+	return snprintf(buf, PAGE_SIZE, "%d\n", ns & 1);
+}
+
+static DEVICE_ATTR_RO(network_link_on);
+
+static ssize_t network_ip_in_use_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	int ns;
+
+	ns = fbctrl_readw(priv->client, FSA_NETWORK_STATUS);
+	if (ns < 0)
+		return ns;
+	return snprintf(buf, PAGE_SIZE, "%d\n", (ns>>1) & 1);
+}
+
+static DEVICE_ATTR_RO(network_ip_in_use);
+
+static ssize_t layer_status_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	const char *s;
+	int ls;
+
+	ls = fbctrl_readw(priv->client, FSA_LAYER_STATUS);
+	if (ls < 0)
+		return ls;
+	switch (ls) {
+	case 0x0000:
+		s = "not yet initialized";
+		break;
+	case 0x0001:
+		s = "successfully initialized";
+		break;
+	case 0x0002:
+		s = "failed to initialize";
+		break;
+	default:
+		return -EINVAL;
+	}
+	return snprintf(buf, PAGE_SIZE, "%s\n", s);
+}
+
+static DEVICE_ATTR_RO(layer_status);
+
+static ssize_t io_controller_status_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct profi_priv *priv = dev_get_drvdata(dev);
+	const char *s;
+	int w;
+
+	w = fbctrl_readw(priv->client, FSA_IO_CTRL_STATUS);
+	if (w < 0)
+		return w;
+	switch (w) {
+	case 0x0000:
+		s = "No connection made";
+		break;
+	case 0x0001:
+		s = "STOP";
+		break;
+	case 0x0002:
+		s = "RUN";
+		break;
+	case 0x0004:
+		s = "STATION OK";
+		break;
+	case 0x0008:
+		s = "STATION PROBLEM";
+		break;
+	case 0x0010:
+		s = "PRIMARY";
+		break;
+	case 0x0020:
+		s = "BACKUP";
+		break;
+	default:
+		return -EINVAL;
+	}
+	return snprintf(buf, PAGE_SIZE, "%s\n", s);
+}
+
+static DEVICE_ATTR_RO(io_controller_status);
+
+static ssize_t layer_fault_code_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int fc;
+	struct profi_priv *priv = dev_get_drvdata(dev);
+
+	fc = fbctrl_readw(priv->client, FSA_LAYER_FAULT_CODE);
+	if (fc < 0)
+		return fc;
+	return snprintf(buf, PAGE_SIZE, "%d\n", fc);
+}
+
+static DEVICE_ATTR_RO(layer_fault_code);
+
+static struct attribute *ctrl_attrs[] = {
+	&dev_attr_mac_addr.attr,
+	&dev_attr_start_defaults.attr,
+	&dev_attr_ip_addr.attr,
+	&dev_attr_subnet_mask.attr,
+	&dev_attr_gateway_addr.attr,
+	&dev_attr_hostname.attr,
+	&dev_attr_domainname.attr,
+	&dev_attr_network_link_on.attr,
+	&dev_attr_network_ip_in_use.attr,
+	&dev_attr_io_controller_status.attr,
+	&dev_attr_layer_status.attr,
+	&dev_attr_layer_fault_code.attr,
+	NULL
+};
+
+static struct attribute_group ctrl_group = { .attrs = ctrl_attrs };
+
+struct profi_open_file {
+	struct profi_priv *priv;
+	int event;
+};
+
+static int profi_open(struct inode *node, struct file *filp)
+{
+	struct profi_open_file *of;
+	struct profi_priv *priv = container_of(filp->private_data,
+					struct profi_priv, misc);
+
+	of = kzalloc(sizeof(*of), GFP_KERNEL);
+	if (!of)
+		return -ENOMEM;
+	of->priv = priv;
+	filp->private_data = of;
+	atomic_inc(&priv->refcount);
+	return 0;
+}
+
+static int profi_release(struct inode *node, struct file *filp)
+{
+	struct profi_open_file *of = filp->private_data;
+	struct profi_priv *priv = of->priv;
+
+	kfree(of);
+	if (!atomic_dec_and_test(&priv->refcount))
+		return 0;
+	return profinet_disable(priv);
+}
+
+static long profi_ioctl(struct file *filp, unsigned int cmd,
+						unsigned long arg)
+{
+	struct profi_open_file *of = filp->private_data;
+	struct profi_priv *priv = of->priv;
+	void __user *argp = (void __user *)arg;
+	struct ProfinetConfig config;
+
+	if (_IOC_TYPE(cmd) != PROFINET_IOC_MAGIC)
+		return -EINVAL;
+	if (!(_IOC_DIR(cmd) & _IOC_WRITE))
+		return -EINVAL;
+	switch (cmd) {
+	case PROFINET_IOCSETCONFIG:
+		if (copy_from_user(&config, argp, sizeof(config)))
+			return -EFAULT;
+		return profinet_enable(priv, &config);
+	default:
+		break;
+	}
+	return -ENOTTY;
+}
+
+static ssize_t
+profi_read(struct file *filp, char __user *buf, size_t size,
+							loff_t *offset)
+{
+	struct profi_open_file *of = filp->private_data;
+	struct profi_priv *priv = of->priv;
+
+	return anybuss_read_output(priv->client, &of->event, buf, size,
+							offset);
+}
+
+static ssize_t
+profi_write(struct file *filp, const char __user *buf, size_t size,
+							loff_t *offset)
+{
+	struct profi_open_file *of = filp->private_data;
+	struct profi_priv *priv = of->priv;
+
+	return anybuss_write_input(priv->client, buf, size, offset);
+}
+
+static unsigned int profi_poll(struct file *filp, poll_table *wait)
+{
+	struct profi_open_file *of = filp->private_data;
+	struct profi_priv *priv = of->priv;
+
+	return anybuss_poll(priv->client, of->event, filp, wait);
+}
+
+static const struct file_operations fops = {
+	.open = profi_open,
+	.release = profi_release,
+	.read = profi_read,
+	.write = profi_write,
+	.unlocked_ioctl = profi_ioctl,
+	.poll = profi_poll,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
+static DEFINE_IDA(profi_index_ida);
+
+static int profinet_probe(struct anybuss_client *client)
+{
+	struct profi_priv *priv;
+	struct device *dev = &client->dev;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	atomic_set(&priv->refcount, 0);
+	mutex_init(&priv->enable_lock);
+	priv->client = client;
+	priv->misc.minor = MISC_DYNAMIC_MINOR;
+	priv->id = ida_simple_get(&profi_index_ida, 0, 0, GFP_KERNEL);
+	if (priv->id < 0)
+		return priv->id;
+	snprintf(priv->node_name, sizeof(priv->node_name), "profinet%d",
+				priv->id);
+	priv->misc.name = priv->node_name;
+	priv->misc.fops = &fops;
+	priv->misc.parent = client->dev.parent;
+	err = misc_register(&priv->misc);
+	if (err < 0) {
+		dev_err(dev, "could not register device (%d)", err);
+		goto err_ida;
+	}
+	priv->dev = priv->misc.this_device;
+	dev_set_drvdata(priv->dev, priv);
+	err = sysfs_create_group(&priv->dev->kobj, &ctrl_group);
+	if (err < 0) {
+		dev_err(dev, "could not create sysfs group (%d)", err);
+		goto err_register;
+	}
+	dev_info(priv->dev, "detected on %s", dev_name(&client->dev));
+	anybuss_set_drvdata(client, priv);
+	return 0;
+err_register:
+	misc_deregister(&priv->misc);
+err_ida:
+	ida_simple_remove(&profi_index_ida, priv->id);
+	return err;
+}
+
+static int profinet_remove(struct anybuss_client *client)
+{
+	struct profi_priv *priv = anybuss_get_drvdata(client);
+
+	sysfs_remove_group(&priv->dev->kobj, &ctrl_group);
+	misc_deregister(&priv->misc);
+	ida_simple_remove(&profi_index_ida, priv->id);
+	return 0;
+}
+
+static struct anybuss_client_driver profinet_driver = {
+	.probe = profinet_probe,
+	.remove = profinet_remove,
+	.driver		= {
+		.name   = "hms-profinet",
+		.owner	= THIS_MODULE,
+	},
+	.fieldbus_type = 0x0089,
+};
+
+static int __init profinet_init(void)
+{
+	return anybuss_client_driver_register(&profinet_driver);
+}
+module_init(profinet_init);
+
+static void __exit profinet_exit(void)
+{
+	return anybuss_client_driver_unregister(&profinet_driver);
+}
+module_exit(profinet_exit);
+
+MODULE_AUTHOR("Sven Van Asbroeck <svendev@arcx.com>");
+MODULE_DESCRIPTION("HMS Profinet IRT Driver (Anybus-S)");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/hms-common.h b/include/uapi/linux/hms-common.h
new file mode 100644
index 000000000000..4b69963a3863
--- /dev/null
+++ b/include/uapi/linux/hms-common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Archronix Corp. All Rights Reserved.
+ *
+ */
+
+#ifndef _UAPILINUX_HMSCOMMON_H_
+#define _UAPILINUX_HMSCOMMON_H_
+
+#define HMS_SMA_CLEAR		0
+#define HMS_SMA_FREEZE		1
+#define HMS_SMA_SET		2
+
+#endif /* _UAPILINUX_HMSCOMMON_H_ */
diff --git a/include/uapi/linux/hms-profinet.h b/include/uapi/linux/hms-profinet.h
new file mode 100644
index 000000000000..beed797191f2
--- /dev/null
+++ b/include/uapi/linux/hms-profinet.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2018 Archronix Corp. All Rights Reserved.
+ *
+ */
+
+#ifndef _UAPILINUX_PROFINET_H_
+#define _UAPILINUX_PROFINET_H_
+
+#include <asm/types.h>
+#include <linux/hms-common.h>
+
+#define PROFI_CFG_STRLEN	64
+
+struct ProfinetConfig {
+	struct {
+		/* addresses IN NETWORK ORDER! */
+		__u32 ip_addr;
+		__u32 subnet_msk;
+		__u32 gateway_addr;
+		__u8  is_valid:1;
+	} eth;
+	struct {
+		__u16 vendorid, deviceid;
+		__u8  is_valid:1;
+	} dev_id;
+	struct {
+		char name[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} station_name;
+	struct {
+		char name[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} station_type;
+	struct {
+		__u8 addr[6];
+		__u8 is_valid:1;
+	} mac_addr;
+	struct {
+		char hostname[PROFI_CFG_STRLEN];
+		char domainname[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} host_domain;
+	struct {
+		__u8 enable:1;
+		__u8 is_valid:1;
+	} hicp;
+	struct {
+		__u8 enable:1;
+		__u8 is_valid:1;
+	} web_server;
+	struct {
+		__u8 disable:1;
+	} ftp_server;
+	struct {
+		__u8 enable:1;
+	} global_admin_mode;
+	struct {
+		__u8 disable:1;
+	} vfs;
+	struct {
+		/* one of HMS_SMA_CLEAR/FREEZE/SET */
+		int action;
+		__u8 is_valid:1;
+	} stop_mode;
+	struct {
+		char description[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} snmp_system_descr;
+	struct {
+		char description[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} snmp_iface_descr;
+	struct {
+		char description[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} mib2_system_descr;
+	struct {
+		char contact[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} mib2_system_contact;
+	struct {
+		char location[PROFI_CFG_STRLEN];
+		__u8 is_valid:1;
+	} mib2_system_location;
+	/*
+	 * use non-volatile defaults for any properties not specified.
+	 * when in doubt, keep this OFF.
+	 */
+	__u8 use_nv_defaults:1;
+};
+
+#define PROFINET_IOC_MAGIC 'l'
+
+/*
+ * Configures profinet according to the ProfinetConfig structure, and
+ * switches the card on if it was previously off.
+ */
+#define PROFINET_IOCSETCONFIG   _IOW(PROFINET_IOC_MAGIC, 0x80,\
+						struct ProfinetConfig)
+
+#endif /* _UAPILINUX_PROFINET_H_ */
-- 
2.17.1

