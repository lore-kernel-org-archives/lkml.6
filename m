Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3722086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 09:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JZa2KT7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeLQJya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 04:54:30 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:40906 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbeLQJya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 04:54:30 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 65D1210C10C8;
        Mon, 17 Dec 2018 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1545040469; bh=YHaOX3TXlGzwqXkDu6KQt5ukWm2yD2rBTZVbL5xobGs=;
        h=From:To:Cc:Subject:Date:From;
        b=JZa2KT7L0IDySSjAaVbDl1XugwvDKDJvUAaHbCqqmDsnZS99pSaiL1qBtZ4qLC6M4
         Dqe2XUE6JKeKbNyHqvHthBhJBjuHH9JBaBbr2O2Dt8DPBcXcllnjMQ5RMFuRenDici
         oOgICo3YKxJVDPn4o5ntoTg/xpwlm17yBZrtcViibq685vf8hoi/cJE3RgkeGc+mwK
         Ub4LPjAj0cqmrwVDbGVIn7OFlkG352VLmhlzVw7LI1bFIkTtJEaoD+xr6H6v8mAgt7
         rmAWz73D19V2F9/lV8eOOlFQAPJCNl5z67C0uC/JaZzp7zDPGeG56ZttXgz3D5NLAj
         2mjE3AeW/f0MA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id D348434FC;
        Mon, 17 Dec 2018 01:54:25 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: perf: map 'ijmptak' to generic 'branches' event
Date:   Mon, 17 Dec 2018 12:54:23 +0300
Message-Id: <20181217095423.20318-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map 'ijmptak' event (all jump instructions that are taken)
instead of 'ijmp' event (all jump and branch instructions)
to generic 'branches' event as taken jump is more interesting
metric for us due to the possible significantly greater
overhead of taken jumps.

'ijmptak' event is available on both ARCv1 and ARCv2.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/include/asm/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index 9185541035cc..6958545390f0 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -103,7 +103,8 @@ static const char * const arc_pmu_ev_hw_map[] = {
 
 	/* counts condition */
 	[PERF_COUNT_HW_INSTRUCTIONS] = "iall",
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmp", /* Excludes ZOL jumps */
+	/* All jump instructions that are taken */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmptak",
 	[PERF_COUNT_ARC_BPOK]         = "bpok",	  /* NP-NT, PT-T, PNT-NT */
 #ifdef CONFIG_ISA_ARCV2
 	[PERF_COUNT_HW_BRANCH_MISSES] = "bpmp",
-- 
2.14.5

