Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9006C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C03F21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfBIMXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:23:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52807 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:23:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CNe3B2624685
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:23:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CNcFu2624671;
        Sat, 9 Feb 2019 04:23:38 -0800
Date:   Sat, 9 Feb 2019 04:23:38 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mv8kolk17xla1smvmp3qabv1@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mpetlan@redhat.com, adrian.hunter@intel.com,
        namhyung@kernel.org, mingo@kernel.org, jolsa@redhat.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, mpetlan@redhat.com, namhyung@kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, jolsa@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Support multiple "vfs_getname" probes
Git-Commit-ID: 6ab3bc240ade47a0f52bc16d97edd9accbe0024e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6ab3bc240ade47a0f52bc16d97edd9accbe0024e
Gitweb:     https://git.kernel.org/tip/6ab3bc240ade47a0f52bc16d97edd9accbe0024e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 29 Jan 2019 15:12:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Feb 2019 15:50:38 -0300

perf trace: Support multiple "vfs_getname" probes

With a suitably defined "probe:vfs_getname" probe, 'perf trace' can
"beautify" its output, so syscalls like open() or openat() can print the
"filename" argument instead of just its hex address, like:

  $ perf trace -e open -- touch /dev/null
  [...]
       0.590 ( 0.014 ms): touch/18063 open(filename: /dev/null, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3
  [...]

The output without such beautifier looks like:

     0.529 ( 0.011 ms): touch/18075 open(filename: 0xc78cf288, flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3

However, when the vfs_getname probe expands to multiple probes and it is
not the first one that is hit, the beautifier fails, as following:

     0.326 ( 0.010 ms): touch/18072 open(filename: , flags: CREAT|NOCTTY|NONBLOCK|WRONLY, mode: IRUGO|IWUGO) = 3

Fix it by hooking into all the expanded probes (inlines), now, for instance:

  [root@quaco ~]# perf probe -l
    probe:vfs_getname    (on getname_flags:73@fs/namei.c with pathname)
    probe:vfs_getname_1  (on getname_flags:73@fs/namei.c with pathname)
  [root@quaco ~]# perf trace -e open* sleep 1
       0.010 ( 0.005 ms): sleep/5588 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: RDONLY|CLOEXEC)   = 3
       0.029 ( 0.006 ms): sleep/5588 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: RDONLY|CLOEXEC)   = 3
       0.194 ( 0.008 ms): sleep/5588 openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: RDONLY|CLOEXEC) = 3
  [root@quaco ~]#

Works, further verified with:

  [root@quaco ~]# perf test vfs
  65: Use vfs_getname probe to get syscall args filenames   : Ok
  66: Add vfs_getname probe to get syscall args filenames   : Ok
  67: Check open filename arg using perf trace + vfs_getname: Ok
  [root@quaco ~]#

Reported-by: Michael Petlan <mpetlan@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-mv8kolk17xla1smvmp3qabv1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ed4583128b9c..b36061cd1ab8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2514,19 +2514,30 @@ static size_t trace__fprintf_thread_summary(struct trace *trace, FILE *fp);
 
 static bool perf_evlist__add_vfs_getname(struct perf_evlist *evlist)
 {
-	struct perf_evsel *evsel = perf_evsel__newtp("probe", "vfs_getname");
+	bool found = false;
+	struct perf_evsel *evsel, *tmp;
+	struct parse_events_error err = { .idx = 0, };
+	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
 
-	if (IS_ERR(evsel))
+	if (ret)
 		return false;
 
-	if (perf_evsel__field(evsel, "pathname") == NULL) {
+	evlist__for_each_entry_safe(evlist, evsel, tmp) {
+		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
+			continue;
+
+		if (perf_evsel__field(evsel, "pathname")) {
+			evsel->handler = trace__vfs_getname;
+			found = true;
+			continue;
+		}
+
+		list_del_init(&evsel->node);
+		evsel->evlist = NULL;
 		perf_evsel__delete(evsel);
-		return false;
 	}
 
-	evsel->handler = trace__vfs_getname;
-	perf_evlist__add(evlist, evsel);
-	return true;
+	return found;
 }
 
 static struct perf_evsel *perf_evsel__new_pgfault(u64 config)
