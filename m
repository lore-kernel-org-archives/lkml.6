Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C3C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CAF20866
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EkKCZB+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55CAF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbeKFCRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:22 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43414 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbeKFCRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5Gs0k6052184;
        Mon, 5 Nov 2018 16:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=gutsZD7DMWVODOwljz7ZZ5gCU9HyKt2gG0UQQPSwfmk=;
 b=EkKCZB+TXN9kcQy8IJsFm22o2vVRS07DBy+dXqp9LYMjvEMjD1joAEahNPTZWc9ZSOmz
 jLoBY+e+kYHrOU9hF9AQU0sD8MM7+F56gU6xaI1jjB5+wQay9w/jLNviOetya7zvPXch
 GCibVfJyxI31RjE3qiCendiAu8YQSsbDf/1kd+mxdw/7Yk6uo+gvyW3uKGOdZy9bGC+P
 f6AfG+cN7UIfR/20nHqSA6ODKq6Za82OnJo62+9DObtkPG1xFnY4PoV6J6fxWBtxFwsa
 K2tZ3GX/fPrk0jTT9cDkMVQmy+sUTCPp9lxtYzpdf/CQNjvcmGHo+CDYsaxjIX/IuFoV /A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2nh4aqg2cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 16:56:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuDIT022159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 16:56:13 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuCeZ010802;
        Mon, 5 Nov 2018 16:56:12 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 08:56:11 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        daniel.m.jordan@oracle.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: [RFC PATCH v4 04/13] ktask: run helper threads at MAX_NICE
Date:   Mon,  5 Nov 2018 11:55:49 -0500
Message-Id: <20181105165558.11698-5-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multithreading may speed long-running kernel tasks, but overly
optimistic parallelization can go wrong if too many helper threads are
started on an already-busy system.  Such helpers can degrade the
performance of other tasks, so they should be sensitive to current CPU
utilization[1].

To achieve this, run helpers at MAX_NICE so that their CPU time is
proportional to idle CPU time.  The main thread that called into ktask
naturally runs at its original priority so that it can make progress on
a heavily loaded system, as it would if ktask were not in the picture.

I tested two different cases in which a non-ktask and a ktask workload
compete for the same CPUs with the goal of showing that normal priority
(i.e. nice=0) ktask helpers cause the non-ktask workload to run more
slowly, whereas MAX_NICE ktask helpers don't.

Testing notes:
  - Each case was run using 8 CPUs on a large two-socket server, with a
    cpumask allowing all test threads to run anywhere within the 8.
  - The non-ktask workload used 7 threads and the ktask workload used 8
    threads to evaluate how much ktask helpers, rather than the main ktask
    thread, disturbed the non-ktask workload.
  - The non-ktask workload was started after the ktask workload and run
    for less time to maximize the chances that the non-ktask workload would
    be disturbed.
  - Runtimes in seconds.

Case 1: Synthetic, worst-case CPU contention

    ktask_test - a tight loop doing integer multiplication to max out on CPU;
                 used for testing only, does not appear in this series
    stress-ng  - cpu stressor ("-c --cpu-method ackerman --cpu-ops 1200");

                 stress-ng
                     alone  (stdev)   max_nice  (stdev)   normal_prio  (stdev)
                  ------------------------------------------------------------
    ktask_test                           96.87  ( 1.09)         90.81  ( 0.29)
    stress-ng        43.04  ( 0.00)      43.58  ( 0.01)         75.86  ( 0.39)

This case shows MAX_NICE helpers make a significant difference compared
to normal priority helpers, with stress-ng taking 76% longer to finish
when competing with normal priority ktask threads than when run by
itself, but only 1% longer when run with MAX_NICE helpers.  The 1% comes
from the small amount of CPU time MAX_NICE threads are given despite
their low priority.

Case 2: Real-world CPU contention

    ktask_vfio - VFIO page pin a 175G kvm guest
    usemem     - faults in 25G of anonymous THP per thread, PAGE_SIZE stride;
                 used to mimic the page clearing that dominates in ktask_vfio
                 so that usemem competes for the same system resources

                    usemem
                     alone  (stdev)   max_nice  (stdev)   normal_prio  (stdev)
                  ------------------------------------------------------------
    ktask_vfio                           14.74  ( 0.04)          9.93  ( 0.09)
        usemem       10.45  ( 0.04)      10.75  ( 0.04)         14.14  ( 0.07)

In the more realistic case 2, the effect is similar although not as
pronounced.  The usemem threads take 35% longer to finish with normal
priority ktask threads than when run alone, but only 3% longer when
MAX_NICE is used.

All ktask users outside of VFIO boil down to page clearing, so I imagine
the results would be similar for them.

[1] lkml.kernel.org/r/20171206143509.GG7515@dhcp22.suse.cz

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 kernel/ktask.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/ktask.c b/kernel/ktask.c
index b91c62f14dcd..72293a0f50c3 100644
--- a/kernel/ktask.c
+++ b/kernel/ktask.c
@@ -575,6 +575,18 @@ void __init ktask_init(void)
 		goto alloc_fail;
 	}
 
+	/*
+	 * All ktask worker threads have the lowest priority on the system so
+	 * they don't disturb other workloads.
+	 */
+	attrs->nice = MAX_NICE;
+
+	ret = apply_workqueue_attrs(ktask_wq, attrs);
+	if (ret != 0) {
+		pr_warn("disabled (couldn't apply attrs to ktask_wq)");
+		goto apply_fail;
+	}
+
 	attrs->no_numa = true;
 
 	ret = apply_workqueue_attrs(ktask_nonuma_wq, attrs);
-- 
2.19.1

