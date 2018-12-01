Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CE2C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5877121473
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 04:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5877121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeLAPUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 10:20:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbeLAPU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 10:20:27 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5765421479;
        Sat,  1 Dec 2018 04:08:53 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gSwaK-0000Gp-Ek; Fri, 30 Nov 2018 23:08:52 -0500
Message-Id: <20181201040852.358871851@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 30 Nov 2018 23:08:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 2/6] tools/lib/traceevent: Rename struct cmdline to struct tep_cmdline
References: <20181201040807.154099010@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

In order to make libtraceevent into a proper library, variables, data
structures and functions require a unique prefix to prevent name space
conflicts. That prefix will be "tep_".
This patch renames struct cmdline to struct tep_cmdline.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse-local.h |  4 +--
 tools/lib/traceevent/event-parse.c       | 36 ++++++++++++------------
 tools/lib/traceevent/event-parse.h       |  8 +++---
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-local.h b/tools/lib/traceevent/event-parse-local.h
index 9a092dd4a86d..35833ee32d6c 100644
--- a/tools/lib/traceevent/event-parse-local.h
+++ b/tools/lib/traceevent/event-parse-local.h
@@ -7,7 +7,7 @@
 #ifndef _PARSE_EVENTS_INT_H
 #define _PARSE_EVENTS_INT_H
 
-struct cmdline;
+struct tep_cmdline;
 struct cmdline_list;
 struct func_map;
 struct func_list;
@@ -36,7 +36,7 @@ struct tep_handle {
 	int long_size;
 	int page_size;
 
-	struct cmdline *cmdlines;
+	struct tep_cmdline *cmdlines;
 	struct cmdline_list *cmdlist;
 	int cmdline_count;
 
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 5cd99bdb0517..c3d22d0a2935 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -124,15 +124,15 @@ struct tep_print_arg *alloc_arg(void)
 	return calloc(1, sizeof(struct tep_print_arg));
 }
 
-struct cmdline {
+struct tep_cmdline {
 	char *comm;
 	int pid;
 };
 
 static int cmdline_cmp(const void *a, const void *b)
 {
-	const struct cmdline *ca = a;
-	const struct cmdline *cb = b;
+	const struct tep_cmdline *ca = a;
+	const struct tep_cmdline *cb = b;
 
 	if (ca->pid < cb->pid)
 		return -1;
@@ -152,7 +152,7 @@ static int cmdline_init(struct tep_handle *pevent)
 {
 	struct cmdline_list *cmdlist = pevent->cmdlist;
 	struct cmdline_list *item;
-	struct cmdline *cmdlines;
+	struct tep_cmdline *cmdlines;
 	int i;
 
 	cmdlines = malloc(sizeof(*cmdlines) * pevent->cmdline_count);
@@ -179,8 +179,8 @@ static int cmdline_init(struct tep_handle *pevent)
 
 static const char *find_cmdline(struct tep_handle *pevent, int pid)
 {
-	const struct cmdline *comm;
-	struct cmdline key;
+	const struct tep_cmdline *comm;
+	struct tep_cmdline key;
 
 	if (!pid)
 		return "<idle>";
@@ -208,8 +208,8 @@ static const char *find_cmdline(struct tep_handle *pevent, int pid)
  */
 int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 {
-	const struct cmdline *comm;
-	struct cmdline key;
+	const struct tep_cmdline *comm;
+	struct tep_cmdline key;
 
 	if (!pid)
 		return 1;
@@ -235,9 +235,9 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 static int add_new_comm(struct tep_handle *pevent,
 			const char *comm, int pid, bool override)
 {
-	struct cmdline *cmdlines = pevent->cmdlines;
-	struct cmdline *cmdline;
-	struct cmdline key;
+	struct tep_cmdline *cmdlines = pevent->cmdlines;
+	struct tep_cmdline *cmdline;
+	struct tep_cmdline key;
 	char *new_comm;
 
 	if (!pid)
@@ -5330,8 +5330,8 @@ const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid)
 	return comm;
 }
 
-static struct cmdline *
-pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *next)
+static struct tep_cmdline *
+pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct tep_cmdline *next)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)next;
 
@@ -5343,7 +5343,7 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
 	while (cmdlist && strcmp(cmdlist->comm, comm) != 0)
 		cmdlist = cmdlist->next;
 
-	return (struct cmdline *)cmdlist;
+	return (struct tep_cmdline *)cmdlist;
 }
 
 /**
@@ -5359,10 +5359,10 @@ pid_from_cmdlist(struct tep_handle *pevent, const char *comm, struct cmdline *ne
  * next pid.
  * Also, it does a linear seach, so it may be slow.
  */
-struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
-				       struct cmdline *next)
+struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+					   struct tep_cmdline *next)
 {
-	struct cmdline *cmdline;
+	struct tep_cmdline *cmdline;
 
 	/*
 	 * If the cmdlines have not been converted yet, then use
@@ -5401,7 +5401,7 @@ struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *co
  * Returns the pid for a give cmdline. If @cmdline is NULL, then
  * -1 is returned.
  */
-int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline)
+int tep_cmdline_pid(struct tep_handle *pevent, struct tep_cmdline *cmdline)
 {
 	struct cmdline_list *cmdlist = (struct cmdline_list *)cmdline;
 
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index e6f4249910e6..77a4a1dd4b4d 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -526,10 +526,10 @@ int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_flags(struct tep_handle *pevent, struct tep_record *rec);
 const char *tep_data_comm_from_pid(struct tep_handle *pevent, int pid);
-struct cmdline;
-struct cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
-				       struct cmdline *next);
-int tep_cmdline_pid(struct tep_handle *pevent, struct cmdline *cmdline);
+struct tep_cmdline;
+struct tep_cmdline *tep_data_pid_from_comm(struct tep_handle *pevent, const char *comm,
+					   struct tep_cmdline *next);
+int tep_cmdline_pid(struct tep_handle *pevent, struct tep_cmdline *cmdline);
 
 void tep_print_field(struct trace_seq *s, void *data,
 		     struct tep_format_field *field);
-- 
2.19.1


