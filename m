Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E441C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C7720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C7720BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbeGLOBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:01:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727072AbeGLOBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:01:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5050D40201BF;
        Thu, 12 Jul 2018 13:52:06 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1FA1111AF0E;
        Thu, 12 Jul 2018 13:52:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     David Carrillo-Cisneros <davidcc@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH] perf tools: Synthesize GROUP_DESC feature in pipe mode
Date:   Thu, 12 Jul 2018 15:52:02 +0200
Message-Id: <20180712135202.14774-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 13:52:06 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 12 Jul 2018 13:52:06 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan reported, that pipe mode does not carry the group
information and thus the piped report won't display the
grouped output for following command:

  # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report

It has no idea about the group setup, so it will display
events separately:

  # Overhead  Command          Shared Object             ...
  # ........  ...............  .......................
  #
       6.71%  swapper          [kernel.kallsyms]
       2.28%  offlineimap      libpython2.7.so.1.0
       0.78%  perf             [kernel.kallsyms]
  ...

Fixing GROUP_DESC feature record to be synthesized in pipe mode,
so the report output is grouped if there's group defined in record:

  #                 Overhead  Command          Shared    ...
  # ........................  ...............  .......
  #
       7.57%   0.16%   0.30%  swapper          [kernel
       1.87%   3.15%   2.46%  offlineimap      libpyth
       1.33%   0.00%   0.00%  perf             [kernel
  ...

Cc: David Carrillo-Cisneros <davidcc@google.com>
Reported-by: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-ybqyh8ac4g173iy3xt4pxnlo@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/header.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 59fcc790c865..af9aaf28f976 100644
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
-- 
2.17.1

