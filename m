Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A98FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD3F218D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbeLTS0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:26:19 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54723 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731963AbeLTS0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:26:18 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIQ4i23686063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:26:04 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIQ4oA3686060;
        Thu, 20 Dec 2018 10:26:04 -0800
Date:   Thu, 20 Dec 2018 10:26:04 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ddghemr8qrm6i0sb8awznbze@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, lclaudio@redhat.com,
        hpa@zytor.com, wangnan0@huawei.com
Reply-To: mingo@kernel.org, jolsa@kernel.org, lclaudio@redhat.com,
          hpa@zytor.com, wangnan0@huawei.com, acme@redhat.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Show NULL when syscall pointer args are
 0
Git-Commit-ID: ce05539f20b337221d3310baf73b45317dab067c
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

Commit-ID:  ce05539f20b337221d3310baf73b45317dab067c
Gitweb:     https://git.kernel.org/tip/ce05539f20b337221d3310baf73b45317dab067c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Dec 2018 12:21:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:18 -0300

perf trace: Show NULL when syscall pointer args are 0

Matching strace's output format. The 'format' file for the syscall
tracepoints have an indication if the arg is a pointer, with some
exceptions like 'mmap' that has its first arg as an 'unsigned long', so
use a heuristic using the argument name, i.e. if it contains the 'addr'
substring, format it with the pointer formatter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ddghemr8qrm6i0sb8awznbze@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c       | 28 ++++++++++++----------------
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 35d8fbe47ee4..6ba8290a0794 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -444,6 +444,13 @@ size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg
 	return scnprintf(bf, size, "%#lx", arg->val);
 }
 
+size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->val == 0)
+		return scnprintf(bf, size, "NULL");
+	return syscall_arg__scnprintf_hex(bf, size, arg);
+}
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%d", arg->val);
@@ -660,7 +667,7 @@ static struct syscall_fmt {
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* brk */ }, }, },
+	  .arg = { [0] = { .scnprintf = SCA_PTR, /* brk */ }, }, },
 	{ .name     = "clock_gettime",
 	  .arg = { [0] = STRARRAY(clk_id, clockid), }, },
 	{ .name	    = "clone",	    .errpid = true, .nr_args = 5,
@@ -738,17 +745,12 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
 	{ .name	    = "mknodat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* fd */ }, }, },
-	{ .name	    = "mlock",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "mlockall",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
 	{ .name	    = "mmap",	    .hexret = true,
 /* The standard mmap maps to old_mmap on s390x */
 #if defined(__s390x__)
 	.alias = "old_mmap",
 #endif
-	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
-		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
+	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
 		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
@@ -760,13 +762,7 @@ static struct syscall_fmt {
 	{ .name	    = "mq_unlink",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* u_name */ }, }, },
 	{ .name	    = "mremap",	    .hexret = true,
-	  .arg = { [0] = { .scnprintf = SCA_HEX,	  /* addr */ },
-		   [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ },
-		   [4] = { .scnprintf = SCA_HEX,	  /* new_addr */ }, }, },
-	{ .name	    = "munlock",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
-	{ .name	    = "munmap",
-	  .arg = { [0] = { .scnprintf = SCA_HEX, /* addr */ }, }, },
+	  .arg = { [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "name_to_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "newfstatat",
@@ -1350,8 +1346,8 @@ static int syscall__set_arg_fmts(struct syscall *sc)
 			  strcmp(field->name, "path") == 0 ||
 			  strcmp(field->name, "pathname") == 0))
 			sc->arg_fmt[idx].scnprintf = SCA_FILENAME;
-		else if (field->flags & TEP_FIELD_IS_POINTER)
-			sc->arg_fmt[idx].scnprintf = syscall_arg__scnprintf_hex;
+		else if ((field->flags & TEP_FIELD_IS_POINTER) || strstr(field->name, "addr"))
+			sc->arg_fmt[idx].scnprintf = SCA_PTR;
 		else if (strcmp(field->type, "pid_t") == 0)
 			sc->arg_fmt[idx].scnprintf = SCA_PID;
 		else if (strcmp(field->type, "umode_t") == 0)
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index ac25b6410bc8..1a93d9c626ef 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -98,6 +98,9 @@ size_t syscall_arg__scnprintf_fd(char *bf, size_t size, struct syscall_arg *arg)
 size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_HEX syscall_arg__scnprintf_hex
 
+size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_PTR syscall_arg__scnprintf_ptr
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_INT syscall_arg__scnprintf_int
 
