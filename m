Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C69C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459A921871
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 12:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546519584;
	bh=hJuUFxe9i9z5KBkVuneTYwwS20/M9eWZmdPUm1jBpsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GVq1cV6Wlp54cPqsmEH7xO5iUvUvsgcaexrc+HNXYo4q5SlwZZoeJOy4M3ZnfnxOD
	 JMx5jLaiR+Cqr0x6b/FJj70bkhfkIzcXzRD51QFMbYKaczpx2gjvSPGSDvfnlaZbqO
	 KW6IIWhPkhP9D/1WyNEe1Ioqjd5mi6+AG2LmmZdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731314AbfACMqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 07:46:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfACMqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 07:46:20 -0500
Received: from quaco.ghostprotocols.net (unknown [187.65.17.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C32BC217D9;
        Thu,  3 Jan 2019 12:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546519580;
        bh=hJuUFxe9i9z5KBkVuneTYwwS20/M9eWZmdPUm1jBpsI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nt5BESInIGyMplXCR8WhlZeZG2etPENL4Z5+0HKq5x6X8GqTYeB25sduFgl3o7Djc
         tf0ilmDxV84vg1yVPhK83CnXG9tDh696O4mkcihOoXSB4uMR4usCmU24LezoblBR8Z
         n3r+zKC/79u7yAjW3QEzTb/sEYeCr9NEuPrOWJcg=
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
Subject: [PATCH 01/29] perf trace: Check if the raw_syscalls:sys_{enter,exit} are setup before setting tp filter
Date:   Thu,  3 Jan 2019 09:45:41 -0300
Message-Id: <20190103124609.29672-2-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While updating 'perf trace' on an machine with an old precompiled
augmented_raw_syscalls.o that didn't setup the syscall map the new 'perf
trace' codebase notices the augmented_raw_syscalls.o eBPF event, decides
to use it instead of the old raw_syscalls:sys_{enter,exit} method, but
then because we don't have the syscall map tries to set the tracepoint
filter on the sys_{enter,exit} evsels, that are NULL, segfaulting.

Make the code more robust by checking it those tracepoints have
their respective evsels in place before trying to set the tp filter.

With this we still get everything to work, just not setting up the
syscall filters, which is better than a segfault. Now to update the
precompiled augmented_raw_syscalls.o and continue development :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-3ft5rjdl05wgz2pwpx2z8btu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ebde59e61133..6689c1a114fe 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2686,7 +2686,9 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 {
 	if (trace->syscalls.map)
 		return trace__set_ev_qualifier_bpf_filter(trace);
-	return trace__set_ev_qualifier_tp_filter(trace);
+	if (trace->syscalls.events.sys_enter)
+		return trace__set_ev_qualifier_tp_filter(trace);
+	return 0;
 }
 
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
-- 
2.19.2

