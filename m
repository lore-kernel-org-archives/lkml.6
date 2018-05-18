Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbeERFYh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 01:24:37 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51455 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750763AbeERFYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 01:24:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=renzhen@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T1Coz38_1526621058;
From: Eric Ren <renzhen@linux.alibaba.com>
To: x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, kan.liang@intel.com,
        ak@linux.intel.com, linux-kernel@vger.kernel.org,
        renzhen@linux.alibaba.com
Subject: [PATCH] perf/x86/intel/uncore: allocate pmu index for pci device dynamically
Date: Fri, 18 May 2018 13:23:59 +0800
Message-Id: <20180518052359.48756-1-renzhen@linux.alibaba.com>
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
---
 arch/x86/events/intel/uncore.c | 7 ++++++-
 arch/x86/events/intel/uncore.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a7956fc..88d390e 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -818,7 +818,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
 
 	for (i = 0; i < type->num_boxes; i++) {
 		pmus[i].func_id	= setid ? i : -1;
-		pmus[i].pmu_idx	= i;
+		/* The pmu idx will be decided at probe for pci device. */
+		if (setid)
+			pmus[i].pmu_idx	= i;
 		pmus[i].type	= type;
 		pmus[i].boxes	= kzalloc(size, GFP_KERNEL);
 		if (!pmus[i].boxes)
@@ -957,6 +959,9 @@ static int uncore_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (atomic_inc_return(&pmu->activeboxes) > 1)
 		return 0;
 
+	/*  Count the real number of pmus for pci uncore device */
+	pmu->pmu_idx = type->num_pmus++;
+
 	/* First active box registers the pmu */
 	ret = uncore_pmu_register(pmu);
 	if (ret) {
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 414dc7e..c4f54fb 100644
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
1.8.3.1
