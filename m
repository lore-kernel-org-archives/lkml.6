Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4B2C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B6A20827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B6A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388690AbeKGErC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:47:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGErC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:47:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JJhqu913017
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:19:43 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JJg1r913012;
        Tue, 6 Nov 2018 11:19:42 -0800
Date:   Tue, 6 Nov 2018 11:19:42 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        andi@firstfloor.org, tglx@linutronix.de, peterz@infradead.org,
        hpa@zytor.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, namhyung@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
          andi@firstfloor.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          namhyung@kernel.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20180923150420.27327-1-jolsa@kernel.org>
References: <20180923150420.27327-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Do not zero sample_id_all for group
 members
Git-Commit-ID: 8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3
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

Commit-ID:  8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3
Gitweb:     https://git.kernel.org/tip/8e88c29b351ed4e09dd63f825f1c8260b0cb0ab3
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 23 Sep 2018 17:04:20 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Nov 2018 08:29:56 -0300

perf tools: Do not zero sample_id_all for group members

Andi reported following malfunction:

  # perf record -e '{ref-cycles,cycles}:S' -a sleep 1
  # perf script
  non matching sample_id_all

That's because we disable sample_id_all bit for non-sampling group
members. We can't do that, because it needs to be the same over the
whole event list. This patch keeps it untouched again.

Reported-by: Andi Kleen <andi@firstfloor.org>
Tested-by: Andi Kleen <andi@firstfloor.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180923150420.27327-1-jolsa@kernel.org
Fixes: e9add8bac6c6 ("perf evsel: Disable write_backward for leader sampling group events")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/test-record-group-sampling | 1 -
 tools/perf/util/evsel.c                          | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/perf/tests/attr/test-record-group-sampling b/tools/perf/tests/attr/test-record-group-sampling
index 8a33ca4f9e1f..f0729c454f16 100644
--- a/tools/perf/tests/attr/test-record-group-sampling
+++ b/tools/perf/tests/attr/test-record-group-sampling
@@ -37,4 +37,3 @@ sample_freq=0
 sample_period=0
 freq=0
 write_backward=0
-sample_id_all=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6d187059a373..d37bb1566cd9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -956,7 +956,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->sample_freq    = 0;
 		attr->sample_period  = 0;
 		attr->write_backward = 0;
-		attr->sample_id_all  = 0;
 	}
 
 	if (opts->no_samples)
