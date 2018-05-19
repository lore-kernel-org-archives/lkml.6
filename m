Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbeESPhC (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 11:37:02 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36693 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752274AbeESPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 11:37:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=renzhen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T1HcYQC_1526744210;
From: Eric Ren <renzhen@linux.alibaba.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, kan.liang@intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org,
        renzhen@linux.alibaba.com
Subject: [PATCH V2] perf/x86/intel/uncore: allocate pmu index for pci device dynamically
Date: Sat, 19 May 2018 23:36:33 +0800
Message-Id: <9048d0bbe4f116532f3c4c1c3b2cdff1e2d7cd3b.1526744130.git.renzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boxes/devices of uncore are exported as pcie devices. However,
the box number is different on different micro-architecture. For
example, the max memory channels for Broadwell is up to 8. However,
there are only 2 channels for Broadwell-DE, 4 channels for Broadwell-EP,
and 8 channels for Broadwell-EX.

The current code allocates pmu index statically so that on Broadwell-EP
machine "perf list|grep uncore" shows discontinuous iMC number, which
doesn't look nice:

Test on Broadwell-EP using "ls /sys/devices | grep -i imc":

Without this patch,
    uncore_imc_0
    uncore_imc_1
    uncore_imc_4
    uncore_imc_5

To maintain pmu index dynamically, move index allocation logic to
uncore_pci_probe(). As a result, we can get continuous index of iMC
devices under /sys/devices directory:

Applied this patch:,
    uncore_imc_0
    uncore_imc_1
    uncore_imc_2
    uncore_imc_3

Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

---
Changes since v1:
1. As Kan Liang suggested, use the same coding style as the existing
   code, also better readability.

---
 arch/x86/events/intel/uncore.c | 9 ++++++++-
 arch/x86/events/intel/uncore.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a7956fc7ca1d..fb53dd2bc94a 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -818,7 +818,8 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	for (i = 0; i < type->num_boxes; i++) {
 		pmus[i].func_id	= setid ? i : -1;
-		pmus[i].pmu_idx	= i;
+		/* The pmu idx will be decided at probe for pci device. */
+		pmus[i].pmu_idx = setid ? i : -1;
 		pmus[i].type	= type;
 		pmus[i].boxes	= kzalloc(size, GFP_KERNEL);
 		if (!pmus[i].boxes)
@@ -957,6 +958,12 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (atomic_inc_return(&pmu->activeboxes) > 1)
 		return 0;
 
+	/*  Count the real number of pmus for pci uncore device */
+	if (pmu->pmu_idx < 0)
+		pmu->pmu_idx = type->num_pmus++;
+	else
+		WARN_ON_ONCE(1);
+
 	/* First active box registers the pmu */
 	ret = uncore_pmu_register(pmu);
 	if (ret) {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 414dc7e7c950..c4f54fb443e7 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -40,6 +40,7 @@ struct intel_uncore_type {
 	const char *name;
 	int num_counters;
 	int num_boxes;
+	int num_pmus; /* for pci uncore device */
 	int perf_ctr_bits;
 	int fixed_ctr_bits;
 	unsigned perf_ctr;
-- 
2.14.3 (Apple Git-98)
