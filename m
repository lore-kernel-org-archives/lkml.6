Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E49C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9D3208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131801;
	bh=Igbe0CRQomAH+XvDQC/RTTi53qfuAkyaQ9uYTL5Uf1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jHV3gTVTd++yfOXV46s87Aq030bkF3gvXDRt86C4q5GHs7y4qqwOqWcGTarNPE8RK
	 TGeq3euSMWAN9bw0NB25ueljv2tq+ZZRl/JSQkeK/nALh2Ja5zXCIT84od2siVi3ab
	 MYcHzyAyAiJ304ypB9CVKEoHNNQRXDocCZwfF0rs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9D3208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeLFVaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeLFV3y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:29:54 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A73A2146F;
        Thu,  6 Dec 2018 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131793;
        bh=Igbe0CRQomAH+XvDQC/RTTi53qfuAkyaQ9uYTL5Uf1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DeGW0X6BFHgxixpFW5oXqZ81EEdJNhXMgFEBbtO313JQWxv1WEehSP/GGwygi7nQv
         pcFg063bnNUlHX5Kqe7zDX/VEWs3QWbVZIGLZrXZgafLAPxSSdacFSC7zd+ZrjdU7T
         Y3GTsEXNfDwCPUIsxDSzhJwGvtxxUHl+j2EN3Edo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 51/75] perf top: Use cond variable instead of a lock
Date:   Thu,  6 Dec 2018 18:25:38 -0300
Message-Id: <20181206212602.20474-52-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-3rdeg23rv3brvy1pwt3igvyw@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
 
-- 
2.19.2

