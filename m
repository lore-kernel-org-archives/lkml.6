Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63570ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3AB20868
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0stwBUFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3AB20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbeKESUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:20:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbeKESUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:20:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 210272082A;
        Mon,  5 Nov 2018 09:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408522;
        bh=hzMDBXBKni82jXXBEKDlqDJaYqT/IAH27/2lm31LVDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0stwBUFnVQNRq41BUZYPE2q2QyBvrk/j13mVoDdxOCWrLDFVhOZzYVPkREE7R8p/+
         tMDLZeePamya3jjO7lDs2Rmhgmf67bD8J643LyVrsoU7MyUcgiLuQDQY1Lm6YwPAwF
         dafTn/u1y7DpjeSRVtNpN31k3VfROJ5I7aMTujDE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 04/12] tracing: Integrate similar probe argument parsers
Date:   Mon,  5 Nov 2018 18:01:40 +0900
Message-Id: <154140850016.17322.9836787731210512176.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154140838606.17322.15294184388075458777.stgit@devbox>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Integrate similar argument parsers for kprobes and uprobes events
into traceprobe_parse_probe_arg().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_kprobe.c |   48 ++-----------------------------------------
 kernel/trace/trace_probe.c  |   47 +++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace_probe.h  |    7 ++----
 kernel/trace/trace_uprobe.c |   44 ++-------------------------------------
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

