Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45819C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE9D2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZfPJrRT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE9D2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbeIFChP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:15 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51BB2077C;
        Wed,  5 Sep 2018 22:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185103;
        bh=8gbwI/bMLMwtGsCTJbnIcwxH8ENwTnUi38GFkqyTEsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZfPJrRTUprngxVX4U3VeiByP09mw1DKi9IUJ1InU+oXlNat1c4rxzVTbzi6RxbJS
         LQEI82b/4CBwvSUo3wlSGwblWOR8jvXuCSOQuSvPP+zKuOVnS9po1vDL62SF/PSA3S
         H3LA2ZrttxCZIk8fp2WosX+FlP1RFLW38azmZbbg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 04/77] perf trace: Extract the comm/tid printing for syscall enter
Date:   Wed,  5 Sep 2018 19:03:27 -0300
Message-Id: <20180905220440.20256-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used with augmented syscalls, where we haven't transitioned
completely to combining sys_enter_FOO with sys_exit_FOO, so we'll go
as far as having it similar to the end result, strace like, as possible.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-canomaoiybkswwnhj69u9ae4@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bcf882afd6d0..92488edd00eb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1144,11 +1144,9 @@ static void sig_handler(int sig)
 	interrupted = sig == SIGINT;
 }
 
-static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
-					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+static size_t trace__fprintf_comm_tid(struct trace *trace, struct thread *thread, FILE *fp)
 {
-	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
-	printed += fprintf_duration(duration, duration_calculated, fp);
+	size_t printed = 0;
 
 	if (trace->multiple_threads) {
 		if (trace->show_comm)
@@ -1159,6 +1157,14 @@ static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thre
 	return printed;
 }
 
+static size_t trace__fprintf_entry_head(struct trace *trace, struct thread *thread,
+					u64 duration, bool duration_calculated, u64 tstamp, FILE *fp)
+{
+	size_t printed = trace__fprintf_tstamp(trace, tstamp, fp);
+	printed += fprintf_duration(duration, duration_calculated, fp);
+	return printed + trace__fprintf_comm_tid(trace, thread, fp);
+}
+
 static int trace__process_event(struct trace *trace, struct machine *machine,
 				union perf_event *event, struct perf_sample *sample)
 {
-- 
2.14.4

