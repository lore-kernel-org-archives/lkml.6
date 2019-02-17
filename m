Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1577C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 03:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996BE21B69
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 03:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfBQDzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 22:55:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727723AbfBQDzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 22:55:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 83BDC6C44685C937A2C7;
        Sun, 17 Feb 2019 11:55:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 17 Feb 2019 11:55:08 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <gcherianv@gmail.com>, <pprakash@codeaurora.org>,
        <george.cherian@cavium.com>, <robert.moore@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>,
        <john.garry@huawei.com>
Subject: [PATCH v3 2/2] cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
Date:   Sun, 17 Feb 2019 11:54:15 +0800
Message-ID: <1550375655-58007-3-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
References: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
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
calculate the real performance using its own method. We reuse the
desired performance register to store the real performance calculated by
the platform. After the platform finished the frequency adjust, it gets
the real performance and writes it into desired performance register. Os
can use it to calculate the real frequency.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index fd25c21c..efc0298 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -42,6 +42,67 @@
  */
 static struct cppc_cpudata **all_cpu_data;
 
+struct cppc_workaround_oem_info {
+	char oem_id[ACPI_OEM_ID_SIZE +1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+};
+
+static bool apply_hisi_workaround;
+
+static struct cppc_workaround_oem_info wa_info[] = {
+	{
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP07   ",
+		.oem_revision	= 0,
+	}, {
+		.oem_id		= "HISI  ",
+		.oem_table_id	= "HIP08   ",
+		.oem_revision	= 0,
+	}
+};
+
+static unsigned int cppc_cpufreq_perf_to_khz(struct cppc_cpudata *cpu,
+					unsigned int perf);
+
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
+static void cppc_check_hisi_workaround(void)
+{
+	struct acpi_table_header *tbl;
+	acpi_status status = AE_OK;
+	int i;
+
+	status = acpi_get_table(ACPI_SIG_PCCT, 0, &tbl);
+	if (ACPI_FAILURE(status) || !tbl)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(wa_info); i++) {
+		if (!memcmp(wa_info[i].oem_id, tbl->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(wa_info[i].oem_table_id, tbl->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    wa_info[i].oem_revision == tbl->oem_revision) {
+			apply_hisi_workaround = true;
+		}
+	}
+}
+
 /* Callback function used to retrieve the max frequency from DMI */
 static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
 {
@@ -334,6 +395,9 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpunum)
 	struct cppc_cpudata *cpu = all_cpu_data[cpunum];
 	int ret;
 
+	if (apply_hisi_workaround)
+		return hisi_cppc_cpufreq_get_rate(cpunum);
+
 	ret = cppc_get_perf_ctrs(cpunum, &fb_ctrs_t0);
 	if (ret)
 		return ret;
@@ -386,6 +450,8 @@ static int __init cppc_cpufreq_init(void)
 		goto out;
 	}
 
+	cppc_check_hisi_workaround();
+
 	ret = cpufreq_register_driver(&cppc_cpufreq_driver);
 	if (ret)
 		goto out;
-- 
1.7.12.4

