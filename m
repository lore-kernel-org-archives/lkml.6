Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61052C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD7B20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977679;
	bh=zNGh6OeHgxYHogMRKVICP1CnSKIHWitFEE+e78ba1bk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Yd4ncWQVckpIPBmZUiJUJ/sjqRNoXJhJp5+HsLFeBfSmo8yvbrWCg+pbvAF9v/JVq
	 3RbiHvg0VoFM0IZJKleXi/LVvrP6LysiSp1K7TFLwgoJ/9Oq1Z3mDndv6xejqbvVyB
	 uhF5VCTOzGORjvXSovGu8c/l9DVGqoFBdl56O0aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfAHUBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:01:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730785AbfAHT7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:23 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7287320827;
        Tue,  8 Jan 2019 19:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977562;
        bh=zNGh6OeHgxYHogMRKVICP1CnSKIHWitFEE+e78ba1bk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcMxfkZgHNlUfOesCdr2hJTIrJ0ES+FTiXmNfgIBBltaADkK02tlY2KJvEgaBERCX
         cxtduLla91CwzeJ0P6g/1EFHX1bT7pijsnwVK5wbjyCKY4gbC3tDtbRSutRj+pR1ti
         1IVoQe1Mi7/wOLmRVR4pMwvGkBokru/AfEecFt2I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/16] perf trace: Fix ')' placement in "interrupted" syscall lines
Date:   Tue,  8 Jan 2019 16:58:55 -0300
Message-Id: <20190108195910.17726-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we get the sys_enter for a syscall we check if the last one is
still waiting for its matching sys_exit, if so we print this:

   468.753 (         ): firefox/32382 poll(ufds: 0x7f3988d3dd00, nfds: 7, timeout_msecs: 4294967295)     ...
   449.575 ( 0.004 ms): Softwar~cThrea/32434 futex(uaddr: 0x7f39a18a9b70, op: WAKE|PRIVATE_FLAG, val: 1)           = 0

At some point we'll get that poll sys_exit event and will print a "[continued]" line.

While making the sizing of the alignment after the syscall arg list and
its result configurable, so that we can mimic strace, which uses a
smaller alingment by default, a bug was introduced where the closing
parens appeared before the syscall name and its arg list, fix it.

Fixes: 4b8a240ed5e0 ("perf trace: Add alignment spaces after the closing parens")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oi45i54s59h1w1kmgpzrfuum@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index adbf28183560..b8bf5d025563 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1758,6 +1758,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 {
 	struct thread_trace *ttrace;
 	size_t printed;
+	int len;
 
 	if (trace->failure_only || trace->current == NULL)
 		return 0;
@@ -1768,9 +1769,14 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, ")%-*s ...\n", trace->args_alignment, ttrace->entry_str);
-	ttrace->entry_pending = false;
+	printed += len = fprintf(trace->output, "%s)", ttrace->entry_str);
+
+	if (len < trace->args_alignment - 4)
+		printed += fprintf(trace->output, "%-*s", trace->args_alignment - 4 - len, " ");
 
+	printed += fprintf(trace->output, " ...\n");
+
+	ttrace->entry_pending = false;
 	++trace->nr_events_printed;
 
 	return printed;
-- 
2.20.1

