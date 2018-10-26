Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0A8ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0509920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0509920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbeJZQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:08:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZQIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:08:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7WIAM136832
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:32:18 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7WIS3136829;
        Fri, 26 Oct 2018 00:32:18 -0700
Date:   Fri, 26 Oct 2018 00:32:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uzufuxws4hufigx07ue1dpv6@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, wangnan0@huawei.com, mingo@kernel.org,
        namhyung@kernel.org, hpa@zytor.com, jolsa@kernel.org
Reply-To: dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org,
          tglx@linutronix.de, wangnan0@huawei.com, jolsa@kernel.org,
          hpa@zytor.com, adrian.hunter@intel.com, acme@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Mark a evsel as disabled when asking
 the kernel do disable it
Git-Commit-ID: b7e8452b860c299f342a012922bdd9ab8f2bb722
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

Commit-ID:  b7e8452b860c299f342a012922bdd9ab8f2bb722
Gitweb:     https://git.kernel.org/tip/b7e8452b860c299f342a012922bdd9ab8f2bb722
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sat, 20 Oct 2018 09:04:41 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 12:37:45 -0300

perf evsel: Mark a evsel as disabled when asking the kernel do disable it

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
