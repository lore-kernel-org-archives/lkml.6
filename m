Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BC2ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAA920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcC5X0mT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAA920819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeKESUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:20:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbeKESUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:20:14 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0856D20819;
        Mon,  5 Nov 2018 09:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408494;
        bh=kvPU1QGPViKM90GlxOmNOjqH2CIuDPpvSXHvhno4gt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcC5X0mTR3UXjGhvkbeVflkG5lIvYyUS1rk48RSvMKmqKA2pduEyhaaZ9jzPCdM71
         9JYozltPxQdHFCVZdy6Mh0L8Xy+cWaT6x6Nz9VCeDuzw4q/8XqBP18QL6hzSVN7jhs
         8P+t7i9hMDOFxhWl1D3/kNl35povp60HJzB8duns=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 03/12] tracing: Simplify creation and deletion of synthetic event
Date:   Mon,  5 Nov 2018 18:01:12 +0900
Message-Id: <154140847194.17322.17960275728005067803.stgit@devbox>
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

Simplify creation and deletion code of synthetic event.

Since the event_mutex and synth_event_mutex ordering issue
is gone, we can skip existing event check when adding or
deleting event, and some redundant code in error path.

This changes release_all_synth_events() to abort the process
when it hits any error and returns the error code. It succeeds
only if it has no error.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |   53 +++++++++++++-------------------------
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

