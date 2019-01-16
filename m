Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FFD20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="aTj72B8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfAPQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:30:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59870 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727593AbfAPQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:29:59 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x0GGLsYA019650
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:29:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=vi1xt4hu0A474PabdmnOFgaYB8WHKZ2kRwdV2m+DLWo=;
 b=aTj72B8PZsZjQc+vRashwgEKiGsrke6eSJLTUfWk2rso5sjlz4ARaDA7OIsDA4cifjeF
 8qxceVhkxYcuq6cMrNwEzSb7MDfqY4339EgRsk5vbSzOEehUr4nxPC2/TIgEckLeqbjq
 kyMrTvuQVpl9bNV14JtKnT3vJ1/dI+TKQ9M= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by m0089730.ppops.net with ESMTP id 2q24rugp51-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 08:29:58 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::176) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Wed, 16 Jan 2019 08:29:53 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4B42962E1D13; Wed, 16 Jan 2019 08:29:50 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, <dsahern@gmail.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v10 perf, bpf-next 8/9] perf top: Synthesize BPF events for pre-existing loaded BPF programs
Date:   Wed, 16 Jan 2019 08:29:30 -0800
Message-ID: <20190116162931.1542429-9-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190116162931.1542429-1-songliubraving@fb.com>
References: <20190116162931.1542429-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-16_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can resolve symbols and map names.

Cc: Song Liu <songliubraving@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: https://lkml.kernel.org/n/tip-h3loibff6htedj43q7uinon0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/builtin-top.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index f64e312db787..5a486d4de56e 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -22,6 +22,7 @@
 #include "perf.h"
 
 #include "util/annotate.h"
+#include "util/bpf-event.h"
 #include "util/config.h"
 #include "util/color.h"
 #include "util/drv_configs.h"
@@ -1215,6 +1216,12 @@ static int __cmd_top(struct perf_top *top)
 
 	init_process_thread(top);
 
+	ret = perf_event__synthesize_bpf_events(&top->tool, perf_event__process,
+						&top->session->machines.host,
+						&top->record_opts);
+	if (ret < 0)
+		pr_warning("Couldn't synthesize bpf events.\n");
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false,
 				    top->nr_threads_synthesize);
-- 
2.17.1

