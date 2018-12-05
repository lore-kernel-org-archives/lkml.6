Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903C9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B52220645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B52220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbeLEXtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:49:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbeLEXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6827214F1;
        Wed,  5 Dec 2018 23:48:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu7-0000IC-RD; Wed, 05 Dec 2018 18:48:31 -0500
Message-Id: <20181205234831.742480131@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 22/30] tracing: Integrate similar probe argument parsers
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Integrate similar argument parsers for kprobes and uprobes events
into traceprobe_parse_probe_arg().

Link: http://lkml.kernel.org/r/154140850016.17322.9836787731210512176.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_kprobe.c | 48 ++-----------------------------------
 kernel/trace/trace_probe.c  | 47 +++++++++++++++++++++++++++++++++---
 kernel/trace/trace_probe.h  |  7 ++----
 kernel/trace/trace_uprobe.c | 44 ++--------------------------------
 4 files changed, 50 insertions(+), 96 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index fec67188c4d2..d313bcc259dc 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -548,7 +548,6 @@ static int create_trace_kprobe(int argc, char **argv)
 	bool is_return = false, is_delete = false;
 	char *symbol = NULL, *event = NULL, *group = NULL;
 	int maxactive = 0;
-	char *arg;
 	long offset = 0;
 	void *addr = NULL;
 	char buf[MAX_EVENT_NAME_LEN];
@@ -676,53 +675,10 @@ static int create_trace_kprobe(int argc, char **argv)
 	}
 
 	/* parse arguments */
-	ret = 0;
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		struct probe_arg *parg = &tk->tp.args[i];
-
-		/* Increment count for freeing args in error case */
-		tk->tp.nr_args++;
-
-		/* Parse argument name */
-		arg = strchr(argv[i], '=');
-		if (arg) {
-			*arg++ = '\0';
-			parg->name = kstrdup(argv[i], GFP_KERNEL);
-		} else {
-			arg = argv[i];
-			/* If argument name is omitted, set "argN" */
-			snprintf(buf, MAX_EVENT_NAME_LEN, "arg%d", i + 1);
-			parg->name = kstrdup(buf, GFP_KERNEL);
-		}
-
-		if (!parg->name) {
-			pr_info("Failed to allocate argument[%d] name.\n", i);
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (!is_good_name(parg->name)) {
-			pr_info("Invalid argument[%d] name: %s\n",
-				i, parg->name);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		if (traceprobe_conflict_field_name(parg->name,
-							tk->tp.args, i)) {
-			pr_info("Argument[%d] name '%s' conflicts with "
-				"another field.\n", i, argv[i]);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		/* Parse fetch argument */
-		ret = traceprobe_parse_probe_arg(arg, &tk->tp.size, parg,
-						 flags);
-		if (ret) {
-			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
+		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
+		if (ret)
 			goto error;
-		}
 	}
 
 	ret = register_trace_kprobe(tk);
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index bd30e9398d2a..449150c6a87f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -348,7 +348,7 @@ static int __parse_bitfield_probe_arg(const char *bf,
 }
 
 /* String length checking wrapper */
-int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
+static int traceprobe_parse_probe_arg_body(char *arg, ssize_t *size,
 		struct probe_arg *parg, unsigned int flags)
 {
 	struct fetch_insn *code, *scode, *tmp = NULL;
@@ -491,8 +491,8 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
 }
 
 /* Return 1 if name is reserved or already used by another argument */
-int traceprobe_conflict_field_name(const char *name,
-			       struct probe_arg *args, int narg)
+static int traceprobe_conflict_field_name(const char *name,
+					  struct probe_arg *args, int narg)
 {
 	int i;
 
@@ -507,6 +507,47 @@ int traceprobe_conflict_field_name(const char *name,
 	return 0;
 }
 
+int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, char *arg,
+				unsigned int flags)
+{
+	struct probe_arg *parg = &tp->args[i];
+	char *body;
+	int ret;
+
+	/* Increment count for freeing args in error case */
+	tp->nr_args++;
+
+	body = strchr(arg, '=');
+	if (body) {
+		parg->name = kmemdup_nul(arg, body - arg, GFP_KERNEL);
+		body++;
+	} else {
+		/* If argument name is omitted, set "argN" */
+		parg->name = kasprintf(GFP_KERNEL, "arg%d", i + 1);
+		body = arg;
+	}
+	if (!parg->name)
+		return -ENOMEM;
+
+	if (!is_good_name(parg->name)) {
+		pr_info("Invalid argument[%d] name: %s\n",
+			i, parg->name);
+		return -EINVAL;
+	}
+
+	if (traceprobe_conflict_field_name(parg->name, tp->args, i)) {
+		pr_info("Argument[%d]: '%s' conflicts with another field.\n",
+			i, parg->name);
+		return -EINVAL;
+	}
+
+	/* Parse fetch argument */
+	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg, flags);
+	if (ret)
+		pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
+	return ret;
+}
+
 void traceprobe_free_probe_arg(struct probe_arg *arg)
 {
 	struct fetch_insn *code = arg->code;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 974afc1a3e73..feeec261b356 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -272,11 +272,8 @@ find_event_file_link(struct trace_probe *tp, struct trace_event_file *file)
 #define TPARG_FL_FENTRY BIT(2)
 #define TPARG_FL_MASK	GENMASK(2, 0)
 
-extern int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
-		   struct probe_arg *parg, unsigned int flags);
-
-extern int traceprobe_conflict_field_name(const char *name,
-			       struct probe_arg *args, int narg);
+extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
+				char *arg, unsigned int flags);
 
 extern int traceprobe_update_arg(struct probe_arg *arg);
 extern void traceprobe_free_probe_arg(struct probe_arg *arg);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index b708e4ff7ea7..6eaaa2150685 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -517,51 +517,11 @@ static int create_trace_uprobe(int argc, char **argv)
 	}
 
 	/* parse arguments */
-	ret = 0;
 	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
-		struct probe_arg *parg = &tu->tp.args[i];
-
-		/* Increment count for freeing args in error case */
-		tu->tp.nr_args++;
-
-		/* Parse argument name */
-		arg = strchr(argv[i], '=');
-		if (arg) {
-			*arg++ = '\0';
-			parg->name = kstrdup(argv[i], GFP_KERNEL);
-		} else {
-			arg = argv[i];
-			/* If argument name is omitted, set "argN" */
-			snprintf(buf, MAX_EVENT_NAME_LEN, "arg%d", i + 1);
-			parg->name = kstrdup(buf, GFP_KERNEL);
-		}
-
-		if (!parg->name) {
-			pr_info("Failed to allocate argument[%d] name.\n", i);
-			ret = -ENOMEM;
-			goto error;
-		}
-
-		if (!is_good_name(parg->name)) {
-			pr_info("Invalid argument[%d] name: %s\n", i, parg->name);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		if (traceprobe_conflict_field_name(parg->name, tu->tp.args, i)) {
-			pr_info("Argument[%d] name '%s' conflicts with "
-				"another field.\n", i, argv[i]);
-			ret = -EINVAL;
-			goto error;
-		}
-
-		/* Parse fetch argument */
-		ret = traceprobe_parse_probe_arg(arg, &tu->tp.size, parg,
+		ret = traceprobe_parse_probe_arg(&tu->tp, i, argv[i],
 					is_return ? TPARG_FL_RETURN : 0);
-		if (ret) {
-			pr_info("Parse error at argument[%d]. (%d)\n", i, ret);
+		if (ret)
 			goto error;
-		}
 	}
 
 	ret = register_trace_uprobe(tu);
-- 
2.19.1


