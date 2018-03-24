Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753310AbeCXUEX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBD92172B
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
Subject: [PATCH 25/44] perf ui browser: Add vprintf() method
Date: Sat, 24 Mar 2018 17:01:52 -0300
Message-Id: <20180324200211.21326-26-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We'll need it for some callbacks for the upcoming
annotation__line_print() routines.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t3qiobj4ua38xzsq8cyw9ky5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c | 7 ++++++-
 tools/perf/ui/browser.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 63399af3049f..33c30325885f 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -56,12 +56,17 @@ void ui_browser__write_nstring(struct ui_browser *browser __maybe_unused, const
 	slsmg_write_nstring(msg, width);
 }
 
+void ui_browser__vprintf(struct ui_browser *browser __maybe_unused, const char *fmt, va_list args)
+{
+	slsmg_vprintf(fmt, args);
+}
+
 void ui_browser__printf(struct ui_browser *browser __maybe_unused, const char *fmt, ...)
 {
 	va_list args;
 
 	va_start(args, fmt);
-	slsmg_vprintf(fmt, args);
+	ui_browser__vprintf(browser, fmt, args);
 	va_end(args);
 }
 
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 03e1734412b9..9e69c6a43514 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -3,6 +3,7 @@
 #define _PERF_UI_BROWSER_H_ 1
 
 #include <linux/types.h>
+#include <stdarg.h>
 
 #define HE_COLORSET_TOP		50
 #define HE_COLORSET_MEDIUM	51
@@ -40,6 +41,7 @@ void ui_browser__reset_index(struct ui_browser *browser);
 void ui_browser__gotorc(struct ui_browser *browser, int y, int x);
 void ui_browser__write_nstring(struct ui_browser *browser, const char *msg,
 			       unsigned int width);
+void ui_browser__vprintf(struct ui_browser *browser, const char *fmt, va_list args);
 void ui_browser__printf(struct ui_browser *browser, const char *fmt, ...);
 void ui_browser__write_graph(struct ui_browser *browser, int graph);
 void __ui_browser__line_arrow(struct ui_browser *browser, unsigned int column,
-- 
2.14.3
