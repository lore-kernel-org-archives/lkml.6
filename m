Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA30C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BD52082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BD52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbeJXL3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:29:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725896AbeJXL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:29:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9O2sYb7068339
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 23:03:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nae49ncxs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 23:03:00 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 24 Oct 2018 04:02:58 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 24 Oct 2018 04:02:55 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9O32sVF37879950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Oct 2018 03:02:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 398FA11C050;
        Wed, 24 Oct 2018 03:02:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B10D11C054;
        Wed, 24 Oct 2018 03:02:52 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.199.52.124])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Oct 2018 03:02:51 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Yi Wang <wang.yi59@zte.com.cn>, zhong.weidong@zte.com.cn,
        Yi Liu <liu.yi24@zte.com.cn>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2] sched/core: Don't mix isolcpus and housekeeping CPUs
Date:   Wed, 24 Oct 2018 08:32:49 +0530
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18102403-0016-0000-0000-000002183C96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102403-0017-0000-0000-000032704ACE
Message-Id: <1540350169-18581-1-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810240024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load balancer and NUMA balancer are not suppose to work on isolcpus.

Currently when setting sched affinity, there are no checks to see if the
requested cpumask has CPUs from both isolcpus and housekeeping CPUs.

If user passes a mix of isolcpus and housekeeping CPUs, then
NUMA balancer can pick a isolcpu to schedule.
With this change, if a combination of isolcpus and housekeeping CPUs are
provided, then we restrict ourselves to housekeeping CPUs.

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
Changelog v1->v2:
 constification of hk_mask (reported by kbuild test robot)

 kernel/sched/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad97f3b..54e7207 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4734,6 +4734,7 @@ static int sched_read_attr(struct sched_attr __user *uattr,
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	cpumask_var_t cpus_allowed, new_mask;
+	const struct cpumask *hk_mask;
 	struct task_struct *p;
 	int retval;
 
@@ -4778,6 +4779,19 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 
 	cpuset_cpus_allowed(p, cpus_allowed);
 	cpumask_and(new_mask, in_mask, cpus_allowed);
+	hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
+
+	/*
+	 * If the cpumask provided has CPUs that are part of isolated and
+	 * housekeeping_cpumask, then restrict it to just the CPUs that
+	 * are part of the housekeeping_cpumask.
+	 */
+	if (!cpumask_subset(new_mask, hk_mask) &&
+			cpumask_intersects(new_mask, hk_mask)) {
+		pr_info("pid %d: Mix of isolcpus and non-isolcpus provided\n",
+			       p->pid);
+		cpumask_and(new_mask, new_mask, hk_mask);
+	}
 
 	/*
 	 * Since bandwidth control happens on root_domain basis,
-- 
1.8.3.1

