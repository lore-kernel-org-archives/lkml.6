Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C71C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA46F20675
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 20:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545165251;
	bh=j+ixuDcAn1hIYHT4VODtlBDyl6KcbgI00Q83zx3rr84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=aGYC3k5vv27Efywz7eigBpJ0ql+bmRrWaJs8bqdxVinEaAm37fntJIZ1/d5daIXNi
	 gI9/37fCdqLai+Uo1vVRrit178WwHk8U23EHMwKWYxjbO18FoCTKzvNS51d3rS3MCq
	 wKU5otVbTVI24dlt1yqunernZVXULjBDpiFqJjA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbeLRUeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 15:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727480AbeLRUeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 15:34:04 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD61218AD;
        Tue, 18 Dec 2018 20:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545165243;
        bh=j+ixuDcAn1hIYHT4VODtlBDyl6KcbgI00Q83zx3rr84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=RHmn4Eyittke2MmV5NIoRyeEXruuXTsLghxHUo/nLp/3qfhlAa4uiY5VVJKBkQSRe
         XvLGj6sdGn8jVugiW72FI5qwB7OcgV6doAVzGCynb47F9XkFB5qJdbcF5+Xy3reNmU
         WCYl7c2wMUIL/0ukrbgz/TsoIQZWnF1AXTH6dwPg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 7/7] tracing: Add hist trigger comments for variable-related fields
Date:   Tue, 18 Dec 2018 14:33:26 -0600
Message-Id: <ea857ce948531d7bec712bbb0f38360aa1d378ec.1545161087.git.tom.zanussi@linux.intel.com>
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

Add a few comments to help clarify how variable and variable reference
fields are used in the code.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_events_hist.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e66dd764e057..b813da145dbd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -40,6 +40,16 @@ enum field_op_id {
 	FIELD_OP_UNARY_MINUS,
 };
 
+/*
+ * A hist_var (histogram variable) contains variable information for
+ * hist_fields having the HIST_FIELD_FL_VAR or HIST_FIELD_FL_VAR_REF
+ * flag set.  A hist_var has a variable name e.g. ts0, and is
+ * associated with a given histogram trigger, as specified by
+ * hist_data.  The hist_var idx is the unique index assigned to the
+ * variable by the hist trigger's tracing_map.  The idx is what is
+ * used to set a variable's value and, by a variable reference, to
+ * retrieve it.
+ */
 struct hist_var {
 	char				*name;
 	struct hist_trigger_data	*hist_data;
@@ -56,11 +66,29 @@ struct hist_field {
 	const char			*type;
 	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
 	struct hist_trigger_data	*hist_data;
+
+	/*
+	 * Variable fields contain variable-specific info in var.
+	 */
 	struct hist_var			var;
 	enum field_op_id		operator;
 	char				*system;
 	char				*event_name;
+
+	/*
+	 * The name field is used for EXPR and VAR_REF fields.  VAR
+	 * fields contain the variable name in var.name.
+	 */
 	char				*name;
+
+	/*
+	 * When a histogram trigger is hit, if it has any references
+	 * to variables, the values of those variables are collected
+	 * into a var_ref_vals array by resolve_var_refs().  The
+	 * current value of each variable is read from the tracing_map
+	 * using the hist field's hist_var.idx and entered into the
+	 * var_ref_idx entry i.e. var_ref_vals[var_ref_idx].
+	 */
 	unsigned int			var_ref_idx;
 	bool                            read_once;
 };
@@ -365,6 +393,14 @@ struct action_data {
 
 	union {
 		struct {
+			/*
+			 * When a histogram trigger is hit, the values of any
+			 * references to variables, including variables being passed
+			 * as parameters to synthetic events, are collected into a
+			 * var_ref_vals array.  This var_ref_idx is the index of the
+			 * first param in the array to be passed to the synthetic
+			 * event invocation.
+			 */
 			unsigned int		var_ref_idx;
 			char			*match_event;
 			char			*match_event_system;
-- 
2.14.1

