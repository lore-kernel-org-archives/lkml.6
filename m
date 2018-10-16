Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D233AC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958C02089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 12:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958C02089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeJPUlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 16:41:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727229AbeJPUlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 16:41:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E3AC1B4B1B353;
        Tue, 16 Oct 2018 20:51:24 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.399.0; Tue, 16 Oct 2018 20:51:18 +0800
From:   Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To:     <lorenzo.pieralisi@arm.com>, <robin.murphy@arm.com>,
        <jean-philippe.brucker@arm.com>
CC:     <will.deacon@arm.com>, <mark.rutland@arm.com>,
        <guohanjun@huawei.com>, <john.garry@huawei.com>,
        <pabba@codeaurora.org>, <vkilari@codeaurora.org>,
        <rruigrok@codeaurora.org>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <neil.m.leeder@gmail.com>
Subject: [PATCH v4 4/4] perf/smmuv3_pmu: Enable HiSilicon Erratum 162001800 quirk
Date:   Tue, 16 Oct 2018 13:49:20 +0100
Message-ID: <20181016124920.24708-5-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20181016124920.24708-1-shameerali.kolothum.thodi@huawei.com>
References: <20181016124920.24708-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HiSilicon erratum 162001800 describes the limitation of
SMMUv3 PMCG implementation on HiSilicon Hip08 platforms.

On these platforms, the PMCG event counter registers
(SMMU_PMCG_EVCNTRn) are read only and as a result it is
not possible to set the initial counter period value on
event monitor start.

To work around this, the current value of the counter is
read and is used for delta calculations. This increases
the possibility of reporting incorrect values if counter
overflow happens and counter passes the initial value.

OEM information from ACPI header is used to identify the
affected hardware platform.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 137 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 130 insertions(+), 7 deletions(-)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index d927ef8..519545e 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -96,6 +96,8 @@
 
 #define SMMU_PA_SHIFT                   12
 
+#define SMMU_PMU_OPT_EVCNTR_RDONLY	(1 << 0)
+
 static int cpuhp_state_num;
 
 struct smmu_pmu {
@@ -111,10 +113,55 @@ struct smmu_pmu {
 	struct device *dev;
 	void __iomem *reg_base;
 	void __iomem *reloc_base;
+	u32 options;
 	u64 counter_present_mask;
 	u64 counter_mask;
 };
 
+struct erratum_acpi_oem_info {
+	char oem_id[ACPI_OEM_ID_SIZE + 1];
+	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
+	u32 oem_revision;
+};
+
+static struct erratum_acpi_oem_info hisi_162001800_oem_info[] = {
+	/*
+	 * Note that trailing spaces are required to properly match
+	 * the OEM table information.
+	 */
+	{
+		.oem_id         = "HISI  ",
+		.oem_table_id   = "HIP08   ",
+		.oem_revision   = 0,
+	},
+	{ /* Sentinel indicating the end of the OEM array */ },
+};
+
+enum smmu_pmu_erratum_match_type {
+	se_match_acpi_oem,
+};
+
+void hisi_erratum_evcntr_rdonly(struct smmu_pmu *smmu_pmu)
+{
+	smmu_pmu->options |= SMMU_PMU_OPT_EVCNTR_RDONLY;
+}
+
+struct smmu_pmu_erratum_wa {
+	enum smmu_pmu_erratum_match_type match_type;
+	const void *id;	/* Indicate the Erratum ID */
+	const char *desc_str;
+	void (*enable)(struct smmu_pmu *smmu_pmu);
+};
+
+static const struct smmu_pmu_erratum_wa smmu_pmu_wa[] = {
+	{
+		.match_type = se_match_acpi_oem,
+		.id = hisi_162001800_oem_info,
+		.desc_str = "HiSilicon erratum 162001800",
+		.enable = hisi_erratum_evcntr_rdonly,
+	},
+};
+
 #define to_smmu_pmu(p) (container_of(p, struct smmu_pmu, pmu))
 
 #define SMMU_PMU_EVENT_ATTR_EXTRACTOR(_name, _config, _start, _end)        \
@@ -224,15 +271,20 @@ static void smmu_pmu_set_period(struct smmu_pmu *smmu_pmu,
 	u32 idx = hwc->idx;
 	u64 new;
 
-	/*
-	 * We limit the max period to half the max counter value of the counter
-	 * size, so that even in the case of extreme interrupt latency the
-	 * counter will (hopefully) not wrap past its initial value.
-	 */
-	new = smmu_pmu->counter_mask >> 1;
+	if (smmu_pmu->options & SMMU_PMU_OPT_EVCNTR_RDONLY) {
+		new = smmu_pmu_counter_get_value(smmu_pmu, idx);
+	} else {
+		/*
+		 * We limit the max period to half the max counter value
+		 * of the counter size, so that even in the case of extreme
+		 * interrupt latency the counter will (hopefully) not wrap
+		 * past its initial value.
+		 */
+		new = smmu_pmu->counter_mask >> 1;
+		smmu_pmu_counter_set_value(smmu_pmu, idx, new);
+	}
 
 	local64_set(&hwc->prev_count, new);
-	smmu_pmu_counter_set_value(smmu_pmu, idx, new);
 }
 
 static void smmu_pmu_get_event_filter(struct perf_event *event, u32 *span,
@@ -670,6 +722,69 @@ static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
 		       smmu_pmu->reloc_base + SMMU_PMCG_OVSCLR0);
 }
 
+typedef bool (*se_match_fn_t)(const struct smmu_pmu_erratum_wa *,
+			      const void *);
+
+bool smmu_pmu_check_acpi_erratum(const struct smmu_pmu_erratum_wa *wa,
+				const void *arg)
+{
+	static const struct erratum_acpi_oem_info empty_oem_info = {};
+	const struct erratum_acpi_oem_info *info = wa->id;
+	const struct acpi_table_header *hdr = arg;
+
+	/* Iterate over the ACPI OEM info array, looking for a match */
+	while (memcmp(info, &empty_oem_info, sizeof(*info))) {
+		if (!memcmp(info->oem_id, hdr->oem_id, ACPI_OEM_ID_SIZE) &&
+		    !memcmp(info->oem_table_id, hdr->oem_table_id, ACPI_OEM_TABLE_ID_SIZE) &&
+		    info->oem_revision == hdr->oem_revision)
+			return true;
+
+		info++;
+	}
+
+	return false;
+
+}
+
+static void smmu_pmu_enable_errata(struct smmu_pmu *smmu_pmu,
+				enum smmu_pmu_erratum_match_type type,
+				se_match_fn_t match_fn,
+				void *arg)
+{
+	const struct smmu_pmu_erratum_wa *wa = smmu_pmu_wa;
+
+	for (; wa->desc_str; wa++) {
+		if (wa->match_type != type)
+			continue;
+
+		if (match_fn(wa, arg)) {
+			if (wa->enable) {
+				wa->enable(smmu_pmu);
+				dev_info(smmu_pmu->dev,
+					"Enabling workaround for %s\n",
+					 wa->desc_str);
+			}
+		}
+	}
+}
+
+static void smmu_pmu_check_workarounds(struct smmu_pmu *smmu_pmu,
+				  enum smmu_pmu_erratum_match_type type,
+				  void *arg)
+{
+	se_match_fn_t match_fn = NULL;
+
+	switch (type) {
+	case se_match_acpi_oem:
+		match_fn = smmu_pmu_check_acpi_erratum;
+		break;
+	default:
+		return;
+	}
+
+	smmu_pmu_enable_errata(smmu_pmu, type, match_fn, arg);
+}
+
 static int smmu_pmu_probe(struct platform_device *pdev)
 {
 	struct smmu_pmu *smmu_pmu;
@@ -678,6 +793,7 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 	u64 ceid_64[2];
 	int irq, err;
 	char *name;
+	struct acpi_table_header *table;
 	struct device *dev = &pdev->dev;
 
 	smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu), GFP_KERNEL);
@@ -749,6 +865,13 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (ACPI_FAILURE(acpi_get_table(ACPI_SIG_IORT, 0, &table))) {
+		dev_err(dev, "IORT get failed, PMU @%pa\n", &res_0->start);
+		return -EINVAL;
+	}
+
+	smmu_pmu_check_workarounds(smmu_pmu, se_match_acpi_oem, table);
+
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = get_cpu();
 	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
-- 
2.7.4


