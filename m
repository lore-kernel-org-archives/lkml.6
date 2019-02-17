Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BFAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 03:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A021A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 03:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfBQDzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 22:55:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbfBQDzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 22:55:18 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 88BBEA1ECEB5ABB27A92;
        Sun, 17 Feb 2019 11:55:15 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Sun, 17 Feb 2019 11:55:07 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <viresh.kumar@linaro.org>, <rafael@kernel.org>,
        <gcherianv@gmail.com>, <pprakash@codeaurora.org>,
        <george.cherian@cavium.com>, <robert.moore@intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>,
        <john.garry@huawei.com>
Subject: [PATCH v3 1/2] ACPI / CPPC: Add a helper to get desired performance
Date:   Sun, 17 Feb 2019 11:54:14 +0800
Message-ID: <1550375655-58007-2-git-send-email-wangxiongfeng2@huawei.com>
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

This patch add a helper to get the value of desired performance
register.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/acpi/cppc_acpi.c | 39 +++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 217a782..231d447 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -1051,6 +1051,45 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 }
 
 /**
+ * cppc_get_desired_perf - Get the value of desired performance register.
+ * @cpunum: CPU from which to get desired performance.
+ * @desired_perf: address of a variable to store the returned desired performance
+ *
+ * Return: 0 for success, -EIO otherwise.
+ */
+int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
+{
+	struct cpc_desc *cpc_desc = per_cpu(cpc_desc_ptr, cpunum);
+	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpunum);
+	struct cpc_register_resource *desired_reg;
+	struct cppc_pcc_data *pcc_ss_data = NULL;
+
+	desired_reg = &cpc_desc->cpc_regs[DESIRED_PERF];
+
+	if (CPC_IN_PCC(desired_reg)) {
+		int ret = 0;
+
+		if (pcc_ss_id < 0)
+			return -EIO;
+		pcc_ss_data = pcc_data[pcc_ss_id];
+
+		down_write(&pcc_ss_data->pcc_lock);
+		if (send_pcc_cmd(pcc_ss_id, CMD_READ) >= 0)
+			cpc_read(cpunum, desired_reg, desired_perf);
+		else
+			ret = -EIO;
+		up_write(&pcc_ss_data->pcc_lock);
+
+		return ret;
+	}
+
+	cpc_read(cpunum, desired_reg, desired_perf);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
+
+/**
  * cppc_get_perf_caps - Get a CPUs performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
  * @perf_caps: ptr to cppc_perf_caps. See cppc_acpi.h
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index 4f34734..ba6fd72 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -137,6 +137,7 @@ struct cppc_cpudata {
 	cpumask_var_t shared_cpu_map;
 };
 
+extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
 extern int cppc_get_perf_ctrs(int cpu, struct cppc_perf_fb_ctrs *perf_fb_ctrs);
 extern int cppc_set_perf(int cpu, struct cppc_perf_ctrls *perf_ctrls);
 extern int cppc_get_perf_caps(int cpu, struct cppc_perf_caps *caps);
-- 
1.7.12.4

