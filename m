Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A339CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8D2082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6jeJUvi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B8D2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbeKESXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:23:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeKESXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:23:05 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6455A20862;
        Mon,  5 Nov 2018 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541408664;
        bh=D8dVtzfMR66LatHwDSjnKAZuLZjghHIT0wf9nlN5jxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6jeJUviBer1kIwgjl3Wi5gRO2VqmXadmaQsHAoeUQXABgUeIitpKloSWf3XAMoww
         4Z3VNKKegWwp1f14FNH2hj432WgYYpJbTRHcBNYGQs45o4HOtpMfMB25cWd9qo+br1
         8TV8N5Z7DRTPJUSySO38Hw5NYvuM4iCZl8Gad+Sc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2 09/12] tracing: Remove unneeded synth_event_mutex
Date:   Mon,  5 Nov 2018 18:04:01 +0900
Message-Id: <154140864134.17322.4796059721306031894.stgit@devbox>
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

Rmove unneeded synth_event_mutex. This mutex protects the reference
count in synth_event, however, those operational points are already
protected by event_mutex.

1. In __create_synth_event() and create_or_delete_synth_event(),
 those synth_event_mutex clearly obtained right after event_mutex.

2. event_hist_trigger_func() is trigger_hist_cmd.func() which is
 called by trigger_process_regex(), which is a part of
 event_trigger_regex_write() and this function takes event_mutex.

3. hist_unreg_all() is trigger_hist_cmd.unreg_all() which is called
 by event_trigger_regex_open() and it takes event_mutex.

4. onmatch_destroy() and onmatch_create() have long call tree,
 but both are finally invoked from event_trigger_regex_write()
 and event_trace_del_tracer(), former takes event_mutex, and latter
 ensures called under event_mutex locked.

Finally, I ensured there is no resource conflict. For safety,
I added lockdep_assert_held(&event_mutex) for each function.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c |   30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 414aabd67d1f..21e4954375a1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -444,8 +444,6 @@ static bool have_hist_err(void)
 	return false;
 }
 
-static DEFINE_MUTEX(synth_event_mutex);
-
 struct synth_trace_event {
 	struct trace_entry	ent;
 	u64			fields[];
@@ -1077,7 +1075,6 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 		return -EINVAL;
 
 	mutex_lock(&event_mutex);
-	mutex_lock(&synth_event_mutex);
 
 	event = find_synth_event(name);
 	if (event) {
@@ -1119,7 +1116,6 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	else
 		free_synth_event(event);
  out:
-	mutex_unlock(&synth_event_mutex);
 	mutex_unlock(&event_mutex);
 
 	return ret;
@@ -1139,7 +1135,6 @@ static int create_or_delete_synth_event(int argc, char **argv)
 	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		mutex_lock(&event_mutex);
-		mutex_lock(&synth_event_mutex);
 		event = find_synth_event(name + 1);
 		if (event) {
 			if (event->ref)
@@ -1153,7 +1148,6 @@ static int create_or_delete_synth_event(int argc, char **argv)
 			}
 		} else
 			ret = -ENOENT;
-		mutex_unlock(&synth_event_mutex);
 		mutex_unlock(&event_mutex);
 		return ret;
 	}
@@ -3535,7 +3529,7 @@ static void onmatch_destroy(struct action_data *data)
 {
 	unsigned int i;
 
-	mutex_lock(&synth_event_mutex);
+	lockdep_assert_held(&event_mutex);
 
 	kfree(data->onmatch.match_event);
 	kfree(data->onmatch.match_event_system);
@@ -3548,8 +3542,6 @@ static void onmatch_destroy(struct action_data *data)
 		data->onmatch.synth_event->ref--;
 
 	kfree(data);
-
-	mutex_unlock(&synth_event_mutex);
 }
 
 static void destroy_field_var(struct field_var *field_var)
@@ -3700,15 +3692,14 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
 	struct synth_event *event;
 	int ret = 0;
 
-	mutex_lock(&synth_event_mutex);
+	lockdep_assert_held(&event_mutex);
+
 	event = find_synth_event(data->onmatch.synth_event_name);
 	if (!event) {
 		hist_err("onmatch: Couldn't find synthetic event: ", data->onmatch.synth_event_name);
-		mutex_unlock(&synth_event_mutex);
 		return -EINVAL;
 	}
 	event->ref++;
-	mutex_unlock(&synth_event_mutex);
 
 	var_ref_idx = hist_data->n_var_refs;
 
@@ -3782,9 +3773,7 @@ static int onmatch_create(struct hist_trigger_data *hist_data,
  out:
 	return ret;
  err:
-	mutex_lock(&synth_event_mutex);
 	event->ref--;
-	mutex_unlock(&synth_event_mutex);
 
 	goto out;
 }
@@ -5492,6 +5481,8 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct synth_event *se;
 	const char *se_name;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (hist_file_check_refs(file))
 		return;
 
@@ -5501,12 +5492,10 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			mutex_lock(&synth_event_mutex);
 			se_name = trace_event_name(file->event_call);
 			se = find_synth_event(se_name);
 			if (se)
 				se->ref--;
-			mutex_unlock(&synth_event_mutex);
 
 			update_cond_flag(file);
 			if (hist_data->enable_timestamps)
@@ -5532,6 +5521,8 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	char *trigger, *p;
 	int ret = 0;
 
+	lockdep_assert_held(&event_mutex);
+
 	if (glob && strlen(glob)) {
 		last_cmd_set(param);
 		hist_err_clear();
@@ -5622,14 +5613,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		}
 
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
-
-		mutex_lock(&synth_event_mutex);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
 		if (se)
 			se->ref--;
-		mutex_unlock(&synth_event_mutex);
-
 		ret = 0;
 		goto out_free;
 	}
@@ -5665,13 +5652,10 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	mutex_lock(&synth_event_mutex);
 	se_name = trace_event_name(file->event_call);
 	se = find_synth_event(se_name);
 	if (se)
 		se->ref++;
-	mutex_unlock(&synth_event_mutex);
-
 	/* Just return zero, not the number of registered triggers */
 	ret = 0;
  out:

