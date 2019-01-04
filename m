Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E0C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69DB218E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546626848;
	bh=Tu5tyL3IfPi5MaGzz4s5emHZs8shc5ND3TiNYQQYNJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nzs/S4j/aJ/RClGcUiXcRnAO45aaAppowektaAmHJvqA1o/isIO1oARATOHnx9DPQ
	 wquElEJ+I5AMdsV+pw4ZdhZKlaLqskhnedAYdUByF9ruL56O7G0Nj0dzF5aa5Ieyt1
	 hA9rtDxYVAJVok5m3aaQqfkEweQ9lnBWcJvdn/o8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbfADSeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfADSeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:34:03 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A73A218E0;
        Fri,  4 Jan 2019 18:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546626842;
        bh=Tu5tyL3IfPi5MaGzz4s5emHZs8shc5ND3TiNYQQYNJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lijMd4ee+4587ZaRX2YKOx56J3Y7yyKFst1tqrhxLoX4CWTm0ZzOeCnbkjnQmhftE
         OpctmPpWo0VAhg94OY2YVSaOUPxdG4vU7fieLjP44IHGKX6/nVdqWyisvk5QJHLNMn
         Xt580fDEe5ZKuKBb7NMgONhjk8D5kABO+B/JlZlY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 01/16] perf stat: Fix endless wait for child process
Date:   Fri,  4 Jan 2019 15:33:22 -0300
Message-Id: <20190104183337.12771-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We hit a 'perf stat' issue by using following script:

  #!/bin/bash

  sleep 1000 &
  exec perf stat -a -e cycles -I1000 -- sleep 5

Since "perf stat" is launched by exec, the "sleep 1000" would be the
child process of "perf stat". The wait4() call will not return because
it's waiting for the child process "sleep 1000" to end. So 'perf stat'
doesn't return even after 5s passes.

This patch lets 'perf stat' return when the specified child process ends
(in this case, the specified child process is "sleep 5").

Committer testing:

  # cat test.sh
  #!/bin/bash

  sleep 10 &
  exec perf stat -a -e cycles -I1000 -- sleep 5
  #

Before:

  # time ./test.sh
  #           time             counts unit events
       1.001113090        108,453,351      cycles
       2.002062196        142,075,435      cycles
       3.002896194        164,801,068      cycles
       4.003731666        107,062,140      cycles
       5.002068867        112,241,832      cycles

  real	0m10.066s
  user	0m0.016s
  sys	0m0.101s
  #

After:

  # time ./test.sh
  #           time             counts unit events
       1.001016096         91,412,027      cycles
       2.002014963        124,063,708      cycles
       3.002883964        125,993,929      cycles
       4.003706470        120,465,734      cycles
       5.002006778        163,560,355      cycles

  real	0m5.123s
  user	0m0.014s
  sys	0m0.105s
  #

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1546501245-4512-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 1410d66192f7..63a3afc7f32b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -561,7 +561,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		wait4(child_pid, &status, 0, &stat_config.ru_data);
+		if (child_pid != -1)
+			wait4(child_pid, &status, 0, &stat_config.ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
-- 
2.20.1

