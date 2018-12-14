Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ACBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8825F2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbeLNUUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:20:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60891 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbeLNUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:20:45 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKK7Zk1450800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:20:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKK7G01450796;
        Fri, 14 Dec 2018 12:20:07 -0800
Date:   Fri, 14 Dec 2018 12:20:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-fd0046c4b95f11ff7abe85ba959b3245accfa68a@git.kernel.org>
Cc:     tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        jolsa@kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, acme@redhat.com, eranian@google.com,
          tglx@linutronix.de, peterz@infradead.org
In-Reply-To: <1541587845-9150-1-git-send-email-eranian@google.com>
References: <1541587845-9150-1-git-send-email-eranian@google.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf stat: Fix CSV mode column output for
 non-cgroup events
Git-Commit-ID: fd0046c4b95f11ff7abe85ba959b3245accfa68a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fd0046c4b95f11ff7abe85ba959b3245accfa68a
Gitweb:     https://git.kernel.org/tip/fd0046c4b95f11ff7abe85ba959b3245accfa68a
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Wed, 7 Nov 2018 02:50:45 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:46 -0300

perf stat: Fix CSV mode column output for non-cgroup events

When using the -x option, perf stat prints CSV-style output with one
event per line.  For each event, it prints the count, the unit, the
event name, the cgroup, and a bunch of other event specific fields (such
as insn per cycles).

When you use CSV-style mode, you expect a normalized output where each
event is printed with the same number of fields regardless of what it is
so it can easily be imported into a spreadsheet or parsed.

For instance, if an event does not have a unit, then print an empty
field for it.

Although this approach was implemented for the unit, it was not for the
cgroup.

When mixing cgroup and non-cgroup events, then non-cgroup events would
not show an empty field, instead the next field was printed, make
columns not line up correctly.

This patch fixes the cgroup output issues by forcing an empty field
for non-cgroup events as soon as one event has cgroup.

Before:

  <not counted> @ @cycles @foo    @ 0    @100.00@@
  2531614       @ @cycles @6420922@100.00@    @

foo cgroup lines up with time_running!

After:

  <not counted> @ @cycles @foo @0       @100.00@@
  2594834       @ @cycles @    @5287372 @100.00@@

Fields line up.

Signed-off-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1541587845-9150-1-git-send-email-eranian@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index e7b4c44ebb62..665ee374fc01 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -59,6 +59,15 @@ static void print_noise(struct perf_stat_config *config,
 	print_noise_pct(config, stddev_stats(&ps->res_stats[0]), avg);
 }
 
+static void print_cgroup(struct perf_stat_config *config, struct perf_evsel *evsel)
+{
+	if (nr_cgroups) {
+		const char *cgrp_name = evsel->cgrp ? evsel->cgrp->name  : "";
+		fprintf(config->output, "%s%s", config->csv_sep, cgrp_name);
+	}
+}
+
+
 static void aggr_printout(struct perf_stat_config *config,
 			  struct perf_evsel *evsel, int id, int nr)
 {
@@ -336,8 +345,7 @@ static void abs_printout(struct perf_stat_config *config,
 
 	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
 
-	if (evsel->cgrp)
-		fprintf(output, "%s%s", config->csv_sep, evsel->cgrp->name);
+	print_cgroup(config, evsel);
 }
 
 static bool is_mixed_hw_group(struct perf_evsel *counter)
@@ -431,9 +439,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			config->csv_output ? 0 : -25,
 			perf_evsel__name(counter));
 
-		if (counter->cgrp)
-			fprintf(config->output, "%s%s",
-				config->csv_sep, counter->cgrp->name);
+		print_cgroup(config, counter);
 
 		if (!config->csv_output)
 			pm(config, &os, NULL, NULL, "", 0);
