Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D1FECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE2B20834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW1UfZsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE2B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJYTnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbeJYTnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:43:32 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E373F20834;
        Thu, 25 Oct 2018 11:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540465874;
        bh=T6wEDX3/6dReaQ/28rw+vvb0BZ7yrwwHB2lR+Eej6Ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MW1UfZsQd6E6kq0k5hDrwuwPiGBDfWnIcH+CDZMjz6VYo/SoyTqavZ9H1BpeRwjlP
         HhsEEN3Ct3YvrfBoh/2bt7okS2ikeR9VmxAABd1Qu4X5zq+ufMcUgqN7hAKXnIynxH
         EIXKke8nkOzBCy4Uwuch0eAv7YAeQe5kf38jyv3U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/37] perf evsel: Mark a evsel as disabled when asking the kernel do disable it
Date:   Thu, 25 Oct 2018 08:10:03 -0300
Message-Id: <20181025111031.3440-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Because there may be more such events in the ring buffer that should be
discarded when an app decides to stop considering them.

At some point we'll do this with eBPF, this way we stop them at origin,
before they are placed in the ring buffer.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-uzufuxws4hufigx07ue1dpv6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c |  2 +-
 tools/perf/util/evsel.c  | 23 +++++++++++++++++------
 tools/perf/util/evsel.h  |  1 +
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index be440df29615..e88e6f9b1463 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -358,7 +358,7 @@ void perf_evlist__disable(struct perf_evlist *evlist)
 	struct perf_evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (!perf_evsel__is_group_leader(pos) || !pos->fd)
+		if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->fd)
 			continue;
 		perf_evsel__disable(pos);
 	}
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7e95ec1c19a8..6d187059a373 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1207,16 +1207,27 @@ int perf_evsel__append_addr_filter(struct perf_evsel *evsel, const char *filter)
 
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_ENABLE,
-				     0);
+	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
+
+	if (!err)
+		evsel->disabled = false;
+
+	return err;
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
 {
-	return perf_evsel__run_ioctl(evsel,
-				     PERF_EVENT_IOC_DISABLE,
-				     0);
+	int err = perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
+	/*
+	 * We mark it disabled here so that tools that disable a event can
+	 * ignore events after they disable it. I.e. the ring buffer may have
+	 * already a few more events queued up before the kernel got the stop
+	 * request.
+	 */
+	if (!err)
+		evsel->disabled = true;
+
+	return err;
 }
 
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index ad5d615c6db6..4ef50f157b50 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -122,6 +122,7 @@ struct perf_evsel {
 	bool			snapshot;
 	bool 			supported;
 	bool 			needs_swap;
+	bool 			disabled;
 	bool			no_aux_samples;
 	bool			immediate;
 	bool			system_wide;
-- 
2.14.4

