Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeB0WfQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 17:35:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:45138 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeB0WfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 17:35:13 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3D51601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=agustinv@codeaurora.org
From: Agustin Vega-Frias <agustinv@codeaurora.org>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>
Cc: timur@codeaurora.org, agustinv@codeaurora.org
Subject: [RFC 1/3] perf, tools: Support wildcards on pmu name in dynamic pmu events
Date: Tue, 27 Feb 2018 17:34:06 -0500
Message-Id: <1519770848-26738-2-git-send-email-agustinv@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
References: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting on v4.12 event parsing code for dynamic pmu events already
supports prefix-based matching of multiple pmus when creating dynamic
events. E.g., in a system with the following dynamic pmus:

    mypmu_0
    mypmu_1
    mypmu_2
    mypmu_4

passing mypmu/<config>/ as an event spec will result in the creation
of the event in all of the pmus. This change expands this matching
through the use of fnmatch so glob-like expressions can be used to
create events in multiple pmus. E.g., in the system described above
if a user only wants to create the event in mypmu_0 and mypmu_1,
mypmu_[01]/<config>/ can be passed.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 tools/perf/util/parse-events.l | 2 +-
 tools/perf/util/parse-events.y | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 655ecff..a1a01b1 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -175,7 +175,7 @@ bpf_source	[^,{}]+\.c[a-zA-Z0-9._]*
 num_dec		[0-9]+
 num_hex		0x[a-fA-F0-9]+
 num_raw_hex	[a-fA-F0-9]+
-name		[a-zA-Z_*?][a-zA-Z0-9_*?.]*
+name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]]*
 name_minus	[a-zA-Z_*?][a-zA-Z0-9\-_*?.:]*
 drv_cfg_term	[a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
 /* If you add a modifier you need to update check_modifier() */
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index e81a20e..c528469 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -8,6 +8,7 @@

 #define YYDEBUG 1

+#include <fnmatch.h>
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
@@ -241,7 +242,7 @@ PE_NAME opt_event_config
 			if (!strncmp(name, "uncore_", 7) &&
 			    strncmp($1, "uncore_", 7))
 				name += 7;
-			if (!strncmp($1, name, strlen($1))) {
+			if (!strncmp($1, name, strlen($1)) || !fnmatch($1, name, 0)) {
 				if (parse_events_copy_term_list(orig_terms, &terms))
 					YYABORT;
 				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms))
--
2.7.4
