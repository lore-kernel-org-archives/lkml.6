Return-Path: <georgi.djakov@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520629812; cv=none;
        d=google.com; s=arc-20160816;
        b=ZotJK45zMPi5GBP+xbSXjJQe/vqAhGOuG2gi9hjltppCLQAPlU/IlKTfsThFFLpnxR
         5KuqvBavexNFo32JVTX0V7qj2XWVr7itfotPSGSMhzCYaDRN+nTRP9gSit9SB3yZzpA6
         3UXh1CGsdXXHpPDADb3/lPhbnbrau5yy2FYT31nDoCbYinTZ/ImHc2HtxEDGcc3dxRz0
         424VVPgecGB7u/mBIDVYWqi/KRxAgP/NIjrFImbB2cYpBIBFIZzQLAE7e/U5F2XMv5hR
         HIY7rjuKatqZCzXRen8xIq3MPfOps0jmsxBr7pa7msv6qbhLsSwN1/ewh8ZgNvhm2KhF
         NBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=8Mtk73RhEVmkzRrq3lZNX81k7l6xB6WNz4oCph8qn5U=;
        b=W/hnOsurb8+5wVKBX30liSFonuDbqGFST1A2XI24jOus3Ky+nxrJsrMT+OsC9LSKzF
         r4+c7vC3ZVMuq4nZun86Sdncb8KcWKpT6VYTD1mhb0EKSbYPklH2EfhILDfkpEhZAWkR
         8sOJZwmKGpFFGR1p8qPP6tQaQYE4mT7ZrX5xTdSm/TbH4q5aWn2WOHpceSSDxm0Y3iBc
         u+uie+0Rsu+Vl5OHBTBQ71pTfla+p0K6mXauk+DGB3AVycfUHFgpizWJ3rTkSXnVi+JQ
         7EtmB69A32mfsW0AXZiyu4S5uj0SU1gWAsowyi+j9rlFs1bgIFKLn7d1b2G5hiFAZsAh
         vhyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WdZnnjgs;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WdZnnjgs;
       spf=pass (google.com: domain of georgi.djakov@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=georgi.djakov@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvi31LpfM7HssiUDCVFV5Jjx+OEArPTEXbDdt7cpoF1Cp1txbn1NhjwnvV7mokgvVTgL7EU8A==
From: Georgi Djakov <georgi.djakov@linaro.org>
To: linux-pm@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net,
	robh+dt@kernel.org,
	mturquette@baylibre.com,
	khilman@baylibre.com,
	vincent.guittot@linaro.org,
	skannan@codeaurora.org,
	bjorn.andersson@linaro.org,
	amit.kucheria@linaro.org,
	seansw@qti.qualcomm.com,
	davidai@quicinc.com,
	mark.rutland@arm.com,
	lorenzo.pieralisi@arm.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	georgi.djakov@linaro.org
Subject: [PATCH v4 4/7] interconnect: qcom: Add RPM communication
Date: Fri,  9 Mar 2018 23:09:55 +0200
Message-Id: <20180309210958.16672-5-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180309210958.16672-1-georgi.djakov@linaro.org>
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594495926480181904?=
X-GMAIL-MSGID: =?utf-8?q?1594495926480181904?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On some Qualcomm SoCs, there is a remote processor, which controls some of
the Network-On-Chip interconnect resources. Other CPUs express their needs
by communicating with this processor. Add a driver to handle comminication
with this remote processor.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../devicetree/bindings/interconnect/qcom-smd.txt  | 31 ++++++++
 drivers/interconnect/qcom/Makefile                 |  1 +
 drivers/interconnect/qcom/smd-rpm.c                | 90 ++++++++++++++++++++++
 drivers/interconnect/qcom/smd-rpm.h                | 15 ++++
 4 files changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom-smd.txt
 create mode 100644 drivers/interconnect/qcom/Makefile
 create mode 100644 drivers/interconnect/qcom/smd-rpm.c
 create mode 100644 drivers/interconnect/qcom/smd-rpm.h

diff --git a/Documentation/devicetree/bindings/interconnect/qcom-smd.txt b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
new file mode 100644
index 000000000000..14e83ed7019b
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom-smd.txt
@@ -0,0 +1,31 @@
+Qualcomm SMD-RPM interconnect driver binding
+------------------------------------------------
+The RPM is a dedicated hardware engine for managing the shared
+SoC resources in order to keep the lowest power profile. It
+communicates with other hardware subsystems via shared memory
+and accepts requests for various resources.
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
index 000000000000..095bdef1ee6e
--- /dev/null
+++ b/drivers/interconnect/qcom/Makefile
@@ -0,0 +1 @@
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
