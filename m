Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbeCEO35 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:29:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751874AbeCEO3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:29:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8331E21770
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <Kan.liang@intel.com>, Kan Liang <kan.liang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/28] perf top: Fix annoying fallback message on older kernels
Date: Mon,  5 Mar 2018 11:29:08 -0300
Message-Id: <20180305142932.16921-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <Kan.liang@intel.com>

On older (e.g. v4.4) kernels, an annoying fallback message can be
observed in 'perf top':

	┌─Warning:──────────────────────┐
	│fall back to non-overwrite mode│
	│                               │
	│                               │
	│Press any key...               │
	└───────────────────────────────┘

The 'perf top' utility has been changed to overwrite mode since commit
ebebbf082357 ("perf top: Switch default mode to overwrite mode").

For older kernels which don't have overwrite mode support, 'perf top'
will fall back to non-overwrite mode and print out the fallback message
using ui__warning(), which needs user's input to close.

The fallback message is not critical for end users. Turning it to debug
message which is printed when running with -vv.

Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kan Liang <kan.liang@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Link: http://lkml.kernel.org/r/1519669030-176549-1-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b7c823ba8374..35ac016fcb98 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -991,7 +991,7 @@ static int perf_top_overwrite_fallback(struct perf_top *top,
 	evlist__for_each_entry(evlist, counter)
 		counter->attr.write_backward = false;
 	opts->overwrite = false;
-	ui__warning("fall back to non-overwrite mode\n");
+	pr_debug2("fall back to non-overwrite mode\n");
 	return 1;
 }
 
-- 
2.14.3
