Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB0EC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5410B2064C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5410B2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJWO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 10:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbeJWO4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 10:56:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4498F3082E22;
        Tue, 23 Oct 2018 06:34:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 25FC0608EC;
        Tue, 23 Oct 2018 06:34:52 +0000 (UTC)
Date:   Tue, 23 Oct 2018 08:34:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     dzickus@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
Message-ID: <20181023063452.GB20075@krava>
References: <20181019.214401.2045294780943844999.davem@davemloft.net>
 <20181022140738.jvutwmstgm2f65et@redhat.com>
 <20181022161613.GF2945@krava>
 <20181022.105842.1364583912952511294.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022.105842.1364583912952511294.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 23 Oct 2018 06:34:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:58:42AM -0700, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Mon, 22 Oct 2018 18:16:13 +0200
> 
> > I think the fix might actualy speed things up,
> > but yes, there could be other report regressions
> 
> I was about to say the same thing, it could actually speed things up.
> In the best case, less work is done (clone avoided, and overlapping
> maps don't have to be handled).  In the worst case, nothing changes.
> 
> Here is what I've been using, to give you an idea.  There may be some
> file offset fuzz in these patches.

I'm not sure about using the misc field bit defined/used by userland,
in case there's some new one comming in future for fork event..

but the only other way I can think of now is adding new 'user' event
for that, but that ended up as a bigger change (attached)

I think if we make some 'big enough' comment about the bit usage,
your change is better.. will you post or should I?

thanks,
jirka


---
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc646185f8d9..06e28cef5579 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -60,6 +60,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_EVENT_UPDATE]		= "EVENT_UPDATE",
 	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
+	[PERF_RECORD_FORK_USER]			= "FORK_USER",
 };
 
 static const char *perf_ns__names[] = {
@@ -307,7 +308,7 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
 	}
 	event->fork.pid  = tgid;
 	event->fork.tid  = pid;
-	event->fork.header.type = PERF_RECORD_FORK;
+	event->fork.header.type = PERF_RECORD_FORK_USER;
 
 	event->fork.header.size = (sizeof(event->fork) + machine->id_hdr_size);
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bfa60bcafbde..e7252ae61529 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -249,6 +249,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_EVENT_UPDATE		= 78,
 	PERF_RECORD_TIME_CONV			= 79,
 	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_FORK_USER			= 81,
 	PERF_RECORD_HEADER_MAX
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..b7d8aec18707 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1702,6 +1702,7 @@ void machine__remove_thread(struct machine *machine, struct thread *th)
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample)
 {
+	bool user = event->header.type == PERF_RECORD_FORK_USER;
 	struct thread *thread = machine__find_thread(machine,
 						     event->fork.pid,
 						     event->fork.tid);
@@ -1738,7 +1739,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 					 event->fork.tid);
 
 	if (thread == NULL || parent == NULL ||
-	    thread__fork(thread, parent, sample->time) < 0) {
+	    thread__fork(thread, parent, sample->time, user) < 0) {
 		dump_printf("problem processing PERF_RECORD_FORK, skipping event.\n");
 		err = -1;
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index df5e12b22905..a219dd119d95 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -801,6 +801,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
 	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
 	[PERF_RECORD_TIME_CONV]		  = perf_event__all64_swap,
+	[PERF_RECORD_FORK_USER]		  = perf_event__task_swap,
 	[PERF_RECORD_HEADER_MAX]	  = NULL,
 };
 
@@ -1269,6 +1270,7 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_NAMESPACES:
 		return tool->namespaces(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
+	case PERF_RECORD_FORK_USER:
 		return tool->fork(tool, event, sample, machine);
 	case PERF_RECORD_EXIT:
 		return tool->exit(tool, event, sample, machine);
@@ -1398,6 +1400,12 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	}
 }
 
+static bool process_user(union perf_event *event)
+{
+	return event->header.type >= PERF_RECORD_USER_TYPE_START &&
+	       event->header.type != PERF_RECORD_FORK_USER;
+}
+
 int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample)
@@ -1407,7 +1415,7 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
-	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
+	if (process_user(event))
 		return perf_session__process_user_event(session, event, 0);
 
 	return machines__deliver_event(&session->machines, evlist, event, sample, tool, 0);
@@ -1492,7 +1500,7 @@ static s64 perf_session__process_event(struct perf_session *session,
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
-	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
+	if (process_user(event))
 		return perf_session__process_user_event(session, event, file_offset);
 
 	if (tool->ordered_events) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2048d393ece6..2782d2626f09 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -332,10 +332,6 @@ static int thread__prepare_access(struct thread *thread)
 static int thread__clone_map_groups(struct thread *thread,
 				    struct thread *parent)
 {
-	/* This is new thread, we share map groups for process. */
-	if (thread->pid_ == parent->pid_)
-		return thread__prepare_access(thread);
-
 	if (thread->mg == parent->mg) {
 		pr_debug("broken map groups on thread %d/%d parent %d/%d\n",
 			 thread->pid_, thread->tid, parent->pid_, parent->tid);
@@ -343,13 +339,11 @@ static int thread__clone_map_groups(struct thread *thread,
 	}
 
 	/* But this one is new process, copy maps. */
-	if (map_groups__clone(thread, parent->mg) < 0)
-		return -ENOMEM;
-
-	return 0;
+	return map_groups__clone(thread, parent->mg);
 }
 
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
+int thread__fork(struct thread *thread, struct thread *parent,
+		 u64 timestamp, bool user)
 {
 	if (parent->comm_set) {
 		const char *comm = thread__comm_str(parent);
@@ -362,6 +356,15 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 	}
 
 	thread->ppid = parent->tid;
+
+	/* This is new thread, we share map groups for process. */
+	if (thread->pid_ == parent->pid_)
+		return thread__prepare_access(thread);
+
+	/* Do not clone maps for user space fork event. */
+	if (user)
+		return 0;
+
 	return thread__clone_map_groups(thread, parent);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 07606aa6998d..827727300100 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -87,7 +87,8 @@ struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
 const char *thread__comm_str(const struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
+int thread__fork(struct thread *thread, struct thread *parent,
+		 u64 timestamp, bool user);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
