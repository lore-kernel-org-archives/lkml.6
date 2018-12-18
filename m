Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E3EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3613217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbeLROQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:16:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41185 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeLROQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:16:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEFHoK2854907
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:15:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEFHAk2854903;
        Tue, 18 Dec 2018 06:15:17 -0800
Date:   Tue, 18 Dec 2018 06:15:17 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-3rdeg23rv3brvy1pwt3igvyw@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, davem@davemloft.net,
        mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        peterz@infradead.org, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, peterz@infradead.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          davem@davemloft.net, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Use cond variable instead of a lock
Git-Commit-ID: 94ad6e7e3606454498aeac1fdd1b9de5c1e6735a
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
Message-ID: <20181218141517.2vJpCjpwwW8HY_XZlyggEFpW7irBhcvfmQjGveFOrvA@z>

Commit-ID:  94ad6e7e3606454498aeac1fdd1b9de5c1e6735a
Gitweb:     https://git.kernel.org/tip/94ad6e7e3606454498aeac1fdd1b9de5c1e6735a
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 5 Nov 2018 21:23:40 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:58:03 -0300

perf top: Use cond variable instead of a lock

Use conditional variable logic to synchronize between the reading and
processing threads. Currently it's done by having mutex around rotation
code.

Using a POSIX cond variable to sync both threads after queues rotation:

  Process thread:

    - Detects data
    - Switches queues
    - Sets rotate variable
    - Waits in pthread_cond_wait()

  Read thread:

    - Detects rotate is set
    - Kicks the process thread with a pthread_cond_signal()

After this rotation is safely completed and both threads can continue
with the new queue.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-3rdeg23rv3brvy1pwt3igvyw@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 24 +++++++++++++++++-------
 tools/perf/util/top.h    |  4 +++-
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 75afeae7f04d..aad58643102e 100644
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
@@ -1271,6 +1280,7 @@ static int __cmd_top(struct perf_top *top)
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
 
