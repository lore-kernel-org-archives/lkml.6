Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CD8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11704214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 15:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11704214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbeKVBgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 20:36:32 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43097 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeKVBgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 20:36:32 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wALF0tHx3416611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 07:00:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wALF0tbC3416608;
        Wed, 21 Nov 2018 07:00:55 -0800
Date:   Wed, 21 Nov 2018 07:00:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-fb50c09e923870a358d68b0d58891bd145b8d7c7@git.kernel.org>
Cc:     yongxin.liu@outlook.com, linux-kernel@vger.kernel.org,
        leeadamrobert@gmail.com, jolsa@kernel.org, mingo@kernel.org,
        hpa@zytor.com, acme@redhat.com, tglx@linutronix.de,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        peterz@infradead.org
Reply-To: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, jolsa@kernel.org, acme@redhat.com,
          yongxin.liu@outlook.com, linux-kernel@vger.kernel.org,
          leeadamrobert@gmail.com
In-Reply-To: <20181112130012.5424-1-jolsa@kernel.org>
References: <20181112130012.5424-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix crash on synthesizing the unit
Git-Commit-ID: fb50c09e923870a358d68b0d58891bd145b8d7c7
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

Commit-ID:  fb50c09e923870a358d68b0d58891bd145b8d7c7
Gitweb:     https://git.kernel.org/tip/fb50c09e923870a358d68b0d58891bd145b8d7c7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 12 Nov 2018 14:00:12 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Nov 2018 08:37:49 -0800

perf tools: Fix crash on synthesizing the unit

Adam reported a record command crash for simple session like:

  $ perf record -e cpu-clock ls

with following backtrace:

  Program received signal SIGSEGV, Segmentation fault.
  3543            ev = event_update_event__new(size + 1, PERF_EVENT_UPDATE__UNIT, evsel->id[0]);
  (gdb) bt
  #0  perf_event__synthesize_event_update_unit
  #1  0x000000000051e469 in perf_event__synthesize_extra_attr
  #2  0x00000000004445cb in record__synthesize
  #3  0x0000000000444bc5 in __cmd_record
  ...

We synthesize an update event that needs to touch the evsel id array,
which is not defined at that time. Fix this by forcing the id allocation
for events with their unit defined.

Reflecting possible read_format ID bit in the attr tests.

Reported-by: Yongxin Liu <yongxin.liu@outlook.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adam Lee <leeadamrobert@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201477
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")
Link: http://lkml.kernel.org/r/20181112130012.5424-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr/base-record | 2 +-
 tools/perf/util/evsel.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/attr/base-record b/tools/perf/tests/attr/base-record
index 37940665f736..efd0157b9d22 100644
--- a/tools/perf/tests/attr/base-record
+++ b/tools/perf/tests/attr/base-record
@@ -9,7 +9,7 @@ size=112
 config=0
 sample_period=*
 sample_type=263
-read_format=0
+read_format=0|4
 disabled=1
 inherit=1
 pinned=0
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d37bb1566cd9..dbc0466db368 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1092,7 +1092,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus)
+	if (evsel->own_cpus || evsel->unit)
 		evsel->attr.read_format |= PERF_FORMAT_ID;
 
 	/*
