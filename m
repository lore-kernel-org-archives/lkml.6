Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbeDTOfK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 10:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755349AbeDTOda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 10:33:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59DE2217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/17] perf record: Remove misleading error suggestion
Date: Fri, 20 Apr 2018 11:32:22 -0300
Message-Id: <20180420143227.16030-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180420143227.16030-1-acme@kernel.org>
References: <20180420143227.16030-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

When perf record encounters an error setting up an event it suggests
to enable CONFIG_PERF_EVENTS. This is misleading because:

- Usually it is enabled (it is really hard to disable on x86)

- The problem is usually somewhere else, e.g. the CPU is not supported
or an invalid configuration has been used.

Remove the misleading suggestion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1ac8d9236efd..66b62570c855 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2894,8 +2894,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"/bin/dmesg may provide additional information.\n"
-	"No CONFIG_PERF_EVENTS=y kernel support configured?",
+	"/bin/dmesg | grep -i perf may provide additional information.\n",
 			 err, str_error_r(err, sbuf, sizeof(sbuf)),
 			 perf_evsel__name(evsel));
 }
-- 
2.14.3
