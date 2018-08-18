Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB36C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A1D2188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:19:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A1D2188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeHRO0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:26:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbeHRO0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:26:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBJCgg1283421
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:19:12 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBJCHX1283418;
        Sat, 18 Aug 2018 04:19:12 -0700
Date:   Sat, 18 Aug 2018 04:19:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xnp44ao3bkb6ejeczxfnjwsh@git.kernel.org>
Cc:     tglx@linutronix.de, dsahern@gmail.com, mingo@kernel.org,
        acme@redhat.com, wangnan0@huawei.com, namhyung@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: wangnan0@huawei.com, namhyung@kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
          mingo@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Associate vfs_getname()'ed pathname
 with fd returned from 'openat'
Git-Commit-ID: 6a648b534d3d4f6532241fd9b97c0dab7b0c3f89
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

Commit-ID:  6a648b534d3d4f6532241fd9b97c0dab7b0c3f89
Gitweb:     https://git.kernel.org/tip/6a648b534d3d4f6532241fd9b97c0dab7b0c3f89
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 2 Aug 2018 10:30:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 Aug 2018 10:30:08 -0300

perf trace: Associate vfs_getname()'ed pathname with fd returned from 'openat'

When the vfs_getname() wannabe tracepoint is in place:

  # perf probe -l
    probe:vfs_getname    (on getname_flags:73@acme/git/linux/fs/namei.c with pathname)
  #

'perf trace' will use it to get the pathname when it is copied from
userspace to the kernel, right after syscalls:sys_enter_open, copied
in the 'probe:vfs_getname', stash it somewhere and then, at
syscalls:sys_exit_open time, if the 'open' return is not -1, i.e. a
successfull open syscall, associate that pathname to this return, i.e.
the fd.

We were not doing this for the 'openat' syscall, which would cause 'perf
trace' to fallback to using /proc to get the fd, change it so that we
use what we got from probe:vfs_getname, reducing the 'openat'
beautification process cost, ditching the syscalls performed to read
procfs state and avoiding some possible races in the process.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xnp44ao3bkb6ejeczxfnjwsh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 88561eed7950..2a85f5198da0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -121,7 +121,6 @@ struct trace {
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
-	int			open_id;
 };
 
 struct tp_field {
@@ -805,12 +804,17 @@ static struct syscall_fmt *syscall_fmt__find(const char *name)
 	return bsearch(name, syscall_fmts, nmemb, sizeof(struct syscall_fmt), syscall_fmt__cmp);
 }
 
+/*
+ * is_exit: is this "exit" or "exit_group"?
+ * is_open: is this "open" or "openat"? To associate the fd returned in sys_exit with the pathname in sys_enter.
+ */
 struct syscall {
 	struct event_format *tp_format;
 	int		    nr_args;
+	bool		    is_exit;
+	bool		    is_open;
 	struct format_field *args;
 	const char	    *name;
-	bool		    is_exit;
 	struct syscall_fmt  *fmt;
 	struct syscall_arg_fmt *arg_fmt;
 };
@@ -1299,6 +1303,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	}
 
 	sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
+	sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
 
 	return syscall__set_arg_fmts(sc);
 }
@@ -1722,7 +1727,7 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 
 	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
 
-	if (id == trace->open_id && ret >= 0 && ttrace->filename.pending_open) {
+	if (sc->is_open && ret >= 0 && ttrace->filename.pending_open) {
 		trace__set_fd_pathname(thread, ret, ttrace->filename.name);
 		ttrace->filename.pending_open = false;
 		++trace->stats.vfs_getname;
@@ -3205,8 +3210,6 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	trace.open_id = syscalltbl__id(trace.sctbl, "open");
-
 	err = target__validate(&trace.opts.target);
 	if (err) {
 		target__strerror(&trace.opts.target, err, bf, sizeof(bf));
