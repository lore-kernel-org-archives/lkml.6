Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FACCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D963A214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 14:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNMGV5UU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D963A214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbeKVA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 19:59:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbeKVA7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 19:59:55 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2DE214C4;
        Wed, 21 Nov 2018 14:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542810317;
        bh=CvmRG2MPwXgLXvsGaq9XQ36t8zsO54Usdb0CTczcp4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DNMGV5UUrFMzSg42yWQtezXIXhM+MwOTBIu/UfuOXgT1qDaFKOttq02IaM8KPEph1
         dRW3oSX8060NMmnTJU7jZ1nzWdkvoRHK26mNo18CuCZBToMY3vmmLj2nK/64vvn45o
         DsIcK2iXPDbHb5WJiDxih1lnpBu1lTEQJbhvmyhY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adam Lee <leeadamrobert@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/7] perf tools: Fix crash on synthesizing the unit
Date:   Wed, 21 Nov 2018 11:24:59 -0300
Message-Id: <20181121142505.27379-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181121142505.27379-1-acme@kernel.org>
References: <20181121142505.27379-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.14.5

