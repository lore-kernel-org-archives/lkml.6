Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18CFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D372084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025926;
	bh=d5e66ixMEeTxcgoxs3o+Fr4UVKvuRJSuRZCbxxGM64Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrqC00Zu/wVUNNJhLi56K3ya0ZenPCpzCYYhaCxBSCu1URNAUTvrxbsNQ4b7qlLTF
	 17dUmaH8JLgIzX8T48/nEGLBMOTCCoOgeHzuMCMLE6JWZ2atk9DzvXJEptBfL8//tA
	 NyWMocNvXHHlUYWUd1ZpnZ8btwsDHyznwnOJiwFY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D372084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbeLEQFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:05:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbeLEQFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:05:23 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03159308FBA0;
        Wed,  5 Dec 2018 16:05:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 729BD5C669;
        Wed,  5 Dec 2018 16:05:19 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luis Claudio R. Goncalves" <lclaudio@uudg.org>, ldv@altlinux.org,
        esyr@redhat.com, Frederic Weisbecker <fweisbec@gmail.com>
Subject: [PATCH 3/8] perf record: Add --block option
Date:   Wed,  5 Dec 2018 17:05:04 +0100
Message-Id: <20181205160509.1168-4-jolsa@kernel.org>
In-Reply-To: <20181205160509.1168-1-jolsa@kernel.org>
References: <20181205160509.1168-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 05 Dec 2018 16:05:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --block option to allow record command set block
bool in struct perf_event_attr for event, like:

  # perf record -e raw_syscalls:sys_enter --block ls
  # perf record -e raw_syscalls:sys_enter --block -p ...

It's allowed only for syscall tracepoint events
attached to process.

Link: http://lkml.kernel.org/n/tip-ocz7zwwkkx11v0mkxrtcddih@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 9 +++++++++
 tools/perf/perf.h           | 1 +
 tools/perf/util/evsel.c     | 3 +++
 3 files changed, 13 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4736dc96c4ca..79c8d2f94f86 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1937,6 +1937,8 @@ static struct option __record_options[] = {
 		    "append timestamp to output filename"),
 	OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
 		    "Record timestamp boundary (time of first/last samples)"),
+	OPT_BOOLEAN(0, "block", &record.opts.block,
+		    "Request blocked tracing (for syscall tracepoints)"),
 	OPT_STRING_OPTARG_SET(0, "switch-output", &record.switch_output.str,
 			  &record.switch_output.set, "signal,size,time",
 			  "Switch output when receive SIGUSR2 or cross size,time threshold",
@@ -2116,6 +2118,13 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (rec->opts.block &&
+	    !target__has_task(&rec->opts.target) &&
+	    !target__none(&rec->opts.target)) {
+		pr_err("Can't use --block on non task targets\n");
+		goto out;
+	}
+
 	/* Enable ignoring missing threads when -u/-p option is defined. */
 	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 4d40baa45a5f..7884701247b8 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -66,6 +66,7 @@ struct record_opts {
 	bool	     ignore_missing_thread;
 	bool	     strict_freq;
 	bool	     sample_id;
+	bool	     block;
 	unsigned int freq;
 	unsigned int mmap_pages;
 	unsigned int auxtrace_mmap_pages;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dbc0466db368..e4943e8f811b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1045,6 +1045,9 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	if (opts->sample_transaction)
 		perf_evsel__set_sample_bit(evsel, TRANSACTION);
 
+	if (opts->block)
+		attr->block = true;
+
 	if (opts->running_time) {
 		evsel->attr.read_format |=
 			PERF_FORMAT_TOTAL_TIME_ENABLED |
-- 
2.17.2

