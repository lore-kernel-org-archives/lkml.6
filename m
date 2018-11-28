Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14583C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC892086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC892086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbeK2DkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:40:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38876 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728141AbeK2DkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:40:14 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wASGbpIQ063337
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:37:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p1wqguaw0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:37:56 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anju@linux.vnet.ibm.com>;
        Wed, 28 Nov 2018 16:37:48 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Nov 2018 16:37:47 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wASGbk8E15925432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Nov 2018 16:37:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A791AE056;
        Wed, 28 Nov 2018 16:37:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC536AE053;
        Wed, 28 Nov 2018 16:37:44 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.3.14])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Nov 2018 16:37:44 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        anju@linux.vnet.ibm.com
Subject: [PATCH 2/4] powerpc/perf: Rearrange setting of ldbar for thread-imc
Date:   Wed, 28 Nov 2018 22:07:33 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128163735.29607-1-anju@linux.vnet.ibm.com>
References: <20181128163735.29607-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18112816-0016-0000-0000-0000022E12ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112816-0017-0000-0000-0000328671A6
Message-Id: <20181128163735.29607-3-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDBAR holds the memory address allocated for each cpu. For thread-imc
the mode bit (i.e bit 1) of LDBAR is set to accumulation.
Currently, ldbar is loaded with per cpu memory address and mode set to
accumulation at boot time.

To enable trace-imc, the mode bit of ldbar should be set to 'trace'. So to
accommodate trace-mode of IMC, reposition setting of ldbar for thread-imc
to thread_imc_event_add(). Also reset ldbar at thread_imc_event_del().

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index f292a3f284f1..3bef46f8417d 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -806,8 +806,11 @@ static int core_imc_event_init(struct perf_event *event)
 }
 
 /*
- * Allocates a page of memory for each of the online cpus, and write the
- * physical base address of that page to the LDBAR for that cpu.
+ * Allocates a page of memory for each of the online cpus, and load
+ * LDBAR with 0.
+ * The physical base address of the page allocated for a cpu will be
+ * written to the LDBAR for that cpu, when the thread-imc event
+ * is added.
  *
  * LDBAR Register Layout:
  *
@@ -825,7 +828,7 @@ static int core_imc_event_init(struct perf_event *event)
  */
 static int thread_imc_mem_alloc(int cpu_id, int size)
 {
-	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, cpu_id);
+	u64 *local_mem = per_cpu(thread_imc_mem, cpu_id);
 	int nid = cpu_to_node(cpu_id);
 
 	if (!local_mem) {
@@ -842,9 +845,7 @@ static int thread_imc_mem_alloc(int cpu_id, int size)
 		per_cpu(thread_imc_mem, cpu_id) = local_mem;
 	}
 
-	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
-
-	mtspr(SPRN_LDBAR, ldbar_value);
+	mtspr(SPRN_LDBAR, 0);
 	return 0;
 }
 
@@ -995,6 +996,7 @@ static int thread_imc_event_add(struct perf_event *event, int flags)
 {
 	int core_id;
 	struct imc_pmu_ref *ref;
+	u64 ldbar_value, *local_mem = per_cpu(thread_imc_mem, smp_processor_id());
 
 	if (flags & PERF_EF_START)
 		imc_event_start(event, flags);
@@ -1003,6 +1005,9 @@ static int thread_imc_event_add(struct perf_event *event, int flags)
 		return -EINVAL;
 
 	core_id = smp_processor_id() / threads_per_core;
+	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | THREAD_IMC_ENABLE;
+	mtspr(SPRN_LDBAR, ldbar_value);
+
 	/*
 	 * imc pmus are enabled only when it is used.
 	 * See if this is triggered for the first time.
@@ -1034,11 +1039,7 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 	int core_id;
 	struct imc_pmu_ref *ref;
 
-	/*
-	 * Take a snapshot and calculate the delta and update
-	 * the event counter values.
-	 */
-	imc_event_update(event);
+	mtspr(SPRN_LDBAR, 0);
 
 	core_id = smp_processor_id() / threads_per_core;
 	ref = &core_imc_refc[core_id];
@@ -1057,6 +1058,11 @@ static void thread_imc_event_del(struct perf_event *event, int flags)
 		ref->refc = 0;
 	}
 	mutex_unlock(&ref->lock);
+	/*
+	 * Take a snapshot and calculate the delta and update
+	 * the event counter values.
+	 */
+	imc_event_update(event);
 }
 
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
-- 
2.17.1

