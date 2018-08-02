Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F0C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09492146D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09492146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeHBJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:58:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbeHBJ6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:58:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7287bb43430573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:07:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7287bFE3430570;
        Thu, 2 Aug 2018 01:07:37 -0700
Date:   Thu, 2 Aug 2018 01:07:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-95035c5e167ae6e740b1ddd30210ae0eaf39a5db@git.kernel.org>
Cc:     jolsa@kernel.org, acme@redhat.com, kan.liang@linux.intel.com,
        peterz@infradead.org, namhyung@kernel.org, mingo@kernel.org,
        sunil.k.pandey@intel.com, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, sunil.k.pandey@intel.com, mingo@kernel.org,
          namhyung@kernel.org, peterz@infradead.org,
          kan.liang@linux.intel.com, jolsa@kernel.org, acme@redhat.com
In-Reply-To: <1531145722-16404-1-git-send-email-kan.liang@linux.intel.com>
References: <1531145722-16404-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evlist: Fix error out while applying initial
 delay and LBR
Git-Commit-ID: 95035c5e167ae6e740b1ddd30210ae0eaf39a5db
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

Commit-ID:  95035c5e167ae6e740b1ddd30210ae0eaf39a5db
Gitweb:     https://git.kernel.org/tip/95035c5e167ae6e740b1ddd30210ae0eaf39a5db
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 9 Jul 2018 07:15:22 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 09:56:46 -0300

perf evlist: Fix error out while applying initial delay and LBR

'perf record' will error out if both --delay and LBR are applied.

For example:

  # perf record -D 1000 -a -e cycles -j any -- sleep 2
  Error:
  dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts.
  Try 'perf stat'
  #

A dummy event is added implicitly for initial delay, which has the same
configurations as real sampling events. The dummy event is a software
event. If LBR is configured, perf must error out.

The dummy event will only be used to track PERF_RECORD_MMAP while perf
waits for the initial delay to enable the real events. The BRANCH_STACK
bit can be safely cleared for the dummy event.

After applying the patch:

  # perf record -D 1000 -a -e cycles -j any -- sleep 2
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.054 MB perf.data (828 samples) ]
  #

Reported-by: Sunil K Pandey <sunil.k.pandey@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1531145722-16404-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5285da0417c5..ddf84b941abf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -859,6 +859,12 @@ static void apply_config_terms(struct perf_evsel *evsel,
 	}
 }
 
+static bool is_dummy_event(struct perf_evsel *evsel)
+{
+	return (evsel->attr.type == PERF_TYPE_SOFTWARE) &&
+	       (evsel->attr.config == PERF_COUNT_SW_DUMMY);
+}
+
 /*
  * The enable_on_exec/disabled value strategy:
  *
@@ -1097,6 +1103,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		else
 			perf_evsel__reset_sample_bit(evsel, PERIOD);
 	}
+
+	/*
+	 * For initial_delay, a dummy event is added implicitly.
+	 * The software event will trigger -EOPNOTSUPP error out,
+	 * if BRANCH_STACK bit is set.
+	 */
+	if (opts->initial_delay && is_dummy_event(evsel))
+		perf_evsel__reset_sample_bit(evsel, BRANCH_STACK);
 }
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
