Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37939ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8C9214C3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8C9214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeJTJj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbeJTJj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:39:28 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA705214C4;
        Sat, 20 Oct 2018 01:30:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gDg6M-0006ER-RJ; Fri, 19 Oct 2018 21:30:50 -0400
Message-Id: <20181020013050.754356806@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 19 Oct 2018 21:29:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/3] tracing: Fix synthetic event to accept unsigned modifier
References: <20181020012958.223064271@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix synthetic event to accept unsigned modifier for its field type
correctly.

Currently, synthetic_events interface returns error for "unsigned"
modifiers as below;

 # echo "myevent unsigned long var" >> synthetic_events
 sh: write error: Invalid argument

This is because argv_split() breaks "unsigned long" into "unsigned"
and "long", but parse_synth_field() doesn't expected it.

With this fix, synthetic_events can handle the "unsigned long"
correctly like as below;

 # echo "myevent unsigned long var" >> synthetic_events
 # cat synthetic_events
 myevent	unsigned long var

Link: http://lkml.kernel.org/r/153986832571.18251.8448135724590496531.stgit@devbox

Cc: Shuah Khan <shuah@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: stable@vger.kernel.org
Fixes: commit 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 85f6b01431c7..6ff83941065a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -738,16 +738,30 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(char *field_type,
-					     char *field_name)
+static struct synth_field *parse_synth_field(int argc, char **argv,
+					     int *consumed)
 {
 	struct synth_field *field;
+	const char *prefix = NULL;
+	char *field_type = argv[0], *field_name;
 	int len, ret = 0;
 	char *array;
 
 	if (field_type[0] == ';')
 		field_type++;
 
+	if (!strcmp(field_type, "unsigned")) {
+		if (argc < 3)
+			return ERR_PTR(-EINVAL);
+		prefix = "unsigned ";
+		field_type = argv[1];
+		field_name = argv[2];
+		*consumed = 3;
+	} else {
+		field_name = argv[1];
+		*consumed = 2;
+	}
+
 	len = strlen(field_name);
 	if (field_name[len - 1] == ';')
 		field_name[len - 1] = '\0';
@@ -760,11 +774,15 @@ static struct synth_field *parse_synth_field(char *field_type,
 	array = strchr(field_name, '[');
 	if (array)
 		len += strlen(array);
+	if (prefix)
+		len += strlen(prefix);
 	field->type = kzalloc(len, GFP_KERNEL);
 	if (!field->type) {
 		ret = -ENOMEM;
 		goto free;
 	}
+	if (prefix)
+		strcat(field->type, prefix);
 	strcat(field->type, field_type);
 	if (array) {
 		strcat(field->type, array);
@@ -1009,7 +1027,7 @@ static int create_synth_event(int argc, char **argv)
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
 	bool delete_event = false;
-	int i, n_fields = 0, ret = 0;
+	int i, consumed = 0, n_fields = 0, ret = 0;
 	char *name;
 
 	mutex_lock(&synth_event_mutex);
@@ -1061,13 +1079,13 @@ static int create_synth_event(int argc, char **argv)
 			goto err;
 		}
 
-		field = parse_synth_field(argv[i], argv[i + 1]);
+		field = parse_synth_field(argc - i, &argv[i], &consumed);
 		if (IS_ERR(field)) {
 			ret = PTR_ERR(field);
 			goto err;
 		}
-		fields[n_fields] = field;
-		i++; n_fields++;
+		fields[n_fields++] = field;
+		i += consumed - 1;
 	}
 
 	if (i < argc) {
-- 
2.19.0


