Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681A6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EA8213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 21:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="h5XY41VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EA8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeJDEUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 00:20:01 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbeJDEUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 00:20:01 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id w93LTeU2009310
        for <linux-kernel@vger.kernel.org>; Wed, 3 Oct 2018 14:29:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=facebook; bh=hc+cNVMJUdAuuXYTRY4htB5vlb5BOrb2cOmP5r73lLc=;
 b=h5XY41VFf2YHtfVIPku79iA7nIXcJPbUcNVoqY2clq6iEgb7Ttj3Pg3w8NE9XxgFE7LQ
 kQWTvcuhY2Deb7o0XLAeArHzag11TYcsUg2LE05lcdeJAa89rdlYiRam4wQYrwRNA/h8
 Fgc5QTqZGIIUll/wRbCRjwoSJSQW47A2aGw= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2mw493r9kh-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 14:29:51 -0700
Received: from PRN-CHUB02.TheFacebook.com (2620:10d:c081:35::11) by
 PRN-CHUB14.TheFacebook.com (2620:10d:c081:35::23) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 3 Oct 2018 14:29:00 -0700
Received: from mx-out.facebook.com (192.168.52.123) by mail.thefacebook.com
 (192.168.16.12) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Oct
 2018 14:29:00 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)    id
 7239762E154C; Wed,  3 Oct 2018 14:28:51 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <ravi.bangoria@linux.ibm.com>,
        <naveen.n.rao@linux.vnet.ibm.com>, <maddy@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH/RFC v4 2/2] perf tools: monitoring per task counter with per cgroup event
Date:   Wed, 3 Oct 2018 14:28:48 -0700
Message-ID: <20181003212848.412256-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003212848.412256-1-songliubraving@fb.com>
References: <20181003212848.412256-1-songliubraving@fb.com>
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-03_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a prototype.

Previous patch enables sharing hardware PMU among perf_events within same
perf_event_context. This sharing comes with limitation that per CPU event
cannot share hardware PMU with per task event. This limitation becomes
a blocker when certain events could only use a specific PMU, for example,
ref-cycles in some Intel CPUs. The following two commands will not share
the PMU (when run in parallel):

   perf stat -e ref-cycles -I 1000
   perf stat -e ref-cycles -I 1000 --pid <pid>

This patch shows a prototype that solves this problem with cgroup events.
With this patch, the following two commands can share the PMU:

   perf stat -e ref-cycles -I 1000
   perf stat -e ref-cycles -I 1000 --pid <pid> --create-cgroup

The second command creates a cgroup for the pid, and move the pid to
that cgroup. Then, a cgroup event (instead of task event) is created
to monitor the process.

Alternatively, we can also create a mechanism in the kernel that is very
similar to cgroup perf events. I am also open to other suggestions.

Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 26 ++++++++++++++
 tools/perf/util/cgroup.c  | 76 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/cgroup.h  |  5 +++
 tools/perf/util/target.h  |  1 +
 4 files changed, 108 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b86aba1c8028..66a4da2d506e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -646,6 +646,17 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 				    ts, argc, argv);
 }

+static void cleanup(void)
+{
+	/* clean up cgroups */
+	if (target.create_cgroup) {
+		char name[32];
+
+		scnprintf(name, 31, "perf.%u", getpid());
+		cgroup__cleanup(name);
+	}
+}
+
 static volatile int signr = -1;

 static void skip_signal(int signo)
@@ -661,6 +672,7 @@ static void skip_signal(int signo)
 	 * and fast PID recycling
 	 */
 	child_pid = -1;
+	cleanup();
 }

 static void sig_atexit(void)
@@ -725,6 +737,8 @@ static const struct option stat_options[] = {
 		   "stat events on existing process id"),
 	OPT_STRING('t', "tid", &target.tid, "tid",
 		   "stat events on existing thread id"),
+	OPT_BOOLEAN(0, "create-cgroup", &target.create_cgroup,
+		    "create a cgroup for the pid/tid"),
 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
 		    "system-wide collection from all CPUs"),
 	OPT_BOOLEAN('g', "group", &group,
@@ -1607,6 +1621,17 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__collect_metric_expr(evsel_list);
 	perf_stat__init_shadow_stats();

+	if (target.create_cgroup) {
+		char name[32];
+
+		scnprintf(name, 31, "perf.%u", getpid());
+		cgroup__create(name);
+		cgroup__add_pid(name, strtoul(target.pid, NULL, 0));
+
+		cgroup__add_evlist(name, evsel_list);
+		target.pid = NULL;
+	}
+
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
 		if (!strcmp(stat_config.csv_sep, "\\t"))
@@ -1906,5 +1931,6 @@ int cmd_stat(int argc, const char **argv)

 	runtime_stat_delete(&stat_config);

+	cleanup();
 	return status;
 }
diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index ccd02634a616..f3e706f6fa96 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -249,3 +249,79 @@ int parse_cgroups(const struct option *opt, const char *str,
 	}
 	return 0;
 }
+
+int cgroup__add_evlist(const char *name, struct perf_evlist *evlist)
+{
+	return add_cgroup(evlist, name);
+}
+
+int cgroup__create(const char *name)
+{
+	char path[PATH_MAX + 1];
+	char mnt[PATH_MAX + 1];
+
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
+
+	return mkdir(path, 0755);
+}
+
+int cgroup__add_pid(const char *name, pid_t pid)
+{
+	char path[PATH_MAX + 1];
+	char mnt[PATH_MAX + 1];
+	char buf[32];
+	int fd;
+
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s/cgroup.procs", mnt, name);
+	fd = open(path, O_WRONLY);
+	if (fd < 0)
+		return -1;
+	scnprintf(buf, 31, "%u", pid);
+	if (write(fd, buf, strlen(buf)) < 0)
+		fprintf(stderr, "Error writing %s to %s\n", buf, path);
+
+	close(fd);
+	return 0;
+}
+
+int cgroup__cleanup(const char *name)
+{
+	char path[PATH_MAX + 1];
+	char mnt[PATH_MAX + 1];
+	char *line;
+	size_t len = 0;
+	FILE *fp;
+	int fd;
+
+	if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/%s/cgroup.procs", mnt, name);
+	fp = fopen(path, "r");
+
+	if (fp == NULL)
+		return -1;
+
+	scnprintf(path, PATH_MAX, "%s/cgroup.procs", mnt);
+	fd = open(path, O_WRONLY);
+	if (fd < 0) {
+		fclose(fp);
+		return -1;
+	}
+
+	while (getline(&line, &len, fp) != -1) {
+		if (write(fd, line, strlen(line)) < 0)
+			fprintf(stderr, "Error writing %s to %s\n", line, path);
+	}
+	close(fd);
+	fclose(fp);
+
+	scnprintf(path, PATH_MAX, "%s/%s", mnt, name);
+	return rmdir(path);
+}
diff --git a/tools/perf/util/cgroup.h b/tools/perf/util/cgroup.h
index f033a80c1b14..7bdd8d99d130 100644
--- a/tools/perf/util/cgroup.h
+++ b/tools/perf/util/cgroup.h
@@ -26,4 +26,9 @@ void evlist__set_default_cgroup(struct perf_evlist *evlist, struct cgroup *cgrou

 int parse_cgroups(const struct option *opt, const char *str, int unset);

+int cgroup__create(const char *name);
+int cgroup__cleanup(const char *name);
+int cgroup__add_pid(const char *name, pid_t pid);
+int cgroup__add_evlist(const char *name, struct perf_evlist *evlist);
+
 #endif /* __CGROUP_H__ */
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 6ef01a83b24e..03c9ac06660a 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -15,6 +15,7 @@ struct target {
 	bool	     uses_mmap;
 	bool	     default_per_cpu;
 	bool	     per_thread;
+	bool	     create_cgroup;
 };

 enum target_errno {
--
2.17.1
