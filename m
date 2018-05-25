Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965916AbeEYKCV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 06:02:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46498 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965657AbeEYKBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 06:01:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 560D360F8E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From: Rajendra Nayak <rnayak@codeaurora.org>
To: viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, collinsd@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v2 5/6] soc: qcom: rpmh powerdomain driver
Date: Fri, 25 May 2018 15:31:20 +0530
Message-Id: <20180525100121.28214-6-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525100121.28214-1-rnayak@codeaurora.org>
References: <20180525100121.28214-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPMh powerdomain driver aggregates the corner votes from various
consumers for the ARC resources and communicates it to RPMh.

We also add data for all powerdomains on sdm845 as part of the patch.
The driver can be extended to support other SoCs which support RPMh

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 .../devicetree/bindings/power/qcom,rpmhpd.txt |  65 ++++
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/rpmhpd.c                     | 360 ++++++++++++++++++
 4 files changed, 435 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
 create mode 100644 drivers/soc/qcom/rpmhpd.c

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
new file mode 100644
index 000000000000..c1fa986c12ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/qcom,rpmhpd.txt
@@ -0,0 +1,65 @@
+Qualcomm RPMh Powerdomains
+
+* For RPMh powerdomains, we communicate a performance state to RPMh
+which then translates it into a corresponding voltage on a rail
+
+Required Properties:
+ - compatible: Should be one of the following
+	* qcom,sdm845-rpmhpd: RPMh powerdomain for the sdm845 family of SoC
+ - power-domain-cells: number of cells in power domain specifier
+	must be 1
+ - operating-points-v2: Phandle to the OPP table for the power-domain.
+	Refer to Documentation/devicetree/bindings/power/power_domain.txt
+	and Documentation/devicetree/bindings/opp/qcom-opp.txt for more details
+
+Example:
+
+	rpmhpd: power-controller {
+		compatible = "qcom,sdm845-rpmhpd";
+		#power-domain-cells = <1>;
+		operating-points-v2 = <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>,
+				      <&rpmhpd_opp_table>;
+	};
+
+	rpmhpd_opp_table: opp-table {
+		compatible = "operating-points-v2-qcom-level", "operating-points-v2";
+
+		rpmhpd_opp1: opp@1 {
+			qcom-corner = <16>;
+		};
+
+		rpmhpd_opp2: opp@2 {
+			qcom-corner = <48>;
+		};
+
+		rpmhpd_opp3: opp@3 {
+			qcom-corner = <64>;
+		};
+
+		rpmhpd_opp4: opp@4 {
+			qcom-corner = <128>;
+		};
+
+		rpmhpd_opp5: opp@5 {
+			qcom-corner = <192>;
+		};
+
+		rpmhpd_opp6: opp@6 {
+			qcom-corner = <256>;
+		};
+
+		rpmhpd_opp7: opp@7 {
+			qcom-corner = <320>;
+		};
+
+		rpmhpd_opp8: opp@8 {
+			qcom-corner = <416>;
+		};
+	};
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index a7a405178967..1faed239701d 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -74,6 +74,15 @@ config QCOM_RMTFS_MEM
 
 	  Say y here if you intend to boot the modem remoteproc.
 
+config QCOM_RPMHPD
+	tristate "Qualcomm RPMh Powerdomain driver"
+	depends on QCOM_RPMH && QCOM_COMMAND_DB
+	help
+	  QCOM RPMh powerdomain driver to support powerdomain with
+	  performance states. The driver communicates a performance state
+	  value to RPMh which then translates it into corresponding voltage
+	  for the voltage rail.
+
 config QCOM_RPMPD
 	tristate "Qualcomm RPM Powerdomain driver"
 	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 9550c170de93..499513f63bef 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
+obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
new file mode 100644
index 000000000000..a79f094ad326
--- /dev/null
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+
+#define domain_to_rpmhpd(domain) container_of(domain, struct rpmhpd, pd)
+
+#define DEFINE_RPMHPD_AO(_platform, _name, _active)			\
+	static struct rpmhpd _platform##_##_active;			\
+	static struct rpmhpd _platform##_##_name = {			\
+		.pd = {	.name = #_name,	},				\
+		.peer = &_platform##_##_active,				\
+		.res_name = #_name".lvl",				\
+	};								\
+	static struct rpmhpd _platform##_##_active = {			\
+		.pd = { .name = #_active, },				\
+		.peer = &_platform##_##_name,				\
+		.active_only = true,					\
+		.res_name = #_name".lvl",				\
+	}
+
+#define DEFINE_RPMHPD(_platform, _name)					\
+	static struct rpmhpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_name = #_name".lvl",				\
+	}
+
+/*
+ * This is the number of bytes used for each command DB aux data entry of an
+ * ARC resource.
+ */
+#define RPMH_ARC_LEVEL_SIZE	2
+#define RPMH_ARC_MAX_LEVELS	16
+
+struct rpmhpd {
+	struct device *dev;
+	struct generic_pm_domain pd;
+	struct rpmhpd *peer;
+	const bool active_only;
+	unsigned long corner;
+	u32	level[RPMH_ARC_MAX_LEVELS];
+	int	level_count;
+	bool enabled;
+	const char *res_name;
+	u32	addr;
+};
+
+struct rpmhpd_desc {
+	struct rpmhpd **rpmhpds;
+	size_t num_pds;
+};
+
+static DEFINE_MUTEX(rpmhpd_lock);
+
+/* sdm845 RPMh powerdomains */
+DEFINE_RPMHPD(sdm845, ebi);
+DEFINE_RPMHPD_AO(sdm845, mx, mx_ao);
+DEFINE_RPMHPD_AO(sdm845, cx, cx_ao);
+DEFINE_RPMHPD(sdm845, lmx);
+DEFINE_RPMHPD(sdm845, lcx);
+DEFINE_RPMHPD(sdm845, gfx);
+DEFINE_RPMHPD(sdm845, mss);
+
+static struct rpmhpd *sdm845_rpmhpds[] = {
+	[0] = &sdm845_ebi,
+	[1] = &sdm845_mx,
+	[2] = &sdm845_mx_ao,
+	[3] = &sdm845_cx,
+	[4] = &sdm845_cx_ao,
+	[5] = &sdm845_lmx,
+	[6] = &sdm845_lcx,
+	[7] = &sdm845_gfx,
+	[8] = &sdm845_mss,
+};
+
+static const struct rpmhpd_desc sdm845_desc = {
+	.rpmhpds = sdm845_rpmhpds,
+	.num_pds = ARRAY_SIZE(sdm845_rpmhpds),
+};
+
+static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmhpd_match_table);
+
+static int rpmhpd_send_corner(struct rpmhpd *pd, int state, unsigned int corner)
+{
+	struct tcs_cmd cmd = {
+		.addr = pd->addr,
+		.data = corner,
+	};
+
+	return rpmh_write(pd->dev, state, &cmd, 1);
+};
+
+static void to_active_sleep(struct rpmhpd *pd, unsigned long corner,
+			    unsigned long *active, unsigned long *sleep)
+{
+	*active = corner;
+
+	if (pd->active_only)
+		*sleep = 0;
+	else
+		*sleep = *active;
+}
+
+static int rpmhpd_aggregate_corner(struct rpmhpd *pd)
+{
+	int ret;
+	struct rpmhpd *peer = pd->peer;
+	unsigned long active_corner, sleep_corner;
+	unsigned long this_corner = 0, this_sleep_corner = 0;
+	unsigned long peer_corner = 0, peer_sleep_corner = 0;
+
+	to_active_sleep(pd, pd->corner, &this_corner, &this_sleep_corner);
+
+	if (peer && peer->enabled)
+		to_active_sleep(peer, peer->corner, &peer_corner,
+				&peer_sleep_corner);
+
+	active_corner = max(this_corner, peer_corner);
+
+	ret = rpmhpd_send_corner(pd, RPMH_ACTIVE_ONLY_STATE, active_corner);
+	if (ret)
+		return ret;
+
+	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
+
+	return rpmhpd_send_corner(pd, RPMH_SLEEP_STATE, sleep_corner);
+}
+
+static int rpmhpd_power_on(struct generic_pm_domain *domain)
+{
+	int ret = 0;
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	mutex_lock(&rpmhpd_lock);
+
+	pd->enabled = true;
+
+	if (pd->corner)
+		ret = rpmhpd_aggregate_corner(pd);
+
+	mutex_unlock(&rpmhpd_lock);
+
+	return ret;
+}
+
+static int rpmhpd_power_off(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	mutex_lock(&rpmhpd_lock);
+
+	if (pd->level[0] == 0) {
+		ret = rpmhpd_send_corner(pd, RPMH_ACTIVE_ONLY_STATE, 0);
+		if (ret)
+			return ret;
+
+		ret = rpmhpd_send_corner(pd, RPMH_SLEEP_STATE, 0);
+		if (ret)
+			return ret;
+	}
+
+	pd->enabled = false;
+
+	mutex_unlock(&rpmhpd_lock);
+
+	return 0;
+}
+
+static int rpmhpd_set_performance(struct generic_pm_domain *domain,
+			     unsigned int state)
+{
+	int ret = 0;
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+
+	mutex_lock(&rpmhpd_lock);
+
+	pd->corner = state;
+
+	if (!pd->enabled)
+		goto out;
+
+	ret = rpmhpd_aggregate_corner(pd);
+out:
+	mutex_unlock(&rpmhpd_lock);
+
+	return ret;
+}
+
+static unsigned int rpmhpd_get_performance(struct generic_pm_domain *genpd,
+					   struct dev_pm_opp *opp)
+{
+	struct device_node *np;
+	unsigned int corner = 0;
+
+	np = dev_pm_opp_get_of_node(opp);
+	if (of_property_read_u32(np, "qcom,level", &corner)) {
+		pr_err("%s: missing 'qcom,level' property\n", __func__);
+		return 0;
+	}
+
+	of_node_put(np);
+
+	return corner;
+}
+
+static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
+{
+	u8 *buf;
+	int i, j, len, ret;
+
+	len = cmd_db_read_aux_data_len(rpmhpd->res_name);
+	if (len <= 0)
+		return len;
+
+	buf = kzalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = cmd_db_read_aux_data(rpmhpd->res_name, buf, len);
+	if (ret < 0)
+		return ret;
+
+	rpmhpd->level_count = len / RPMH_ARC_LEVEL_SIZE;
+
+	for (i = 0; i < rpmhpd->level_count; i++) {
+		for (j = 0; j < RPMH_ARC_LEVEL_SIZE; j++)
+			rpmhpd->level[i] |=
+				buf[i * RPMH_ARC_LEVEL_SIZE + j] << (8 * j);
+
+		/*
+		 * The AUX data may be zero padded.  These 0 valued entries at
+		 * the end of the map must be ignored.
+		 */
+		if (i > 0 && rpmhpd->level[i] == 0) {
+			rpmhpd->level_count = i;
+			break;
+		}
+		pr_dbg("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
+		       rpmhpd->level[i]);
+	}
+
+	kfree(buf);
+	return 0;
+}
+
+static int rpmhpd_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	size_t num;
+	struct genpd_onecell_data *data;
+	struct rpmhpd **rpmhpds;
+	const struct rpmhpd_desc *desc;
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+	num = desc->num_pds;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+	data->num_domains = num;
+
+	ret = cmd_db_ready();
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "Command DB unavailable, ret=%d\n",
+				ret);
+		return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		if (!rpmhpds[i])
+			continue;
+
+		rpmhpds[i]->dev = &pdev->dev;
+		rpmhpds[i]->addr = cmd_db_read_addr(rpmhpds[i]->res_name);
+		if (!rpmhpds[i]->addr) {
+			dev_err(&pdev->dev, "Could not find RPMh address for resource %s\n",
+				rpmhpds[i]->res_name);
+			return -ENODEV;
+		}
+
+		ret = cmd_db_read_slave_id(rpmhpds[i]->res_name);
+		if (ret != CMD_DB_HW_ARC) {
+			dev_err(&pdev->dev, "RPMh slave ID mismatch\n");
+			return -EINVAL;
+		}
+
+		ret = rpmhpd_update_level_mapping(rpmhpds[i]);
+		if (ret)
+			return ret;
+
+		rpmhpds[i]->pd.power_off = rpmhpd_power_off;
+		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
+		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance;
+		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance;
+		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
+
+		data->domains[i] = &rpmhpds[i]->pd;
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+}
+
+static int rpmhpd_remove(struct platform_device *pdev)
+{
+	of_genpd_del_provider(pdev->dev.of_node);
+	return 0;
+}
+
+static struct platform_driver rpmhpd_driver = {
+	.driver = {
+		.name = "qcom-rpmhpd",
+		.of_match_table = rpmhpd_match_table,
+	},
+	.probe = rpmhpd_probe,
+	.remove = rpmhpd_remove,
+};
+
+static int __init rpmhpd_init(void)
+{
+	return platform_driver_register(&rpmhpd_driver);
+}
+core_initcall(rpmhpd_init);
+
+static void __exit rpmhpd_exit(void)
+{
+	platform_driver_unregister(&rpmhpd_driver);
+}
+module_exit(rpmhpd_exit);
+
+MODULE_DESCRIPTION("Qualcomm RPMh Power Domain Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-rpmhpd");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
