Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeCYWSp (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:18:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54131 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCYWSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:18:43 -0400
Date: Sun, 25 Mar 2018 15:18:33 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t3qiobj4ua38xzsq8cyw9ky5@git.kernel.org>
Cc: dsahern@gmail.com, tglx@linutronix.de, acme@redhat.com,
        adrian.hunter@intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, wangnan0@huawei.com,
        yao.jin@linux.intel.com, hpa@zytor.com, ak@linux.intel.com,
        jolsa@kernel.org
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
        tglx@linutronix.de, dsahern@gmail.com, ak@linux.intel.com,
        jolsa@kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        yao.jin@linux.intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ui browser: Add vprintf() method
Git-Commit-ID: c52202434de2bd3e0c447c6dce992266fd7fc589
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

Commit-ID:  c52202434de2bd3e0c447c6dce992266fd7fc589
Gitweb:     https://git.kernel.org/tip/c52202434de2bd3e0c447c6dce992266fd7fc589
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 17:52:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:30 -0300

perf ui browser: Add vprintf() method

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
