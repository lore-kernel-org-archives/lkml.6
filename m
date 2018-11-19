Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997FAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9EF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 12:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9EF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbeKSWoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 17:44:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728679AbeKSWoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 17:44:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 957DF820E3;
        Mon, 19 Nov 2018 12:20:38 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE0B55C8A1;
        Mon, 19 Nov 2018 12:20:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        David Miller <davem@davemloft.net>
Subject: [PATCH 07/12] perf top: Use cond variable instead of the lock
Date:   Mon, 19 Nov 2018 13:20:11 +0100
Message-Id: <20181119122016.22423-8-jolsa@kernel.org>
In-Reply-To: <20181119122016.22423-1-jolsa@kernel.org>
References: <20181119122016.22423-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 19 Nov 2018 12:20:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using conditional variable logic to synchronize between
reading and processing threads. Currently it's done by
having mutex around rotation code.

Using posix cond variable to sync both threads after queues
rotation:

  process thread:
    - detects data
    - switches queues
    - set rotate variable
    - waits in pthread_cond_wait

  read thread:
    - detects rotate is set
    - kicks process thread with pthread_cond_signal

After this rotation is safely completed and both threads
can continue with the new queue.

Link: http://lkml.kernel.org/n/tip-3rdeg23rv3brvy1pwt3igvyw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-top.c | 24 +++++++++++++++++-------
 tools/perf/util/top.h    |  4 +++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f8dcdf0f54e1..ca2a1557ac07 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -846,13 +846,18 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		if (ret && ret != -1)
 			break;
 
-		pthread_mutex_lock(&top->qe.lock);
 		ret = ordered_events__queue(top->qe.in, event, timestamp, 0);
-		pthread_mutex_unlock(&top->qe.lock);
-
-		perf_mmap__consume(md);
 		if (ret)
 			break;
+
+		perf_mmap__consume(md);
+
+		if (top->qe.rotate) {
+			pthread_mutex_lock(&top->qe.mutex);
+			top->qe.rotate = false;
+			pthread_cond_signal(&top->qe.cond);
+			pthread_mutex_unlock(&top->qe.mutex);
+		}
 	}
 
 	perf_mmap__read_done(md);
@@ -1059,9 +1064,12 @@ static void *process_thread(void *arg)
 			continue;
 		}
 
-		pthread_mutex_lock(&top->qe.lock);
 		out = rotate_queues(top);
-		pthread_mutex_unlock(&top->qe.lock);
+
+		pthread_mutex_lock(&top->qe.mutex);
+		top->qe.rotate = true;
+		pthread_cond_wait(&top->qe.cond, &top->qe.mutex);
+		pthread_mutex_unlock(&top->qe.mutex);
 
 		if (ordered_events__flush(out, OE_FLUSH__TOP))
 			pr_err("failed to process events\n");
@@ -1151,7 +1159,8 @@ static void init_process_thread(struct perf_top *top)
 	ordered_events__set_copy_on_queue(&top->qe.data[0], true);
 	ordered_events__set_copy_on_queue(&top->qe.data[1], true);
 	top->qe.in = &top->qe.data[0];
-	pthread_mutex_init(&top->qe.lock, NULL);
+	pthread_mutex_init(&top->qe.mutex, NULL);
+	pthread_cond_init(&top->qe.cond, NULL);
 }
 
 static int __cmd_top(struct perf_top *top)
@@ -1272,6 +1281,7 @@ static int __cmd_top(struct perf_top *top)
 out_join:
 	pthread_join(thread, NULL);
 out_join_thread:
+	pthread_cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
 out_delete:
 	perf_session__delete(top->session);
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index 5f503293cfd8..5bce62ebcf14 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -44,7 +44,9 @@ struct perf_top {
 	struct {
 		struct ordered_events	*in;
 		struct ordered_events	 data[2];
-		pthread_mutex_t		 lock;
+		bool			 rotate;
+		pthread_mutex_t		 mutex;
+		pthread_cond_t		 cond;
 	} qe;
 };
 
-- 
2.17.2

