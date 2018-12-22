Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8BCC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0A72197D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbeLVQrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:47:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeLVQrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:47:13 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FC8E21CEB;
        Sat, 22 Dec 2018 16:28:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gak93-0001GL-2V; Sat, 22 Dec 2018 11:28:57 -0500
Message-Id: <20181222162856.972056232@goodmis.org>
User-Agent: quilt/0.65
Date:   Sat, 22 Dec 2018 11:20:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 4/5] tracing: Have the historgram use the result of str_has_prefix() for
 len of prefix
References: <20181222162007.697862256@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

As str_has_prefix() returns the length on match, we can use that for the
updating of the string pointer instead of recalculating the prefix size.

Cc: Tom Zanussi  <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0d878dcd1e4b..449d90cfa151 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4342,12 +4342,13 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	unsigned int i;
 	int ret = 0;
 	char *str;
+	int len;
 
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (str_has_prefix(str, "onmatch(")) {
-			char *action_str = str + sizeof("onmatch(") - 1;
+		if ((len = str_has_prefix(str, "onmatch("))) {
+			char *action_str = str + len;
 
 			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data)) {
@@ -4355,8 +4356,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (str_has_prefix(str, "onmax(")) {
-			char *action_str = str + sizeof("onmax(") - 1;
+		} else if ((len = str_has_prefix(str, "onmax("))) {
+			char *action_str = str + len;
 
 			data = onmax_parse(action_str);
 			if (IS_ERR(data)) {
-- 
2.19.2


