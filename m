Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4EFC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768AF21700
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768AF21700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeHCIKE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:10:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49486 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727836AbeHCIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:09:36 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w736EHk0033814
        for <linux-kernel@vger.kernel.org>; Fri, 3 Aug 2018 02:14:53 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmgwn9evx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 02:14:52 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 3 Aug 2018 07:14:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Aug 2018 07:14:47 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w736Ek6Q41091074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Aug 2018 06:14:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE4FEAE045;
        Fri,  3 Aug 2018 09:14:44 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73265AE04D;
        Fri,  3 Aug 2018 09:14:43 +0100 (BST)
Received: from srikart450.in.ibm.com (unknown [9.122.211.85])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Aug 2018 09:14:43 +0100 (BST)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/6] mm/migrate: Use trylock while resetting rate limit
Date:   Fri,  3 Aug 2018 11:43:57 +0530
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533276841-16341-1-git-send-email-srikar@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18080306-0020-0000-0000-000002B065A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18080306-0021-0000-0000-000020FC969B
Message-Id: <1533276841-16341-3-git-send-email-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-03_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808030068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this spinlock will only serialize migrate rate limiting,
convert the spinlock to a trylock. If another task races ahead of this task
then this task can simply move on.

While here, add correct two abnormalities.
- Avoid time being stretched for every interval.
- Use READ/WRITE_ONCE with next window.

specjbb2005 / bops/JVM / higher bops are better
on 2 Socket/2 Node Intel
JVMS  Prev    Current  %Change
4     206350  200892   -2.64502
1     319963  325766   1.81365


on 2 Socket/2 Node Power9 (PowerNV)
JVMS  Prev    Current  %Change
4     186539  190261   1.99529
1     220344  195305   -11.3636


on 4 Socket/4 Node Power7
JVMS  Prev    Current  %Change
8     56836   57651.1  1.43413
1     112970  111351   -1.43312


dbench / transactions / higher numbers are better
on 2 Socket/2 Node Intel
count  Min      Max      Avg      Variance  %Change
5      13136.1  13170.2  13150.2  14.7482
5      12254.7  12331.9  12297.8  28.1846   -6.48203


on 2 Socket/4 Node Power8 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      4319.79  4998.19  4836.53  261.109
5      4997.83  5030.14  5015.54  12.947    3.70121


on 2 Socket/2 Node Power9 (PowerNV)
count  Min      Max      Avg      Variance  %Change
5      9325.56  9402.7   9362.49  25.9638
5      9331.84  9375.11  9352.04  16.0703   -0.111616


on 4 Socket/4 Node Power7
count  Min      Max      Avg      Variance  %Change
5      132.581  191.072  170.554  21.6444
5      147.55   181.605  168.963  11.3513   -0.932842

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
Changelog v1->v2:
Fix stretch every interval pointed by Peter Zijlstra.
Verified that some of the regression is due to fixing interval stretch.

 mm/migrate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 8c0af0f..dbc2cb7 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1868,16 +1868,24 @@ static struct page *alloc_misplaced_dst_page(struct page *page,
 static bool numamigrate_update_ratelimit(pg_data_t *pgdat,
 					unsigned long nr_pages)
 {
+	unsigned long next_window, interval;
+
+	next_window = READ_ONCE(pgdat->numabalancing_migrate_next_window);
+	interval = msecs_to_jiffies(migrate_interval_millisecs);
+
 	/*
 	 * Rate-limit the amount of data that is being migrated to a node.
 	 * Optimal placement is no good if the memory bus is saturated and
 	 * all the time is being spent migrating!
 	 */
-	if (time_after(jiffies, next_window)) {
-		spin_lock(&pgdat->numabalancing_migrate_lock);
+	if (time_after(jiffies, next_window) &&
+			spin_trylock(&pgdat->numabalancing_migrate_lock)) {
 		pgdat->numabalancing_migrate_nr_pages = 0;
-		pgdat->numabalancing_migrate_next_window = jiffies +
-			msecs_to_jiffies(migrate_interval_millisecs);
+		do {
+			next_window += interval;
+		} while (unlikely(time_after(jiffies, next_window)));
+
+		WRITE_ONCE(pgdat->numabalancing_migrate_next_window, next_window);
 		spin_unlock(&pgdat->numabalancing_migrate_lock);
 	}
 	if (pgdat->numabalancing_migrate_nr_pages > ratelimit_pages) {
-- 
1.8.3.1

