Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE21FC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71DFF20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DFF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932858AbeGIOQC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:16:02 -0400
Received: from mga04.intel.com ([192.55.52.120]:46586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932574AbeGIOQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:16:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 07:16:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="69817084"
Received: from otc-lr-04.jf.intel.com ([10.54.39.14])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2018 07:16:00 -0700
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com,
        sunil.k.pandey@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf evlist: Fix error out while applying initial delay and LBR
Date:   Mon,  9 Jul 2018 07:15:22 -0700
Message-Id: <1531145722-16404-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf record will error out if both --delay and LBR are applied.
For example:
  perf record -D 1000 -a -e cycles -j any -- sleep 2
  Error:
  dummy:HG: PMU Hardware doesn't support sampling/overflow-interrupts.
  Try 'perf stat'

A dummy event is added implicitly for initial delay, which has the same
configurations as real sampling events. The dummy event is a software
event. If LBR is configured, perf must error out.

The dummy event only be used to track PERF_RECORD_MMAP while perf waits
for the initial delay to enable the real events. The BRANCH_STACK bit
can be safely cleared for the dummy event.

After applying the patch:
  perf record -D 1000 -a -e cycles -j any -- sleep 2
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 1.054 MB perf.data (828 samples) ]

Reported-by: Pandey, Sunil K <sunil.k.pandey@intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/util/evsel.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 94fce4f..0d55047 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -848,6 +848,12 @@ static void apply_config_terms(struct perf_evsel *evsel,
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
@@ -1086,6 +1092,14 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
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
-- 
2.7.4

