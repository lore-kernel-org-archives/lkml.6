Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D49C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4432083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 10:12:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4432083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbeIGOv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:51:56 -0400
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:44065 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbeIGOv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:51:56 -0400
Received: from mail.blacknight.com (unknown [81.17.254.17])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id 650111C31F7
        for <linux-kernel@vger.kernel.org>; Fri,  7 Sep 2018 11:11:40 +0100 (IST)
Received: (qmail 19888 invoked from network); 7 Sep 2018 10:11:40 -0000
Received: from unknown (HELO stampy.163woodhaven.lan) (mgorman@techsingularity.net@[37.228.229.88])
  by 81.17.254.9 with ESMTPA; 7 Sep 2018 10:11:40 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/4] Follow-up fixes for v4.19-rc1 NUMA balancing
Date:   Fri,  7 Sep 2018 11:11:35 +0100
Message-Id: <20180907101139.20760-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar had an automatic NUMA balancing series merged during the 4.19 window
and there some issues I missed during review that this series addresses.

Patches 1-2 are simply removing redundant code and calculations that are
never used.

Patch 3 makes the observation that we can call select_idle_sibling during
NUMA placement several times for each idle CPU on a socket.  The patch
stops the search on the first idle CPU. While there is the risk that
parallel callers will stack on the same idle CPU, the current code has
the same problem.

Patch 4 is the one that needs the most examination. I believe intent of
load_too_imbalanced was to stop automatic NUMA balancing fighting the load
balancer. Unfortunately, when a machine is lightly utilised there are idle
CPUs and tasks are allowed to migrate even though the load is imbalanced.
In some cases, this limits memory bandwidth and can perform worse even if
data locality is fine. The patch corrects the condition.

If they pass review, I think it would suggest considering them a fix for
4.19 instead of deferring to 4.20.

 kernel/sched/fair.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

-- 
2.16.4

