Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A700C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73AE218A6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165244;
	bh=Cv7605pWXCvJsuctaI+lgj4tbMu+qY6gKJB6Y4pbEU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=e6FEkcZFynP24/cbWwE5WhOH4wZmEPuszXpJSn7Q1mdyQXCqDZXNU9ZUZj7q2eYf2
	 I4LFsc+1LcVs2RTRqkW4QplqUXFaiJW1LQi7uOTSZ58f5L6u1+cZRk+Dt39CezhszM
	 /BQTUFOdprTEtZqFpVJBAWiIZomizTTP6N9aoCBI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeLRUeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:34:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:55346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727400AbeLRUeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:34:00 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22043218AC;
        Tue, 18 Dec 2018 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165240;
        bh=Cv7605pWXCvJsuctaI+lgj4tbMu+qY6gKJB6Y4pbEU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=HZzU9hYzMRY3qMWKYZXRCphig/Gx/i0I8k1Bmgx2Qa6e/rAei7S4oAdOawdXg/eQH
         gWaHs1el3XQqkW+js88SE+Kbe0LmVO4VGl2uG8273i9hN5kfmReFFb1LJ+DQviovW+
         AW27dcQCpxBnrEg33Rmc6Qx4aUFFE7mI8+LZAXCI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 5/7] tracing: Use hist trigger's var_ref array to destroy var_refs
Date:   Tue, 18 Dec 2018 14:33:24 -0600
Message-Id: <fad1a164f0e257c158e70d6eadbf6c586e04b2a2.1545161087.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545161087.git.tom.zanussi@linux.intel.com>
References: <cover.1545161087.git.tom.zanussi@linux.intel.com>
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

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9d4cf7a8a95b..725d22f5372f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2193,6 +2193,15 @@ static int contains_operator(char *str)
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
@@ -2204,14 +2213,13 @@ static void destroy_hist_field(struct hist_field *hist_field,
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
@@ -2338,6 +2346,12 @@ static void destroy_hist_fields(struct hist_trigger_data *hist_data)
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
2.14.1

