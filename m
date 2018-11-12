Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECAF2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82B62175B
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PcIDnS4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82B62175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbeKLRyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:54:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39238 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbeKLRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:54:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id n11-v6so3926973pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wvT2MV0cpdZ3I4k2m3tel+zZFqPKLYuEhJfBEnHZVEo=;
        b=PcIDnS4YOg2mmEqT5vkPQNSDhtzUaLrdG5VD9MHpQXC+J1fCSwTPr24UTdcMZI28GP
         z3jjdZLGP6dECqP7n5xUKx3TzzjD5jXVVIvDkFBjbcQbAX98BhpoGCvygQYbrnmWqZXQ
         iCBrAdmpUoYLqnJ1ZFFvSBk/Q7BKut22JGWgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wvT2MV0cpdZ3I4k2m3tel+zZFqPKLYuEhJfBEnHZVEo=;
        b=RBP2kJ6QDQoyupdH+nqXj2Oz1aw7sq4g/a84OkYY6CTrcHh+fIkBYHcVX3WcG297W5
         IgVw0XCrxeSFxecNuZ9nMi/cznfUEJn/dIx3lnRdzcddOEnldZERb8QYDAHf7wfHcjAq
         53B+UR12K7ELjECUKZyJA5MEGDSmUYH4GDP/ukhZ9e/iIQEWhLdKKy9gqe0HX+nxQd+m
         92g+Jd+hWQ4TgggJXHt6OfLiNypFXxZLkmvloVf6MYqF56FyYwMMPyIHAqPcXrt5RVV+
         sssxFB6/IpD33iIE4U4xCi5R7UEDiQM72MT0ccS6NGVr6grJ1rDh0Vjap/gxQmQhZPZJ
         kgbA==
X-Gm-Message-State: AGRZ1gL7QvfmjyR82Qr/Frcn8rdwQQLdjmflTy2bPMyJPp2V5Me3fH4N
        ghwmylpUeY+P2W+S/aYGSJ07sA==
X-Google-Smtp-Source: AJdET5es5vksXKydOwxNsn4mt9yfFgKB03XqwHh59ZSuXEo27rpkU9DPPFjgjzq9Q2TDbkP2W3N0aw==
X-Received: by 2002:a65:434d:: with SMTP id k13mr3800506pgq.269.1542009730225;
        Mon, 12 Nov 2018 00:02:10 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 134sm13590085pgb.78.2018.11.12.00.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 00:02:09 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] soc: qcom: Add AOSS QMP genpd provider
Date:   Mon, 12 Nov 2018 00:05:57 -0800
Message-Id: <20181112080557.22698-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181112080557.22698-1-bjorn.andersson@linaro.org>
References: <20181112080557.22698-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP genpd provider implements control over power-related
resources related to low-power state associated with the remoteprocs in
the system as well as control over a set of clocks related to debug
hardware in the SoC.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/Kconfig       |   8 ++
 drivers/soc/qcom/Makefile      |   1 +
 drivers/soc/qcom/aoss-qmp-pd.c | 135 +++++++++++++++++++++++++++++++++
 3 files changed, 144 insertions(+)
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index ba08fc00d7f5..e1eda3d59748 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -10,6 +10,14 @@ config QCOM_AOSS_QMP
 	  micro-controller in the AOSS, using QMP, to control certain resource
 	  that are not exposed through RPMh.
 
+config QCOM_AOSS_QMP_PD
+	tristate "Qualcomm AOSS Messaging Power Domain driver"
+	depends on QCOM_AOSS_QMP
+	help
+	  This driver provides the means of controlling the AOSSs handling of
+	  low-power state for resources related to the remoteproc subsystems as
+	  well as controlling the debug clocks.
+
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index d0d7fdc94d9a..ebfa414a5b77 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS_rpmh-rsc.o := -I$(src)
 obj-$(CONFIG_QCOM_AOSS_QMP) +=	aoss-qmp.o
+obj-$(CONFIG_QCOM_AOSS_QMP_PD) += aoss-qmp-pd.o
 obj-$(CONFIG_QCOM_GENI_SE) +=	qcom-geni-se.o
 obj-$(CONFIG_QCOM_COMMAND_DB) += cmd-db.o
 obj-$(CONFIG_QCOM_GLINK_SSR) +=	glink_ssr.o
diff --git a/drivers/soc/qcom/aoss-qmp-pd.c b/drivers/soc/qcom/aoss-qmp-pd.c
new file mode 100644
index 000000000000..467d0db4abfa
--- /dev/null
+++ b/drivers/soc/qcom/aoss-qmp-pd.c
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Ltd
+ */
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/soc/qcom/aoss-qmp.h>
+
+#include <dt-bindings/power/qcom-aoss-qmp.h>
+
+struct qmp_pd {
+	struct qmp *qmp;
+
+	struct generic_pm_domain pd;
+
+	const char *name;
+};
+
+#define to_qmp_pd_resource(res) container_of(res, struct qmp_pd, pd)
+
+struct qmp_pd_resource {
+	const char *name;
+	int (*on)(struct generic_pm_domain *domain);
+	int (*off)(struct generic_pm_domain *domain);
+};
+
+static int qmp_pd_clock_toggle(struct qmp_pd *res, bool enable)
+{
+	char buf[96];
+	size_t n;
+
+	n = snprintf(buf, sizeof(buf), "{class: clock, res: %s, val: %d}",
+		     res->name, !!enable);
+	return qmp_send(res->qmp, buf, n);
+}
+
+static int qmp_pd_clock_on(struct generic_pm_domain *domain)
+{
+	return qmp_pd_clock_toggle(to_qmp_pd_resource(domain), true);
+}
+
+static int qmp_pd_clock_off(struct generic_pm_domain *domain)
+{
+	return qmp_pd_clock_toggle(to_qmp_pd_resource(domain), false);
+}
+
+static int qmp_pd_image_toggle(struct qmp_pd *res, bool enable)
+{
+	char buf[96];
+	size_t n;
+
+	n = snprintf(buf, sizeof(buf),
+		     "{class: image, res: load_state, name: %s, val: %s}",
+		     res->name, enable ? "on" : "off");
+	return qmp_send(res->qmp, buf, sizeof(buf));
+}
+
+static int qmp_pd_image_on(struct generic_pm_domain *domain)
+{
+	return qmp_pd_image_toggle(to_qmp_pd_resource(domain), true);
+}
+
+static int qmp_pd_image_off(struct generic_pm_domain *domain)
+{
+	return qmp_pd_image_toggle(to_qmp_pd_resource(domain), false);
+}
+
+static const struct qmp_pd_resource sdm845_resources[] = {
+	[AOSS_QMP_QDSS_CLK] = { "qdss", qmp_pd_clock_on, qmp_pd_clock_off },
+	[AOSS_QMP_LS_CDSP] = { "cdsp", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_LPASS] = { "adsp", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_MODEM] = { "modem", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_SLPI] = { "slpi", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_SPSS] = { "spss", qmp_pd_image_on, qmp_pd_image_off },
+	[AOSS_QMP_LS_VENUS] = { "venus", qmp_pd_image_on, qmp_pd_image_off },
+};
+
+static int qmp_pd_probe(struct platform_device *pdev)
+{
+	struct genpd_onecell_data *data;
+	struct qmp_pd *res;
+	struct qmp *qmp;
+	size_t num = ARRAY_SIZE(sdm845_resources);
+	int i;
+
+	qmp = dev_get_drvdata(pdev->dev.parent);
+	if (!qmp)
+		return -EINVAL;
+
+	res = devm_kcalloc(&pdev->dev, num, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domains = devm_kcalloc(&pdev->dev, num, sizeof(*data->domains),
+				     GFP_KERNEL);
+
+	for (i = 0; i < num; i++) {
+		pm_genpd_init(&res[i].pd, NULL, true);
+		res[i].qmp = qmp;
+		res[i].name = sdm845_resources[i].name;
+
+		res[i].pd.name = sdm845_resources[i].name;
+		res[i].pd.power_on = sdm845_resources[i].on;
+		res[i].pd.power_off = sdm845_resources[i].off;
+
+		data->domains[data->num_domains++] = &res[i].pd;
+	}
+
+	return of_genpd_add_provider_onecell(pdev->dev.of_node, data);
+}
+
+static const struct of_device_id qmp_pd_dt_match[] = {
+	{ .compatible = "qcom,sdm845-aoss-qmp-pd", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qmp_pd_dt_match);
+
+static struct platform_driver qmp_pd_driver = {
+	.driver = {
+		.name		= "aoss_qmp_pd",
+		.of_match_table	= qmp_pd_dt_match,
+	},
+	.probe = qmp_pd_probe,
+};
+module_platform_driver(qmp_pd_driver);
+
+MODULE_DESCRIPTION("Qualcomm AOSS QMP load-state driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

