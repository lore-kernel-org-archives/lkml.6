Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52EDCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC5C222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437364AbfBNHrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:47:09 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44880 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437344AbfBNHq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:46:59 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 39AE2FE54CF62DD54B0F;
        Thu, 14 Feb 2019 15:46:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Feb 2019 15:46:45 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <gcherianv@gmail.com>, <pprakash@codeaurora.org>,
        <george.cherian@cavium.com>, <robert.moore@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>,
        <john.garry@huawei.com>
Subject: [PATCH v2 2/2] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
Date:   Thu, 14 Feb 2019 15:46:08 +0800
Message-ID: <1550130368-60513-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hisilicon chips do not support delivered performance counter register
and reference performance counter register. But the platform can
calculate the real performance using its own method. This patch provide
a workaround for this problem, and other platforms can also use this
workaround framework. We reuse the desired performance register to
store the real performance calculated by the platform. After the
platform finished the frequency adjust, it gets the real performance and
writes it into desired performance register. OS can use it to calculate
the real frequency.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fd25c21c..da96fec 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -33,6 +33,16 @@
 /* Offest in the DMI processor structure for the max frequency */
 #define DMI_PROCESSOR_MAX_SPEED  0x14
 
+struct cppc_workaround_info {
+	char oem_id[ACPI_OEM_ID_SIZE +1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+	unsigned int (*get_rate)(unsigned int cpu);
+};
+
+/* CPPC workaround for get_rate callback */
+unsigned int (*cppc_wa_get_rate)(unsigned int cpu);
+
 /*
  * These structs contain information parsed from per CPU
  * ACPI _CPC structures.
@@ -334,6 +344,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
 	int ret;
 
+	if (cppc_wa_get_rate)
+		return cppc_wa_get_rate(cpunum);
+
 	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
 	if (ret)
 		return ret;
@@ -357,6 +370,61 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	.name = "cppc_cpufreq",
 };
 
+/*
+ * HISI platform does not support delivered performance counter and
+ * reference performance counter. It can calculate the performance using the
+ * platform specific mechanism. We reuse the desired performance register to
+ * store the real performance calculated by the platform.
+ */
+static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpunum)
+{
+	struct cppc_cpudata *cpudata = all_cpu_data[cpunum];
+	u64 desired_perf;
+	int ret;
+
+	ret = cppc_get_desired_perf(cpunum, &desired_perf);
+	if (ret < 0)
+		return -EIO;
+
+	return cppc_cpufreq_perf_to_khz(cpudata, desired_perf);
+}
+
+static struct cppc_workaround_info wa_info[] = {
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP07   ",
+		.oem_revision	= 0,
+		.get_rate = hisi_cppc_cpufreq_get_rate,
+	}, {
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP08   ",
+		.oem_revision	= 0,
+		.get_rate = hisi_cppc_cpufreq_get_rate,
+	}
+};
+
+static int cppc_check_workaround(void)
+{
+	struct acpi_table_header *tbl;
+	acpi_status status = AE_OK;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
+	if (ACPI_FAILURE(status) || !tbl)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
+		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    wa_info[i].oem_revision == tbl->oem_revision) {
+			cppc_wa_get_rate = wa_info[i].get_rate;
+			return 0;
+		}
+	}
+
+	return -ENODEV;
+}
+
 static int __init cppc_cpufreq_init(void)
 {
 	int i, ret = 0;
@@ -386,6 +454,8 @@ static int __init cppc_cpufreq_init(void)
 		goto out;
 	}
 
+	cppc_check_workaround();
+
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
 	if (ret)
 		goto out;
-- 
1.7.12.4

