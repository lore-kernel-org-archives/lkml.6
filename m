Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A218AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588952088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588952088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbeGYPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:37:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33409 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbeGYPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:37:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PEOssA402025
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 07:24:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PEOsQD402022;
        Wed, 25 Jul 2018 07:24:54 -0700
Date:   Wed, 25 Jul 2018 07:24:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-5f95ba7a43057f28a349ea1f03ee8d04e0f445ea@git.kernel.org>
Cc:     mgorman@techsingularity.net, torvalds@linux-foundation.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        srikar@linux.vnet.ibm.com, riel@surriel.com, tglx@linutronix.de,
        hpa@zytor.com, peterz@infradead.org
Reply-To: peterz@infradead.org, hpa@zytor.com, srikar@linux.vnet.ibm.com,
          tglx@linutronix.de, riel@surriel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          mgorman@techsingularity.net, torvalds@linux-foundation.org
In-Reply-To: <1529514181-9842-4-git-send-email-srikar@linux.vnet.ibm.com>
References: <1529514181-9842-4-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/numa: Simplify load_too_imbalanced()
Git-Commit-ID: 5f95ba7a43057f28a349ea1f03ee8d04e0f445ea
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  5f95ba7a43057f28a349ea1f03ee8d04e0f445ea
Gitweb:     https://git.kernel.org/tip/5f95ba7a43057f28a349ea1f03ee8d04e0f445ea
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Wed, 20 Jun 2018 22:32:44 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 25 Jul 2018 11:41:06 +0200

sched/numa: Simplify load_too_imbalanced()

Currently load_too_imbalance() cares about the slope of imbalance.
It doesn't care of the direction of the imbalance.

However this may not work if nodes that are being compared have
dissimilar capacities. Few nodes might have more cores than other nodes
in the system. Also unlike traditional load balance at a NUMA sched
domain, multiple requests to migrate from the same source node to same
destination node may run in parallel. This can cause huge load
imbalance. This is specially true on a larger machines with either large
cores per node or more number of nodes in the system. Hence allow
move/swap only if the imbalance is going to reduce.

Running SPECjbb2005 on a 4 node machine and comparing bops/JVM
JVMS  LAST_PATCH  WITH_PATCH  %CHANGE
16    25058.2     25122.9     0.25
1     72950       73850       1.23

(numbers from v1 based on v4.17-rc5)
Testcase       Time:         Min         Max         Avg      StdDev
numa01.sh      Real:      516.14      892.41      739.84      151.32
numa01.sh       Sys:      153.16      192.99      177.70       14.58
numa01.sh      User:    39821.04    69528.92    57193.87    10989.48
numa02.sh      Real:       60.91       62.35       61.58        0.63
numa02.sh       Sys:       16.47       26.16       21.20        3.85
numa02.sh      User:     5227.58     5309.61     5265.17       31.04
numa03.sh      Real:      739.07      917.73      795.75       64.45
numa03.sh       Sys:       94.46      136.08      109.48       14.58
numa03.sh      User:    57478.56    72014.09    61764.48     5343.69
numa04.sh      Real:      442.61      715.43      530.31       96.12
numa04.sh       Sys:      224.90      348.63      285.61       48.83
numa04.sh      User:    35836.84    47522.47    40235.41     3985.26
numa05.sh      Real:      386.13      489.17      434.94       43.59
numa05.sh       Sys:      144.29      438.56      278.80      105.78
numa05.sh      User:    33255.86    36890.82    34879.31     1641.98

Testcase       Time:         Min         Max         Avg      StdDev 	 %Change
numa01.sh      Real:      435.78      653.81      534.58       83.20 	 38.39%
numa01.sh       Sys:      121.93      187.18      145.90       23.47 	 21.79%
numa01.sh      User:    37082.81    51402.80    43647.60     5409.75 	 31.03%
numa02.sh      Real:       60.64       61.63       61.19        0.40 	 0.637%
numa02.sh       Sys:       14.72       25.68       19.06        4.03 	 11.22%
numa02.sh      User:     5210.95     5266.69     5233.30       20.82 	 0.608%
numa03.sh      Real:      746.51      808.24      780.36       23.88 	 1.972%
numa03.sh       Sys:       97.26      108.48      105.07        4.28 	 4.197%
numa03.sh      User:    58956.30    61397.05    60162.95     1050.82 	 2.661%
numa04.sh      Real:      465.97      519.27      484.81       19.62 	 9.385%
numa04.sh       Sys:      304.43      359.08      334.68       20.64 	 -14.6%
numa04.sh      User:    37544.16    41186.15    39262.44     1314.91 	 2.478%
numa05.sh      Real:      411.57      457.20      433.29       16.58 	 0.380%
numa05.sh       Sys:      230.05      435.48      339.95       67.58 	 -17.9%
numa05.sh      User:    33325.54    36896.31    35637.84     1222.64 	 -2.12%

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1529514181-9842-4-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b10e0663a49e..226837960ec0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1546,28 +1546,12 @@ static bool load_too_imbalanced(long src_load, long dst_load,
 	src_capacity = env->src_stats.compute_capacity;
 	dst_capacity = env->dst_stats.compute_capacity;
 
-	/* We care about the slope of the imbalance, not the direction. */
-	if (dst_load < src_load)
-		swap(dst_load, src_load);
-
-	/* Is the difference below the threshold? */
-	imb = dst_load * src_capacity * 100 -
-	      src_load * dst_capacity * env->imbalance_pct;
-	if (imb <= 0)
-		return false;
+	imb = abs(dst_load * src_capacity - src_load * dst_capacity);
 
-	/*
-	 * The imbalance is above the allowed threshold.
-	 * Compare it with the old imbalance.
-	 */
 	orig_src_load = env->src_stats.load;
 	orig_dst_load = env->dst_stats.load;
 
-	if (orig_dst_load < orig_src_load)
-		swap(orig_dst_load, orig_src_load);
-
-	old_imb = orig_dst_load * src_capacity * 100 -
-		  orig_src_load * dst_capacity * env->imbalance_pct;
+	old_imb = abs(orig_dst_load * src_capacity - orig_src_load * dst_capacity);
 
 	/* Would this change make things worse? */
 	return (imb > old_imb);
