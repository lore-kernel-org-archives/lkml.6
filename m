Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93FBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D0D20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="PGrublSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbfAQQQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:16:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:60842 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729034AbfAQQQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:16:09 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0HG7Lfs022259
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:16:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=vi1xt4hu0A474PabdmnOFgaYB8WHKZ2kRwdV2m+DLWo=;
 b=PGrublSsKT9rt8M+gNZbJzZg72ufwfMndTkxjzcjognnDPCr22g2Jd5K0cRgs87QFa1b
 kPZo3JIFYZfLgyVMwfKyAtJu/6NPSnmIRMRGeBZw0UB+zBx/sXGIcQKjUtdVy1g497Ou
 SkCbiRcoGJFy+B88rVvgvpy5FJP9DmR27ho= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q2uta092u-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:16:09 -0800
Received: from mx-out.facebook.com (2620:10d:c0a1:3::13) by
 mail.thefacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3;
 Thu, 17 Jan 2019 08:15:32 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 13F4262E19D5; Thu, 17 Jan 2019 08:15:30 -0800 (PST)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@redhat.com>, <peterz@infradead.org>,
        <acme@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, Song Liu <songliubraving@fb.com>,
        David Ahern <dsahern@gmail.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v11 perf, bpf-next 8/9] perf top: Synthesize BPF events for pre-existing loaded BPF programs
Date:   Thu, 17 Jan 2019 08:15:20 -0800
Message-ID: <20190117161521.1341602-9-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190117161521.1341602-1-songliubraving@fb.com>
References: <20190117161521.1341602-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-17_05:,,
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

