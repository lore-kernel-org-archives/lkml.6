Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912CCC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AFB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNRVHgTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AFB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeJ3WV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeJ3WV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:21:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D295620827;
        Tue, 30 Oct 2018 13:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540906077;
        bh=DtjZJcQ1neADCvX283Vl2SucERE04LpWvmmB2HEKues=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNRVHgTO16SyyJfnWpanbDItWMTsvKGR4VyZkyeWFLnQK6sgVNlx0qYJMNx3q95BK
         E0Hx4lvGzQCrG0VNPVCsM5BFtzhZbtNvod+/PLG3TCP9GzzicT90Mb4IlnN+YBKrNP
         PdeRQ4S0PJ0U/VWEBfqk7GjXSFQeboYndcFTATFs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 21/33] perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
Date:   Tue, 30 Oct 2018 09:26:45 -0400
Message-Id: <20181030132657.217970-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181030132657.217970-1-sashal@kernel.org>
References: <20181030132657.217970-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>

[ Upstream commit 4ab8455f8bd83298bf7f67ab9357e3b1cc765c7d ]

John reported crash when recording on an event under PMU with cpumask defined:

  root@localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
  perf: Segmentation fault
  Obtained 9 stack frames.
  ./perf_debug_() [0x4c5ef8]
  [0xffff82ba267c]
  ./perf_debug_() [0x4bc5a8]
  ./perf_debug_() [0x419550]
  ./perf_debug_() [0x41a928]
  ./perf_debug_() [0x472f58]
  ./perf_debug_() [0x473210]
  ./perf_debug_() [0x4070f4]
  /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe0) [0xffff8294c8a0]
  Segmentation fault (core dumped)

We synthesize an update event that needs to touch the evsel id array, which is
not defined at that time. Fixing this by forcing the id allocation for events
with their own cpus.

Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: John Garry <john.garry@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Fixes: bfd8f72c2778 ("perf record: Synthesize unit/scale/... in event update")
Link: http://lkml.kernel.org/r/20181003212052.GA32371@krava
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-report.c | 1 +
 tools/perf/util/evsel.c     | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index c04dc7b53797..82a3c8be19ee 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -981,6 +981,7 @@ int cmd_report(int argc, const char **argv)
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
+			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 6324afba8fdd..86ad1389ff5a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1078,6 +1078,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 		attr->exclude_user   = 1;
 	}
 
+	if (evsel->own_cpus)
+		evsel->attr.read_format |= PERF_FORMAT_ID;
+
 	/*
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.
-- 
2.17.1

