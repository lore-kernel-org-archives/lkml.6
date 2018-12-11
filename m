Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FDFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9088E214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544486580;
	bh=NDphBdM/AZN/57MTCfNqlLndpcp88jPafJAkid+WwRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=dDCB2mIgqI4Ayvqfoco0c9hFKbX+FDMqBWb1X9kMfcbIeUbywXf4VQ1MdusC6RfLC
	 HIfFpwPSYo89AkXIIYP53e3BK38pBYpB3xSQn5VD/PADWar575r03yoR/6afd0JPp3
	 UWKIA+vkOeW5vs6N0jTzL/ymgJK72RKdIV/dG9SY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9088E214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeLKAC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbeLKACQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:02:16 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D069214F0;
        Tue, 11 Dec 2018 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544486535;
        bh=NDphBdM/AZN/57MTCfNqlLndpcp88jPafJAkid+WwRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Se/BI0yZo8C/LJz+KR7mZTx7yUq6t4Q0jZ2ulAmso1I0/KuPsxlvi2DZvchEbcVFz
         r7Zcy07FZCB5VtksEXEyKzo+Rc9JUtNpwBPfjx2z2pdT0BFGtd17MqSOlQbHsTMZsT
         1Op47YVvDM4ehgPd7zsXQiJo3k9qFQDCdtHvEyB4=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH v8 19/22] tracing: Remove open-coding of hist trigger var_ref management
Date:   Mon, 10 Dec 2018 18:01:33 -0600
Message-Id: <f096c43e26f46d88f41bc187e620272c02d9d8d8.1544483273.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1544483272.git.tom.zanussi@linux.intel.com>
References: <cover.1544483272.git.tom.zanussi@linux.intel.com>
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

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 93 ++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 268f56bc12de..d07bb2d75e18 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1416,6 +1416,17 @@ static u64 hist_field_cpu(struct hist_field *hist_field,
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
@@ -1432,6 +1443,18 @@ check_field_for_var_ref(struct hist_field *hist_field,
 	return found;
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
@@ -1449,6 +1472,20 @@ static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 	return found;
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
@@ -1467,6 +1504,19 @@ static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
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
@@ -2465,7 +2515,23 @@ static int init_var_ref(struct hist_field *ref_field,
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
@@ -2479,6 +2545,9 @@ static struct hist_field *create_var_ref(struct hist_field *var_field,
 		}
 	}
 
+	hist_data->var_refs[hist_data->n_var_refs] = ref_field;
+	ref_field->var_ref_idx = hist_data->n_var_refs++;
+
 	return ref_field;
 }
 
@@ -2550,7 +2619,8 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
 
 	var_field = find_event_var(hist_data, system, event_name, var_name);
 	if (var_field)
-		ref_field = create_var_ref(var_field, system, event_name);
+		ref_field = create_var_ref(hist_data, var_field,
+					   system, event_name);
 
 	if (!ref_field)
 		hist_err_event("Couldn't find variable: $",
@@ -2668,8 +2738,6 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
 	if (!s) {
 		hist_field = parse_var_ref(hist_data, ref_system, ref_event, ref_var);
 		if (hist_field) {
-			hist_data->var_refs[hist_data->n_var_refs] = hist_field;
-			hist_field->var_ref_idx = hist_data->n_var_refs++;
 			if (var_name) {
 				hist_field = create_alias(hist_data, hist_field, var_name);
 				if (!hist_field) {
@@ -3650,7 +3718,6 @@ static int track_data_create(struct hist_trigger_data *hist_data,
 	struct hist_field *var_field, *ref_field, *track_var = NULL;
 	struct trace_event_file *file = hist_data->event_file;
 	char *track_data_var_str;
-	unsigned long flags;
 	int ret = 0;
 
 	track_data_var_str = data->track_data.var_str;
@@ -3666,18 +3733,10 @@ static int track_data_create(struct hist_trigger_data *hist_data,
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
 	data->track_data.var_ref = ref_field;
 
 	if (data->handler == HANDLER_ONMAX)
@@ -3944,9 +4003,6 @@ static void save_synth_var_ref(struct hist_trigger_data *hist_data,
 			 struct hist_field *var_ref)
 {
 	hist_data->synth_var_refs[hist_data->n_synth_var_refs++] = var_ref;
-
-	hist_data->var_refs[hist_data->n_var_refs] = var_ref;
-	var_ref->var_ref_idx = hist_data->n_var_refs++;
 }
 
 static int check_synth_field(struct synth_event *event,
@@ -4109,7 +4165,8 @@ static int trace_action_create(struct hist_trigger_data *hist_data,
 		}
 
 		if (check_synth_field(event, hist_field, field_pos) == 0) {
-			var_ref = create_var_ref(hist_field, system, event_name);
+			var_ref = create_var_ref(hist_data, hist_field,
+						 system, event_name);
 			if (!var_ref) {
 				kfree(p);
 				ret = -ENOMEM;
-- 
2.14.1

