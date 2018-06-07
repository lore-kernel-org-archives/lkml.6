Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id yk4hHJfpGFsQVgAAmS7hNA
	; Thu, 07 Jun 2018 08:16:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D526608BF; Thu,  7 Jun 2018 08:16:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D86A607F7;
	Thu,  7 Jun 2018 08:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D86A607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeFGIQL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:16:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeFGIQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:16:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w578FxlW2125498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 7 Jun 2018 01:15:59 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w578FwlP2125495;
        Thu, 7 Jun 2018 01:15:58 -0700
Date: Thu, 7 Jun 2018 01:15:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-edgwb1b2mpbrdeg0w64wp7ms@git.kernel.org>
Cc: jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
        dsahern@gmail.com, wangnan0@huawei.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          adrian.hunter@intel.com, dsahern@gmail.com, acme@redhat.com,
          mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com,
          namhyung@kernel.org, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf sched: Use sched->show_callchain where
 appropriate
Git-Commit-ID: 4c50563d818622bb0f99b378b4e6683f189b39fb
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

Commit-ID:  4c50563d818622bb0f99b378b4e6683f189b39fb
Gitweb:     https://git.kernel.org/tip/4c50563d818622bb0f99b378b4e6683f189b39fb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 28 May 2018 16:07:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 5 Jun 2018 10:09:54 -0300

perf sched: Use sched->show_callchain where appropriate

Instead of using symbol_conf.use_callchain, reducing its usage a bit
more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-edgwb1b2mpbrdeg0w64wp7ms@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 97f9e755e8e6..cbf39dab19c1 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2143,7 +2143,7 @@ static void save_task_callchain(struct perf_sched *sched,
 		return;
 	}
 
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
 	if (thread__resolve_callchain(thread, cursor, evsel, sample,
@@ -2271,10 +2271,11 @@ static struct thread *get_idle_thread(int cpu)
 	return idle_threads[cpu];
 }
 
-static void save_idle_callchain(struct idle_thread_runtime *itr,
+static void save_idle_callchain(struct perf_sched *sched,
+				struct idle_thread_runtime *itr,
 				struct perf_sample *sample)
 {
-	if (!symbol_conf.use_callchain || sample->callchain == NULL)
+	if (!sched->show_callchain || sample->callchain == NULL)
 		return;
 
 	callchain_cursor__copy(&itr->cursor, &callchain_cursor);
@@ -2320,7 +2321,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
 
 			/* copy task callchain when entering to idle */
 			if (perf_evsel__intval(evsel, sample, "next_pid") == 0)
-				save_idle_callchain(itr, sample);
+				save_idle_callchain(sched, itr, sample);
 		}
 	}
 
@@ -2849,7 +2850,7 @@ static void timehist_print_summary(struct perf_sched *sched,
 			printf("    CPU %2d idle entire time window\n", i);
 	}
 
-	if (sched->idle_hist && symbol_conf.use_callchain) {
+	if (sched->idle_hist && sched->show_callchain) {
 		callchain_param.mode  = CHAIN_FOLDED;
 		callchain_param.value = CCVAL_PERIOD;
 
