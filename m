Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E86C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753CD217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbfAZKG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:06:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40257 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:06:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA5mF4513000
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:05:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA5i3q512997;
        Sat, 26 Jan 2019 02:05:44 -0800
Date:   Sat, 26 Jan 2019 02:05:44 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-811184fb6977bb02c21512d8af6a613a7ebce329@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, daniel@iogearbox.net,
        peterz@infradead.org, songliubraving@fb.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, ast@kernel.org,
        mingo@kernel.org, jolsa@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, peterz@infradead.org,
          daniel@iogearbox.net, songliubraving@fb.com, mingo@kernel.org,
          acme@redhat.com, ast@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190122210218.358664-1-songliubraving@fb.com>
References: <20190122210218.358664-1-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Fix synthesized
 PERF_RECORD_KSYMBOL/BPF_EVENT
Git-Commit-ID: 811184fb6977bb02c21512d8af6a613a7ebce329
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

Commit-ID:  811184fb6977bb02c21512d8af6a613a7ebce329
Gitweb:     https://git.kernel.org/tip/811184fb6977bb02c21512d8af6a613a7ebce329
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Tue, 22 Jan 2019 13:02:18 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT

Added missing machine->id_hdr_size to event->header.size. Also fixed
size of PERF_RECORD_KSYMBOL by removing extra bytes for name.

Committer notes:

We need to malloc that extra machine->id_hdr_size at the start of
perf_event__synthesize_bpf_events() and also need to cast the event to
(void *) otherwise we segfault, fix it.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
Link: http://lkml.kernel.org/r/20190122210218.358664-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 01e1dc1bb7fb..796ef793f4ce 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -7,6 +7,7 @@
 #include "bpf-event.h"
 #include "debug.h"
 #include "symbol.h"
+#include "machine.h"
 
 #define ptr_to_u64(ptr)    ((__u64)(unsigned long)(ptr))
 
@@ -149,7 +150,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 		*ksymbol_event = (struct ksymbol_event){
 			.header = {
 				.type = PERF_RECORD_KSYMBOL,
-				.size = sizeof(struct ksymbol_event),
+				.size = offsetof(struct ksymbol_event, name),
 			},
 			.addr = prog_addrs[i],
 			.len = prog_lens[i],
@@ -178,6 +179,9 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 
 		ksymbol_event->header.size += PERF_ALIGN(name_len + 1,
 							 sizeof(u64));
+
+		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
+		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
@@ -194,6 +198,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			.id = info.id,
 		};
 		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		memset((void *)event + event->header.size, 0, machine->id_hdr_size);
+		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
@@ -217,7 +223,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 	int err;
 	int fd;
 
-	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN);
+	event = malloc(sizeof(event->bpf_event) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
 	while (true) {
