Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A61F218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391311AbeLUR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:57:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391154AbeLUR47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:59 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3287219C2;
        Fri, 21 Dec 2018 17:56:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2f-0002OR-Vb; Fri, 21 Dec 2018 12:56:57 -0500
Message-Id: <20181221175657.855549331@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 15/24] tracing: Remove open-coding of hist trigger var_ref management
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Have create_var_ref() manage the hist trigger's var_ref list, rather
than having similar code doing it in multiple places.  This cleans up
the code and makes sure var_refs are always accounted properly.

Also, document the var_ref-related functions to make what their
purpose clearer.

Link: http://lkml.kernel.org/r/05ddae93ff514e66fc03897d6665231892939913.1545161087.git.tom.zanussi@linux.intel.com

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 93 +++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f3caf6e484f4..6309f4dbfb9c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1292,6 +1292,17 @@ static u64 hist_field_cpu(struct hist_field *hist_field,
 	return cpu;
 }
 
+/**
+ * check_field_for_var_ref - Check if a VAR_REF field references a variable
+ * @hist_field: The VAR_REF field to check
+ * @var_data: The hist trigger that owns the variable
+ * @var_idx: The trigger variable identifier
+ *
+ * Check the given VAR_REF field to see whether or not it references
+ * the given variable associated with the given trigger.
+ *
+ * Return: The VAR_REF field if it does reference the variable, NULL if not
+ */
 static struct hist_field *
 check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
@@ -1306,6 +1317,18 @@ check_field_for_var_ref(struct hist_field *hist_field,
 	return NULL;
 }
 
+/**
+ * find_var_ref - Check if a trigger has a reference to a trigger variable
+ * @hist_data: The hist trigger that might have a reference to the variable
+ * @var_data: The hist trigger that owns the variable
+ * @var_idx: The trigger variable identifier
+ *
+ * Check the list of var_refs[] on the first hist trigger to see
+ * whether any of them are references to the variable on the second
+ * trigger.
+ *
+ * Return: The VAR_REF field referencing the variable if so, NULL if not
+ */
 static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 				       struct hist_trigger_data *var_data,
 				       unsigned int var_idx)
@@ -1322,6 +1345,20 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 	return NULL;
 }
 
+/**
+ * find_any_var_ref - Check if there is a reference to a given trigger variable
+ * @hist_data: The hist trigger
+ * @var_idx: The trigger variable identifier
+ *
+ * Check to see whether the given variable is currently referenced by
+ * any other trigger.
+ *
+ * The trigger the variable is defined on is explicitly excluded - the
+ * assumption being that a self-reference doesn't prevent a trigger
+ * from being removed.
+ *
+ * Return: The VAR_REF field referencing the variable if so, NULL if not
+ */
 static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 					   unsigned int var_idx)
 {
@@ -1340,6 +1377,19 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
 	return found;
 }
 
+/**
+ * check_var_refs - Check if there is a reference to any of trigger's variables
+ * @hist_data: The hist trigger
+ *
+ * A trigger can define one or more variables.  If any one of them is
+ * currently referenced by any other trigger, this function will
+ * determine that.
+
+ * Typically used to determine whether or not a trigger can be removed
+ * - if there are any references to a trigger's variables, it cannot.
+ *
+ * Return: True if there is a reference to any of trigger's variables
+ */
 static bool check_var_refs(struct hist_trigger_data *hist_data)
 {
 	struct hist_field *field;
@@ -2343,7 +2393,23 @@ static int init_var_ref(struct hist_field *ref_field,
 	goto out;
 }
 
-static struct hist_field *create_var_ref(struct hist_field *var_field,
+/**
+ * create_var_ref - Create a variable reference and attach it to trigger
+ * @hist_data: The trigger that will be referencing the variable
+ * @var_field: The VAR field to create a reference to
+ * @system: The optional system string
+ * @event_name: The optional event_name string
+ *
+ * Given a variable hist_field, create a VAR_REF hist_field that
+ * represents a reference to it.
+ *
+ * This function also adds the reference to the trigger that
+ * now references the variable.
+ *
+ * Return: The VAR_REF field if successful, NULL if not
+ */
+static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
+					 struct hist_field *var_field,
 					 char *system, char *event_name)
 {
 	unsigned long flags = HIST_FIELD_FL_VAR_REF;
@@ -2355,6 +2421,9 @@ static struct hist_field *create_var_ref(struct hist_field *var_field,
 			destroy_hist_field(ref_field, 0);
 			return NULL;
 		}
+
+		hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+		ref_field->var_ref_idx = hist_data->n_var_refs++;
 	}
 
 	return ref_field;
@@ -2428,7 +2497,8 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 
 	var_field = find_event_var(hist_data, system, event_name, var_name);
 	if (var_field)
-		ref_field = create_var_ref(var_field, system, event_name);
+		ref_field = create_var_ref(hist_data, var_field,
+					   system, event_name);
 
 	if (!ref_field)
 		hist_err_event("Couldn't find variable: $",
@@ -2546,8 +2616,6 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	if (!s) {
 		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
 		if (hist_field) {
-			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
-			hist_field->var_ref_idx = hist_data->n_var_refs++;
 			if (var_name) {
 				hist_field = create_alias(hist_data, hist_field, var_name);
 				if (!hist_field) {
@@ -3321,7 +3389,6 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 	unsigned int var_ref_idx = hist_data->n_var_refs;
 	struct field_var *field_var;
 	char *onmax_var_str, *param;
-	unsigned long flags;
 	unsigned int i;
 	int ret = 0;
 
@@ -3338,18 +3405,10 @@ static int onmax_create(struct hist_trigger_data *hist_data,
 		return -EINVAL;
 	}
 
-	flags = HIST_FIELD_FL_VAR_REF;
-	ref_field = create_hist_field(hist_data, NULL, flags, NULL);
+	ref_field = create_var_ref(hist_data, var_field, NULL, NULL);
 	if (!ref_field)
 		return -ENOMEM;
 
-	if (init_var_ref(ref_field, var_field, NULL, NULL)) {
-		destroy_hist_field(ref_field, 0);
-		ret = -ENOMEM;
-		goto out;
-	}
-	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
-	ref_field->var_ref_idx = hist_data->n_var_refs++;
 	data->onmax.var = ref_field;
 
 	data->fn = onmax_save;
@@ -3538,9 +3597,6 @@ static void save_synth_var_ref(struct hist_trigger_data *hist_data,
 			 struct hist_field *var_ref)
 {
 	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-
-	hist_data->var_refs[hist_data->n_var_refs] = var_ref;
-	var_ref->var_ref_idx = hist_data->n_var_refs++;
 }
 
 static int check_synth_field(struct synth_event *event,
@@ -3694,7 +3750,8 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 		}
 
 		if (check_synth_field(event, hist_field, field_pos) == 0) {
-			var_ref = create_var_ref(hist_field, system, event_name);
+			var_ref = create_var_ref(hist_data, hist_field,
+						 system, event_name);
 			if (!var_ref) {
 				kfree(p);
 				ret = -ENOMEM;
-- 
2.19.2


