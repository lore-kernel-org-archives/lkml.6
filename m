Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B58BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAD120834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAD120834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJZQIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:08:52 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48201 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJZQIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:08:52 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7WotN136864
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:32:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7WnDu136861;
        Fri, 26 Oct 2018 00:32:49 -0700
Date:   Fri, 26 Oct 2018 00:32:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ivg9hifzeuokb1f5jxc2wob4@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, dsahern@gmail.com,
        wangnan0@huawei.com, namhyung@kernel.org, adrian.hunter@intel.com,
        jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, dsahern@gmail.com,
          mingo@kernel.org, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Drop addr_location refcounts
Git-Commit-ID: 4291bf5cb93918232f88a3a70d8f70a72fbb6ab0
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

Commit-ID:  4291bf5cb93918232f88a3a70d8f70a72fbb6ab0
Gitweb:     https://git.kernel.org/tip/4291bf5cb93918232f88a3a70d8f70a72fbb6ab0
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Sat, 20 Oct 2018 09:18:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 22 Oct 2018 12:37:51 -0300

perf trace: Drop addr_location refcounts

When we use machine__resolve() we grab a reference to
addr_location.thread (and in the future to other elements there) via
machine__findnew_thread(), so we must pair that with
addr_location__put(), else we'll never drop that thread when it exits
and no other remaining data structures have pointers to it. Fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ivg9hifzeuokb1f5jxc2wob4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 74638034861c..77b8748ad5ed 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1814,12 +1814,14 @@ static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evse
 	int max_stack = evsel->attr.sample_max_stack ?
 			evsel->attr.sample_max_stack :
 			trace->max_stack;
+	int err;
 
-	if (machine__resolve(trace->host, &al, sample) < 0 ||
-	    thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack))
+	if (machine__resolve(trace->host, &al, sample) < 0)
 		return -1;
 
-	return 0;
+	err = thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack);
+	addr_location__put(&al);
+	return err;
 }
 
 static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sample)
