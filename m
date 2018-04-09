Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754211AbeDITfS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754195AbeDITfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:35:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368A6217D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/13] perf hists browser: Remove leftover from row returned from refresh
Date: Mon,  9 Apr 2018 16:34:33 -0300
Message-Id: <20180409193437.14199-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180409193437.14199-1-acme@kernel.org>
References: <20180409193437.14199-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
