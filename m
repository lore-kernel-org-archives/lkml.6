Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5763C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FC0218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900883;
	bh=dCPESDjZWOA6hnQ0Ai4567Y/M4VnAQS0tDUfPuk5Lzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FIUXXUGb8tJydWZz21QR1U3X/ZkzttNYBVR4wM2mdiF/XajY+XpPV+TStG2dQxkcR
	 S31bviavJqCmPvtI1T39tA2pgvS8wnDUbmESOaBaeeDompkzNr2NkypDyjzPX7/vPg
	 zJdazWV6/aEltlSo5kLAYGMK6p3WqLwFiNbVq3IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbfBKObR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:31:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730264AbfBKObO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E841620675;
        Mon, 11 Feb 2019 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895473;
        bh=dCPESDjZWOA6hnQ0Ai4567Y/M4VnAQS0tDUfPuk5Lzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ljJVCF7T9r38Ry3HCmGHGxCUo7eGpfco52h97hKAGmn7Pq73Ibjitz/fZXx+5Rzjr
         CVZGfDXh0oPRwPgRrIBGdVggosGkf0QCsCxbIDHlzi2oibVNH9JgjJASkDB99xmC/t
         +Uk8NUw4TZktpTFgiuqRlrXPjNtTzPWS6BT7pdGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 185/352] perf stat: Fix CSV mode column output for non-cgroup events
Date:   Mon, 11 Feb 2019 15:16:52 +0100
Message-Id: <20190211141858.884488697@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bc4da38a4789e7819fca4c7723ded0b86aea27c0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1



