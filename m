Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FF2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96222084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96222084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbeJAQm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:42:28 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:48021 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728960AbeJAQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:42:28 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 3B3AA9892D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Oct 2018 10:05:26 +0000 (UTC)
Received: (qmail 4663 invoked from network); 1 Oct 2018 10:05:26 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPA; 1 Oct 2018 10:05:26 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Faster migration for automatic NUMA balancing
Date:   Mon,  1 Oct 2018 11:05:23 +0100
Message-Id: <20181001100525.29789-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are based on top of Srikar Dronamraju's recent work
on automatic NUMA balancing and are motivated by a bug report from Jirka
Hladky that STREAM performance has regressed.

The STREAM workload is mildly interesting in that it only works as a valid
benchmark if tasks are pinned to memory channels. Otherwise it is very
sensitive to the starting conditions of the benchmark. Recent scheduler
changes prevent prematurely spreading a workload across multiple sockets
which benefits many workloads but not STREAM. This series restores STREAM
performance without reintroducing other regressions.

The first patch removes migration rate limiting as it's expected that
automatic NUMA balancing decisions are mature enough that we do not
need the safety net. The second patch migrates pages faster early in the
lifetime of the process which has an impact if the load balancer spreads
a workload to remote nodes.

 include/linux/mmzone.h         |  6 ----
 include/trace/events/migrate.h | 27 ------------------
 kernel/sched/fair.c            | 12 +++++++-
 mm/migrate.c                   | 65 ------------------------------------------
 mm/page_alloc.c                |  2 --
 5 files changed, 11 insertions(+), 101 deletions(-)

-- 
2.16.4

