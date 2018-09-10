Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE696C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1BFD20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1BFD20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeIJPAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:00:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52925 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbeIJPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:00:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AA6Bdj1806869
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:06:11 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AA697p1806859;
        Mon, 10 Sep 2018 03:06:09 -0700
Date:   Mon, 10 Sep 2018 03:06:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Srikar Dronamraju <tipbot@zytor.com>
Message-ID: <tip-e5e96fafd9028b1478b165db78c52d981c14f471@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        torvalds@linux-foundation.org, wild@linux.vnet.ibm.com,
        suravee.suthikulpanit@amd.com, hpa@zytor.com, mingo@kernel.org,
        mpe@ellerman.id.au, heiko.carstens@de.ibm.com, tglx@linutronix.de,
        peterz@infradead.org, riel@surriel.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net
Reply-To: mingo@kernel.org, hpa@zytor.com, suravee.suthikulpanit@amd.com,
          torvalds@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
          wild@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          srikar@linux.vnet.ibm.com, mgorman@techsingularity.net,
          riel@surriel.com, peterz@infradead.org, tglx@linutronix.de,
          heiko.carstens@de.ibm.com, mpe@ellerman.id.au
In-Reply-To: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Set correct NUMA topology type
Git-Commit-ID: e5e96fafd9028b1478b165db78c52d981c14f471
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

Commit-ID:  e5e96fafd9028b1478b165db78c52d981c14f471
Gitweb:     https://git.kernel.org/tip/e5e96fafd9028b1478b165db78c52d981c14f471
Author:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
AuthorDate: Fri, 10 Aug 2018 22:30:18 +0530
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:13:45 +0200

sched/topology: Set correct NUMA topology type

With the following commit:

  051f3ca02e46 ("sched/topology: Introduce NUMA identity node sched domain")

the scheduler introduced a new NUMA level. However this leads to the NUMA topology
on 2 node systems to not be marked as NUMA_DIRECT anymore.

After this commit, it gets reported as NUMA_BACKPLANE, because
sched_domains_numa_level is now 2 on 2 node systems.

Fix this by allowing setting systems that have up to 2 NUMA levels as
NUMA_DIRECT.

While here remove code that assumes that level can be 0.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andre Wild <wild@linux.vnet.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Fixes: 051f3ca02e46 "Introduce NUMA identity node sched domain"
Link: http://lkml.kernel.org/r/1533920419-17410-1-git-send-email-srikar@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/topology.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 56a0fed30c0a..505a41c42b96 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1295,7 +1295,7 @@ static void init_numa_topology_type(void)
 
 	n = sched_max_numa_distance;
 
-	if (sched_domains_numa_levels <= 1) {
+	if (sched_domains_numa_levels <= 2) {
 		sched_numa_topology_type = NUMA_DIRECT;
 		return;
 	}
@@ -1380,9 +1380,6 @@ void sched_init_numa(void)
 			break;
 	}
 
-	if (!level)
-		return;
-
 	/*
 	 * 'level' contains the number of unique distances
 	 *
