Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F1C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAA72188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AAA72188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbeHROti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:49:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeHROti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:49:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBftiN1287799
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:41:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBftvq1287795;
        Sat, 18 Aug 2018 04:41:55 -0700
Date:   Sat, 18 Aug 2018 04:41:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-e5adfc3e7e774ba86f7bb725c6eef5f32df8630e@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, khlebnikov@yandex-team.ru,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, jolsa@kernel.org, mingo@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, khlebnikov@yandex-team.ru,
          peterz@infradead.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, mingo@kernel.org
In-Reply-To: <153363294102.396323.6277944760215058174.stgit@buzz>
References: <153363294102.396323.6277944760215058174.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf map: Synthesize maps only for thread group
 leader
Git-Commit-ID: e5adfc3e7e774ba86f7bb725c6eef5f32df8630e
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

Commit-ID:  e5adfc3e7e774ba86f7bb725c6eef5f32df8630e
Gitweb:     https://git.kernel.org/tip/e5adfc3e7e774ba86f7bb725c6eef5f32df8630e
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Tue, 7 Aug 2018 12:09:01 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:59 -0300

perf map: Synthesize maps only for thread group leader

Threads share map_groups, all map events are merged into it.

Thus we could send mmaps only for thread group leader.  Otherwise it
took ages to attach and record something from processes with many vmas
and threads.

Thread group leader could be already dead, but it seems perf cannot
handle this case anyway.

Testing dummy:

  #include <stdio.h>
  #include <stdlib.h>
  #include <sys/mman.h>
  #include <pthread.h>
  #include <unistd.h>

  void *thread(void *arg) {
          pause();
  }

  int main(int argc, char **argv) {
        int threads = 10000;
        int vmas = 50000;
        pthread_t th;
        for (int i = 0; i < threads; i++)
                pthread_create(&th, NULL, thread, NULL);
        for (int i = 0; i < vmas; i++)
                mmap(NULL, 4096, (i & 1) ? PROT_READ : PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
        sleep(60);
        return 0;
  }

Comment by Jiri Olsa:

We actualy synthesize the group leader (if we found one) for the thread
even if it's not present in the thread_map, so the process maps are
always in data.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/153363294102.396323.6277944760215058174.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/event.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0c8ecf0c78a4..0cd42150f712 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -541,10 +541,17 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 						      tgid, process, machine) < 0)
 			return -1;
 
+		/*
+		 * send mmap only for thread group leader
+		 * see thread__init_map_groups
+		 */
+		if (pid == tgid &&
+		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
+						       process, machine, mmap_data,
+						       proc_map_timeout))
+			return -1;
 
-		return perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-							  process, machine, mmap_data,
-							  proc_map_timeout);
+		return 0;
 	}
 
 	if (machine__is_default_guest(machine))
