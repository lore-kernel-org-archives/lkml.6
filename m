Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D011CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9436E20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeJVq1dX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9436E20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbeKLJ2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:28:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388138AbeKLITx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:19:53 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BC582154B;
        Sun, 11 Nov 2018 22:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975397;
        bh=wItgoPuZHYsCYZVT3RqlTaIaXNOX+hshSof4Jh2kg0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KeJVq1dXwkTdQQVtxffuETI7WfpnQa7TjbQg5/rLgaYpKM8qgk0tu3s4MkQkSjXTx
         XwGTrLWYecJkWkJvjewbQaOH6c4z4AJao2RtKVhbWAnNVfqt/rOkuz00QuE9t6NNjQ
         B6M+PNRsmkln/lbsyGbAm+GPqjv8LmK+h2hLKWw0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 054/350] perf evsel: Store ids for events with their own cpus perf_event__synthesize_event_update_cpus
Date:   Sun, 11 Nov 2018 14:18:38 -0800
Message-Id: <20181111221709.413446205@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-report.c |    1 +
 tools/perf/util/evsel.c     |    3 +++
 2 files changed, 4 insertions(+)

--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -981,6 +981,7 @@ int cmd_report(int argc, const char **ar
 			.id_index	 = perf_event__process_id_index,
 			.auxtrace_info	 = perf_event__process_auxtrace_info,
 			.auxtrace	 = perf_event__process_auxtrace,
+			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1078,6 +1078,9 @@ void perf_evsel__config(struct perf_evse
 		attr->exclude_user   = 1;
 	}
 
+	if (evsel->own_cpus)
+		evsel->attr.read_format |= PERF_FORMAT_ID;
+
 	/*
 	 * Apply event specific term settings,
 	 * it overloads any global configuration.


