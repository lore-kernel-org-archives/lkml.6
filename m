Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF25ECDE5F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA5D20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA5D20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbeGYWDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:03:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730606AbeGYWDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:03:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKnxId501223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:49:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKnxTN501220;
        Wed, 25 Jul 2018 13:49:59 -0700
Date:   Wed, 25 Jul 2018 13:49:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e8fedff1cc729fd227924305152ccc6f580e8c83@git.kernel.org>
Cc:     mingo@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, hpa@zytor.com, eranian@google.com,
        jolsa@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, acme@redhat.com, namhyung@kernel.org,
        davidcc@google.com
Reply-To: mingo@kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, eranian@google.com, hpa@zytor.com,
          jolsa@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, dsahern@gmail.com, acme@redhat.com,
          namhyung@kernel.org, davidcc@google.com
In-Reply-To: <20180712135202.14774-1-jolsa@kernel.org>
References: <20180712135202.14774-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Synthesize GROUP_DESC feature in pipe
 mode
Git-Commit-ID: e8fedff1cc729fd227924305152ccc6f580e8c83
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

Commit-ID:  e8fedff1cc729fd227924305152ccc6f580e8c83
Gitweb:     https://git.kernel.org/tip/e8fedff1cc729fd227924305152ccc6f580e8c83
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 12 Jul 2018 15:52:02 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:53:20 -0300

perf tools: Synthesize GROUP_DESC feature in pipe mode

Stephan reported, that pipe mode does not carry the group information
and thus the piped report won't display the grouped output for following
command:

  # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report

It has no idea about the group setup, so it will display events
separately:

  # Overhead  Command          Shared Object             ...
  # ........  ...............  .......................
  #
       6.71%  swapper          [kernel.kallsyms]
       2.28%  offlineimap      libpython2.7.so.1.0
       0.78%  perf             [kernel.kallsyms]
  ...

Fix GROUP_DESC feature record to be synthesized in pipe mode, so the
report output is grouped if there are groups defined in record:

  #                 Overhead  Command          Shared    ...
  # ........................  ...............  .......
  #
       7.57%   0.16%   0.30%  swapper          [kernel
       1.87%   3.15%   2.46%  offlineimap      libpyth
       1.33%   0.00%   0.00%  perf             [kernel
  ...

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180712135202.14774-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 653ff65aa2c3..5af58aac91ad 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPR(NUMA_TOPOLOGY,	numa_topology,	true),
 	FEAT_OPN(BRANCH_STACK,	branch_stack,	false),
 	FEAT_OPR(PMU_MAPPINGS,	pmu_mappings,	false),
-	FEAT_OPN(GROUP_DESC,	group_desc,	false),
+	FEAT_OPR(GROUP_DESC,	group_desc,	false),
 	FEAT_OPN(AUXTRACE,	auxtrace,	false),
 	FEAT_OPN(STAT,		stat,		false),
 	FEAT_OPN(CACHE,		cache,		true),
