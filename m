Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4BEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B120872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 12:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXSahKX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7B120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932224AbeFTMNI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 08:13:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52452 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753760AbeFTMLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 08:11:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so5641700wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 05:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YQedRsQJNuAfIwCAUJuQkZ5zDukYeoDlE3WusBgILBs=;
        b=SXSahKX8uWMyt1WblmdQznBnUg+i40t+18Ryu5eMBARRnuV+m2LufALCVc1UMvScsE
         BC9LdUuvTv9Y22jCdpdUrsZoKUNICANCohGWsokaYI108xs/nBux8CQvKQScpolCbOCa
         0MXDjn8CPatrrqFDyjpwcVpZcnPxA+RJikokg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YQedRsQJNuAfIwCAUJuQkZ5zDukYeoDlE3WusBgILBs=;
        b=CyTnS84Tk46a2aJ/AoplqAzfsgTusw0vxGEO0CfnyF9YT/o9YrPWn4tJotWvfyS8Cn
         9JVkQcbapZE4XFPxJvrKuHdU8kRMmb6+g5graXxldHu2aeyiTPQHS9tjQhVwAoGIkD4S
         zdw55Rd1+yABjKAx6yoK9lBvcSdXb7r11+oQkGim9ubXW/M1fNXXqP2ITht1R1LhmOS3
         IJ6P/vDx0iBN9K5uvR+DOcUgYuFEp1FaRyyDRVjVSdM29lttLto1dyT0fEH0/M9qVFqu
         1EELSc9PGaeQHmX+TiVTjXmo+xdqAkSePOJBq03XT6PaIoSjBekegfgRBoz2naXGAbtn
         n13Q==
X-Gm-Message-State: APt69E3w08hEO1vRVmguqdQJcL/fU4w+NEnwCAX+ys1kmZONUhJ8+40K
        zQ3e2tlz3cht2s2a1YAXkj9oSw==
X-Google-Smtp-Source: ADUXVKLfkw8eCvTvYdHMuAJvc1m4rENgHURQBD0690gaFgMyV1Re4u1eVFxS4QS7D9EGsCJg7DEnbQ==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr1463663wmm.110.1529496711240;
        Wed, 20 Jun 2018 05:11:51 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e14-v6sm1656483wmh.17.2018.06.20.05.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jun 2018 05:11:50 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     rjw@rjwysocki.net, robh+dt@kernel.org, mturquette@baylibre.com,
        khilman@baylibre.com, vincent.guittot@linaro.org,
        skannan@codeaurora.org, bjorn.andersson@linaro.org,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        daidavid1@codeaurora.org, evgreen@chromium.org,
        mark.rutland@arm.com, lorenzo.pieralisi@arm.com,
        abailon@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v5 4/8] interconnect: qcom: Add RPM communication
Date:   Wed, 20 Jun 2018 15:11:37 +0300
Message-Id: <20180620121141.15403-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620121141.15403-1-georgi.djakov@linaro.org>
References: <20180620121141.15403-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some Qualcomm SoCs, there is a remote processor, which controls some of
the Network-On-Chip interconnect resources. Other CPUs express their needs
by communicating with this processor. Add a driver to handle comminication
with this remote processor.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom-smd.txt        | 32 +++++++
 drivers/interconnect/qcom/Makefile            |  2 +
 drivers/interconnect/qcom/smd-rpm.c           | 90 +++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h           | 15 ++++
 4 files changed, 139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
new file mode 100644
index 000000000000..88a5aeb50935
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
@@ -0,0 +1,32 @@
+Qualcomm SMD-RPM interconnect driver binding
+------------------------------------------------
+The RPM (Resource Power Manager) is a dedicated hardware engine
+for managing the shared SoC resources in order to keep the lowest
+power profile. It communicates with other hardware subsystems via
+the shared memory driver (SMD) back-end and accepts requests for
+various resources.
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,interconnect-smd-rpm"
+
+Example:
+	smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <0 168 1>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8916";
+				qcom,smd-channels = "rpm_requests";
+
+				interconnect-smd-rpm {
+					compatible = "qcom,interconnect-smd-rpm";
+				};
+
+			};
+		};
+	};
diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
new file mode 100644
index 000000000000..2a0c41db91c4
--- /dev/null
+++ b/drivers/interconnect/qcom/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += smd-rpm.o
diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
new file mode 100644
index 000000000000..0cf772f51642
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPM over SMD communication wrapper for interconects
+ *
+ * Copyright (C) 2018 Linaro Ltd
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#include <linux/interconnect-provider.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smd-rpm.h>
+#include "smd-rpm.h"
+
+#define	RPM_KEY_BW	0x00007762
+
+static struct qcom_icc_rpm {
+	struct qcom_smd_rpm *rpm;
+} icc_rpm_smd;
+
+struct icc_rpm_smd_req {
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
+};
+
+bool qcom_icc_rpm_smd_available(void)
+{
+	if (!icc_rpm_smd.rpm)
+		return false;
+
+	return true;
+}
+
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
+{
+	struct icc_rpm_smd_req req = {
+		.key = cpu_to_le32(RPM_KEY_BW),
+		.nbytes = cpu_to_le32(sizeof(u32)),
+		.value = cpu_to_le32(val),
+	};
+
+	return qcom_rpm_smd_write(icc_rpm_smd.rpm, ctx, rsc_type, id, &req,
+				  sizeof(req));
+}
+EXPORT_SYMBOL(qcom_icc_rpm_smd_send);
+
+static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
+{
+	icc_rpm_smd.rpm = dev_get_drvdata(pdev->dev.parent);
+	if (!icc_rpm_smd.rpm) {
+		dev_err(&pdev->dev, "unable to retrieve handle to RPM\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id qcom_icc_rpm_smd_dt_match[] = {
+	{ .compatible = "qcom,interconnect-smd-rpm", },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, qcom_interconnect_rpm_smd_dt_match);
+
+static struct platform_driver qcom_interconnect_rpm_smd_driver = {
+	.driver = {
+		.name		= "qcom-interconnect-smd-rpm",
+		.of_match_table	= qcom_icc_rpm_smd_dt_match,
+	},
+	.probe = qcom_icc_rpm_smd_probe,
+};
+
+static int __init rpm_smd_interconnect_init(void)
+{
+	return platform_driver_register(&qcom_interconnect_rpm_smd_driver);
+}
+subsys_initcall(rpm_smd_interconnect_init);
+
+static void __exit rpm_smd_interconnect_exit(void)
+{
+	platform_driver_unregister(&qcom_interconnect_rpm_smd_driver);
+}
+module_exit(rpm_smd_interconnect_exit)
+
+MODULE_AUTHOR("Georgi Djakov <georgi.djakov@linaro.org>");
+MODULE_DESCRIPTION("Qualcomm SMD RPM interconnect driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/interconnect/qcom/smd-rpm.h b/drivers/interconnect/qcom/smd-rpm.h
new file mode 100644
index 000000000000..0f4a3da31cf6
--- /dev/null
+++ b/drivers/interconnect/qcom/smd-rpm.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __LINUX_INTERCONNECT_QCOM_RPM_H
+#define __LINUX_INTERCONNECT_QCOM_RPM_H
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+bool qcom_icc_rpm_smd_available(void);
+int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
+
+#endif
