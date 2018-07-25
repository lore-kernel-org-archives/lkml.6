Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BA7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FA920893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 18:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPYaJCsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FA920893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbeGYTO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 15:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbeGYTO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 15:14:56 -0400
Received: from jouet.infradead.org (189-94-96-116.3g.claro.net.br [189.94.96.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15DA02088E;
        Wed, 25 Jul 2018 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532541730;
        bh=W+xw2Hpw1gJWQ6xrQ1ISE9YUfVBnPV0+9AksmnhQY8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPYaJCsqwsbGXAIdAbKGTEGEbpKVgQDa0j6jxn8QVrT+panN0IHxSaaldnooWw1xM
         jWDyBTdmhSJb+8fp2J4vS0Gn7ESpMnqTiU58r0vhIS7WAjlv8gvbMFehi1CmUEpqLq
         2u3ihm0ev1V/J/iQov100gflQ+78X6i5CMJkEkZ8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/27] perf tools: Synthesize GROUP_DESC feature in pipe mode
Date:   Wed, 25 Jul 2018 14:59:54 -0300
Message-Id: <20180725180001.15108-21-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.4

