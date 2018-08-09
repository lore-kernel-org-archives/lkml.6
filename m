Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B10C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C092D2183D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k20+d9Qi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C092D2183D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbeHIRYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732388AbeHIRYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:05 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 961BD2183D;
        Thu,  9 Aug 2018 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826728;
        bh=18sgzCCYH0VRaNgDsUT6zGVUM0v24g6pXvqrIbbMhkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k20+d9Qixax+mAvx3NOit94bF6ibAKVJg6c8SasY5xfUId6EbjNEJcxZfourrs1Lp
         YqmFsRXgTosubOAp9dbX11TkNYCP7TrrAmv7lRauIf2Yyl8L8Ws0H4uWjRYugQAbR6
         MNe4GgK6b2QNylCtDewwLu3HXP4oRAnfLRCdBWew=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 01/44] perf trace: Associate vfs_getname()'ed pathname with fd returned from 'openat'
Date:   Thu,  9 Aug 2018 11:57:39 -0300
Message-Id: <20180809145822.21391-2-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

