Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9151C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705F1214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546977585;
	bh=uBNUvjkMY3Cs9U5Bt+ExJ49E8ntdzD3+JZ6nIl2lj1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b41HdL7KFYtRq2jU78rgfTYhGWzJP3bTdxj+y48S255eIaLuzj9ga6WWNvj+koE4g
	 99YzRevhS5k28kaQPiTSLhr4cyTblySME/w3CHqcyLAEE1e22QZEaZSofBMZjoUcAO
	 2PVSMLz4hVSdyoxQnQ1HA62DCVc9p94/OxuS2mLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbfAHT7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:59:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732915AbfAHT7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:59:41 -0500
Received: from quaco.ghostprotocols.net (unknown [177.135.9.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D70C2176F;
        Tue,  8 Jan 2019 19:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546977580;
        bh=uBNUvjkMY3Cs9U5Bt+ExJ49E8ntdzD3+JZ6nIl2lj1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aaaah+QSKhrQ4ERn36Y00b1cVmdf+Qn5KrndEwNZGu1I+VgDg+M8hyI7UObDX8wdv
         yZWvdomS5SkpFn/6scf1uajwiOEsMc8tn1L9mf+aoBkO/ceVz80ekt7c/jmzHLeQFQ
         ZNSAb45iNnNNuROp+3cHKDv5Bk8kGFuYkD/r38yY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/16] tools lib traceevent: Introduce new libtracevent API: tep_override_comm()
Date:   Tue,  8 Jan 2019 16:58:59 -0300
Message-Id: <20190108195910.17726-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

This patch adds a new API of tracevent library: tep_override_comm() It
registers a pid / command mapping. If a mapping with the same pid
already exists, the entry is updated with the new command.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181130154648.038915912@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 69 +++++++++++++++++++++++-------
 tools/lib/traceevent/event-parse.h |  1 +
 2 files changed, 55 insertions(+), 15 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 69a96e39f0ab..156e513074b2 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -232,11 +232,13 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
  * we must add this pid. This is much slower than when cmdlines
  * are added before the array is initialized.
  */
-static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
+static int add_new_comm(struct tep_handle *pevent,
+			const char *comm, int pid, bool override)
 {
 	struct cmdline *cmdlines = pevent->cmdlines;
-	const struct cmdline *cmdline;
+	struct cmdline *cmdline;
 	struct cmdline key;
+	char *new_comm;
 
 	if (!pid)
 		return 0;
@@ -247,8 +249,19 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 	cmdline = bsearch(&key, pevent->cmdlines, pevent->cmdline_count,
 		       sizeof(*pevent->cmdlines), cmdline_cmp);
 	if (cmdline) {
-		errno = EEXIST;
-		return -1;
+		if (!override) {
+			errno = EEXIST;
+			return -1;
+		}
+		new_comm = strdup(comm);
+		if (!new_comm) {
+			errno = ENOMEM;
+			return -1;
+		}
+		free(cmdline->comm);
+		cmdline->comm = new_comm;
+
+		return 0;
 	}
 
 	cmdlines = realloc(cmdlines, sizeof(*cmdlines) * (pevent->cmdline_count + 1));
@@ -275,21 +288,13 @@ static int add_new_comm(struct tep_handle *pevent, const char *comm, int pid)
 	return 0;
 }
 
-/**
- * tep_register_comm - register a pid / comm mapping
- * @pevent: handle for the pevent
- * @comm: the command line to register
- * @pid: the pid to map the command line to
- *
- * This adds a mapping to search for command line names with
- * a given pid. The comm is duplicated.
- */
-int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+static int _tep_register_comm(struct tep_handle *pevent,
+			      const char *comm, int pid, bool override)
 {
 	struct cmdline_list *item;
 
 	if (pevent->cmdlines)
-		return add_new_comm(pevent, comm, pid);
+		return add_new_comm(pevent, comm, pid, override);
 
 	item = malloc(sizeof(*item));
 	if (!item)
@@ -312,6 +317,40 @@ int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
 	return 0;
 }
 
+/**
+ * tep_register_comm - register a pid / comm mapping
+ * @pevent: handle for the pevent
+ * @comm: the command line to register
+ * @pid: the pid to map the command line to
+ *
+ * This adds a mapping to search for command line names with
+ * a given pid. The comm is duplicated. If a command with the same pid
+ * already exist, -1 is returned and errno is set to EEXIST
+ */
+int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid)
+{
+	return _tep_register_comm(pevent, comm, pid, false);
+}
+
+/**
+ * tep_override_comm - register a pid / comm mapping
+ * @pevent: handle for the pevent
+ * @comm: the command line to register
+ * @pid: the pid to map the command line to
+ *
+ * This adds a mapping to search for command line names with
+ * a given pid. The comm is duplicated. If a command with the same pid
+ * already exist, the command string is udapted with the new one
+ */
+int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid)
+{
+	if (!pevent->cmdlines && cmdline_init(pevent)) {
+		errno = ENOMEM;
+		return -1;
+	}
+	return _tep_register_comm(pevent, comm, pid, true);
+}
+
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock)
 {
 	pevent->trace_clock = strdup(trace_clock);
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 35d37087d3c5..e6f4249910e6 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -432,6 +432,7 @@ int tep_set_function_resolver(struct tep_handle *pevent,
 			      tep_func_resolver_t *func, void *priv);
 void tep_reset_function_resolver(struct tep_handle *pevent);
 int tep_register_comm(struct tep_handle *pevent, const char *comm, int pid);
+int tep_override_comm(struct tep_handle *pevent, const char *comm, int pid);
 int tep_register_trace_clock(struct tep_handle *pevent, const char *trace_clock);
 int tep_register_function(struct tep_handle *pevent, char *name,
 			  unsigned long long addr, char *mod);
-- 
2.20.1

