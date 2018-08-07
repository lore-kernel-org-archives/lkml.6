Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83573C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D652089C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 09:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="D21DJwtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D652089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbeHGLW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 07:22:29 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:44025 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726879AbeHGLW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 07:22:29 -0400
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:10])
        by forwardcorp1g.cmail.yandex.net (Yandex) with ESMTP id 9874C217A1;
        Tue,  7 Aug 2018 12:09:04 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1p.mail.yandex.net (Yandex) with ESMTP id 952A46E40E66;
        Tue,  7 Aug 2018 12:09:04 +0300 (MSK)
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5ecaJBVOI6-94wqASDp;
        Tue, 07 Aug 2018 12:09:04 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1533632944; bh=hx+j3Lro9Fd2YGzkmPX3oSPtAi0IlblPKQRFmA6WR2g=;
        h=Subject:From:To:Cc:Date:Message-ID;
        b=D21DJwtno5xw7BPaxX2W5W6J9/tbSDJog0/35amCLwupaS2ej/ItB7E47IEo754B3
         Lu+jJRHJpysvtcBDbRRuqQ2bYBCGHFNwCh2NpJlsPij2nafudD6kSD9PIaihbE22av
         dVSI1aRNyxREFj1C/BKWuimS6IfsTyEerlYtTw+M=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH 1/2] perf map: synthesize maps only for thread group leader
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>
Date:   Tue, 07 Aug 2018 12:09:01 +0300
Message-ID: <153363294102.396323.6277944760215058174.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Threads share map_groups, all map events are merged into it.

Thus we could send mmaps only for thread group leader.
Otherwise it took ages to attach and record something from
processes with many vmas and threads.

Thread group leader could be already dead,
but it seems perf cannot handle this case anyway.

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

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 tools/perf/util/event.c |   13 ++++++++++---
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

