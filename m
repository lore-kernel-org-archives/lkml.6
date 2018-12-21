Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2177C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9330205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391208AbeLUR5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391168AbeLUR5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:57:00 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EEAD21929;
        Fri, 21 Dec 2018 17:57:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2h-0002TF-Ew; Fri, 21 Dec 2018 12:56:59 -0500
Message-Id: <20181221175659.352294134@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@linux.intel.com>
Subject: [for-next][PATCH 24/24] tracing: Use strncmp_prefix() helper for histogram code
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The tracing histogram code contains a lot of instances of the construct:

 strncmp(str, "const", sizeof("const") - 1)

This can be prone to bugs due to typos or bad cut and paste. Use the
strncmp_prefix() helper macro instead that removes the need for having two
copies of the constant string.

Cc: Tom Zanussi <zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c5448c103770..a11653ac7087 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1881,8 +1881,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) ||
-	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
+	if ((strncmp_prefix(str, "onmatch(") == 0) ||
+	    (strncmp_prefix(str, "onmax(") == 0)) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1899,34 +1899,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
-	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
+	if ((strncmp_prefix(str, "key=") == 0) ||
+	    (strncmp_prefix(str, "keys=") == 0)) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0) ||
-		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0) ||
-		 (strncmp(str, "values=", sizeof("values=") - 1) == 0)) {
+	} else if ((strncmp_prefix(str, "val=") == 0) ||
+		   (strncmp_prefix(str, "vals=") == 0) ||
+		   (strncmp_prefix(str, "values=") == 0)) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) == 0) {
+	} else if (strncmp_prefix(str, "sort=") == 0) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", sizeof("name=") - 1) == 0) {
+	} else if (strncmp_prefix(str, "name=") == 0) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) == 0) {
+	} else if (strncmp_prefix(str, "clock=") == 0) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1939,7 +1939,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", sizeof("size=") - 1) == 0) {
+	} else if (strncmp_prefix(str, "size=") == 0) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -3558,7 +3558,7 @@ static struct action_data *onmax_parse(char *str)
 	if (!onmax_fn_name || !str)
 		goto free;
 
-	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) == 0) {
+	if (strncmp_prefix(onmax_fn_name, "save") == 0) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
@@ -4346,7 +4346,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) {
+		if (strncmp_prefix(str, "onmatch(") == 0) {
 			char *action_str = str + sizeof("onmatch(") - 1;
 
 			data = onmatch_parse(tr, action_str);
@@ -4355,7 +4355,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0) {
+		} else if (strncmp_prefix(str, "onmax(") == 0) {
 			char *action_str = str + sizeof("onmax(") - 1;
 
 			data = onmax_parse(action_str);
-- 
2.19.2


