Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AH8x2248lV/CJQDBhSJUTF3wFRkb01GKlGyTPjXRXeWufdMefwTXu5Z41YLlV2veBEtDzu+rej2f
ARC-Seal: i=1; a=rsa-sha256; t=1518461167; cv=none;
        d=google.com; s=arc-20160816;
        b=f6hN/LeLi0jGYWuNKrAzwIddmsoHRaMYKhxl8ncvp2FsTXl1DRF+D/+4grwAiCEpcV
         UttdXSWY4guXjkHvW/GZyGaR55A/OyFK/K9hXa4UFvCsbhKcDlwmtEZqCbb5eKbn7twd
         rQaY/JyKi4Phsrx5ym8cSOmc+ivnnuAtdGSOa23LWe2+lx799YtLyOOzS9f21bry4JvP
         +cH8kTWFv1BKyafr3zC4Me2SbL8iVAJnEi1rxbYtpR/G+o//pRJYJCwN4ms49mD+ipTo
         swO9N+tR7COb18b2qQNojJYnvcsb9yUvGdTRBnBKIvjT5ccqCSR6kHQ51dg234MCY3nx
         EXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=zxOP0WiWlvtJ/OIp+Rq6G/vshRCRASh4HZX8EJBR3Ek=;
        b=k64mUUIpPnBhziEH9VeGUN0QbMroVg8dPQ7Rtc5Hu2ytF8NWpCMMZbu4lFwe3woNzd
         m2+cZNK5gG2VMR8412fRP7258GkzgNrIEZppRHGu3U9UXNwbfoG86yKPTPkluHDvPlgl
         TeabGU+Oxit6kjob+mQvr9YtzLaTjB2xw/nIgjlalPaNix35/F4yamQoQcqWJu+9n8jf
         dRxrrNEUnFbNdZ/wB69YpX8v7KB7Rgig0RKNVXDCcaVWoE4+8Ruu087j3SoiFkd2fCYx
         fjQHWqowMEpqaOwPuF9vtSPE1vWzW0md8hd79WCwRl3AQG0FgnlyN81Ues8mVrwBqrys
         rdIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
From: Sudeep Holla <sudeep.holla@arm.com>
To: ALKML <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DTML <devicetree@vger.kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 15/20] firmware: arm_scmi: add device power domain support using genpd
Date: Mon, 12 Feb 2018 18:45:19 +0000
Message-Id: <1518461124-17371-16-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
References: <1518461124-17371-1-git-send-email-sudeep.holla@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592221936430954088?=
X-GMAIL-MSGID: =?utf-8?q?1592221936430954088?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch hooks up the support for device power domain provided by
SCMI using the Linux generic power domain infrastructure.

Cc: Kevin Hilman <khilman@baylibre.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/Kconfig                   |  13 +++
 drivers/firmware/arm_scmi/Makefile         |   1 +
 drivers/firmware/arm_scmi/scmi_pm_domain.c | 140 +++++++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 drivers/firmware/arm_scmi/scmi_pm_domain.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 704961e0473a..6e83880046d7 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -40,6 +40,19 @@ config ARM_SCMI_PROTOCOL
 	  This protocol library provides interface for all the client drivers
 	  making use of the features offered by the SCMI.
 
+config ARM_SCMI_POWER_DOMAIN
+	tristate "SCMI power domain driver"
+	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
+	default y
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  This enables support for the SCMI power domains which can be
+	  enabled or disabled via the SCP firmware
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called scmi_pm_domain. Note this may needed early in boot
+	  before rootfs may be available.
+
 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
index 3236890905b9..99e36c580fbc 100644
--- a/drivers/firmware/arm_scmi/Makefile
+++ b/drivers/firmware/arm_scmi/Makefile
@@ -2,3 +2,4 @@ obj-y	= scmi-bus.o scmi-driver.o scmi-protocols.o
 scmi-bus-y = bus.o
 scmi-driver-y = driver.o
 scmi-protocols-y = base.o clock.o perf.o power.o sensors.o
+obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) += scmi_pm_domain.o
diff --git a/drivers/firmware/arm_scmi/scmi_pm_domain.c b/drivers/firmware/arm_scmi/scmi_pm_domain.c
new file mode 100644
index 000000000000..c03c06d3840a
--- /dev/null
+++ b/drivers/firmware/arm_scmi/scmi_pm_domain.c
@@ -0,0 +1,140 @@
+/*
+ * SCMI Generic power domain support.
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
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pm_domain.h>
+#include <linux/scmi_protocol.h>
+
+struct scmi_pm_domain {
+	struct generic_pm_domain genpd;
+	const struct scmi_handle *handle;
+	const char *name;
+	u32 domain;
+};
+
+#define to_scmi_pd(gpd) container_of(gpd, struct scmi_pm_domain, genpd)
+
+static int scmi_pd_power(struct generic_pm_domain *domain, bool power_on)
+{
+	int ret;
+	u32 state, ret_state;
+	struct scmi_pm_domain *pd = to_scmi_pd(domain);
+	const struct scmi_power_ops *ops = pd->handle->power_ops;
+
+	if (power_on)
+		state = SCMI_POWER_STATE_GENERIC_ON;
+	else
+		state = SCMI_POWER_STATE_GENERIC_OFF;
+
+	ret = ops->state_set(pd->handle, pd->domain, state);
+	if (!ret)
+		ret = ops->state_get(pd->handle, pd->domain, &ret_state);
+	if (!ret && state != ret_state)
+		return -EIO;
+
+	return ret;
+}
+
+static int scmi_pd_power_on(struct generic_pm_domain *domain)
+{
+	return scmi_pd_power(domain, true);
+}
+
+static int scmi_pd_power_off(struct generic_pm_domain *domain)
+{
+	return scmi_pd_power(domain, false);
+}
+
+static int scmi_pm_domain_probe(struct scmi_device *sdev)
+{
+	int num_domains, i;
+	struct device *dev = &sdev->dev;
+	struct device_node *np = dev->of_node;
+	struct scmi_pm_domain *scmi_pd;
+	struct genpd_onecell_data *scmi_pd_data;
+	struct generic_pm_domain **domains;
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle || !handle->power_ops)
+		return -ENODEV;
+
+	num_domains = handle->power_ops->num_domains_get(handle);
+	if (num_domains < 0) {
+		dev_err(dev, "number of domains not found\n");
+		return num_domains;
+	}
+
+	scmi_pd = devm_kcalloc(dev, num_domains, sizeof(*scmi_pd), GFP_KERNEL);
+	if (!scmi_pd)
+		return -ENOMEM;
+
+	scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
+	if (!scmi_pd_data)
+		return -ENOMEM;
+
+	domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
+	if (!domains)
+		return -ENOMEM;
+
+	for (i = 0; i < num_domains; i++, scmi_pd++) {
+		u32 state;
+
+		domains[i] = &scmi_pd->genpd;
+
+		scmi_pd->domain = i;
+		scmi_pd->handle = handle;
+		scmi_pd->name = handle->power_ops->name_get(handle, i);
+		scmi_pd->genpd.name = scmi_pd->name;
+		scmi_pd->genpd.power_off = scmi_pd_power_off;
+		scmi_pd->genpd.power_on = scmi_pd_power_on;
+
+		if (handle->power_ops->state_get(handle, i, &state)) {
+			dev_warn(dev, "failed to get state for domain %d\n", i);
+			continue;
+		}
+
+		pm_genpd_init(&scmi_pd->genpd, NULL,
+			      state == SCMI_POWER_STATE_GENERIC_OFF);
+	}
+
+	scmi_pd_data->domains = domains;
+	scmi_pd_data->num_domains = num_domains;
+
+	of_genpd_add_provider_onecell(np, scmi_pd_data);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_POWER },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_power_domain_driver = {
+	.name = "scmi-power-domain",
+	.probe = scmi_pm_domain_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_power_domain_driver);
+
+MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
+MODULE_DESCRIPTION("ARM SCMI power domain driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
