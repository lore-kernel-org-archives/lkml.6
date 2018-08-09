Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F50BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD18E21E21
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDN+/1Ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD18E21E21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733073AbeHIR0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732116AbeHIR0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:26:31 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0587421DEC;
        Thu,  9 Aug 2018 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826873;
        bh=nOI7fMlqg/kTCVhk3dhWPGmVf9Mxi09yN6jwgJn0JKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sDN+/1KomAMa5szPTh3i75KyjoMHGJQFRtgLnvwzO8y/mxLZRtDyGQ1OQFpjy8m2k
         NOGyJPgkkdsygV3MpuRSSexMSgNXg3OEch3RutAhFsS1SHpDHW0m7UbwMUOqdpziOQ
         C4kmNxuQ3P56w5aTWjy+xI476UaXtVR6KLjmN51I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 32/44] perf report: Add --percent-type option
Date:   Thu,  9 Aug 2018 11:58:10 -0300
Message-Id: <20180809145822.21391-33-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Set annotation percent type from following choices:

  global-period, local-period, global-hits, local-hits

With following report option setup the percent type will be passed to
annotation browser:

  $ perf report --percent-type period-local

The local/global keywords set if the percentage is computed in the scope
of the function (local) or the whole data (global).  The period/hits
keywords set the base the percentage is computed on - the samples period
or the number of samples (hits).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/r/20180804130521.11408-21-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-report.txt | 9 +++++++++
 tools/perf/builtin-report.c              | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 917e36fde6d8..474a4941f65d 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -477,6 +477,15 @@ include::itrace.txt[]
 	Display monitored tasks stored in perf data. Displaying pid/tid/ppid
 	plus the command string aligned to distinguish parent and child tasks.
 
+--percent-type::
+	Set annotation percent type from following choices:
+	  global-period, local-period, global-hits, local-hits
+
+	The local/global keywords set if the percentage is computed
+	in the scope of the function (local) or the whole data (global).
+	The period/hits keywords set the base the percentage is computed
+	on - the samples period or the number of samples (hits).
+
 include::callchain-overhead-calculation.txt[]
 
 SEE ALSO
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 02f7a3c27761..143542ffac20 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1124,6 +1124,9 @@ int cmd_report(int argc, const char **argv)
 		   "Time span of interest (start,stop)"),
 	OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
 		    "Show inline function"),
+	OPT_CALLBACK(0, "percent-type", &report.annotation_opts, "local-period",
+		     "Set percent type local/global-period/hits",
+		     annotate_parse_percent_type),
 	OPT_END()
 	};
 	struct perf_data data = {
-- 
2.14.4

