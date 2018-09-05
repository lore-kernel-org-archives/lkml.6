Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E7C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FB420652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="orPnofRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FB420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeIFCk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbeIFCk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:28 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B7420857;
        Wed,  5 Sep 2018 22:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185296;
        bh=z3CXMX21k8mfpJw5BCQrJBGAoSBI/K7e5Ya5G8gJ9SQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orPnofRln8+OcIhlEZZqD5/9PMxAyRCNSVe+sORcLyySaQxSaymw7t+D1WJQHSb5g
         pkGLfLEDdgN47ZGgz9j8CTFysd1mePudWADXcqOEpLsU8rKUe/0/fCJMVkLt6L/Bp+
         J7HYM1IhpemjxxlxI44m6pCS1lrHk2h0w3FwH1hg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 73/77] perf trace: Introduce syscall__augmented_args() method
Date:   Wed,  5 Sep 2018 19:04:36 -0300
Message-Id: <20180905220440.20256-74-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

That will be used by trace__sys_enter when we start combining the
augmented syscalls:sys_enter_FOO + syscalls:sys_exit_FOO.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-iiseo3s0qbf9i3rzn8k597bv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c106189f4066..12356deb6046 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1677,6 +1677,17 @@ static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
 	return printed;
 }
 
+static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sample, int *augmented_args_size)
+{
+	void *augmented_args = NULL;
+
+	*augmented_args_size = sample->raw_size - sc->args_size;
+	if (*augmented_args_size > 0)
+		augmented_args = sample->raw_data + sc->args_size;
+
+	return augmented_args;
+}
+
 static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
@@ -1762,10 +1773,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evse
 		goto out_put;
 
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
-	augmented_args_size = sample->raw_size - sc->args_size;
-	if (augmented_args_size > 0)
-		augmented_args = sample->raw_data + sc->args_size;
-
+	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
 	syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
 	fprintf(trace->output, "%s", msg);
 	err = 0;
-- 
2.14.4

