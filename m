Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09929C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68E82173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 04:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MvZQDI5A";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WPGDNon0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfAJEDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 23:03:42 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51192 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfAJEDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 23:03:39 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1C488609C1; Thu, 10 Jan 2019 04:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547093018;
        bh=+aOBiuzFdjRX1Sutfp3TFZZym0wdm6qyv7eqsw9EP/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvZQDI5ARGGHMgb55cT5hnvKg114gHBNsY9JeRav3QiSpuLJLfAsBesHm0ukIqz+q
         ddIJ4CzlUDwvmrUpCbHDR7z7MH+2BAT+ia38U3Vk6H+vwyrky/XxJE50KQKXhMG/AM
         1BYsTJbK0WIUQ7SfWHS0vwCTNm8x2Rbh+7tAB0Yw=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 991A360247;
        Thu, 10 Jan 2019 04:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547093015;
        bh=+aOBiuzFdjRX1Sutfp3TFZZym0wdm6qyv7eqsw9EP/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WPGDNon0mQba+IfR/iWAUBXeT4pC6oZZ26e33xFDGHs1fmIhi5OsMex9ug13JmKDW
         SrqXGMRdLHykEM51KmN+cWBOPiUWGhz1A2NqIU78XtskkOCRaA7utgI5k4gVMNDGCB
         df6di0MtrKcBqhssNGVhNGR0Hdk0WLHDU6GK8y9c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 991A360247
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     andy.gross@linaro.org, robh@kernel.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, ulf.hansson@linaro.org, collinsd@codeaurora.org,
        mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v11 7/9] soc: qcom: rpmhpd: Add RPMh power domain driver
Date:   Thu, 10 Jan 2019 09:32:07 +0530
Message-Id: <20190110040209.6028-8-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190110040209.6028-1-rnayak@codeaurora.org>
References: <20190110040209.6028-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RPMh power domain driver aggregates the corner votes from various
consumers for the ARC resources and communicates it to RPMh.

With RPMh we use 2 different numbering space for corners, one used
by the clients to express their performance needs, and another used
to communicate to RPMh hardware.

The clients express their performance requirements using a sparse
numbering space which are mapped to meaningful levels like RET, SVS,
NOMINAL, TURBO etc which then get mapped to another number space
between 0 and 15 which is communicated to RPMh. The sparse number space,
also referred to as vlvl is mapped to the continuous number space of 0
to 15, also referred to as hlvl, using command DB.

Some power domain clients could request a performance state only while
the CPU is active, while some others could request for a certain
performance state all the time regardless of the state of the CPU.
We handle this by internally aggregating the votes from both type of
clients and then send the aggregated votes to RPMh.

There are also 3 different types of votes that are comunicated to RPMh
for every resource.
1. ACTIVE_ONLY:
	This specifies the requirement for the resource when the CPU is
 	active
2. SLEEP:
	This specifies the requirement for the resource when the CPU is
	going to sleep
3. WAKE_ONLY:
	This specifies the requirement for the resource when the CPU is
	coming out of sleep to active state

We add data for all power domains on sdm845 SoC as part of the patch.
The driver can be extended to support other SoCs which support RPMh

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/soc/qcom/Kconfig  |   9 +
 drivers/soc/qcom/Makefile |   1 +
 drivers/soc/qcom/rpmhpd.c | 391 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 drivers/soc/qcom/rpmhpd.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index df5cd9fa0d5e..6241d3e3b115 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -98,6 +98,15 @@ config QCOM_RPMH
 	  of hardware components aggregate requests for these resources and
 	  help apply the aggregated state on the resource.
 
+config QCOM_RPMHPD
+	bool "Qualcomm RPMh Power domain driver"
+	depends on QCOM_RPMH && QCOM_COMMAND_DB
+	help
+	  QCOM RPMh Power domain driver to support power-domains with
+	  performance states. The driver communicates a performance state
+	  value to RPMh which then translates it into corresponding voltage
+	  for the voltage rail.
+
 config QCOM_RPMPD
 	bool "Qualcomm RPM Power domain driver"
 	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index f1b25fdcf2ad..ffe519b0cb66 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
 obj-$(CONFIG_QCOM_LLCC) += llcc-slice.o
 obj-$(CONFIG_QCOM_SDM845_LLCC) += llcc-sdm845.o
+obj-$(CONFIG_QCOM_RPMHPD) += rpmhpd.o
 obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
new file mode 100644
index 000000000000..e45628694f09
--- /dev/null
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -0,0 +1,391 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved.*/
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mutex.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_opp.h>
+#include <soc/qcom/cmd-db.h>
+#include <soc/qcom/rpmh.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+#define domain_to_rpmhpd(domain) container_of(domain, struct rpmhpd, pd)
+
+#define RPMH_ARC_MAX_LEVELS	16
+
+/**
+ * struct rpmhpd - top level RPMh power domain resource data structure
+ * @dev:		rpmh power domain controller device
+ * @pd: 		generic_pm_domain corrresponding to the power domain
+ * @peer:		A peer power domain in case Active only Voting is supported
+ * @active_only:	True if it represents an Active only peer
+ * @level:		An array of level (vlvl) to corner (hlvl) mappings derived from cmd-db
+ * @level_count:	Number of levels supported by the power domain. max being 16 (0 - 15)
+ * @enabled:		true if the power domain is enabled
+ * @res_name:		Resource name used for cmd-db lookup
+ * @addr:		Resource address as looped up using resource name from cmd-db
+ */
+struct rpmhpd {
+	struct device	*dev;
+	struct generic_pm_domain pd;
+	struct generic_pm_domain *parent;
+	struct rpmhpd	*peer;
+	const bool	active_only;
+	unsigned int	corner;
+	unsigned int	active_corner;
+	u32		level[RPMH_ARC_MAX_LEVELS];
+	size_t		level_count;
+	bool		enabled;
+	const char	*res_name;
+	u32		addr;
+};
+
+struct rpmhpd_desc {
+	struct rpmhpd **rpmhpds;
+	size_t num_pds;
+};
+
+static DEFINE_MUTEX(rpmhpd_lock);
+
+/* SDM845 RPMH powerdomains */
+
+static struct rpmhpd sdm845_ebi = {
+	.pd = { .name = "ebi", },
+	.res_name = "ebi.lvl",
+};
+
+static struct rpmhpd sdm845_lmx = {
+	.pd = { .name = "lmx", },
+	.res_name = "lmx.lvl",
+};
+
+static struct rpmhpd sdm845_lcx = {
+	.pd = { .name = "lcx", },
+	.res_name = "lcx.lvl",
+};
+
+static struct rpmhpd sdm845_gfx = {
+	.pd = { .name = "gfx", },
+	.res_name = "gfx.lvl",
+};
+
+static struct rpmhpd sdm845_mss = {
+	.pd = { .name = "mss", },
+	.res_name = "mss.lvl",
+};
+
+static struct rpmhpd sdm845_mx_ao;
+static struct rpmhpd sdm845_mx = {
+	.pd = { .name = "mx", },
+	.peer = &sdm845_mx_ao,
+	.res_name = "mx.lvl",
+};
+
+static struct rpmhpd sdm845_mx_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &sdm845_mx,
+	.res_name = "mx.lvl",
+};
+
+static struct rpmhpd sdm845_cx_ao;
+static struct rpmhpd sdm845_cx = {
+	.pd = { .name = "cx", },
+	.peer = &sdm845_cx_ao,
+	.res_name = "cx.lvl",
+};
+
+static struct rpmhpd sdm845_cx_ao = {
+	.pd = { .name = "cx_ao", },
+	.peer = &sdm845_cx,
+	.res_name = "cx.lvl",
+};
+
+static struct rpmhpd *sdm845_rpmhpds[] = {
+	[SDM845_EBI] = &sdm845_ebi,
+	[SDM845_MX] = &sdm845_mx,
+	[SDM845_MX_AO] = &sdm845_mx_ao,
+	[SDM845_CX] = &sdm845_cx,
+	[SDM845_CX_AO] = &sdm845_cx_ao,
+	[SDM845_LMX] = &sdm845_lmx,
+	[SDM845_LCX] = &sdm845_lcx,
+	[SDM845_GFX] = &sdm845_gfx,
+	[SDM845_MSS] = &sdm845_mss,
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
+
+static int rpmhpd_send_corner(struct rpmhpd *pd, int state,
+			      unsigned int corner, bool sync)
+{
+	struct tcs_cmd cmd = {
+		.addr = pd->addr,
+		.data = corner,
+	};
+
+	/*
+	 * Wait for an ack only when we are increasing the
+	 * perf state of the power domain
+	 */
+	if (sync)
+		return rpmh_write(pd->dev, state, &cmd, 1);
+	else
+		return rpmh_write_async(pd->dev, state, &cmd, 1);
+}
+
+static void to_active_sleep(struct rpmhpd *pd, unsigned int corner,
+			    unsigned int *active, unsigned int *sleep)
+{
+	*active = corner;
+
+	if (pd->active_only)
+		*sleep = 0;
+	else
+		*sleep = *active;
+}
+
+/*
+ * This function is used to aggregate the votes across the active only
+ * resources and its peers. The aggregated votes are sent to RPMh as
+ * ACTIVE_ONLY votes (which take effect immediately), as WAKE_ONLY votes
+ * (applied by RPMh on system wakeup) and as SLEEP votes (applied by RPMh
+ * on system sleep).
+ * We send ACTIVE_ONLY votes for resources without any peers. For others,
+ * which have an active only peer, all 3 votes are sent.
+ */
+static int rpmhpd_aggregate_corner(struct rpmhpd *pd, unsigned int corner)
+{
+	int ret;
+	struct rpmhpd *peer = pd->peer;
+	unsigned int active_corner, sleep_corner;
+	unsigned int this_active_corner = 0, this_sleep_corner = 0;
+	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+
+	to_active_sleep(pd, corner, &this_active_corner, &this_sleep_corner);
+
+	if (peer && peer->enabled)
+		to_active_sleep(peer, peer->corner, &peer_active_corner,
+				&peer_sleep_corner);
+
+	active_corner = max(this_active_corner, peer_active_corner);
+
+	ret = rpmhpd_send_corner(pd, RPMH_ACTIVE_ONLY_STATE, active_corner,
+				 active_corner > pd->active_corner);
+	if (ret)
+		return ret;
+
+	pd->active_corner = active_corner;
+
+	if (peer) {
+		peer->active_corner = active_corner;
+
+		ret = rpmhpd_send_corner(pd, RPMH_WAKE_ONLY_STATE,
+					 active_corner, false);
+		if (ret)
+			return ret;
+
+		sleep_corner = max(this_sleep_corner, peer_sleep_corner);
+
+		return rpmhpd_send_corner(pd, RPMH_SLEEP_STATE, sleep_corner,
+					  false);
+	}
+
+	return ret;
+}
+
+static int rpmhpd_power_on(struct generic_pm_domain *domain)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+	int ret = 0;
+
+	mutex_lock(&rpmhpd_lock);
+
+	if (pd->corner)
+		ret = rpmhpd_aggregate_corner(pd, pd->corner);
+
+	if (!ret)
+		pd->enabled = true;
+
+	mutex_unlock(&rpmhpd_lock);
+
+	return ret;
+}
+
+static int rpmhpd_power_off(struct generic_pm_domain *domain)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+	int ret = 0;
+
+	mutex_lock(&rpmhpd_lock);
+
+	ret = rpmhpd_aggregate_corner(pd, pd->level[0]);
+
+	if (!ret)
+		pd->enabled = false;
+
+	mutex_unlock(&rpmhpd_lock);
+
+	return ret;
+}
+
+static int rpmhpd_set_performance_state(struct generic_pm_domain *domain,
+					unsigned int level)
+{
+	struct rpmhpd *pd = domain_to_rpmhpd(domain);
+	int ret = 0, i;
+
+	mutex_lock(&rpmhpd_lock);
+
+	for (i = 0; i < pd->level_count; i++)
+		if (level <= pd->level[i])
+			break;
+
+	/*
+	 * If the level requested is more than that supported by the
+	 * max corner, just set it to max anyway.
+	 */
+	if (i == pd->level_count)
+		i--;
+
+	if (pd->enabled) {
+		ret = rpmhpd_aggregate_corner(pd, i);
+		if (ret)
+			goto out;
+	}
+
+	pd->corner = i;
+out:
+	mutex_unlock(&rpmhpd_lock);
+
+	return ret;
+}
+
+static unsigned int rpmhpd_get_performance_state(struct generic_pm_domain *genpd,
+						 struct dev_pm_opp *opp)
+{
+	return dev_pm_opp_get_level(opp);
+}
+
+static int rpmhpd_update_level_mapping(struct rpmhpd *rpmhpd)
+{
+	int i;
+	const u16 *buf;
+
+	buf = cmd_db_read_aux_data(rpmhpd->res_name, &rpmhpd->level_count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
+	/* 2 bytes used for each command DB aux data entry */
+	rpmhpd->level_count >>= 1;
+
+	if (rpmhpd->level_count > RPMH_ARC_MAX_LEVELS)
+		return -EINVAL;
+
+	for (i = 0; i < rpmhpd->level_count; i++) {
+		rpmhpd->level[i] = buf[i];
+
+		/*
+		 * The AUX data may be zero padded.  These 0 valued entries at
+		 * the end of the map must be ignored.
+		 */
+		if (i > 0 && rpmhpd->level[i] == 0) {
+			rpmhpd->level_count = i;
+			break;
+		}
+		pr_debug("%s: ARC hlvl=%2d --> vlvl=%4u\n", rpmhpd->res_name, i,
+			 rpmhpd->level[i]);
+	}
+
+	return 0;
+}
+
+static int rpmhpd_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	size_t num_pds;
+	struct device *dev = &pdev->dev;
+	struct genpd_onecell_data *data;
+	struct rpmhpd **rpmhpds;
+	const struct rpmhpd_desc *desc;
+
+	desc = of_device_get_match_data(dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmhpds = desc->rpmhpds;
+	num_pds = desc->num_pds;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(dev, num_pds, sizeof(*data->domains),
+				     GFP_KERNEL);
+	if (!data->domains)
+		return -ENOMEM;
+
+	data->num_domains = num_pds;
+
+	for (i = 0; i < num_pds; i++) {
+		if (!rpmhpds[i]) {
+			dev_warn(dev, "rpmhpds[%d] is empty\n", i);
+			continue;
+		}
+
+		rpmhpds[i]->dev = dev;
+		rpmhpds[i]->addr = cmd_db_read_addr(rpmhpds[i]->res_name);
+		if (!rpmhpds[i]->addr) {
+			dev_err(dev, "Could not find RPMh address for resource %s\n",
+				rpmhpds[i]->res_name);
+			return -ENODEV;
+		}
+
+		ret = cmd_db_read_slave_id(rpmhpds[i]->res_name);
+		if (ret != CMD_DB_HW_ARC) {
+			dev_err(dev, "RPMh slave ID mismatch\n");
+			return -EINVAL;
+		}
+
+		ret = rpmhpd_update_level_mapping(rpmhpds[i]);
+		if (ret)
+			return ret;
+
+		rpmhpds[i]->pd.power_off = rpmhpd_power_off;
+		rpmhpds[i]->pd.power_on = rpmhpd_power_on;
+		rpmhpds[i]->pd.set_performance_state = rpmhpd_set_performance_state;
+		rpmhpds[i]->pd.opp_to_performance_state = rpmhpd_get_performance_state;
+		pm_genpd_init(&rpmhpds[i]->pd, NULL, true);
+
+		data->domains[i] = &rpmhpds[i]->pd;
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+}
+
+static struct platform_driver rpmhpd_driver = {
+	.driver = {
+		.name = "qcom-rpmhpd",
+		.of_match_table = rpmhpd_match_table,
+		.suppress_bind_attrs = true,
+	},
+	.probe = rpmhpd_probe,
+};
+
+static int __init rpmhpd_init(void)
+{
+	return platform_driver_register(&rpmhpd_driver);
+}
+core_initcall(rpmhpd_init);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

