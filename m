Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeCFGmR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:42:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56983 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeCFGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:42:16 -0500
Date: Mon, 5 Mar 2018 22:42:08 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-853745f5e6d95faaae6381c9a01dbd43de992fb3@git.kernel.org>
Cc: acme@redhat.com, Kan.liang@intel.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, kan.liang@intel.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, Kan.liang@intel.com, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, kan.liang@intel.com,
        hpa@zytor.com
In-Reply-To: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
References: <1519669030-176549-1-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top: Fix annoying fallback message on older
 kernels
Git-Commit-ID: 853745f5e6d95faaae6381c9a01dbd43de992fb3
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  853745f5e6d95faaae6381c9a01dbd43de992fb3
Gitweb:     https://git.kernel.org/tip/853745f5e6d95faaae6381c9a01dbd43de992fb3
Author:     Kan Liang <Kan.liang@intel.com>
AuthorDate: Mon, 26 Feb 2018 10:17:10 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 26 Feb 2018 16:04:08 -0300

perf top: Fix annoying fallback message on older kernels

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
 
