Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E829CC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A326D20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 09:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A326D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbeLNJLp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 04:11:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727698AbeLNJLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 04:11:43 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBE99ASv134972
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:11:42 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pc5ma1j22-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:11:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <anju@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 09:11:39 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 09:11:36 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBE9BZM937617772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 09:11:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E66D4C058;
        Fri, 14 Dec 2018 09:11:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8A2314C04A;
        Fri, 14 Dec 2018 09:11:34 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.31.22])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 09:11:34 +0000 (GMT)
From:   Anju T Sudhakar <anju@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, maddy@linux.vnet.ibm.com,
        anju@linux.vnet.ibm.com
Subject: [PATCH v2 5/5] powerpc/perf: Trace imc PMU functions
Date:   Fri, 14 Dec 2018 14:41:22 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214091122.20992-1-anju@linux.vnet.ibm.com>
References: <20181214091122.20992-1-anju@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121409-4275-0000-0000-000002F0623D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121409-4276-0000-0000-000037FD9192
Message-Id: <20181214091122.20992-6-anju@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PMU functions to support trace-imc.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 175 ++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 1f09265c8fb0..32ff0e449fca 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -1120,6 +1120,173 @@ static int trace_imc_cpu_init(void)
 			  ppc_trace_imc_cpu_offline);
 }
 
+static u64 get_trace_imc_event_base_addr(void)
+{
+	return (u64)per_cpu(trace_imc_mem, smp_processor_id());
+}
+
+/*
+ * Function to parse trace-imc data obtained
+ * and to prepare the perf sample.
+ */
+static int trace_imc_prepare_sample(struct trace_imc_data *mem,
+				    struct perf_sample_data *data,
+				    u64 *prev_tb,
+				    struct perf_event_header *header,
+				    struct perf_event *event)
+{
+	/* Sanity checks for a valid record */
+	if (be64_to_cpu(READ_ONCE(mem->tb1)) > *prev_tb)
+		*prev_tb = be64_to_cpu(READ_ONCE(mem->tb1));
+	else
+		return -EINVAL;
+
+	if ((be64_to_cpu(READ_ONCE(mem->tb1)) & IMC_TRACE_RECORD_TB1_MASK) !=
+			 be64_to_cpu(READ_ONCE(mem->tb2)))
+		return -EINVAL;
+
+	/* Prepare perf sample */
+	data->ip =  be64_to_cpu(READ_ONCE(mem->ip));
+	data->period = event->hw.last_period;
+
+	header->type = PERF_RECORD_SAMPLE;
+	header->size = sizeof(*header) + event->header_size;
+	header->misc = 0;
+
+	if (is_kernel_addr(data->ip))
+		header->misc |= PERF_RECORD_MISC_KERNEL;
+	else
+		header->misc |= PERF_RECORD_MISC_USER;
+
+	perf_event_header__init_id(header, data, event);
+
+	return 0;
+}
+
+static void dump_trace_imc_data(struct perf_event *event)
+{
+	struct trace_imc_data *mem;
+	int i, ret;
+	u64 prev_tb = 0;
+
+	mem = (struct trace_imc_data *)get_trace_imc_event_base_addr();
+	for (i = 0; i < (trace_imc_mem_size / sizeof(struct trace_imc_data));
+		i++, mem++) {
+		struct perf_sample_data data;
+		struct perf_event_header header;
+
+		ret = trace_imc_prepare_sample(mem, &data, &prev_tb, &header, event);
+		if (ret) /* Exit, if not a valid record */
+			break;
+		else {
+			/* If this is a valid record, create the sample */
+			struct perf_output_handle handle;
+
+			if (perf_output_begin(&handle, event, header.size))
+				return;
+
+			perf_output_sample(&handle, &header, &data, event);
+			perf_output_end(&handle);
+		}
+	}
+}
+
+static int trace_imc_event_add(struct perf_event *event, int flags)
+{
+	/* Enable the sched_task to start the engine */
+       perf_sched_cb_inc(event->ctx->pmu);
+       return 0;
+}
+
+static void trace_imc_event_read(struct perf_event *event)
+{
+	dump_trace_imc_data(event);
+}
+
+static void trace_imc_event_stop(struct perf_event *event, int flags)
+{
+	trace_imc_event_read(event);
+}
+
+static void trace_imc_event_start(struct perf_event *event, int flags)
+{
+	return;
+}
+
+static void trace_imc_event_del(struct perf_event *event, int flags)
+{
+	perf_sched_cb_dec(event->ctx->pmu);
+}
+
+void trace_imc_pmu_sched_task(struct perf_event_context *ctx,
+				bool sched_in)
+{
+	int core_id = smp_processor_id() / threads_per_core;
+	struct imc_pmu_ref *ref;
+	u64 local_mem, ldbar_value;
+
+	/* Set trace-imc bit in ldbar and load ldbar with per-thread memory address */
+	local_mem = get_trace_imc_event_base_addr();
+	ldbar_value = ((u64)local_mem & THREAD_IMC_LDBAR_MASK) | TRACE_IMC_ENABLE;
+
+	ref = &core_imc_refc[core_id];
+	if (!ref)
+		return;
+
+	if (sched_in) {
+		mtspr(SPRN_LDBAR, ldbar_value);
+		mutex_lock(&ref->lock);
+		if (ref->refc == 0) {
+			if (opal_imc_counters_start(OPAL_IMC_COUNTERS_TRACE,
+					get_hard_smp_processor_id(smp_processor_id()))) {
+				mutex_unlock(&ref->lock);
+				pr_err("trace-imc: Unable to start the counters for core %d\n", core_id);
+				mtspr(SPRN_LDBAR, 0);
+				return;
+			}
+		}
+		++ref->refc;
+		mutex_unlock(&ref->lock);
+	} else {
+		mtspr(SPRN_LDBAR, 0);
+		mutex_lock(&ref->lock);
+		ref->refc--;
+		if (ref->refc == 0) {
+			if (opal_imc_counters_stop(OPAL_IMC_COUNTERS_TRACE,
+					get_hard_smp_processor_id(smp_processor_id()))) {
+				mutex_unlock(&ref->lock);
+				pr_err("trace-imc: Unable to stop the counters for core %d\n", core_id);
+				return;
+			}
+		} else if (ref->refc < 0) {
+			ref->refc = 0;
+		}
+		mutex_unlock(&ref->lock);
+	}
+	return;
+}
+
+static int trace_imc_event_init(struct perf_event *event)
+{
+	struct task_struct *target;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	/* Return if this is a couting event */
+	if (event->attr.sample_period == 0)
+		return -ENOENT;
+
+	event->hw.idx = -1;
+	target = event->hw.target;
+
+	event->pmu->task_ctx_nr = perf_hw_context;
+	return 0;
+}
+
 /* update_pmu_ops : Populate the appropriate operations for "pmu" */
 static int update_pmu_ops(struct imc_pmu *pmu)
 {
@@ -1149,6 +1316,14 @@ static int update_pmu_ops(struct imc_pmu *pmu)
 		pmu->pmu.cancel_txn = thread_imc_pmu_cancel_txn;
 		pmu->pmu.commit_txn = thread_imc_pmu_commit_txn;
 		break;
+	case IMC_DOMAIN_TRACE:
+		pmu->pmu.event_init = trace_imc_event_init;
+		pmu->pmu.add = trace_imc_event_add;
+		pmu->pmu.del = trace_imc_event_del;
+		pmu->pmu.start = trace_imc_event_start;
+		pmu->pmu.stop = trace_imc_event_stop;
+		pmu->pmu.read = trace_imc_event_read;
+		pmu->pmu.sched_task = trace_imc_pmu_sched_task;
 	default:
 		break;
 	}
-- 
2.17.1

