Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56715C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDD020883
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 15:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfAHPhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 10:37:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50679 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfAHPhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 10:37:21 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x08Favwm3566078
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 8 Jan 2019 07:36:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x08Favqd3566075;
        Tue, 8 Jan 2019 07:36:57 -0800
Date:   Tue, 8 Jan 2019 07:36:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-8a99255a50c0b4c2a449b96fd8d45fcc8d72c701@git.kernel.org>
Cc:     peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, tglx@linutronix.de,
        acme@redhat.com, jolsa@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com,
        kan.liang@linux.intel.com, ak@linux.intel.com
Reply-To: peterz@infradead.org, alexander.shishkin@linux.intel.com,
          tglx@linutronix.de, mingo@kernel.org, yao.jin@linux.intel.com,
          acme@redhat.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, ak@linux.intel.com, hpa@zytor.com
In-Reply-To: <1546501245-4512-1-git-send-email-yao.jin@linux.intel.com>
References: <1546501245-4512-1-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf stat: Fix endless wait for child process
Git-Commit-ID: 8a99255a50c0b4c2a449b96fd8d45fcc8d72c701
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

Commit-ID:  8a99255a50c0b4c2a449b96fd8d45fcc8d72c701
Gitweb:     https://git.kernel.org/tip/8a99255a50c0b4c2a449b96fd8d45fcc8d72c701
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Thu, 3 Jan 2019 15:40:45 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 3 Jan 2019 12:12:18 -0300

perf stat: Fix endless wait for child process

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
@@ -561,7 +561,8 @@ try_again:
 					break;
 			}
 		}
-		wait4(child_pid, &status, 0, &stat_config.ru_data);
+		if (child_pid != -1)
+			wait4(child_pid, &status, 0, &stat_config.ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
