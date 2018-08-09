Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A673C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5645C21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1v648ovE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5645C21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733240AbeHIR1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:27:22 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3959D2183D;
        Thu,  9 Aug 2018 15:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826925;
        bh=qMCv76HXEZLbaznsHdQNaFLxhgp4ZKU0UtVIQjtBR44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1v648ovEO7xLzPsABoh3ifgVPIQdDefGxhQ2Ha/IifBkAD2dFVguETB8muluEFWHc
         wRGFw7WplH6kWE0T10Cs462AIN1tCWgSlZatCNZatFznO4MQERX/2v6CP0dGOo9NoK
         U+6EqJYBIxaQ8VPcyD59UwH0axb/ENXnNGVmX7Dg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 43/44] perf map: Synthesize maps only for thread group leader
Date:   Thu,  9 Aug 2018 11:58:21 -0300
Message-Id: <20180809145822.21391-44-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

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
-- 
2.14.4

