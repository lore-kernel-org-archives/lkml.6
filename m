Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEF5C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2361723D21
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Iw4cmVjO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DlfI+a6i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2361723D21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeF0EyR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:54:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57756 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbeF0ExN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:53:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 628EC60791; Wed, 27 Jun 2018 04:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075193;
        bh=8smHsN6LaX0ynbMlRYuimae8j97JFEx7ciZmXws2/NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iw4cmVjOY+vAjUsFJYnEmblOGFcfjjd7VkFhJ4Q1GIseiGmFVd+VT7OPiOOwb7XKP
         QeWyvE7I2Hehc0H4pRm47ivstZztn2v4nHFaYuIhhz51d+51fOWdjoshRmDiNO1hWL
         i0NOG/I/lf5Kiz4PMOculkfOZg/Ttm89AYmPMMC8=
Received: from blr-ubuntu-173.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rnayak@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E9A460AD8;
        Wed, 27 Jun 2018 04:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530075192;
        bh=8smHsN6LaX0ynbMlRYuimae8j97JFEx7ciZmXws2/NQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlfI+a6idL7nPLWsoCKu/W3VAJG7I584UcorBhzLAq+LCjVOsoz3vEvsjysGhMWPe
         NtE6DzGA3hV9svrW2/ROokRAKHC5SvUPDJwouFjkKIVbyHkgkNUQHDygOJcsxN1VTP
         p9TcHEAHbhIoQrOgouQWDSqVnZmOm9H9F/SZtJrM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E9A460AD8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rnayak@codeaurora.org
From:   Rajendra Nayak <rnayak@codeaurora.org>
To:     viresh.kumar@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: [PATCH v4 3/6] soc: qcom: rpmpd: Add a Power domain driver to model corners
Date:   Wed, 27 Jun 2018 10:22:31 +0530
Message-Id: <20180627045234.27403-4-rnayak@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180627045234.27403-1-rnayak@codeaurora.org>
References: <20180627045234.27403-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Power domains for corners just pass the performance state set by the
consumers to the RPM (Remote Power manager) which then takes care
of setting the appropriate voltage on the corresponding rails to
meet the performance needs.

We add all Power domain data needed on msm8996 here. This driver can easily
be extended by adding data for other qualcomm SoCs as well.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 drivers/soc/qcom/Kconfig  |   9 ++
 drivers/soc/qcom/Makefile |   1 +
 drivers/soc/qcom/rpmpd.c  | 294 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)
 create mode 100644 drivers/soc/qcom/rpmpd.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 9dc02f390ba3..131da9d34a40 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -74,6 +74,15 @@ config QCOM_RMTFS_MEM
 
 	  Say y here if you intend to boot the modem remoteproc.
 
+config QCOM_RPMPD
+	bool "Qualcomm RPM Power domain driver"
+	depends on MFD_QCOM_RPM && QCOM_SMD_RPM
+	help
+	  QCOM RPM Power domain driver to support power-domains with
+	  performance states. The driver communicates a performance state
+	  value to RPM which then translates it into corresponding voltage
+	  for the voltage rail.
+
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 19dcf957cb3a..9550c170de93 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
 obj-$(CONFIG_QCOM_SMSM)	+= smsm.o
 obj-$(CONFIG_QCOM_WCNSS_CTRL) += wcnss_ctrl.o
 obj-$(CONFIG_QCOM_APR) += apr.o
+obj-$(CONFIG_QCOM_RPMPD) += rpmpd.o
diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
new file mode 100644
index 000000000000..a0b9f122d793
--- /dev/null
+++ b/drivers/soc/qcom/rpmpd.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2017-2018, The Linux Foundation. All rights reserved. */
+
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_domain.h>
+#include <linux/mfd/qcom_rpm.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include <dt-bindings/mfd/qcom-rpm.h>
+#include <dt-bindings/power/qcom-rpmpd.h>
+
+#define domain_to_rpmpd(domain) container_of(domain, struct rpmpd, pd)
+
+/* Resource types */
+#define RPMPD_SMPA 0x61706d73
+#define RPMPD_LDOA 0x616f646c
+
+/* Operation Keys */
+#define KEY_CORNER		0x6e726f63 /* corn */
+#define KEY_ENABLE		0x6e657773 /* swen */
+#define KEY_FLOOR_CORNER	0x636676   /* vfc */
+
+#define DEFINE_RPMPD_CORN_SMPA(_platform, _name, _active, r_id)		\
+	static struct rpmpd _platform##_##_active;			\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = {	.name = #_name,	},				\
+		.peer = &_platform##_##_active,				\
+		.res_type = RPMPD_SMPA,					\
+		.res_id = r_id,						\
+		.key = KEY_CORNER,					\
+	};								\
+	static struct rpmpd _platform##_##_active = {			\
+		.pd = { .name = #_active, },				\
+		.peer = &_platform##_##_name,				\
+		.active_only = true,					\
+		.res_type = RPMPD_SMPA,					\
+		.res_id = r_id,						\
+		.key = KEY_CORNER,					\
+	}
+
+#define DEFINE_RPMPD_CORN_LDOA(_platform, _name, r_id)			\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_type = RPMPD_LDOA,					\
+		.res_id = r_id,						\
+		.key = KEY_CORNER,					\
+	}
+
+#define DEFINE_RPMPD_VFC(_platform, _name, r_id, r_type)		\
+	static struct rpmpd _platform##_##_name = {			\
+		.pd = { .name = #_name, },				\
+		.res_type = r_type,					\
+		.res_id = r_id,						\
+		.key = KEY_FLOOR_CORNER,				\
+	}
+
+#define DEFINE_RPMPD_VFC_SMPA(_platform, _name, r_id)			\
+	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_SMPA)
+
+#define DEFINE_RPMPD_VFC_LDOA(_platform, _name, r_id)			\
+	DEFINE_RPMPD_VFC(_platform, _name, r_id, RPMPD_LDOA)
+
+struct rpmpd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+struct rpmpd {
+	struct generic_pm_domain pd;
+	struct rpmpd *peer;
+	const bool active_only;
+	unsigned int corner;
+	bool enabled;
+	const char *res_name;
+	const int res_type;
+	const int res_id;
+	struct qcom_smd_rpm *rpm;
+	__le32 key;
+};
+
+struct rpmpd_desc {
+	struct rpmpd **rpmpds;
+	size_t num_pds;
+};
+
+static DEFINE_MUTEX(rpmpd_lock);
+
+/* msm8996 RPM Power domains */
+DEFINE_RPMPD_CORN_SMPA(msm8996, vddcx, vddcx_ao, 1);
+DEFINE_RPMPD_CORN_SMPA(msm8996, vddmx, vddmx_ao, 2);
+DEFINE_RPMPD_CORN_LDOA(msm8996, vddsscx, 26);
+
+DEFINE_RPMPD_VFC_SMPA(msm8996, vddcx_vfc, 1);
+DEFINE_RPMPD_VFC_LDOA(msm8996, vddsscx_vfc, 26);
+
+static struct rpmpd *msm8996_rpmpds[] = {
+	[MSM8996_VDDCX] =	&msm8996_vddcx,
+	[MSM8996_VDDCX_AO] =	&msm8996_vddcx_ao,
+	[MSM8996_VDDCX_VFC] =	&msm8996_vddcx_vfc,
+	[MSM8996_VDDMX] =	&msm8996_vddmx,
+	[MSM8996_VDDMX_AO] =	&msm8996_vddmx_ao,
+	[MSM8996_VDDSSCX] =	&msm8996_vddsscx,
+	[MSM8996_VDDSSCX_VFC] =	&msm8996_vddsscx_vfc,
+};
+
+static const struct rpmpd_desc msm8996_desc = {
+	.rpmpds = msm8996_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8996_rpmpds),
+};
+
+static const struct of_device_id rpmpd_match_table[] = {
+	{ .compatible = "qcom,msm8996-rpmpd", .data = &msm8996_desc },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rpmpd_match_table);
+
+static int rpmpd_send_enable(struct rpmpd *pd, bool enable)
+{
+	struct rpmpd_req req = {
+		.key = KEY_ENABLE,
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(enable),
+	};
+
+	return qcom_rpm_smd_write(pd->rpm, QCOM_RPM_ACTIVE_STATE, pd->res_type,
+				  pd->res_id, &req, sizeof(req));
+}
+
+static int rpmpd_send_corner(struct rpmpd *pd, int state, unsigned int corner)
+{
+	struct rpmpd_req req = {
+		.key = pd->key,
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(corner),
+	};
+
+	return qcom_rpm_smd_write(pd->rpm, state, pd->res_type, pd->res_id,
+				  &req, sizeof(req));
+};
+
+static void to_active_sleep(struct rpmpd *pd, unsigned int corner,
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
+static int rpmpd_aggregate_corner(struct rpmpd *pd)
+{
+	int ret;
+	struct rpmpd *peer = pd->peer;
+	unsigned int active_corner, sleep_corner;
+	unsigned int this_active_corner = 0, this_sleep_corner = 0;
+	unsigned int peer_active_corner = 0, peer_sleep_corner = 0;
+
+	to_active_sleep(pd, pd->corner, &this_active_corner, &this_sleep_corner);
+
+	if (peer && peer->enabled)
+		to_active_sleep(peer, peer->corner, &peer_active_corner,
+				&peer_sleep_corner);
+
+	active_corner = max(this_active_corner, peer_active_corner);
+
+	ret = rpmpd_send_corner(pd, QCOM_RPM_ACTIVE_STATE, active_corner);
+	if (ret)
+		return ret;
+
+	sleep_corner = max(this_sleep_corner, peer_sleep_corner);
+
+	return rpmpd_send_corner(pd, QCOM_RPM_SLEEP_STATE, sleep_corner);
+}
+
+static int rpmpd_power_on(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	ret = rpmpd_send_enable(pd, true);
+	if (ret)
+		goto out;
+
+	pd->enabled = true;
+
+	if (pd->corner)
+		ret = rpmpd_aggregate_corner(pd);
+
+out:
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+static int rpmpd_power_off(struct generic_pm_domain *domain)
+{
+	int ret;
+	struct rpmpd *pd = domain_to_rpmpd(domain);
+
+	mutex_lock(&rpmpd_lock);
+
+	ret = rpmpd_send_enable(pd, false);
+	if (!ret)
+		pd->enabled = false;
+
+	mutex_unlock(&rpmpd_lock);
+
+	return ret;
+}
+
+static int rpmpd_probe(struct platform_device *pdev)
+{
+	int i;
+	size_t num;
+	struct genpd_onecell_data *data;
+	struct qcom_smd_rpm *rpm;
+	struct rpmpd **rpmpds;
+	const struct rpmpd_desc *desc;
+
+	rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!rpm) {
+		dev_err(&pdev->dev, "Unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc)
+		return -EINVAL;
+
+	rpmpds = desc->rpmpds;
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
+	for (i = 0; i < num; i++) {
+		if (!rpmpds[i]) {
+			dev_warn(&pdev->dev, "rpmpds[] with empty entry at index=%d\n",
+				 i);
+			continue;
+		}
+
+		rpmpds[i]->rpm = rpm;
+		rpmpds[i]->pd.power_off = rpmpd_power_off;
+		rpmpds[i]->pd.power_on = rpmpd_power_on;
+		pm_genpd_init(&rpmpds[i]->pd, NULL, true);
+
+		data->domains[i] = &rpmpds[i]->pd;
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+}
+
+static struct platform_driver rpmpd_driver = {
+	.driver = {
+		.name = "qcom-rpmpd",
+		.of_match_table = rpmpd_match_table,
+	},
+	.probe = rpmpd_probe,
+};
+
+static int __init rpmpd_init(void)
+{
+	return platform_driver_register(&rpmpd_driver);
+}
+core_initcall(rpmpd_init);
+
+static void __exit rpmpd_exit(void)
+{
+	platform_driver_unregister(&rpmpd_driver);
+}
+module_exit(rpmpd_exit);
+
+MODULE_DESCRIPTION("Qualcomm Technologies, Inc. RPM Power Domain Driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:qcom-rpmpd");
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

