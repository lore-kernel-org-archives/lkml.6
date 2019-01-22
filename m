Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D63C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3343C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="cg0jTpR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAVVDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:03:01 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56484 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbfAVVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:03:00 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0ML0nZB005813
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:02:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Vq71pGzNvFa/CwSVGkqtdhx3IauhYZExC6e91g7mP5E=;
 b=cg0jTpR6PTWYi+aJK3KMC/fn0rdPknloSCcZIG6OWN6k6pViJaVtyJuQXp7Amrqda118
 dIqybocJZ7SK5bLyLurZNwJ+XSU4R52cUq02Jx97BlpqDk3nan6NDc292wklKWQ+rCz8
 b+FpPyTZZzTLJdnZ9oQ8rLimix1l+mSKV4I= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q690prdf1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 13:02:58 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Tue, 22 Jan 2019 13:02:25 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 461E962E1D62; Tue, 22 Jan 2019 13:02:20 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH perf] perf tools: fix synthesized PERF_RECORD_KSYMBOL/BPF_EVENT
Date:   Tue, 22 Jan 2019 13:02:18 -0800
Message-ID: <20190122210218.358664-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added missing machine->id_hdr_size to event->header.size. Also fixed size
of PERF_RECORD_KSYMBOL by removing extra bytes for name.

Fixes: 7b612e291a5a ("perf tools: Synthesize PERF_RECORD_* for loaded BPF programs")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/util/bpf-event.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 01e1dc1bb7fb..f610872812ef 100644
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
+		memset(event + event->header.size, 0, machine->id_hdr_size);
+		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
@@ -194,6 +198,8 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
 			.id = info.id,
 		};
 		memcpy(bpf_event->tag, prog_tags[i], BPF_TAG_SIZE);
+		memset(event + event->header.size, 0, machine->id_hdr_size);
+		event->header.size += machine->id_hdr_size;
 		err = perf_tool__process_synth_event(tool, event,
 						     machine, process);
 	}
-- 
2.17.1

