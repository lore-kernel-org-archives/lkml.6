Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562E2C37124
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16850217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115154;
	bh=fff1z2nIOsHeMlOuEGqeT7/LHwdyGvBXVfgoIgi/Ksw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hoguyoObSJOkgX6YgUIYtF/U6OtSQ/FDvYqp/cpF0sTx8nmhN59cFEXk8KBG93RxP
	 4JNW6p5et8CPru/hPneSSO8oNfSQd7VZnwnFw25d32CM3CoT1LatW0IcVUazM3BAyS
	 HdC/EZgvri2PjQo+DBI9LhAXBmW7CO5AS9JQcl7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfAUX7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbfAUX7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:59:07 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE4ED21721;
        Mon, 21 Jan 2019 23:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115147;
        bh=fff1z2nIOsHeMlOuEGqeT7/LHwdyGvBXVfgoIgi/Ksw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYI10lHLgN6kE6pbJVff/Ii6cIBDeagtLObcALzl7eZQomk+bHstAPGsxBy1xOClC
         JaTMPU6oNbB89nCPgS2SyxK6qLoISL8KpaYwHrzDMXTRNarspG9tOmjbXrfZdVywkN
         hfLrfNOaTUUpFzM+uW25ZI2ogPEK8ewl3dup/cc4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Ahern <dsahern@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>, kernel-team@fb.com,
        netdev@vger.kernel.org
Subject: [PATCH 21/24] perf top: Synthesize BPF events for pre-existing loaded BPF programs
Date:   Mon, 21 Jan 2019 20:57:03 -0300
Message-Id: <20190121235706.20005-22-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can resolve symbols and map names.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: kernel-team@fb.com
Cc: netdev@vger.kernel.org
Link: http://lkml.kernel.org/r/20190117161521.1341602-9-songliubraving@fb.com
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.20.1

