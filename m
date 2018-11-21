Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF964C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82172145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:56:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82172145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeKUO3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:29:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725982AbeKUO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:29:11 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAL3rpYj093357
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 22:56:32 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nvrs5x90w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 22:56:32 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 21 Nov 2018 03:56:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Nov 2018 03:56:27 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wAL3uQL655509052
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Nov 2018 03:56:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D9C74C04A;
        Wed, 21 Nov 2018 03:56:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D724C04E;
        Wed, 21 Nov 2018 03:56:20 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.102.2.77])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Nov 2018 03:56:19 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc:     benh@kernel.crashing.org, paulus@samba.org, ebiederm@xmission.com,
        muriloo@linux.ibm.com, christophe.leroy@c-s.fr, npiggin@gmail.com,
        leitao@debian.org, aneesh.kumar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2] Powerpc/perf: Wire up PMI throttling
Date:   Wed, 21 Nov 2018 09:26:37 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112103-0028-0000-0000-0000031E00ED
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112103-0029-0000-0000-000023DA075B
Message-Id: <20181121035637.17446-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=923 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811210034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 14c63f17b1fde ("perf: Drop sample rate when sampling is too
slow") introduced a way to throttle PMU interrupts if we're spending
too much time just processing those. Wire up powerpc PMI handler to
use this infrastructure.

We have throttling of the *rate* of interrupts, but this adds
throttling based on the *time taken* to process the interrupts.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
v1: https://lkml.org/lkml/2018/11/14/627

 arch/powerpc/perf/core-book3s.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 81f8a0c838ae..3cd2ec9c9732 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -10,6 +10,7 @@
  */
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/sched/clock.h>
 #include <linux/perf_event.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
@@ -2148,7 +2149,7 @@ static bool pmc_overflow(unsigned long val)
 /*
  * Performance monitor interrupt stuff
  */
-static void perf_event_interrupt(struct pt_regs *regs)
+static void __perf_event_interrupt(struct pt_regs *regs)
 {
 	int i, j;
 	struct cpu_hw_events *cpuhw = this_cpu_ptr(&cpu_hw_events);
@@ -2232,6 +2233,14 @@ static void perf_event_interrupt(struct pt_regs *regs)
 		irq_exit();
 }
 
+static void perf_event_interrupt(struct pt_regs *regs)
+{
+	u64 start_clock = sched_clock();
+
+	__perf_event_interrupt(regs);
+	perf_sample_event_took(sched_clock() - start_clock);
+}
+
 static int power_pmu_prepare_cpu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuhw = &per_cpu(cpu_hw_events, cpu);
-- 
2.17.1

