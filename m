Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752591AbeDFL0R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbeDFLZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:25:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AC99217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 3/6] perf annotate browser: Fixup vertical line separating metrics from instructions
Date: Fri,  6 Apr 2018 08:24:36 -0300
Message-Id: <20180406112439.21685-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180406112439.21685-1-acme@kernel.org>
References: <20180406112439.21685-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that we can have extra title lines we should use ui_browser->rows
and not ->height when drawing lines, as it will use ui_browser__gotorc()
and that will take the extra title lines into account, which was causing
an off by one at the end of the vertical line drawn by
__ui_browser__vline(), fix it.

The visual effect was that the last line, with status messages, was
being overwritten by the vertical line, looking like:

Press 'h' for help on│key bindings

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: ef9ff6017e3c ("perf ui browser: Move the extra title lines from the hists browser")
Link: https://lkml.kernel.org/n/tip-08y1ln3xjn76zvizz1i1dsvn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 78bcd220f1b6..12c099a87f8b 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -218,7 +218,7 @@ static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 		annotate_browser__draw_current_jump(browser);
 
 	ui_browser__set_color(browser, HE_COLORSET_NORMAL);
-	__ui_browser__vline(browser, pcnt_width, 0, browser->height - 1);
+	__ui_browser__vline(browser, pcnt_width, 0, browser->rows - 1);
 	return ret;
 }
 
-- 
2.14.3
