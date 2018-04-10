Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49qA/bYEbNtSMwacjrngxorf+NFZCNmroNZvRRIaANjSl2JY1zWq4Vv29tXzp2YmDXfnGKf
ARC-Seal: i=1; a=rsa-sha256; t=1523399699; cv=none;
        d=google.com; s=arc-20160816;
        b=UOu9hpy2/nbF0iVTZ8AShC1yQdUzf0BIz269W3Q+7XD+LPRtIr2xXUzChY/3cQpbOL
         hxmt4TRQwmIy5srCiDm9yaNg2Onli274ncXwOiSabqG42Edx/hCHyGhS4qTbrJC/8BqV
         bNnt3zZn5UPIRBox3FHIO//eNDmEOHp+NDALpB2Z8oP6qs6VM223+37Nbz3keKuIKxOe
         hZZATv92FgpOnlr2zh0MQo+Eb5MpmiibmFitgkU3SW8YuLgcZL6edf/652/p7UJ1yt6l
         pKaJGFiCPTmtHSnMhxKgmqeeK3W9ETyQTk9LQMsKnf7jyrJO35ipnTil2vUNHaba0UV0
         HOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rDwNVi5Nx2aFGsoOmQbRM34Iu1azgd6IfyfsDkIJ6vg=;
        b=TJ9cNyXey/G1IG6EJ9+gkWCq7yfepn4IAE5SY898Wx8Gs4hx4Bag7XbtrEXVUwWeiQ
         0gSMskvFFoAzLhW4kTsKlzwx1p/ZUbyxnk5cLPsbIgP2nUKz3i6/DBo6lbFE0AE2sKLH
         ABu70latQCCMxMqgMINM52C3Gkqfuny/em9xorW5Zg0mxwRydcCtaeyLfWzEU85pt0+H
         LtojFGRK+3ofaaEDWBAjheBq1OKbg1LPIG6cpnEdu2PCHdd9+wAlI+Kmdzy3abJdI+Y7
         khdGSjNegCl6MpRQsEe7F47X85E+j3zUg13IwbQE5oIUAPgle42F6IaHhu9n0NjK+qH6
         kv4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mengting Zhang <zhangmengting@huawei.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Cheng Jian <cj.chengjian@huawei.com>,
	Li Bin <huawei.libin@huawei.com>,
	Wang Nan <wangnan0@huawei.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 011/138] perf evsel: Enable ignore_missing_thread for pid option
Date: Wed, 11 Apr 2018 00:23:21 +0200
Message-Id: <20180410212903.460139042@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597399865451816464?=
X-GMAIL-MSGID: =?utf-8?q?1597400362980839789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mengting Zhang <zhangmengting@huawei.com>


[ Upstream commit ca8000684ec4e66f965e1f9547a3c6cb834154ca ]

While monitoring a multithread process with pid option, perf sometimes
may return sys_perf_event_open failure with 3(No such process) if any of
the process's threads die before we open the event. However, we want
perf continue monitoring the remaining threads and do not exit with
error.

Here, the patch enables perf_evsel::ignore_missing_thread for -p option
to ignore complete failure if any of threads die before we open the event.
But it may still return sys_perf_event_open failure with 22(Invalid) if we
monitors several event groups.

        sys_perf_event_open: pid 28960  cpu 40  group_fd 118202  flags 0x8
        sys_perf_event_open: pid 28961  cpu 40  group_fd 118203  flags 0x8
        WARNING: Ignored open failure for pid 28962
        sys_perf_event_open: pid 28962  cpu 40  group_fd [118203]  flags 0x8
        sys_perf_event_open failed, error -22

That is because when we ignore a missing thread, we change the thread_idx
without dealing with its fds, FD(evsel, cpu, thread). Then get_group_fd()
may return a wrong group_fd for the next thread and sys_perf_event_open()
return with 22.

        sys_perf_event_open(){
           ...
           if (group_fd != -1)
               perf_fget_light()//to get corresponding group_leader by group_fd
           ...
           if (group_leader)
              if (group_leader->ctx->task != ctx->task)//should on the same task
                   goto err_context
           ...
        }

This patch also fixes this bug by introducing perf_evsel__remove_fd() and
update_fds to allow removing fds for the missing thread.

Changes since v1:
- Change group_fd__remove() into a more genetic way without changing code logic
- Remove redundant condition

Changes since v2:
- Use a proper function name and add some comment.
- Multiline comment style fixes.

Committer testing:

Before this patch the recently added 'perf stat --per-thread' for system
wide counting would race while enumerating all threads using /proc:

  [root@jouet ~]# perf stat --per-thread
  failed to parse CPUs map: No such file or directory

   Usage: perf stat [<options>] [<command>]

      -C, --cpu <cpu>       list of cpus to monitor in system-wide
      -a, --all-cpus        system-wide collection from all CPUs
  [root@jouet ~]# perf stat --per-thread
  failed to parse CPUs map: No such file or directory

   Usage: perf stat [<options>] [<command>]

      -C, --cpu <cpu>       list of cpus to monitor in system-wide
      -a, --all-cpus        system-wide collection from all CPUs
  [root@jouet ~]#

When, say, the kernel was being built, so lots of shortlived threads,
after this patch this doesn't happen.

Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Cheng Jian <cj.chengjian@huawei.com>
Cc: Li Bin <huawei.libin@huawei.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1513148513-6974-1-git-send-email-zhangmengting@huawei.com
[ Remove one use 'evlist' alias variable ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-record.c |    4 +--
 tools/perf/util/evsel.c     |   47 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 4 deletions(-)

--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1856,8 +1856,8 @@ int cmd_record(int argc, const char **ar
 		goto out;
 	}
 
-	/* Enable ignoring missing threads when -u option is defined. */
-	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX;
+	/* Enable ignoring missing threads when -u/-p option is defined. */
+	rec->opts.ignore_missing_thread = rec->opts.target.uid != UINT_MAX || rec->opts.target.pid;
 
 	err = -ENOMEM;
 	if (perf_evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1591,10 +1591,46 @@ static int __open_attr__fprintf(FILE *fp
 	return fprintf(fp, "  %-32s %s\n", name, val);
 }
 
+static void perf_evsel__remove_fd(struct perf_evsel *pos,
+				  int nr_cpus, int nr_threads,
+				  int thread_idx)
+{
+	for (int cpu = 0; cpu < nr_cpus; cpu++)
+		for (int thread = thread_idx; thread < nr_threads - 1; thread++)
+			FD(pos, cpu, thread) = FD(pos, cpu, thread + 1);
+}
+
+static int update_fds(struct perf_evsel *evsel,
+		      int nr_cpus, int cpu_idx,
+		      int nr_threads, int thread_idx)
+{
+	struct perf_evsel *pos;
+
+	if (cpu_idx >= nr_cpus || thread_idx >= nr_threads)
+		return -EINVAL;
+
+	evlist__for_each_entry(evsel->evlist, pos) {
+		nr_cpus = pos != evsel ? nr_cpus : cpu_idx;
+
+		perf_evsel__remove_fd(pos, nr_cpus, nr_threads, thread_idx);
+
+		/*
+		 * Since fds for next evsel has not been created,
+		 * there is no need to iterate whole event list.
+		 */
+		if (pos == evsel)
+			break;
+	}
+	return 0;
+}
+
 static bool ignore_missing_thread(struct perf_evsel *evsel,
+				  int nr_cpus, int cpu,
 				  struct thread_map *threads,
 				  int thread, int err)
 {
+	pid_t ignore_pid = thread_map__pid(threads, thread);
+
 	if (!evsel->ignore_missing_thread)
 		return false;
 
@@ -1610,11 +1646,18 @@ static bool ignore_missing_thread(struct
 	if (threads->nr == 1)
 		return false;
 
+	/*
+	 * We should remove fd for missing_thread first
+	 * because thread_map__remove() will decrease threads->nr.
+	 */
+	if (update_fds(evsel, nr_cpus, cpu, threads->nr, thread))
+		return false;
+
 	if (thread_map__remove(threads, thread))
 		return false;
 
 	pr_warning("WARNING: Ignored open failure for pid %d\n",
-		   thread_map__pid(threads, thread));
+		   ignore_pid);
 	return true;
 }
 
@@ -1719,7 +1762,7 @@ retry_open:
 			if (fd < 0) {
 				err = -errno;
 
-				if (ignore_missing_thread(evsel, threads, thread, err)) {
+				if (ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
 					/*
 					 * We just removed 1 thread, so take a step
 					 * back on thread index and lower the upper
