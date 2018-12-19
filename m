Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEBD2080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYLRvYXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbeLSTJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:09:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35454 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbeLSTJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:09:20 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so10912035itp.0;
        Wed, 19 Dec 2018 11:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcGFm+WWDHMbNkU16anFiaUGHrZn3yGJ3Q07OiBG13g=;
        b=HYLRvYXdkfKHcAblKIBrGZVgbt4hEPc3QJM9MLgCXh8kKV8TP+RjeTiHZaf6nTWMpr
         rjTZbdqVfewSAkNQVJqPxdwb60qEXBRwk3BkMNguhDCUT5uoFhUJtER3pramCJMllIio
         ZxH2X0IEg1YuujLEyeW36ch8gTYon/CS1ns23/meqxHYYDxiS/1APcqi7YFQUWtIjBfU
         LDhHmaaxNxrbPuNu3IBI+9JPrwUKdi1pUSx6ZYJO0TL6en5Bn0GQJdwblfsH5WHbt/iJ
         ZvN6/mjkcu8q8lVQJYR5A7Vsqt/+3FvkV1r2uvBhz4FARLAgclRrh5VIVdWik1ApTpvS
         91Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pcGFm+WWDHMbNkU16anFiaUGHrZn3yGJ3Q07OiBG13g=;
        b=AtviUOMC+Id/VlwF+mvmLoZf+T0iebxPFc82pt3da2Ex0pxZfV3O/bLQDDY+kVr3qi
         573migdq1JGxT5AEjg5h9zDW8IrcjFI5Nk4nX3lWm70HG4BH27DSgysFROdkAodF6/vO
         aOMsZZqXQOARRnXfih/lhL453LWb4bkGPc91bCIaD8BbupGn/fZbsab4FN9JWRjK6+yC
         3kv+Lf4Jbfz5n1KO6GPxT3e27zUl9RRRAHZbbU1nA/kDVjVQLHrKOLs1DlAGLPlthxll
         g2/ThnSRN+nAjsdVaMcJENaZWqL92icvlpCEkxFbJ+Rb2Agn7OwinsgnsogibPD8SKs6
         Syag==
X-Gm-Message-State: AA+aEWa7W7cqmSUKIM4yu93CsyubuOIKQOs2b903SZ+vND7Kk4XO62X6
        zL1eL/xuPEe4k7Ee/WEG0+I=
X-Google-Smtp-Source: AFSGD/URCyFjb9IQQJKrZCpe9Re/8eFHLdfGsK1lwzTny8sDIuYHe/uLT3Etoso72w9L6XMS6qlAdQ==
X-Received: by 2002:a02:9b26:: with SMTP id o35mr20904426jak.23.1545246559092;
        Wed, 19 Dec 2018 11:09:19 -0800 (PST)
Received: from tzanussi-mobl ([2601:246:0:7004:2550:47d9:db89:e6e1])
        by smtp.googlemail.com with ESMTPSA id 196sm4367385itu.37.2018.12.19.11.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 11:09:18 -0800 (PST)
Message-ID: <1545246556.4239.7.camel@gmail.com>
Subject: [PATCH v2 3/7] tracing: Use var_refs[] for hist trigger reference
 checking
From:   Tom Zanussi <tzanussi@gmail.com>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 19 Dec 2018 13:09:16 -0600
In-Reply-To: <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
         <becb9627fb09681960f26809961b832be9591048.1545161087.git.tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all the variable reference hist_fields are collected into
hist_data->var_refs[] array, there's no need to go through all the
fields looking for them, or in separate arrays like synth_var_refs[],
which will be going away soon anyway.

This also allows us to get rid of some unnecessary code and functions
currently used for the same purpose.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 68 +++++++---------------------------------
 1 file changed, 11 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 25d06b3ae1f6..f3caf6e484f4 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1297,75 +1297,29 @@ check_field_for_var_ref(struct hist_field *hist_field,
 			struct hist_trigger_data *var_data,
 			unsigned int var_idx)
 {
-	struct hist_field *found = NULL;
-
-	if (hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF) {
-		if (hist_field->var.idx == var_idx &&
-		    hist_field->var.hist_data == var_data) {
-			found = hist_field;
-		}
-	}
-
-	return found;
-}
-
-static struct hist_field *
-check_field_for_var_refs(struct hist_trigger_data *hist_data,
-			 struct hist_field *hist_field,
-			 struct hist_trigger_data *var_data,
-			 unsigned int var_idx,
-			 unsigned int level)
-{
-	struct hist_field *found = NULL;
-	unsigned int i;
-
-	if (level > 3)
-		return found;
-
-	if (!hist_field)
-		return found;
-
-	found = check_field_for_var_ref(hist_field, var_data, var_idx);
-	if (found)
-		return found;
-
-	for (i = 0; i < HIST_FIELD_OPERANDS_MAX; i++) {
-		struct hist_field *operand;
+	WARN_ON(!(hist_field && hist_field->flags & HIST_FIELD_FL_VAR_REF));
 
-		operand = hist_field->operands[i];
-		found = check_field_for_var_refs(hist_data, operand, var_data,
-						 var_idx, level + 1);
-		if (found)
-			return found;
-	}
+	if (hist_field && hist_field->var.idx == var_idx &&
+	    hist_field->var.hist_data == var_data)
+		return hist_field;
 
-	return found;
+	return NULL;
 }
 
 static struct hist_field *find_var_ref(struct hist_trigger_data *hist_data,
 				       struct hist_trigger_data *var_data,
 				       unsigned int var_idx)
 {
-	struct hist_field *hist_field, *found = NULL;
+	struct hist_field *hist_field;
 	unsigned int i;
 
-	for_each_hist_field(i, hist_data) {
-		hist_field = hist_data->fields[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
-	}
-
-	for (i = 0; i < hist_data->n_synth_var_refs; i++) {
-		hist_field = hist_data->synth_var_refs[i];
-		found = check_field_for_var_refs(hist_data, hist_field,
-						 var_data, var_idx, 0);
-		if (found)
-			return found;
+	for (i = 0; i < hist_data->n_var_refs; i++) {
+		hist_field = hist_data->var_refs[i];
+		if (check_field_for_var_ref(hist_field, var_data, var_idx))
+			return hist_field;
 	}
 
-	return found;
+	return NULL;
 }
 
 static struct hist_field *find_any_var_ref(struct hist_trigger_data *hist_data,
-- 
2.14.1

