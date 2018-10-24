Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B56C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F73207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 11:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F73207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJXUCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 16:02:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbeJXUCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 16:02:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 29D5681129;
        Wed, 24 Oct 2018 11:34:19 +0000 (UTC)
Received: from krava (unknown [10.40.205.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id B26971057063;
        Wed, 24 Oct 2018 11:34:17 +0000 (UTC)
Date:   Wed, 24 Oct 2018 13:34:16 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, dzickus@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
Message-ID: <20181024113416.GA26027@krava>
References: <20181023063452.GB20075@krava>
 <20181023.105405.364015687995752826.davem@davemloft.net>
 <20181023180503.GA6114@kernel.org>
 <20181023.111503.1978409398989251135.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023.111503.1978409398989251135.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 24 Oct 2018 11:34:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:15:03AM -0700, David Miller wrote:
> From: Arnaldo Carvalho de Melo <acme@kernel.org>
> Date: Tue, 23 Oct 2018 15:05:03 -0300
> 
> > IIRC this was first done for 'perf record', where we have to stash those
> > events in the perf.data file, to then, later, 'perf report' to process
> > those, so when working on 'perf top', it just reuses that machinery.
> > 
> > Sure, with some love and care 'perf top' could do better and update all
> > the data structures directly :-)
> 
> Thanks for the history, it is useful information :)
> 
> > Anyway, have you guys considered tweaking using event->header.misc |=
> > PERF_RECORD_MISC_USER? The kernel leaves that as zero for the
> > PERF_RECORD_FORK it emits:
> 
> I really would like to steer the approach away from using UAPI
> perf_event fields in an internal way.
> 
> I am really very sorry for suggesting such a scheme myself in the
> first place.  It really was a bad idea upon much consideration.
> 
> The synthetic fork is not really a fork, it's more like a "create".
> 
> And this fundamental semantic difference is why we have all of these
> issues wrt. handling COMM and parent map inheritance.
> 
> There is also a bunch of non-trivial code to deal with whether we
> synthetically create the child or the parent first, wrt. finding
> thread leaders and parent threads.
> 
> What I'm trying to say is that there is a clean design based solution
> hiding somewhere in here and I'd like to find it :-)

how about adding a data file marker/event when the synthesized
portion of data is over

attached patch adds an 'SYNTHESIZE_END' event and prevents
parent's maps cloning on fork until that event is found

we would need more code to stay backward compatible, which
I did not include.. just to cleanly outline the solution

jirka


---
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 10cf889c6d75..328b75711272 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -746,6 +746,11 @@ static const struct perf_event_mmap_page *record__pick_pc(struct record *rec)
 	return NULL;
 }
 
+static struct perf_event_header synthesize_end_event = {
+	.size = sizeof(struct perf_event_header),
+	.type = PERF_RECORD_SYNTHESIZE_END,
+};
+
 static int record__synthesize(struct record *rec, bool tail)
 {
 	struct perf_session *session = rec->session;
@@ -853,6 +858,12 @@ static int record__synthesize(struct record *rec, bool tail)
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
 					    process_synthesized_event, opts->sample_address,
 					    opts->proc_map_timeout, 1);
+
+	if (err < 0)
+		return err;
+
+	err = record__write(rec, NULL, &synthesize_end_event,
+			    sizeof(synthesize_end_event));
 out:
 	return err;
 }
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc646185f8d9..d7aee86faa60 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -60,6 +60,7 @@ static const char *perf_event__names[] = {
 	[PERF_RECORD_EVENT_UPDATE]		= "EVENT_UPDATE",
 	[PERF_RECORD_TIME_CONV]			= "TIME_CONV",
 	[PERF_RECORD_HEADER_FEATURE]		= "FEATURE",
+	[PERF_RECORD_SYNTHESIZE_END]		= "SYNTHESIZE_END",
 };
 
 static const char *perf_ns__names[] = {
@@ -1413,12 +1414,12 @@ size_t perf_event__fprintf_task(union perf_event *event, FILE *fp)
 		       event->fork.ppid, event->fork.ptid);
 }
 
-int perf_event__process_fork(struct perf_tool *tool __maybe_unused,
+int perf_event__process_fork(struct perf_tool *tool,
 			     union perf_event *event,
 			     struct perf_sample *sample,
 			     struct machine *machine)
 {
-	return machine__process_fork_event(machine, event, sample);
+	return machine__process_fork_event(machine, event, sample, tool->synth_end);
 }
 
 int perf_event__process_exit(struct perf_tool *tool __maybe_unused,
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bfa60bcafbde..51eb996f2696 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -249,6 +249,7 @@ enum perf_user_event_type { /* above any possible kernel type */
 	PERF_RECORD_EVENT_UPDATE		= 78,
 	PERF_RECORD_TIME_CONV			= 79,
 	PERF_RECORD_HEADER_FEATURE		= 80,
+	PERF_RECORD_SYNTHESIZE_END		= 81,
 	PERF_RECORD_HEADER_MAX
 };
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..f5e08ccb6032 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1700,7 +1700,7 @@ void machine__remove_thread(struct machine *machine, struct thread *th)
 }
 
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
-				struct perf_sample *sample)
+				struct perf_sample *sample, bool clone)
 {
 	struct thread *thread = machine__find_thread(machine,
 						     event->fork.pid,
@@ -1738,7 +1738,7 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 					 event->fork.tid);
 
 	if (thread == NULL || parent == NULL ||
-	    thread__fork(thread, parent, sample->time) < 0) {
+	    thread__fork(thread, parent, sample->time, clone) < 0) {
 		dump_printf("problem processing PERF_RECORD_FORK, skipping event.\n");
 		err = -1;
 	}
@@ -1781,7 +1781,7 @@ int machine__process_event(struct machine *machine, union perf_event *event,
 	case PERF_RECORD_MMAP2:
 		ret = machine__process_mmap2_event(machine, event, sample); break;
 	case PERF_RECORD_FORK:
-		ret = machine__process_fork_event(machine, event, sample); break;
+		ret = machine__process_fork_event(machine, event, sample, false); break;
 	case PERF_RECORD_EXIT:
 		ret = machine__process_exit_event(machine, event, sample); break;
 	case PERF_RECORD_LOST:
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..c4a343809273 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -109,7 +109,7 @@ int machine__process_comm_event(struct machine *machine, union perf_event *event
 int machine__process_exit_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 int machine__process_fork_event(struct machine *machine, union perf_event *event,
-				struct perf_sample *sample);
+				struct perf_sample *sample, bool clone);
 int machine__process_lost_event(struct machine *machine, union perf_event *event,
 				struct perf_sample *sample);
 int machine__process_lost_samples_event(struct machine *machine, union perf_event *event,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index df5e12b22905..e3c6661a3936 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1393,6 +1393,9 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return tool->time_conv(session, event);
 	case PERF_RECORD_HEADER_FEATURE:
 		return tool->feature(session, event);
+	case PERF_RECORD_SYNTHESIZE_END:
+		tool->synth_end = true;
+		return 0;
 	default:
 		return -EINVAL;
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2048d393ece6..e8c09bc60ba9 100644
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
+		 u64 timestamp, bool clone)
 {
 	if (parent->comm_set) {
 		const char *comm = thread__comm_str(parent);
@@ -362,6 +356,13 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 	}
 
 	thread->ppid = parent->tid;
+
+	fprintf(stderr, "fork %d, clone %d\n", thread->tid, clone);
+
+	/* This is new thread, we share map groups for process. */
+	if (!clone || thread->pid_ == parent->pid_)
+		return thread__prepare_access(thread);
+
 	return thread__clone_map_groups(thread, parent);
 }
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 07606aa6998d..dd6716cd0fd6 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -87,7 +87,8 @@ struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
 const char *thread__comm_str(const struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
+int thread__fork(struct thread *thread, struct thread *parent,
+		 u64 timestamp, bool clone);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 56e4ca54020a..25463d7d9647 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -74,6 +74,7 @@ struct perf_tool {
 	bool		ordering_requires_timestamps;
 	bool		namespace_events;
 	bool		no_warn;
+	bool		synth_end;
 	enum show_feature_header show_feat_hdr;
 };
 
