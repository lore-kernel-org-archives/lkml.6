Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140FDC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD16120B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BuZhgRDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfAaAkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:40:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43573 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729767AbfAaAkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:40:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so574574pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=inUJcDmLJEIhpghXAnayf+quiU2aPZto5SpfxGijJ28=;
        b=BuZhgRDRGl5ItmiuO0N27bfNGkhoyMnX12fdFlDAoWHlMfSnfl7dlIeRkqgeatpcrV
         ujmLuje7rbm1DEYKf8W624dgOUM3FSJ93APiD1U2WR6afHpHwIFz2HZZ9XhURXJPPnJf
         XY2wlV09ZqtnZvca/RPBVNe0sNMUzwLTRT/PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=inUJcDmLJEIhpghXAnayf+quiU2aPZto5SpfxGijJ28=;
        b=DVv+zuRgYyW+YFqfNeGrPfOydtIFr/U+bR2fUHn9GPPdWFzHrVBVFjuz487qWqKKXW
         VwjusVwgg1TRC3ArrIj0uSqnl5UvLlUWo15Ivx4OUoKIBZ2vqsWLlg2Vi+wvi5/Mbx0G
         H7QzA43MAzXZS4YDWeOdHV4NR+/v6wWBFx3MoiUmPFudnX6wN5p3QykFJzoue741Cbux
         HCAojrOGH5+8vMIcoR1Q4IbkROJJUmWN0VJ49Vs1mA4AePvU/Go3Rj7edJtCBuvuBJ7z
         3wYusWtDA5Rk9WuSMVyoOWXyG2DbrAC300k3uvbQPy5Xl2BDAjfAKk6cW2/UJb0fF3Ca
         pCKQ==
X-Gm-Message-State: AJcUukd8YoOfJJmzIfnbGrigOIIgjsO1CyOBSQ65hzdA0cvmKv72DuyD
        X0vai4VOsod8hXxp2LTmMwYo1g==
X-Google-Smtp-Source: ALg8bN7ItTlT4l5lB5EYY+qsjsrprgLOwFOmnzwr+iqCm2iwAsiUPzgpUBpPwvn5urfK3MDhKMW+vw==
X-Received: by 2002:a63:3e05:: with SMTP id l5mr21531006pga.96.1548895198998;
        Wed, 30 Jan 2019 16:39:58 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k15sm4357928pfb.147.2019.01.30.16.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 16:39:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH v5 06/10] soc: qcom: Add AOSS QMP genpd provider
Date:   Wed, 30 Jan 2019 16:39:29 -0800
Message-Id: <20190131003933.11436-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190131003933.11436-1-bjorn.andersson@linaro.org>
References: <20190131003933.11436-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AOSS QMP genpd provider implements control over power-related
resources related to low-power state associated with the remoteprocs in
the system as well as control over a set of clocks related to debug
hardware in the SoC.

Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v4:
- None

Changes since v3:
- None

 drivers/soc/qcom/Kconfig       |   9 +++
 drivers/soc/qcom/Makefile      |   1 +
 drivers/soc/qcom/aoss-qmp-pd.c | 138 +++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/soc/qcom/aoss-qmp-pd.c

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 28ab19bf8c98..893b56b70957 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -12,6 +12,15 @@ config QCOM_AOSS_QMP
 	  micro-controller in the AOSS, using QMP, to control certain resource
 	  that are not exposed through RPMh.
 
+config QCOM_AOSS_QMP_PD
+	tristate "Qualcomm AOSS Messaging Power Domain driver"
+	depends on QCOM_AOSS_QMP
+	select PM_GENERIC_DOMAINS
+	help
+	  This driver provides the means of controlling the AOSS's handling of
+	  low-power state for resources related to the remoteproc subsystems as
+	  well as controlling the debug clocks.
+
 config QCOM_COMMAND_DB
 	bool "Qualcomm Command DB"
 	depends on ARCH_QCOM || COMPILE_TEST
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 2c04d27fbf9e..16913e73fddf 100644
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
index 000000000000..82dd569a2bc9
--- /dev/null
+++ b/drivers/soc/qcom/aoss-qmp-pd.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, Linaro Ltd
+ */
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/soc/qcom/aoss-qmp.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
+
+/* Requests are expected to be 96 bytes long */
+#define AOSS_QMP_PD_MSG_LEN	96
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
+	char buf[AOSS_QMP_PD_MSG_LEN];
+
+	snprintf(buf, sizeof(buf), "{class: clock, res: %s, val: %d}",
+		 res->name, !!enable);
+	return qmp_send(res->qmp, buf, sizeof(buf));
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
+	char buf[AOSS_QMP_PD_MSG_LEN];
+
+	snprintf(buf, sizeof(buf),
+		 "{class: image, res: load_state, name: %s, val: %s}",
+		 res->name, enable ? "on" : "off");
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
+	struct device *parent = pdev->dev.parent;
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
+	return of_genpd_add_provider_onecell(parent->of_node, data);
+}
+
+static int qmp_pd_remove(struct platform_device *pdev)
+{
+	struct device *parent = pdev->dev.parent;
+
+	of_genpd_del_provider(parent->of_node);
+
+	return 0;
+}
+
+static struct platform_driver qmp_pd_driver = {
+	.driver = {
+		.name		= "aoss_qmp_pd",
+	},
+	.probe = qmp_pd_probe,
+	.remove = qmp_pd_remove,
+};
+module_platform_driver(qmp_pd_driver);
+
+MODULE_ALIAS("platform:aoss_qmp_pd");
+MODULE_DESCRIPTION("Qualcomm AOSS QMP load-state driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

