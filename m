Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2710C41537
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7039F2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7039F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbeKTWgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:36:03 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:38590 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728494AbeKTWgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:36:03 -0500
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 20 Nov 2018 21:07:12 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO localhost.localdomain) (10.177.227.17)
        by 156.147.1.126 with ESMTP; 20 Nov 2018 21:07:12 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Miller <davem@davemloft.net>
Subject: [PATCH v2.1] perf ui/tui: Fix possible UI rendering breakage
Date:   Tue, 20 Nov 2018 21:07:11 +0900
Message-Id: <20181120120711.23955-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181120115120.21300-1-namhyung@kernel.org>
References: <20181120115120.21300-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tui_helpline__push() should acquire/release the ui__lock when it
deals with screen setting.  Otherwise it could race with display thread
and screen rendering would not be handled properly.

Also move helpline__push/pop out of ui__lock to prevent deadlock.

Fixes: e6e904687949 ("perf ui: Introduce struct ui_helpline")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
* use browser->helpline for display instead of helpline (format)

 tools/perf/ui/browser.c      |  7 ++++---
 tools/perf/ui/tui/helpline.c | 17 ++++++++++++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 4f75561424ed..2a99a0fbbcf6 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -294,16 +294,17 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 	va_start(ap, helpline);
 	err = vasprintf(&browser->helpline, helpline, ap);
 	va_end(ap);
-	if (err > 0)
-		ui_helpline__push(browser->helpline);
 	pthread_mutex_unlock(&ui__lock);
+
+	if (err > 0)
+		ui_helpline__push(browser->helpline);
 	return err ? 0 : -1;
 }
 
 void ui_browser__hide(struct ui_browser *browser)
 {
-	pthread_mutex_lock(&ui__lock);
 	ui_helpline__pop();
+	pthread_mutex_lock(&ui__lock);
 	zfree(&browser->helpline);
 	pthread_mutex_unlock(&ui__lock);
 }
diff --git a/tools/perf/ui/tui/helpline.c b/tools/perf/ui/tui/helpline.c
index 4ca799aadb4e..83b6eebb451a 100644
--- a/tools/perf/ui/tui/helpline.c
+++ b/tools/perf/ui/tui/helpline.c
@@ -12,6 +12,14 @@
 char ui_helpline__last_msg[1024];
 bool tui_helpline__set;
 
+static void tui_helpline__puts(const char *msg)
+{
+	SLsmg_gotorc(SLtt_Screen_Rows - 1, 0);
+	SLsmg_set_color(0);
+	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
+	SLsmg_refresh();
+}
+
 static void tui_helpline__pop(void)
 {
 }
@@ -20,11 +28,10 @@ static void tui_helpline__push(const char *msg)
 {
 	const size_t sz = sizeof(ui_helpline__current);
 
-	SLsmg_gotorc(SLtt_Screen_Rows - 1, 0);
-	SLsmg_set_color(0);
-	SLsmg_write_nstring((char *)msg, SLtt_Screen_Cols);
-	SLsmg_refresh();
+	pthread_mutex_lock(&ui__lock);
 	strncpy(ui_helpline__current, msg, sz)[sz - 1] = '\0';
+	tui_helpline__puts(msg);
+	pthread_mutex_unlock(&ui__lock);
 }
 
 static int tui_helpline__show(const char *format, va_list ap)
@@ -40,7 +47,7 @@ static int tui_helpline__show(const char *format, va_list ap)
 	tui_helpline__set = true;
 
 	if (ui_helpline__last_msg[backlog - 1] == '\n') {
-		ui_helpline__puts(ui_helpline__last_msg);
+		tui_helpline__puts(ui_helpline__last_msg);
 		SLsmg_refresh();
 		backlog = 0;
 	}
-- 
2.19.0

