Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE1FC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DC221DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0xSLcpaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63DC221DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbeHIRYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:31 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4942183D;
        Thu,  9 Aug 2018 14:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826754;
        bh=2rzjxx6eMs2zfXYOIM7BG0ijDC+q5QvJADWU2iH+oCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0xSLcpaYcHXtLE1Y7D3L1ioyEDH5d8ZveF7LWgldCYQ8yifsePmiKpRxsxPj8JwTX
         /kxdk1TqgnqEW6OkV/Ywh5BK/GOe82xrOV/U8VfJ117bLUd3mK/bW0wegT3bK/XlpK
         5wHnebKZWbTGD8kPzzWEbhd/gmTy7HJPgaETom3A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/44] perf trace: Use perf_evsel__sc_tp_{uint,ptr} for "id"/"args" handling syscalls:* events
Date:   Thu,  9 Aug 2018 11:57:44 -0300
Message-Id: <20180809145822.21391-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now it looks just about the same as for the trace__sys_{enter,exit}.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-y59may7zx1eccnp4m3qm4u0b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 41799596c045..7232a7302580 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1693,20 +1693,13 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
 				    struct perf_sample *sample)
 {
-	struct format_field *field = perf_evsel__field(evsel, "__syscall_nr");
 	struct thread_trace *ttrace;
 	struct thread *thread;
-	struct syscall *sc;
+	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	char msg[1024];
-	int id, err = -1;
 	void *args;
 
-	if (field == NULL)
-		return -1;
-
-	id = format_field__intval(field, sample, evsel->needs_swap);
-	sc = trace__syscall_info(trace, evsel, id);
-
 	if (sc == NULL)
 		return -1;
 
@@ -1719,7 +1712,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 	if (ttrace == NULL)
 		goto out_put;
 
-	args = sample->raw_data + field->offset + sizeof(u64); /* skip __syscall_nr, there is where args are */
+	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
-- 
2.14.4

