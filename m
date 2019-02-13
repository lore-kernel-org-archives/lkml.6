Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79832222D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550081901;
	bh=EAIuOb18qll7AhmOBzJG+bLpQg246BARcII33sOMI1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=PvX3qflsD9mlQQcnn9Z12MuTxiYO120qXSCKpPAbbGuaU7xOUqZE2JH+wZGYO5y4a
	 /S6blfB0BmGZf9hecH1wSXwOs4deX5PemIy62BjfECYHnBKOd6jz/f9YONw8M9VQu0
	 BeDmUeUFQ/MMfvfT6bdzKCc0824HNaWvPKm7hpEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404895AbfBMSSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:18:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393682AbfBMSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:18:10 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AEB4222D4;
        Wed, 13 Feb 2019 18:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550081889;
        bh=EAIuOb18qll7AhmOBzJG+bLpQg246BARcII33sOMI1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=m4yuPseBnSVOi1b1vjInANkbgqnNWVkgjftQmKMDvC8K2k4sFuoCbM28iBBlCvbE4
         w8a1bjNokmoYfqKNb0FAXTwUr2AlyPilkk7s6/eS3k58zqEGJYUeg0n9AUQlMP8AUF
         5mfv7BK4zehfgBA4T0qAqz+DriEgZ7K3UYUxOG7I=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        bigeasy@linutronix.de, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 4/5] tracing: Use tracing error_log with kprobe events (incomplete)
Date:   Wed, 13 Feb 2019 12:17:55 -0600
Message-Id: <db931dea3818fb79a710f7b83cb53b06cf565de1.1550074795.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1550074795.git.tom.zanussi@linux.intel.com>
References: <cover.1550074795.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Here are a few examples of replacing kprobe_events error handling with
tracing_log_err() from the new tracing error_log mechanism.  Only a
few example errors are converted, and even these are incomplete, since
I didn't know where to get the current command and used a dummy string
for those.  Also, these are completely untested, just provided for
RFC purposes.

With this change, users will find some kprobe_events errors in
tracing/error_log instead of dmesg.

TODO: If acceptable, convert all the rest of the kprobe errors and
figure out how to get the actual cmd logged along with the error.

Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 kernel/trace/trace_probe.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 9962cb5da8ac..3d7b195c943b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -13,6 +13,22 @@
 
 #include "trace_probe.h"
 
+#define ERRORS								\
+	C(NONE,			"No error"),				\
+	C(INVALID_STRING_SPEC,	"string only accepts memory or address."), \
+	C(ARG_TOO_LONG,		"Argument is too long."),		\
+	C(INVALID_ARG_NAME,	"Invalid argument name"),
+
+#undef C
+#define C(a, b)		KPROBE_ERR_##a
+
+enum { ERRORS };
+
+#undef C
+#define C(a, b)		b
+
+static const char *err_text[] = { ERRORS };
+
 const char *reserved_field_names[] = {
 	"common_type",
 	"common_flags",
@@ -384,7 +400,7 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	int ret, len;
 
 	if (strlen(arg) > MAX_ARGSTR_LEN) {
-		pr_info("Argument is too long.: %s\n",  arg);
+		tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_ARG_TOO_LONG, err_pos("command", arg));
 		return -ENOSPC;
 	}
 	parg->comm = kstrdup(arg, GFP_KERNEL);
@@ -443,7 +459,8 @@ static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 	if (!strcmp(parg->type->name, "string")) {
 		if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_IMM &&
 		    code->op != FETCH_OP_COMM) {
-			pr_info("string only accepts memory or address.\n");
+			tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_INVALID_STRING_SPEC, 0);
+
 			ret = -EINVAL;
 			goto fail;
 		}
@@ -558,8 +575,7 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
 		return -ENOMEM;
 
 	if (!is_good_name(parg->name)) {
-		pr_info("Invalid argument[%d] name: %s\n",
-			i, parg->name);
+		tracing_log_err("kprobe_events", "replace this with command", err_text, KPROBE_ERR_INVALID_ARG_NAME, err_pos("cmd", parg->name));
 		return -EINVAL;
 	}
 
-- 
2.14.1

