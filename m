Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B28C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FB620C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FB620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbeIMSEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbeIMSEp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0296C30B9310;
        Thu, 13 Sep 2018 12:55:25 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 011C8600C6;
        Thu, 13 Sep 2018 12:55:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 14/48] perf tools: Introduce thread__comm(_str)_by_time() helpers
Date:   Thu, 13 Sep 2018 14:54:16 +0200
Message-Id: <20180913125450.21342-15-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Sep 2018 12:55:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

When data file indexing is enabled, it processes all task, comm and mmap
events first and then goes to the sample events.  So all it sees is the
last comm of a thread although it has information at the time of sample.

Sort thread's comm by time so that it can find appropriate comm at the
sample time.  The thread__comm_by_time() will mostly work even if
PERF_SAMPLE_TIME bit is off since in that case, sample->time will be
-1 so it'll take the last comm anyway.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: http://lkml.kernel.org/n/tip-g0q0o4prp0tj1zkb86in0dqu@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/thread.c | 33 ++++++++++++++++++++++++++++++++-
 tools/perf/util/thread.h |  2 ++
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2048d393ece6..a61683157760 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -192,6 +192,21 @@ struct comm *thread__exec_comm(const struct thread *thread)
 	return last;
 }
 
+struct comm *thread__comm_by_time(const struct thread *thread, u64 timestamp)
+{
+	struct comm *comm;
+
+	list_for_each_entry(comm, &thread->comm_list, list) {
+		if (timestamp >= comm->start)
+			return comm;
+	}
+
+	if (list_empty(&thread->comm_list))
+		return NULL;
+
+	return list_last_entry(&thread->comm_list, struct comm, list);
+}
+
 static int ____thread__set_comm(struct thread *thread, const char *str,
 				u64 timestamp, bool exec)
 {
@@ -206,7 +221,13 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
 		new = comm__new(str, timestamp, exec);
 		if (!new)
 			return -ENOMEM;
-		list_add(&new->list, &thread->comm_list);
+
+		/* sort by time */
+		list_for_each_entry(curr, &thread->comm_list, list) {
+			if (timestamp >= curr->start)
+				break;
+		}
+		list_add_tail(&new->list, &curr->list);
 
 		if (exec)
 			unwind__flush_access(thread);
@@ -266,6 +287,16 @@ const char *thread__comm_str(const struct thread *thread)
 	return str;
 }
 
+const char *thread__comm_str_by_time(const struct thread *thread, u64 timestamp)
+{
+	const struct comm *comm = thread__comm_by_time(thread, timestamp);
+
+	if (!comm)
+		return NULL;
+
+	return comm__str(comm);
+}
+
 /* CHECKME: it should probably better return the max comm len from its comm list */
 int thread__comm_len(struct thread *thread)
 {
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 07606aa6998d..64eaa68bb112 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -85,8 +85,10 @@ int thread__set_comm_from_proc(struct thread *thread);
 int thread__comm_len(struct thread *thread);
 struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
+struct comm *thread__comm_by_time(const struct thread *thread, u64 timestamp);
 const char *thread__comm_str(const struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
+const char *thread__comm_str_by_time(const struct thread *thread, u64 timestamp);
 int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
 
-- 
2.17.1

