Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F205DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57F920665
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C57F920665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbeJZDQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:16:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727428AbeJZDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:16:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PIYQ14094417
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:42:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nbg1csrcc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 14:42:37 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 25 Oct 2018 19:42:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 19:42:33 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9PIgW1025100422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 18:42:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED81AA405B;
        Thu, 25 Oct 2018 18:42:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECEE7A4057;
        Thu, 25 Oct 2018 18:42:29 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.102.3.165])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Oct 2018 18:42:29 +0000 (GMT)
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
Subject: [PATCH v3 1/3] sched/core: Warn if cpumask has a mix of isolcpus and housekeeping CPUs
Date:   Fri, 26 Oct 2018 00:12:21 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540492943-17147-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1540492943-17147-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18102518-0020-0000-0000-000002DA42C7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102518-0021-0000-0000-000021297797
Message-Id: <1540492943-17147-2-git-send-email-srikar@linux.vnet.ibm.com>
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

Currently when setting sched affinity, there are no checks to see if the
requested cpumask has CPUs from both isolcpus and housekeeping CPUs.
Mixing of isolcpus and housekeeping CPUs may lead to inconsistent
behaviours like tasks running on isolcpus with no load balancing.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v2->v3:
Only a warning in sched_setaffinity. The actual detection is moved to
set_cpus_allowed_common.

 kernel/sched/core.c | 11 +++++++++++

 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ad97f3b..3064e0f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4734,6 +4734,7 @@ static int sched_read_attr(struct sched_attr __user *uattr,
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
 	cpumask_var_t cpus_allowed, new_mask;
+	const struct cpumask *hk_mask;
 	struct task_struct *p;
 	int retval;
 
@@ -4778,6 +4779,16 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 
 	cpuset_cpus_allowed(p, cpus_allowed);
 	cpumask_and(new_mask, in_mask, cpus_allowed);
+	hk_mask = housekeeping_cpumask(HK_FLAG_DOMAIN);
+
+	/*
+	 * Warn if the cpumask provided has CPUs that are part of isolated and
+	 * housekeeping_cpumask
+	 */
+	if (!cpumask_subset(new_mask, hk_mask) &&
+			cpumask_intersects(new_mask, hk_mask))
+		pr_warn("pid %d: Mix of isolcpus and non-isolcpus provided\n",
+			p->pid);
 
 	/*
 	 * Since bandwidth control happens on root_domain basis,
-- 
1.8.3.1

