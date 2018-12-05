Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28558C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D827320851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXElLbtf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D827320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbeLEJhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:39886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbeLEJhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:37:17 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A9F2084C;
        Wed,  5 Dec 2018 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002637;
        bh=kf2JOeyFFgXIux2G09VVP+PMV0fhqA6L2U6Zja5Rr+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXElLbtfiwzHL3riL12O/F9tTp02I6jGrG3xfIL7+ArGT8rzxIUJRreGwjqBirIYb
         SyxOQqTe4yAD2f3NDEtpyIllZaDqSrkr4K5tnWDM+GY/dDtmgE50+/OJ8GXyZgYPhR
         KaZenAJuN2MGD0XAE5E0Rzmwi/IxKnODlkRiO4g0=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@kernel.org>, Adam Lee <leeadamrobert@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 022/123] perf tools: Fix crash on synthesizing the unit
Date:   Wed,  5 Dec 2018 04:34:14 -0500
Message-Id: <20181205093555.5386-22-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit fb50c09e923870a358d68b0d58891bd145b8d7c7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
index 03a72310315f..e7dbdcc8d465 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1088,7 +1088,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
-	if (evsel->own_cpus)
+	if (evsel->own_cpus || evsel->unit)
 		evsel->attr.read_format |= PERF_FORMAT_ID;
 
 	/*
-- 
2.17.1

