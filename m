Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE93C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894CC20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 894CC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbeLEXsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728938AbeLEXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:48:33 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC5F20989;
        Wed,  5 Dec 2018 23:48:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gUgu7-0000He-MY; Wed, 05 Dec 2018 18:48:31 -0500
Message-Id: <20181205234831.598635573@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Dec 2018 18:48:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 21/30] tracing: Simplify creation and deletion of synthetic events
References: <20181205234749.372720574@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Since the event_mutex and synth_event_mutex ordering issue
is gone, we can skip existing event check when adding or
deleting events, and some redundant code in error path.

This changes release_all_synth_events() to abort the process
when it hits any error and returns the error code. It succeeds
only if it has no error.

Link: http://lkml.kernel.org/r/154140847194.17322.17960275728005067803.stgit@devbox

Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 53 +++++++++++---------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 1670c65389fe..0feb7f460123 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1008,18 +1008,6 @@ struct hist_var_data {
 	struct hist_trigger_data *hist_data;
 };
 
-static void add_or_delete_synth_event(struct synth_event *event, int delete)
-{
-	if (delete)
-		free_synth_event(event);
-	else {
-		if (!find_synth_event(event->name))
-			list_add(&event->list, &synth_event_list);
-		else
-			free_synth_event(event);
-	}
-}
-
 static int create_synth_event(int argc, char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
@@ -1052,15 +1040,16 @@ static int create_synth_event(int argc, char **argv)
 	if (event) {
 		if (delete_event) {
 			if (event->ref) {
-				event = NULL;
 				ret = -EBUSY;
 				goto out;
 			}
-			list_del(&event->list);
-			goto out;
-		}
-		event = NULL;
-		ret = -EEXIST;
+			ret = unregister_synth_event(event);
+			if (!ret) {
+				list_del(&event->list);
+				free_synth_event(event);
+			}
+		} else
+			ret = -EEXIST;
 		goto out;
 	} else if (delete_event) {
 		ret = -ENOENT;
@@ -1100,29 +1089,21 @@ static int create_synth_event(int argc, char **argv)
 		event = NULL;
 		goto err;
 	}
+	ret = register_synth_event(event);
+	if (!ret)
+		list_add(&event->list, &synth_event_list);
+	else
+		free_synth_event(event);
  out:
-	if (event) {
-		if (delete_event) {
-			ret = unregister_synth_event(event);
-			add_or_delete_synth_event(event, !ret);
-		} else {
-			ret = register_synth_event(event);
-			add_or_delete_synth_event(event, ret);
-		}
-	}
 	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
 
 	return ret;
  err:
-	mutex_unlock(&synth_event_mutex);
-	mutex_unlock(&event_mutex);
-
 	for (i = 0; i < n_fields; i++)
 		free_synth_field(fields[i]);
-	free_synth_event(event);
 
-	return ret;
+	goto out;
 }
 
 static int release_all_synth_events(void)
@@ -1141,10 +1122,12 @@ static int release_all_synth_events(void)
 	}
 
 	list_for_each_entry_safe(event, e, &synth_event_list, list) {
-		list_del(&event->list);
-
 		ret = unregister_synth_event(event);
-		add_or_delete_synth_event(event, !ret);
+		if (!ret) {
+			list_del(&event->list);
+			free_synth_event(event);
+		} else
+			break;
 	}
 	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
-- 
2.19.1


