Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752430AbeDJF3a (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 01:29:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57669 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbeDJF32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 01:29:28 -0400
Date: Mon, 9 Apr 2018 22:29:16 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-odryfso74eaarm0z3e4v9owx@git.kernel.org>
Cc: acme@redhat.com, wangnan0@huawei.com, yao.jin@linux.intel.com,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, namhyung@kernel.org,
        dsahern@gmail.com, mingo@kernel.org, ak@linux.intel.com
Reply-To: acme@redhat.com, wangnan0@huawei.com, yao.jin@linux.intel.com,
        tglx@linutronix.de, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, dsahern@gmail.com,
        mingo@kernel.org, namhyung@kernel.org, ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists browser: Remove leftover from row
 returned from refresh
Git-Commit-ID: 94e87a8bd529121ea90219164c65c36ea1d19e56
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

Commit-ID:  94e87a8bd529121ea90219164c65c36ea1d19e56
Gitweb:     https://git.kernel.org/tip/94e87a8bd529121ea90219164c65c36ea1d19e56
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 6 Apr 2018 12:11:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 6 Apr 2018 12:23:25 -0300

perf hists browser: Remove leftover from row returned from refresh

The per-browser screen refresh routine (ui_browser->refresh()) should
return the first row that should be cleaned after the rows just printed,
in case not all rows available on the screen gets filled.

When moving the extra title lines logic from the hists browser to the
generic ui_browser class, one piece of that logic remained in the hists
browser and then when going back from the annotate browser to the hists
browser in a case where fewer lines were displayed in the hists browser,
for instance when filtering the entries per substring, one line of the
annotate browser would remain on the screen, fix that.

Example of the screen artifact:

================================================================================
Samples: 73K of event 'cycles:ppp', 4000 Hz, Event count (approx.): 45172901394
Overhead  Shared O  Symbol
   0.30%  [kernel]  [k] __indirect_thunk_start
   0.09%  [kernel]  [k] __x86_indirect_thunk_r10
       │      lfence
================================================================================

Here from 'perf top' the view was zoomed with '/thunk' to functions
having that substring, then the first was annotated and from the
annotate browser ESC was pressed, then the first lines were overwritten,
but the 'lfence' line remained due to the off by one bug fixed in this
cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ef9ff6017e3c ("perf ui browser: Move the extra title lines from the hists browser")
Link: https://lkml.kernel.org/n/tip-odryfso74eaarm0z3e4v9owx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index de17e59d9952..0eec06c105c6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -1744,17 +1744,11 @@ static void ui_browser__hists_init_top(struct ui_browser *browser)
 static unsigned int hist_browser__refresh(struct ui_browser *browser)
 {
 	unsigned row = 0;
-	u16 header_offset = 0;
 	struct rb_node *nd;
 	struct hist_browser *hb = container_of(browser, struct hist_browser, b);
-	struct hists *hists = hb->hists;
-
-	if (hb->show_headers) {
-		struct perf_hpp_list *hpp_list = hists->hpp_list;
 
+	if (hb->show_headers)
 		hist_browser__show_headers(hb);
-		header_offset = hpp_list->nr_header_lines;
-	}
 
 	ui_browser__hists_init_top(browser);
 	hb->he_selection = NULL;
@@ -1792,7 +1786,7 @@ static unsigned int hist_browser__refresh(struct ui_browser *browser)
 			break;
 	}
 
-	return row + header_offset;
+	return row;
 }
 
 static struct rb_node *hists__filter_entries(struct rb_node *nd,
