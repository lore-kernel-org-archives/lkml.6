Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96371C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6069420645
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uiI6lo7t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6069420645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732373AbeJICEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731723AbeJICEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:04:45 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FEF2087D;
        Mon,  8 Oct 2018 18:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024697;
        bh=jgXt5P9C9XUqVv/rDOmnPkruqRh6JMO08LtAxHJifrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uiI6lo7tHjxqebEftQ8EabRwbe6iy/Yq9HH+PWQq/r0M4ZDZd8IefriyZb34dOyU4
         rre/M81NgJivbBbEFv5TCDBzVrRp4TkI3tyGcRMpILpOMoZNC7HXSH9jLCcx9u95Q1
         leoTFw5vBDKq94jFRLOEXQSuuv5dxaIC6jL+ON5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andre Wild <wild@linux.vnet.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rik van Riel <riel@surriel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 125/168] sched/topology: Set correct NUMA topology type
Date:   Mon,  8 Oct 2018 20:31:45 +0200
Message-Id: <20181008175624.800138207@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

[ Upstream commit e5e96fafd9028b1478b165db78c52d981c14f471 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/topology.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1295,7 +1295,7 @@ static void init_numa_topology_type(void
 
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


