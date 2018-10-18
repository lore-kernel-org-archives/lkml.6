Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8273AECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2F12145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1mCZ3aKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B2F12145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbeJRVN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:13:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727493AbeJRVN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:13:28 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21922145D;
        Thu, 18 Oct 2018 13:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539868348;
        bh=Wshnrpf/TZGMaOPy+SKgZhkiC1cw7byEaeH6+393b6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mCZ3aKNaOC8aquMm63HzWtkSAUBOsKaV+3mTy0t5L08tu31OZ2A37UhQLdl7r3Wy
         ugu+Iq7nJRl4Rm8Tne/2QBrvKg5JsEVd2OoBK45SjQN87Vm1oOYQc724SMoQSSzRtA
         pUd15w0nWT163Nid1YrWF3ixSnORB5/sdR6yWxUQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>
Cc:     Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [PATCH v2 1/3] tracing: Fix synthetic event to accept unsigned modifier
Date:   Thu, 18 Oct 2018 22:12:05 +0900
Message-Id: <153986832571.18251.8448135724590496531.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153986829702.18251.1286066460999338772.stgit@devbox>
References: <153986829702.18251.1286066460999338772.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: commit 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 Changes in v2:
  - Fix a typo of stable ML.
---
 kernel/trace/trace_events_hist.c |   30 ++++++++++++++++++++++++------
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

