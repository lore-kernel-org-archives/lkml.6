Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeBZSaM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 13:30:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:30230 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750986AbeBZSaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 13:30:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="207119539"
From: kan.liang@intel.com
To: mingo@kernel.org, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, Kan Liang <Kan.liang@intel.com>
Subject: [PATCH] perf top: Fix annoying fallback message on older kernel
Date: Mon, 26 Feb 2018 10:17:10 -0800
Message-Id: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <Kan.liang@intel.com>

On older (v4.4) kernels, the annoying fallback message can be observed
in 'perf top'.

The 'perf top' has been changed to overwrite mode since
'commit ebebbf082357 ("perf top: Switch default mode to overwrite mode")'
For the older kernels which don't have overwrite mode support, the 'perf
top' will fall back to non-overwrite mode and print out the fallback
message by ui__warning, which needs user's input to close.

The fallback message is not critical message for end users. Turning it
to debug message which is printed when running with -vv.

Fixes: ebebbf082357 ("perf top: Switch default mode to overwrite mode")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kan Liang <Kan.liang@intel.com>
---
 tools/perf/builtin-top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index b7c823b..35ac016 100644
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
2.7.4
