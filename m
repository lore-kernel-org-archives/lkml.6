Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C2FC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24D20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24D20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbeIMSHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:07:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbeIMSFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29AD5C057FA2;
        Thu, 13 Sep 2018 12:56:02 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A5CB600C8;
        Thu, 13 Sep 2018 12:56:00 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 30/48] perf tools: Rename perf_evlist__munmap_filtered to perf_mmap__put_filtered
Date:   Thu, 13 Sep 2018 14:54:32 +0200
Message-Id: <20180913125450.21342-31-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 13 Sep 2018 12:56:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will use it outside the evlist scope.

Link: http://lkml.kernel.org/n/tip-0r9rtn1bii1iaggumlgkyxqk@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 6 +++---
 tools/perf/util/evlist.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 2f094f3bf446..05f57814e9e5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -503,8 +503,8 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd)
 	return __perf_evlist__add_pollfd(evlist, fd, NULL, POLLIN);
 }
 
-static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
-					 void *arg __maybe_unused)
+void perf_mmap__put_filtered(struct fdarray *fda, int fd,
+			     void *arg __maybe_unused)
 {
 	struct perf_mmap *map = fda->priv[fd].ptr;
 
@@ -515,7 +515,7 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask)
 {
 	return fdarray__filter(&evlist->pollfd, revents_and_mask,
-			       perf_evlist__munmap_filtered, NULL);
+			       perf_mmap__put_filtered, NULL);
 }
 
 int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index df5162c4292b..523bd68a78a3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -316,4 +316,5 @@ bool perf_evlist__exclude_kernel(struct perf_evlist *evlist);
 
 void perf_evlist__force_leader(struct perf_evlist *evlist);
 
+void perf_mmap__put_filtered(struct fdarray *fda, int fd, void *arg);
 #endif /* __PERF_EVLIST_H */
-- 
2.17.1

