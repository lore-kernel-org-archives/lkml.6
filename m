Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F4EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9BBF21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391198AbeLUR5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391156AbeLUR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:59 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CF921939;
        Fri, 21 Dec 2018 17:56:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2g-0002Oy-4G; Fri, 21 Dec 2018 12:56:58 -0500
Message-Id: <20181221175658.015569158@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 16/24] tracing: Use hist triggers var_ref array to destroy var_refs
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Since every var ref for a trigger has an entry in the var_ref[] array,
use that to destroy the var_refs, instead of piecemeal via the field
expressions.

This allows us to avoid having to keep and treat differently separate
lists for the action-related references, which future patches will
remove.

Link: http://lkml.kernel.org/r/fad1a164f0e257c158e70d6eadbf6c586e04b2a2.1545161087.git.tom.zanussi@linux.intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6309f4dbfb9c..923c572ee68d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2190,6 +2190,15 @@ static int contains_operator(char *str)
 	return field_op;
 }
 
+static void __destroy_hist_field(struct hist_field *hist_field)
+{
+	kfree(hist_field->var.name);
+	kfree(hist_field->name);
+	kfree(hist_field->type);
+
+	kfree(hist_field);
+}
+
 static void destroy_hist_field(struct hist_field *hist_field,
 			       unsigned int level)
 {
@@ -2201,14 +2210,13 @@ static void destroy_hist_field(struct hist_field *hist_field,
 	if (!hist_field)
 		return;
 
+	if (hist_field->flags & HIST_FIELD_FL_VAR_REF)
+		return; /* var refs will be destroyed separately */
+
 	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++)
 		destroy_hist_field(hist_field->operands[i], level + 1);
 
-	kfree(hist_field->var.name);
-	kfree(hist_field->name);
-	kfree(hist_field->type);
-
-	kfree(hist_field);
+	__destroy_hist_field(hist_field);
 }
 
 static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
@@ -2335,6 +2343,12 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
 			hist_data->fields[i] = NULL;
 		}
 	}
+
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		WARN_ON(!(hist_data->var_refs[i]->flags & HIST_FIELD_FL_VAR_REF));
+		__destroy_hist_field(hist_data->var_refs[i]);
+		hist_data->var_refs[i] = NULL;
+	}
 }
 
 static int init_var_ref(struct hist_field *ref_field,
-- 
2.19.2


