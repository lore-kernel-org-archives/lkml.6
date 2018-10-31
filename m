Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C057FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4044520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 05:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4044520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeJaOu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 10:50:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38984 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbeJaOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 10:50:56 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7522B143B5929;
        Tue, 30 Oct 2018 22:54:18 -0700 (PDT)
Date:   Tue, 30 Oct 2018 22:54:16 -0700 (PDT)
Message-Id: <20181030.225416.1931363067297844847.davem@davemloft.net>
To:     acme@kernel.org
CC:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC] perf: Go back to by-hand proc mmap parsing and kill
 timeout
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Oct 2018 22:54:18 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This goes back to by-hand parsing of the proc mmap file, and removes
the timeout.

In my measurements this makes the parsing about twice as fast.

Profiling thread synthesizing shows that most of the time is spent in
the sscanf() call.

Processing samples is critical for perf top and perf record -a startup
performance, and perf's ability to keep up with high sample rates.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 2b1ef704169f..d4b5177c3c22 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1364,8 +1364,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 			"show events other than"
 			" HLT (x86 only) or Wait state (s390 only)"
 			" that take longer than duration usecs"),
-		OPT_UINTEGER(0, "proc-map-timeout", &kvm->opts.proc_map_timeout,
-				"per thread proc mmap processing timeout in ms"),
 		OPT_END()
 	};
 	const char * const live_usage[] = {
@@ -1394,7 +1392,6 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	kvm->opts.target.uses_mmap = false;
 	kvm->opts.target.uid_str = NULL;
 	kvm->opts.target.uid = UINT_MAX;
-	kvm->opts.proc_map_timeout = 500;
 
 	symbol__init(NULL);
 	disable_buildid_cache();
@@ -1453,8 +1450,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 	perf_session__set_id_hdr_size(kvm->session);
 	ordered_events__set_copy_on_queue(&kvm->session->ordered_events, true);
 	machine__synthesize_threads(&kvm->session->machines.host, &kvm->opts.target,
-				    kvm->evlist->threads, false,
-				    kvm->opts.proc_map_timeout, 1);
+				    kvm->evlist->threads, false, 1);
 	err = kvm_live_open_events(kvm);
 	if (err)
 		goto out;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0980dfe3396b..4259ea42a8ef 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -633,8 +633,7 @@ static int record__synthesize_workload(struct record *rec, bool tail)
 	err = perf_event__synthesize_thread_map(&rec->tool, thread_map,
 						 process_synthesized_event,
 						 &rec->session->machines.host,
-						 rec->opts.sample_address,
-						 rec->opts.proc_map_timeout);
+						 rec->opts.sample_address);
 	thread_map__put(thread_map);
 	return err;
 }
@@ -848,8 +847,7 @@ static int record__synthesize(struct record *rec, bool tail)
 	}
 
 	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->threads,
-					    process_synthesized_event, opts->sample_address,
-					    opts->proc_map_timeout, 1);
+					    process_synthesized_event, opts->sample_address, 1);
 out:
 	return err;
 }
@@ -1521,7 +1519,6 @@ static struct record record = {
 			.uses_mmap   = true,
 			.default_per_cpu = true,
 		},
-		.proc_map_timeout     = 500,
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1651,8 +1648,6 @@ static struct option __record_options[] = {
 	parse_clockid),
 	OPT_STRING_OPTARG('S', "snapshot", &record.opts.auxtrace_snapshot_opts,
 			  "opts", "AUX area tracing Snapshot Mode", ""),
-	OPT_UINTEGER(0, "proc-map-timeout", &record.opts.proc_map_timeout,
-			"per thread proc mmap processing timeout in ms"),
 	OPT_BOOLEAN(0, "namespaces", &record.opts.record_namespaces,
 		    "Record namespaces events"),
 	OPT_BOOLEAN(0, "switch-events", &record.opts.record_switch_events,
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index d21d8751e749..4eec44d815bd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1096,7 +1096,6 @@ static int __cmd_top(struct perf_top *top)
 
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->threads, false,
-				    opts->proc_map_timeout,
 				    top->nr_threads_synthesize);
 
 	if (top->nr_threads_synthesize > 1)
@@ -1256,7 +1255,6 @@ int cmd_top(int argc, const char **argv)
 			.target		= {
 				.uses_mmap   = true,
 			},
-			.proc_map_timeout    = 500,
 			.overwrite	= 1,
 		},
 		.max_stack	     = sysctl__max_stack(),
@@ -1360,8 +1358,6 @@ int cmd_top(int argc, const char **argv)
 	OPT_STRING('w', "column-widths", &symbol_conf.col_width_list_str,
 		   "width[,width...]",
 		   "don't try to adjust column width, use these fixed values"),
-	OPT_UINTEGER(0, "proc-map-timeout", &opts->proc_map_timeout,
-			"per thread proc mmap processing timeout in ms"),
 	OPT_CALLBACK_NOOPT('b', "branch-any", &opts->branch_stack,
 		     "branch any", "sample any taken branches",
 		     parse_branch_stack),
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 90289f31dd87..0b68e0538107 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1240,8 +1240,7 @@ static int trace__symbols_init(struct trace *trace, struct perf_evlist *evlist)
 		goto out;
 
 	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
-					    evlist->threads, trace__tool_process, false,
-					    trace->opts.proc_map_timeout, 1);
+					    evlist->threads, trace__tool_process, false, 1);
 out:
 	if (err)
 		symbol__exit();
@@ -3242,7 +3241,6 @@ int cmd_trace(int argc, const char **argv)
 			.user_interval = ULLONG_MAX,
 			.no_buffering  = true,
 			.mmap_pages    = UINT_MAX,
-			.proc_map_timeout  = 500,
 		},
 		.output = stderr,
 		.show_comm = true,
@@ -3310,8 +3308,6 @@ int cmd_trace(int argc, const char **argv)
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
 	OPT_BOOLEAN(0, "print-sample", &trace.print_sample,
 			"print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info, for debugging"),
-	OPT_UINTEGER(0, "proc-map-timeout", &trace.opts.proc_map_timeout,
-			"per thread proc mmap processing timeout in ms"),
 	OPT_CALLBACK('G', "cgroup", &trace, "name", "monitor event in cgroup name only",
 		     trace__parse_cgroups),
 	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..0e2aafd8bb6e 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -81,7 +81,6 @@ struct record_opts {
 	unsigned     initial_delay;
 	bool         use_clockid;
 	clockid_t    clockid;
-	unsigned int proc_map_timeout;
 };
 
 struct option;
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 6b049f3f5cf4..dbf2c69944d2 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -599,7 +599,7 @@ static int do_test_code_reading(bool try_kcore)
 	}
 
 	ret = perf_event__synthesize_thread_map(NULL, threads,
-						perf_event__process, machine, false, 500);
+						perf_event__process, machine, false);
 	if (ret < 0) {
 		pr_debug("perf_event__synthesize_thread_map failed\n");
 		goto out_err;
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 2f008067d989..7c8d2e422401 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -34,7 +34,7 @@ static int init_live_machine(struct machine *machine)
 	pid_t pid = getpid();
 
 	return perf_event__synthesize_mmap_events(NULL, &event, pid, pid,
-						  mmap_handler, machine, true, 500);
+						  mmap_handler, machine, true);
 }
 
 /*
diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index b1af2499a3c9..5ede9b561d32 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -132,7 +132,7 @@ static int synth_all(struct machine *machine)
 {
 	return perf_event__synthesize_threads(NULL,
 					      perf_event__process,
-					      machine, 0, 500, 1);
+					      machine, 0, 1);
 }
 
 static int synth_process(struct machine *machine)
@@ -144,7 +144,7 @@ static int synth_process(struct machine *machine)
 
 	err = perf_event__synthesize_thread_map(NULL, map,
 						perf_event__process,
-						machine, 0, 500);
+						machine, 0);
 
 	thread_map__put(map);
 	return err;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc646185f8d9..92b09b2ba6bf 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -317,19 +317,39 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
 	return 0;
 }
 
+static int dec(char ch)
+{
+	if ((ch >= '0') && (ch <= '9'))
+		return ch - '0';
+	return -1;
+}
+
+static int dec2u64(const char *ptr, u64 *long_val)
+{
+	const char *p = ptr;
+
+	*long_val = 0;
+	while (*p) {
+		const int dec_val = dec(*p);
+
+		if (dec_val < 0)
+			break;
+
+		*long_val = (*long_val * 10) + dec_val;
+		p++;
+	}
+	return p - ptr;
+}
+
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       union perf_event *event,
 				       pid_t pid, pid_t tgid,
 				       perf_event__handler_t process,
 				       struct machine *machine,
-				       bool mmap_data,
-				       unsigned int proc_map_timeout)
+				       bool mmap_data)
 {
 	char filename[PATH_MAX];
 	FILE *fp;
-	unsigned long long t;
-	bool truncation = false;
-	unsigned long long timeout = proc_map_timeout * 1000000ULL;
 	int rc = 0;
 	const char *hugetlbfs_mnt = hugetlbfs__mountpoint();
 	int hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
@@ -350,87 +370,99 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	}
 
 	event->header.type = PERF_RECORD_MMAP2;
-	t = rdclock();
 
 	while (1) {
-		char bf[BUFSIZ];
-		char prot[5];
-		char execname[PATH_MAX];
+		char bf[BUFSIZ], *pbf = bf;
 		char anonstr[] = "//anon";
-		unsigned int ino;
+		char *execname;
 		size_t size;
 		ssize_t n;
+		u64 tmp;
 
 		if (fgets(bf, sizeof(bf), fp) == NULL)
 			break;
 
-		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
-				   "You may want to increase "
-				   "the time limit by --proc-map-timeout\n",
-				   filename);
-			truncation = true;
-			goto out;
-		}
-
-		/* ensure null termination since stack will be reused. */
-		strcpy(execname, "");
-
 		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		n = sscanf(bf, "%"PRIx64"-%"PRIx64" %s %"PRIx64" %x:%x %u %[^\n]\n",
-		       &event->mmap2.start, &event->mmap2.len, prot,
-		       &event->mmap2.pgoff, &event->mmap2.maj,
-		       &event->mmap2.min,
-		       &ino, execname);
-
-		/*
- 		 * Anon maps don't have the execname.
- 		 */
-		if (n < 7)
+		n = hex2u64(pbf, &event->mmap2.start);
+		if (n < 0)
 			continue;
-
-		event->mmap2.ino = (u64)ino;
-
-		/*
-		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
-		 */
-		if (machine__is_host(machine))
-			event->header.misc = PERF_RECORD_MISC_USER;
-		else
-			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
+		pbf += n + 1;
+		n = hex2u64(pbf, &event->mmap2.len);
+		if (n < 0)
+			continue;
+		pbf += n + 1;
 
 		/* map protection and flags bits */
 		event->mmap2.prot = 0;
 		event->mmap2.flags = 0;
-		if (prot[0] == 'r')
+		if (pbf[0] == 'r')
 			event->mmap2.prot |= PROT_READ;
-		if (prot[1] == 'w')
+		if (pbf[1] == 'w')
 			event->mmap2.prot |= PROT_WRITE;
-		if (prot[2] == 'x')
+		if (pbf[2] == 'x')
 			event->mmap2.prot |= PROT_EXEC;
 
-		if (prot[3] == 's')
+		if (pbf[3] == 's')
 			event->mmap2.flags |= MAP_SHARED;
 		else
 			event->mmap2.flags |= MAP_PRIVATE;
 
-		if (prot[2] != 'x') {
-			if (!mmap_data || prot[0] != 'r')
+		if (pbf[2] != 'x') {
+			if (!mmap_data || pbf[0] != 'r')
 				continue;
 
 			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
 		}
 
-out:
-		if (truncation)
-			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
+		pbf += 5;
+		n = hex2u64(pbf, &event->mmap2.pgoff);
+		if (n < 0)
+			continue;
+		pbf += n + 1;
+
+		n = hex2u64(pbf, &tmp);
+		if (n < 0)
+			continue;
+		event->mmap2.maj = tmp;
+		pbf += n + 1;
+
+		n = hex2u64(pbf, &tmp);
+		if (n < 0)
+			continue;
+		event->mmap2.min = tmp;
+		pbf += n + 1;
 
-		if (!strcmp(execname, ""))
-			strcpy(execname, anonstr);
+		n = dec2u64(pbf, &event->mmap2.ino);
+		if (n < 0)
+			continue;
+		pbf += n;
+
+		execname = strchr(pbf, '/');
+		if (!execname)
+			execname = strchr(pbf, '[');
+
+		/*
+		 * Anon map, skip.
+		 */
+		if (!execname)
+			continue;
+
+		pbf = strchr(execname, '\n');
+		if (!pbf)
+			continue;
+		*pbf = '\0';
+
+		/*
+		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
+		 */
+		if (machine__is_host(machine))
+			event->header.misc = PERF_RECORD_MISC_USER;
+		else
+			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
 
 		if (hugetlbfs_mnt_len &&
 		    !strncmp(execname, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
-			strcpy(execname, anonstr);
+			execname = anonstr;
 			event->mmap2.flags |= MAP_HUGETLB;
 		}
 
@@ -449,9 +481,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			rc = -1;
 			break;
 		}
-
-		if (truncation)
-			break;
 	}
 
 	fclose(fp);
@@ -520,8 +549,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      perf_event__handler_t process,
 				      struct perf_tool *tool,
 				      struct machine *machine,
-				      bool mmap_data,
-				      unsigned int proc_map_timeout)
+				      bool mmap_data)
 {
 	char filename[PATH_MAX];
 	DIR *tasks;
@@ -547,8 +575,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		 */
 		if (pid == tgid &&
 		    perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-						       process, machine, mmap_data,
-						       proc_map_timeout))
+						       process, machine, mmap_data))
 			return -1;
 
 		return 0;
@@ -597,7 +624,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		if (_pid == pid) {
 			/* process the parent's maps too */
 			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
-						process, machine, mmap_data, proc_map_timeout);
+						process, machine, mmap_data);
 			if (rc)
 				break;
 		}
@@ -611,8 +638,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
 				      struct thread_map *threads,
 				      perf_event__handler_t process,
 				      struct machine *machine,
-				      bool mmap_data,
-				      unsigned int proc_map_timeout)
+				      bool mmap_data)
 {
 	union perf_event *comm_event, *mmap_event, *fork_event;
 	union perf_event *namespaces_event;
@@ -642,7 +668,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
 					       fork_event, namespaces_event,
 					       thread_map__pid(threads, thread), 0,
 					       process, tool, machine,
-					       mmap_data, proc_map_timeout)) {
+					       mmap_data)) {
 			err = -1;
 			break;
 		}
@@ -668,7 +694,7 @@ int perf_event__synthesize_thread_map(struct perf_tool *tool,
 						       fork_event, namespaces_event,
 						       comm_event->comm.pid, 0,
 						       process, tool, machine,
-						       mmap_data, proc_map_timeout)) {
+						       mmap_data)) {
 				err = -1;
 				break;
 			}
@@ -689,7 +715,6 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
 					    perf_event__handler_t process,
 					    struct machine *machine,
 					    bool mmap_data,
-					    unsigned int proc_map_timeout,
 					    struct dirent **dirent,
 					    int start,
 					    int num)
@@ -733,8 +758,7 @@ static int __perf_event__synthesize_threads(struct perf_tool *tool,
 		 */
 		__event__synthesize_thread(comm_event, mmap_event, fork_event,
 					   namespaces_event, pid, 1, process,
-					   tool, machine, mmap_data,
-					   proc_map_timeout);
+					   tool, machine, mmap_data);
 	}
 	err = 0;
 
@@ -754,7 +778,6 @@ struct synthesize_threads_arg {
 	perf_event__handler_t process;
 	struct machine *machine;
 	bool mmap_data;
-	unsigned int proc_map_timeout;
 	struct dirent **dirent;
 	int num;
 	int start;
@@ -766,7 +789,7 @@ static void *synthesize_threads_worker(void *arg)
 
 	__perf_event__synthesize_threads(args->tool, args->process,
 					 args->machine, args->mmap_data,
-					 args->proc_map_timeout, args->dirent,
+					 args->dirent,
 					 args->start, args->num);
 	return NULL;
 }
@@ -775,7 +798,6 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 				   perf_event__handler_t process,
 				   struct machine *machine,
 				   bool mmap_data,
-				   unsigned int proc_map_timeout,
 				   unsigned int nr_threads_synthesize)
 {
 	struct synthesize_threads_arg *args = NULL;
@@ -805,7 +827,6 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 	if (thread_nr <= 1) {
 		err = __perf_event__synthesize_threads(tool, process,
 						       machine, mmap_data,
-						       proc_map_timeout,
 						       dirent, base, n);
 		goto free_dirent;
 	}
@@ -827,7 +848,6 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		args[i].process = process;
 		args[i].machine = machine;
 		args[i].mmap_data = mmap_data;
-		args[i].proc_map_timeout = proc_map_timeout;
 		args[i].dirent = dirent;
 	}
 	for (i = 0; i < m; i++) {
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index bfa60bcafbde..45a3b47fc82c 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -412,7 +412,6 @@ struct events_stats {
 	u32 nr_unknown_id;
 	u32 nr_unprocessable_samples;
 	u32 nr_auxtrace_errors[PERF_AUXTRACE_ERROR_MAX];
-	u32 nr_proc_map_timeout;
 };
 
 enum {
@@ -669,8 +668,7 @@ typedef int (*perf_event__handler_t)(struct perf_tool *tool,
 int perf_event__synthesize_thread_map(struct perf_tool *tool,
 				      struct thread_map *threads,
 				      perf_event__handler_t process,
-				      struct machine *machine, bool mmap_data,
-				      unsigned int proc_map_timeout);
+				      struct machine *machine, bool mmap_data);
 int perf_event__synthesize_thread_map2(struct perf_tool *tool,
 				      struct thread_map *threads,
 				      perf_event__handler_t process,
@@ -682,7 +680,6 @@ int perf_event__synthesize_cpu_map(struct perf_tool *tool,
 int perf_event__synthesize_threads(struct perf_tool *tool,
 				   perf_event__handler_t process,
 				   struct machine *machine, bool mmap_data,
-				   unsigned int proc_map_timeout,
 				   unsigned int nr_threads_synthesize);
 int perf_event__synthesize_kernel_mmap(struct perf_tool *tool,
 				       perf_event__handler_t process,
@@ -797,8 +794,7 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       pid_t pid, pid_t tgid,
 				       perf_event__handler_t process,
 				       struct machine *machine,
-				       bool mmap_data,
-				       unsigned int proc_map_timeout);
+				       bool mmap_data);
 
 int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
 				       perf_event__handler_t process,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..6427a74ebc4a 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2443,15 +2443,13 @@ int machines__for_each_thread(struct machines *machines,
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
 				  struct target *target, struct thread_map *threads,
 				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int proc_map_timeout,
 				  unsigned int nr_threads_synthesize)
 {
 	if (target__has_task(target))
-		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap, proc_map_timeout);
+		return perf_event__synthesize_thread_map(tool, threads, process, machine, data_mmap);
 	else if (target__has_cpu(target))
 		return perf_event__synthesize_threads(tool, process,
 						      machine, data_mmap,
-						      proc_map_timeout,
 						      nr_threads_synthesize);
 	/* command specified */
 	return 0;
diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
index d856b85862e2..688d84ba823a 100644
--- a/tools/perf/util/machine.h
+++ b/tools/perf/util/machine.h
@@ -247,17 +247,14 @@ int machines__for_each_thread(struct machines *machines,
 int __machine__synthesize_threads(struct machine *machine, struct perf_tool *tool,
 				  struct target *target, struct thread_map *threads,
 				  perf_event__handler_t process, bool data_mmap,
-				  unsigned int proc_map_timeout,
 				  unsigned int nr_threads_synthesize);
 static inline
 int machine__synthesize_threads(struct machine *machine, struct target *target,
 				struct thread_map *threads, bool data_mmap,
-				unsigned int proc_map_timeout,
 				unsigned int nr_threads_synthesize)
 {
 	return __machine__synthesize_threads(machine, NULL, target, threads,
 					     perf_event__process, data_mmap,
-					     proc_map_timeout,
 					     nr_threads_synthesize);
 }
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d2c8ce6cfad..33d2c50cdc18 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1261,8 +1261,6 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_MMAP:
 		return tool->mmap(tool, event, sample, machine);
 	case PERF_RECORD_MMAP2:
-		if (event->header.misc & PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT)
-			++evlist->stats.nr_proc_map_timeout;
 		return tool->mmap2(tool, event, sample, machine);
 	case PERF_RECORD_COMM:
 		return tool->comm(tool, event, sample, machine);
@@ -1640,17 +1638,6 @@ static void perf_session__warn_about_errors(const struct perf_session *session)
 	perf_session__warn_order(session);
 
 	events_stats__auxtrace_error_warn(stats);
-
-	if (stats->nr_proc_map_timeout != 0) {
-		ui__warning("%d map information files for pre-existing threads were\n"
-			    "not processed, if there are samples for addresses they\n"
-			    "will not be resolved, you may find out which are these\n"
-			    "threads by running with -v and redirecting the output\n"
-			    "to a file.\n"
-			    "The time limit to process proc map is too short?\n"
-			    "Increase it by --proc-map-timeout\n",
-			    stats->nr_proc_map_timeout);
-	}
 }
 
 static int perf_session__flush_thread_stack(struct thread *thread,
