Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618FFC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B11205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 17:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B11205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbeJWCSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:18:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33870 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbeJWCSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:18:16 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 848E51466B51B;
        Mon, 22 Oct 2018 10:58:44 -0700 (PDT)
Date:   Mon, 22 Oct 2018 10:58:42 -0700 (PDT)
Message-Id: <20181022.105842.1364583912952511294.davem@davemloft.net>
To:     jolsa@redhat.com
Cc:     dzickus@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf overlapping maps...
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181022161613.GF2945@krava>
References: <20181019.214401.2045294780943844999.davem@davemloft.net>
        <20181022140738.jvutwmstgm2f65et@redhat.com>
        <20181022161613.GF2945@krava>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Oct 2018 10:58:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@redhat.com>
Date: Mon, 22 Oct 2018 18:16:13 +0200

> I think the fix might actualy speed things up,
> but yes, there could be other report regressions

I was about to say the same thing, it could actually speed things up.
In the best case, less work is done (clone avoided, and overlapping
maps don't have to be handled).  In the worst case, nothing changes.

Here is what I've been using, to give you an idea.  There may be some
file offset fuzz in these patches.

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 0cd42150f712..e5a442313f9d 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -308,6 +308,7 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
 	event->fork.pid  = tgid;
 	event->fork.tid  = pid;
 	event->fork.header.type = PERF_RECORD_FORK;
+	event->fork.header.misc = PERF_RECORD_MISC_COMM_EXEC;
 
 	event->fork.header.size = (sizeof(event->fork) + machine->id_hdr_size);
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..dc06f1fc2ed5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1708,5 +1720,6 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	struct thread *parent = machine__findnew_thread(machine,
 							event->fork.ppid,
 							event->fork.ptid);
+	int do_maps_clone = 1;
 	int err = 0;
 
@@ -1737,8 +1754,11 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	thread = machine__findnew_thread(machine, event->fork.pid,
 					 event->fork.tid);
 
+	if (event->fork.header.misc & PERF_RECORD_MISC_COMM_EXEC)
+		do_maps_clone = 0;
+
 	if (thread == NULL || parent == NULL ||
-	    thread__fork(thread, parent, sample->time) < 0) {
+	    thread__fork(thread, parent, sample->time, do_maps_clone) < 0) {
 		dump_printf("problem processing PERF_RECORD_FORK, skipping event.\n");
 		err = -1;
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 2048d393ece6..7f2858edf221 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -330,7 +330,8 @@ static int thread__prepare_access(struct thread *thread)
 }
 
 static int thread__clone_map_groups(struct thread *thread,
-				    struct thread *parent)
+				    struct thread *parent,
+				    int do_maps_clone)
 {
 	/* This is new thread, we share map groups for process. */
 	if (thread->pid_ == parent->pid_)
@@ -341,15 +342,14 @@ static int thread__clone_map_groups(struct thread *thread,
 			 thread->pid_, thread->tid, parent->pid_, parent->tid);
 		return 0;
 	}
-
 	/* But this one is new process, copy maps. */
-	if (map_groups__clone(thread, parent->mg) < 0)
+	if (do_maps_clone &&
+	    map_groups__clone(thread, parent->mg) < 0)
 		return -ENOMEM;
-
 	return 0;
 }
 
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
+int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, int do_maps_clone)
 {
 	if (parent->comm_set) {
 		const char *comm = thread__comm_str(parent);
@@ -362,7 +362,7 @@ int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp)
 	}
 
 	thread->ppid = parent->tid;
-	return thread__clone_map_groups(thread, parent);
+	return thread__clone_map_groups(thread, parent, do_maps_clone);
 }
 
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 07606aa6998d..8e4ca1ede01f 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -87,7 +87,7 @@ struct comm *thread__comm(const struct thread *thread);
 struct comm *thread__exec_comm(const struct thread *thread);
 const char *thread__comm_str(const struct thread *thread);
 int thread__insert_map(struct thread *thread, struct map *map);
-int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp);
+int thread__fork(struct thread *thread, struct thread *parent, u64 timestamp, int do_maps_clone);
 size_t thread__fprintf(struct thread *thread, FILE *fp);
 
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread);
