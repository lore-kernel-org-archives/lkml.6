Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CC6ECDE4C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC87A214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzXYY6Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC87A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbeKIHsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732311AbeKIHsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:48:03 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DD352148E;
        Thu,  8 Nov 2018 22:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541715030;
        bh=W4lPOMT/vZj8yFyqVLSA7+/KhKTh5wSmZ/zsiMdWOH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzXYY6Rs4ABLHDLDn7bVcP5uHTxMnUgQdEQOe+igm6Jw9MGfDlzs3eD/Hgru3BM0b
         TtQMYrz4MidBHI+Q/BUQKRkbJj5arAy0hvPtTjCcBRtLWJbnNHOstXLFoiLPJtwxar
         gm9j2/eR/DaJ8x9OB7QwrZG7tUiqTbkmZwpDbNnM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.18 24/34] tracing: Fix synthetic event to accept unsigned modifier
Date:   Thu,  8 Nov 2018 13:52:53 -0800
Message-Id: <20181108215140.400268164@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215138.892971755@linuxfoundation.org>
References: <20181108215138.892971755@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 282447ba6b00c64678ffdf964f44e5c8b1c68377 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/trace_events_hist.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -747,16 +747,30 @@ static void free_synth_field(struct synt
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
@@ -769,11 +783,15 @@ static struct synth_field *parse_synth_f
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
@@ -1018,7 +1036,7 @@ static int create_synth_event(int argc,
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
 	bool delete_event = false;
-	int i, n_fields = 0, ret = 0;
+	int i, consumed = 0, n_fields = 0, ret = 0;
 	char *name;
 
 	mutex_lock(&synth_event_mutex);
@@ -1070,13 +1088,13 @@ static int create_synth_event(int argc,
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


