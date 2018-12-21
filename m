Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC708C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0019218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391299AbeLUR5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391150AbeLUR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:59 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 821EE2197E;
        Fri, 21 Dec 2018 17:56:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2f-0002NN-Ig; Fri, 21 Dec 2018 12:56:57 -0500
Message-Id: <20181221175657.471685006@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 13/24] tracing: Change strlen to sizeof for hist trigger static strings
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

There's no need to use strlen() for static strings when the length is
already known, so update trace_events_hist.c with sizeof() for those
cases.

Link: http://lkml.kernel.org/r/e3e754f2bd18e56eaa8baf79bee619316ebf4cfc.1545161087.git.tom.zanussi@linux.intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 38 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index d29bf8a8e1dd..25d06b3ae1f6 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -507,7 +507,7 @@ static int synth_field_string_size(char *type)
 	start = strstr(type, "char[");
 	if (start == NULL)
 		return -EINVAL;
-	start += strlen("char[");
+	start += sizeof("char[") - 1;
 
 	end = strchr(type, ']');
 	if (!end || end < start)
@@ -1843,8 +1843,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
 	if (attrs->n_actions >= HIST_ACTIONS_MAX)
 		return ret;
 
-	if ((strncmp(str, "onmatch(", strlen("onmatch(")) == 0) ||
-	    (strncmp(str, "onmax(", strlen("onmax(")) == 0)) {
+	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) ||
+	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0)) {
 		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
 		if (!attrs->action_str[attrs->n_actions]) {
 			ret = -ENOMEM;
@@ -1861,34 +1861,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 {
 	int ret = 0;
 
-	if ((strncmp(str, "key=", strlen("key=")) == 0) ||
-	    (strncmp(str, "keys=", strlen("keys=")) == 0)) {
+	if ((strncmp(str, "key=", sizeof("key=") - 1) == 0) ||
+	    (strncmp(str, "keys=", sizeof("keys=") - 1) == 0)) {
 		attrs->keys_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->keys_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if ((strncmp(str, "val=", strlen("val=")) == 0) ||
-		 (strncmp(str, "vals=", strlen("vals=")) == 0) ||
-		 (strncmp(str, "values=", strlen("values=")) == 0)) {
+	} else if ((strncmp(str, "val=", sizeof("val=") - 1) == 0) ||
+		 (strncmp(str, "vals=", sizeof("vals=") - 1) == 0) ||
+		 (strncmp(str, "values=", sizeof("values=") - 1) == 0)) {
 		attrs->vals_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->vals_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "sort=", strlen("sort=")) == 0) {
+	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) == 0) {
 		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
 		if (!attrs->sort_key_str) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "name=", strlen("name=")) == 0) {
+	} else if (strncmp(str, "name=", sizeof("name=") - 1) == 0) {
 		attrs->name = kstrdup(str, GFP_KERNEL);
 		if (!attrs->name) {
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "clock=", strlen("clock=")) == 0) {
+	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) == 0) {
 		strsep(&str, "=");
 		if (!str) {
 			ret = -EINVAL;
@@ -1901,7 +1901,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
 			ret = -ENOMEM;
 			goto out;
 		}
-	} else if (strncmp(str, "size=", strlen("size=")) == 0) {
+	} else if (strncmp(str, "size=", sizeof("size=") - 1) == 0) {
 		int map_bits = parse_map_size(str);
 
 		if (map_bits < 0) {
@@ -3497,7 +3497,7 @@ static struct action_data *onmax_parse(char *str)
 	if (!onmax_fn_name || !str)
 		goto free;
 
-	if (strncmp(onmax_fn_name, "save", strlen("save")) == 0) {
+	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) == 0) {
 		char *params = strsep(&str, ")");
 
 		if (!params) {
@@ -4302,8 +4302,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 	for (i = 0; i < hist_data->attrs->n_actions; i++) {
 		str = hist_data->attrs->action_str[i];
 
-		if (strncmp(str, "onmatch(", strlen("onmatch(")) == 0) {
-			char *action_str = str + strlen("onmatch(");
+		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) == 0) {
+			char *action_str = str + sizeof("onmatch(") - 1;
 
 			data = onmatch_parse(tr, action_str);
 			if (IS_ERR(data)) {
@@ -4311,8 +4311,8 @@ static int parse_actions(struct hist_trigger_data *hist_data)
 				break;
 			}
 			data->fn = action_trace;
-		} else if (strncmp(str, "onmax(", strlen("onmax(")) == 0) {
-			char *action_str = str + strlen("onmax(");
+		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) == 0) {
+			char *action_str = str + sizeof("onmax(") - 1;
 
 			data = onmax_parse(action_str);
 			if (IS_ERR(data)) {
@@ -5548,9 +5548,9 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 			p++;
 			continue;
 		}
-		if (p >= param + strlen(param) - strlen("if") - 1)
+		if (p >= param + strlen(param) - (sizeof("if") - 1) - 1)
 			return -EINVAL;
-		if (*(p + strlen("if")) != ' ' && *(p + strlen("if")) != '\t') {
+		if (*(p + sizeof("if") - 1) != ' ' && *(p + sizeof("if") - 1) != '\t') {
 			p++;
 			continue;
 		}
-- 
2.19.2


