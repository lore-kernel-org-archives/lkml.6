Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8DCD9C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA2E208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 06:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA2E208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeFNGVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 02:21:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38785 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752721AbeFNGVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 02:21:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5E6KgPl763474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 13 Jun 2018 23:20:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5E6Kgv8763471;
        Wed, 13 Jun 2018 23:20:42 -0700
Date:   Wed, 13 Jun 2018 23:20:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hg5g7yddjio3ljwyqnnaj5dt@git.kernel.org>
Cc:     namhyung@kernel.org, dsahern@gmail.com, jolsa@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        yao.jin@linux.intel.com, mingo@kernel.org, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
          wangnan0@huawei.com, hpa@zytor.com, jolsa@kernel.org,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org, yao.jin@linux.intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Reimplement hists__has_callchains()
Git-Commit-ID: c9d366287042489090da0391318df528bdce9941
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

Commit-ID:  c9d366287042489090da0391318df528bdce9941
Gitweb:     https://git.kernel.org/tip/c9d366287042489090da0391318df528bdce9941
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 7 Jun 2018 14:42:27 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 7 Jun 2018 14:42:27 -0300

perf hists: Reimplement hists__has_callchains()

There are places where we have only access to struct hists and need to
know if any of its hist_entries has callchains, like when drawing
headers for the various output modes (stdio, TUI, etc), so, when adding
a new hist_entry, check if it has callchains, storing this info for
later use by hists__has_callchains().

This reimplementation is necessary because not always a 'struct hists'
is allocated together with a 'struct perf evsel', so we can't go from
'hists' to 'perf_event_attr.sample_type & PERF_SAMPLE_CALLCHAIN'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hg5g7yddjio3ljwyqnnaj5dt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 6 ++++--
 tools/perf/util/hist.h | 4 ++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 0441a92b855f..828cb9794c76 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -621,9 +621,11 @@ __hists__add_entry(struct hists *hists,
 		.raw_data = sample->raw_data,
 		.raw_size = sample->raw_size,
 		.ops = ops,
-	};
+	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
-	return hists__findnew_entry(hists, &entry, al, sample_self);
+	if (!hists->has_callchains && he && he->callchain_size != 0)
+		hists->has_callchains = true;
+	return he;
 }
 
 struct hist_entry *hists__add_entry(struct hists *hists,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 06607c434949..73049f7f0f60 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -85,6 +85,7 @@ struct hists {
 	struct events_stats	stats;
 	u64			event_stream;
 	u16			col_len[HISTC_NR_COLS];
+	bool			has_callchains;
 	int			socket_filter;
 	struct perf_hpp_list	*hpp_list;
 	struct list_head	hpp_formats;
@@ -222,8 +223,7 @@ static inline struct hists *evsel__hists(struct perf_evsel *evsel)
 
 static __pure inline bool hists__has_callchains(struct hists *hists)
 {
-	const struct perf_evsel *evsel = hists_to_evsel(hists);
-	return evsel__has_callchain(evsel);
+	return hists->has_callchains;
 }
 
 int hists__init(void);
