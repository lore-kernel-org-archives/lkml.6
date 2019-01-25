Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F28C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F5421902
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458372;
	bh=oC50OPzWvQu1UKkjNXhJQjYbFOTaHEK64t7zhHsR+v0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Aq48Oq8OhT7xoK7BAi1ke85KKpFxFoaiiI/ssVF2wjRbODcC7x9GuZK0f/BKNItvp
	 Y6C3nr/GIBhWqph2W1HZdgMAuOqQx+En1SV/omXV1t6yTfVhUWMbqJYvPFSRYEECoG
	 5fNywykGsuhgQQ/JyIJ9WaqmghnaTc5kSIOtFA/E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729877AbfAYXTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729853AbfAYXT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:27 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB321218FF;
        Fri, 25 Jan 2019 23:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458366;
        bh=oC50OPzWvQu1UKkjNXhJQjYbFOTaHEK64t7zhHsR+v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5MCg6hgiii7x1Jza/Ralwu3/AoKc7DvGJG6htWhx1WQmrKo5vMwt4ToNY7wdZEUe
         1KkfMrbGsIFZ8IaVCGUm4uSldbqXPOGy8lMW7axrHkEP2IAb0UK5ho5cUkwGl1mnxQ
         lg2RDdf8IZEw7GhP/GcAS0KVa45t2ex9recu83sQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@fb.com
Subject: [PATCH 17/29] perf bpf: Fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT
Date:   Sat, 26 Jan 2019 00:18:31 +0100
Message-Id: <20190125231843.2895-18-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Song Liu <songliubraving@fb.com>

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
-- 
2.20.1

