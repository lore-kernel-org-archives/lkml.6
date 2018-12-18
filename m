Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14140C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC553217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171223;
	bh=tWUqkLtSA8AyGcHIntArte1OpaL9OV9a/kbrfEhMjfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=phmJjfekoYbdt7UW3ZQ7ejlp0cik2dwTlYH6bab6Ee+oRQLP1W6PkE0C0l5tI4npB
	 7EA5k5F7dlH2zJKojD8XjeFP2OrTNyk+00S9H0i9Pq4MAG1aqvSoEhOcjTZJONS/Jf
	 ZMidJzO1jIP3UJHpksOmiL9/52YOyWHokMppJ3J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeLRWNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:13:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726993AbeLRWNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:13:40 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163C9217D9;
        Tue, 18 Dec 2018 22:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171218;
        bh=tWUqkLtSA8AyGcHIntArte1OpaL9OV9a/kbrfEhMjfY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ufXXMYZSbUX1bXMyXCQdy/FNt79ruh0vbXGQInKzV8lCcw1RUGfYPycdoIxJkRWeI
         aaXfFjjAt5Z8FKp2iMqq3KoLgUtw11HB6Ik+Q5ppJRMdWmmtAXW19TIN5lR/UL6i9j
         8AzCouA+iIzW10LB12RMboCu2OF2DdDBDzqaYl3U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 41/63] perf trace: Allow suppressing the syscall argument names
Date:   Tue, 18 Dec 2018 19:07:11 -0300
Message-Id: <20181218220733.15839-42-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To show just the values:

Default:

  # trace -e open*,close,*sleep sleep 1
  openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC           ) = 3
  close(fd: 3                                                           ) = 0
  openat(dfd: CWD, filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
  close(fd: 3                                                           ) = 0
  nanosleep(rqtp: 0x7ffc0c4ea0d0, rmtp: 0                               ) = 0
  close(fd: 1                                                           ) = 0
  close(fd: 2                                                           ) = 0
  #

Remove it:

  # perf config trace.show_arg_names=no
  # trace -e open*,close,*sleep sleep 1
  openat(CWD, /etc/ld.so.cache, CLOEXEC                                 ) = 3
  close(3                                                               ) = 0
  openat(CWD, /lib64/libc.so.6, CLOEXEC                                 ) = 3
  close(3                                                               ) = 0
  openat(CWD, /usr/lib/locale/locale-archive, CLOEXEC                   ) = 3
  close(3                                                               ) = 0
  nanosleep(0x7ffced3a8c40, 0                                           ) = 0
  close(1                                                               ) = 0
  close(2                                                               ) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ta9tbdwgodpw719sr2bjm8eb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt |  4 ++++
 tools/perf/builtin-trace.c               | 22 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index ecd1e9514925..35108fd61fa6 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -532,6 +532,10 @@ trace.*::
 	trace.no_inherit::
 		Do not follow children threads.
 
+	trace.show_arg_names::
+		Should syscall argument names be printed? If not then trace.show_zeros
+		will be set.
+
 	trace.show_duration::
 		Show syscall duration.
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e978ce034863..95dfcb851604 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -130,6 +130,7 @@ struct trace {
 	bool			show_tstamp;
 	bool			show_duration;
 	bool			show_zeros;
+	bool			show_arg_names;
 	bool			force;
 	bool			vfs_getname;
 	int			trace_pgfaults;
@@ -1613,8 +1614,11 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 			      sc->arg_fmt[arg.idx].parm))
 				continue;
 
-			printed += scnprintf(bf + printed, size - printed,
-					     "%s%s: ", printed ? ", " : "", field->name);
+			printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
+
+			if (trace->show_arg_names)
+				printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
+
 			printed += syscall__scnprintf_val(sc, bf + printed, size - printed, &arg, val);
 		}
 	} else if (IS_ERR(sc->tp_format)) {
@@ -3546,12 +3550,21 @@ static int trace__config(const char *var, const char *value, void *arg)
 		trace->show_tstamp = perf_config_bool(var, value);
 	} else if (!strcmp(var, "trace.show_duration")) {
 		trace->show_duration = perf_config_bool(var, value);
+	} else if (!strcmp(var, "trace.show_arg_names")) {
+		trace->show_arg_names = perf_config_bool(var, value);
+		if (!trace->show_arg_names)
+			trace->show_zeros = true;
 	} else if (!strcmp(var, "trace.show_zeros")) {
-		trace->show_zeros = perf_config_bool(var, value);
+		bool new_show_zeros = perf_config_bool(var, value);
+		if (!trace->show_arg_names && !new_show_zeros) {
+			pr_warning("trace.show_zeros has to be set when trace.show_arg_names=no\n");
+			goto out;
+		}
+		trace->show_zeros = new_show_zeros;
 	} else if (!strcmp(var, "trace.no_inherit")) {
 		trace->opts.no_inherit = perf_config_bool(var, value);
 	}
-
+out:
 	return err;
 }
 
@@ -3582,6 +3595,7 @@ int cmd_trace(int argc, const char **argv)
 		.show_comm = true,
 		.show_tstamp = true,
 		.show_duration = true,
+		.show_arg_names = true,
 		.trace_syscalls = false,
 		.kernel_syscallchains = false,
 		.max_stack = UINT_MAX,
-- 
2.19.2

