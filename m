Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeBLKVb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 05:21:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932868AbeBLKV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 05:21:28 -0500
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Check  negative value returned by cpufreq_table_find_index_dl()
Date: Mon, 12 Feb 2018 15:51:16 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18021210-0040-0000-0000-0000040ECC8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021210-0041-0000-0000-000026128AB1
Message-Id: <1518430876-24464-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the below Coverity warning:

*** CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
/drivers/cpufreq/powernv-cpufreq.c: 1008 in powernv_fast_switch()
1002     					unsigned int target_freq)
1003     {
1004     	int index;
1005     	struct powernv_smp_call_data freq_data;
1006
1007     	index = cpufreq_table_find_index_dl(policy, target_freq);
>>>     CID 182816:  Memory - illegal accesses  (NEGATIVE_RETURNS)
>>>     Using variable "index" as an index to array "powernv_freqs".
1008     	freq_data.pstate_id = powernv_freqs[index].driver_data;
1009     	freq_data.gpstate_id = powernv_freqs[index].driver_data;
1010     	set_pstate(&freq_data);
1011
1012     	return powernv_freqs[index].frequency;
1013     }

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 29cdec1..69edfe9 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -1005,6 +1005,9 @@ static unsigned int powernv_fast_switch(struct cpufreq_policy *policy,
 	struct powernv_smp_call_data freq_data;
 
 	index = cpufreq_table_find_index_dl(policy, target_freq);
+	if (unlikely(index < 0))
+		index = get_nominal_index();
+
 	freq_data.pstate_id = powernv_freqs[index].driver_data;
 	freq_data.gpstate_id = powernv_freqs[index].driver_data;
 	set_pstate(&freq_data);
-- 
1.8.3.1
