Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeEPMCb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:02:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751786AbeEPMC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:02:28 -0400
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, ego@linux.vnet.ibm.com,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle/powernv : init all present cpus for deep states
Date: Wed, 16 May 2018 17:32:14 +0530
X-Mailer: git-send-email 2.5.5
X-TM-AS-GCONF: 00
x-cbid: 18051612-0040-0000-0000-0000043A62DB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051612-0041-0000-0000-0000263F79BD
Message-Id: <1526472134-23757-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160123
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Init all present cpus for deep states instead of "all possible" cpus.
Init fails if the possible cpu is gaurded. Resulting in making only
non-deep states available for cpuidle/hotplug.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1f12ab1..1c5d067 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -79,7 +79,7 @@ static int pnv_save_sprs_for_deep_states(void)
 	uint64_t msr_val = MSR_IDLE;
 	uint64_t psscr_val = pnv_deepest_stop_psscr_val;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		uint64_t pir = get_hard_smp_processor_id(cpu);
 		uint64_t hsprg0_val = (uint64_t)paca_ptrs[cpu];
 
@@ -814,7 +814,7 @@ static int __init pnv_init_idle_states(void)
 		int cpu;
 
 		pr_info("powernv: idle: Saving PACA pointers of all CPUs in their thread sibling PACA\n");
-		for_each_possible_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			int base_cpu = cpu_first_thread_sibling(cpu);
 			int idx = cpu_thread_in_core(cpu);
 			int i;
-- 
2.5.5
