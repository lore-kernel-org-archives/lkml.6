Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD125C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015221479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131605;
	bh=rOwPVmKKkaUiY3zq8NE48+pupninZU1H7c6bdH7Afcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y1DiuFDtf8zPrFui0hD+ssUci2e59yoB25OYR6oKZ4ZEoSS5IIv2i35U6jfFmG5lC
	 nS93qUmJI9Mv02z66XK/c3MWtpYCXDK5G7FK8mVNjny2qDksrtGLkEslCjjbW5S+8Q
	 ImFfQUncWIpbvy4l78TYJA6Jdg714AtVFff1bV/w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9015221479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbeLFV0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:45576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbeLFV0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:26:42 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE202208E7;
        Thu,  6 Dec 2018 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131601;
        bh=rOwPVmKKkaUiY3zq8NE48+pupninZU1H7c6bdH7Afcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYrO0XrI3rJho+ALyzuXgpNgPpJ4rNUta/RidKPRCyjFvZfZtz+tCJ6hAL/43DSoD
         DMUDoPxMTYrl8frN9syHURybpWsOo4Pp6Oq3AhmDss1PiHXcOSFZt3XhfZPBB7hx1J
         Ud0gDN3szRvKW20zSjEd2WxE1ELhOJKmJgQ1EgyU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/75] perf stat: Fix CSV mode column output for non-cgroup events
Date:   Thu,  6 Dec 2018 18:24:50 -0300
Message-Id: <20181206212602.20474-4-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

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
-- 
2.19.2

