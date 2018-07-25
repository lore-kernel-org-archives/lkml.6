Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A471C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33D620671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33D620671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731452AbeGYWGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:06:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43665 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbeGYWGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:06:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKqdBg501748
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:52:39 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKqd6L501745;
        Wed, 25 Jul 2018 13:52:39 -0700
Date:   Wed, 25 Jul 2018 13:52:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-2d6cae13f10d5d8b370038dbfdf60317c22b9f52@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org,
        peterz@infradead.org, namhyung@kernel.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
          peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, acme@redhat.com, dsahern@gmail.com
In-Reply-To: <20180720110036.32251-1-jolsa@kernel.org>
References: <20180720110036.32251-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Use perf_evsel__match instead of open
 coded equivalent
Git-Commit-ID: 2d6cae13f10d5d8b370038dbfdf60317c22b9f52
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

Commit-ID:  2d6cae13f10d5d8b370038dbfdf60317c22b9f52
Gitweb:     https://git.kernel.org/tip/2d6cae13f10d5d8b370038dbfdf60317c22b9f52
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 20 Jul 2018 13:00:33 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:54:13 -0300

perf tools: Use perf_evsel__match instead of open coded equivalent

Use perf_evsel__match() helper in perf_evsel__is_bpf_output().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180720110036.32251-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index d277930b19a1..890babf9ce86 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -402,10 +402,7 @@ bool perf_evsel__is_function_event(struct perf_evsel *evsel);
 
 static inline bool perf_evsel__is_bpf_output(struct perf_evsel *evsel)
 {
-	struct perf_event_attr *attr = &evsel->attr;
-
-	return (attr->config == PERF_COUNT_SW_BPF_OUTPUT) &&
-		(attr->type == PERF_TYPE_SOFTWARE);
+	return perf_evsel__match(evsel, SOFTWARE, SW_BPF_OUTPUT);
 }
 
 struct perf_attr_details {
