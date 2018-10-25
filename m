Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24B2C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A9220665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A9220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJZDQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:16:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727428AbeJZDQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:16:38 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PIYRG1118794
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:42:43 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nbh5be05m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:42:42 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 25 Oct 2018 19:42:41 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 19:42:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9PIgZil20250700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 18:42:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 825B2A4040;
        Thu, 25 Oct 2018 18:42:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51E99A404D;
        Thu, 25 Oct 2018 18:42:33 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.102.3.165])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Oct 2018 18:42:33 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3 2/3] sched/core: Don't mix isolcpus and housekeeping CPUs
Date:   Fri, 26 Oct 2018 00:12:22 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540492943-17147-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1540492943-17147-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18102518-0008-0000-0000-00000285B77B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102518-0009-0000-0000-000021EFBEC7
Message-Id: <1540492943-17147-3-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load balancer and NUMA balancer are not suppose to work on isolcpus.

Currently when setting cpus_allowed for a task, there are no checks to see
if the requested cpumask has CPUs from both isolcpus and housekeeping CPUs.

If user passes a mix of isolcpus and housekeeping CPUs, then NUMA balancer
can pick a isolcpu to schedule.  With this change, if a combination of
isolcpus and housekeeping CPUs are provided, then we restrict it to
housekeeping CPUs only.

For example: System with 32 CPUs
$ grep -o "isolcpus=[,,1-9]*" /proc/cmdline
isolcpus=1,5,9,13
$ grep -i cpus_allowed /proc/$$/status
Cpus_allowed:   ffffdddd
Cpus_allowed_list:      0,2-4,6-8,10-12,14-31

Running "perf bench numa mem --no-data_rand_walk -p 4 -t 8 -G 0 -P 3072
-T 0 -l 50 -c -s 1000" which  calls sched_setaffinity to all CPUs in
system.

Without patch
------------
$ for i in $(pgrep -f perf); do  grep -i cpus_allowed_list  /proc/$i/task/*/status ; done | head -n 10
Cpus_allowed_list:      0,2-4,6-8,10-12,14-31
/proc/2107/task/2107/status:Cpus_allowed_list:  0-31
/proc/2107/task/2196/status:Cpus_allowed_list:  0-31
/proc/2107/task/2197/status:Cpus_allowed_list:  0-31
/proc/2107/task/2198/status:Cpus_allowed_list:  0-31
/proc/2107/task/2199/status:Cpus_allowed_list:  0-31
/proc/2107/task/2200/status:Cpus_allowed_list:  0-31
/proc/2107/task/2201/status:Cpus_allowed_list:  0-31
/proc/2107/task/2202/status:Cpus_allowed_list:  0-31
/proc/2107/task/2203/status:Cpus_allowed_list:  0-31

With patch
----------
$ for i in $(pgrep -f perf); do  grep -i cpus_allowed_list  /proc/$i/task/*/status ; done | head -n 10
Cpus_allowed_list:      0,2-4,6-8,10-12,14-31
/proc/18591/task/18591/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18603/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18604/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18605/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18606/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18607/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18608/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18609/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31
/proc/18591/task/18610/status:Cpus_allowed_list:        0,2-4,6-8,10-12,14-31

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v2->v3:
The actual detection is moved to set_cpus_allowed_common from
sched_setaffinity. This helps to solve all cases where task cpus_allowed is
set.

 kernel/sched/core.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3064e0f..37e62b8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1003,7 +1003,19 @@ static int migration_cpu_stop(void *data)
  */
 void set_cpus_allowed_common(struct task_struct *p, const struct cpumask *new_mask)
 {
-	cpumask_copy(&p->cpus_allowed, new_mask);
+	const struct cpumask *hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
+
+	/*
+	 * If the cpumask provided has CPUs that are part of isolated and
+	 * housekeeping_cpumask, then restrict it to just the CPUs that
+	 * are part of the housekeeping_cpumask.
+	 */
+	if (!cpumask_subset(new_mask, hk_mask) &&
+			cpumask_intersects(new_mask, hk_mask))
+		cpumask_and(&p->cpus_allowed, new_mask, hk_mask);
+	else
+		cpumask_copy(&p->cpus_allowed, new_mask);
+
 	p->nr_cpus_allowed = cpumask_weight(new_mask);
 }
 
-- 
1.8.3.1

