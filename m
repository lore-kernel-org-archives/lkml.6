Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1752CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B704020839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+38eGLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B704020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbeIFChV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:21 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCE362077C;
        Wed,  5 Sep 2018 22:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185109;
        bh=Cwj4o0jlskgS0zOq99X4ZHQnzt+458ZrD7veSFwKXjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+38eGLUGQWMaWZPkoL/hw5OhQPrQv1WitZeZYphQRbDRIx8SHzC3Lz1nsN+PTl6+
         i9c6PnP5hPcQtwpWFHmfaiuV6QRtVgKoNm0DMOyuJDx5FFsP7KrLtJCBEoYrbpM5gi
         j1XwvTPKEKnOK+n5/aMYZpU1FQUbkoED2c7umWbM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 06/77] perf trace: Use the augmented filename, expanding syscall enter pointers
Date:   Wed,  5 Sep 2018 19:03:29 -0300
Message-Id: <20180905220440.20256-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is the final touch in showing how a syscall argument beautifier can
access the augmented args put in place by the
tools/perf/examples/bpf/augmented_syscalls.c eBPF script, right after
the regular raw syscall args, i.e. the up to 6 long integer values in
the syscall interface.

With this we are able to show the 'openat' syscall arg, now with up to
64 bytes, but in time this will be configurable, just like with the
'strace -s strsize' argument, from 'strace''s man page:

  -s strsize  Specify the maximum string size to print (the default is 32).

This actually is the maximum string to _collect_ and store in the ring
buffer, not just print.

Before:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): cat/9658 openat(dfd: CWD, filename: 0x6626eda8, flags: CLOEXEC)
     0.017 ( 0.007 ms): cat/9658 openat(dfd: CWD, filename: 0x6626eda8, flags: CLOEXEC) = 3
     0.049 (         ): cat/9658 openat(dfd: CWD, filename: 0x66476ce0, flags: CLOEXEC)
     0.051 ( 0.007 ms): cat/9658 openat(dfd: CWD, filename: 0x66476ce0, flags: CLOEXEC) = 3
     0.377 (         ): cat/9658 openat(dfd: CWD, filename: 0x1e8f806b)
     0.379 ( 0.005 ms): cat/9658 openat(dfd: CWD, filename: 0x1e8f806b) = 3
  #

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): cat/11966 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
     0.006 ( 0.006 ms): cat/11966 openat(dfd: CWD, filename: 0x4bfdcda8, flags: CLOEXEC) = 3
     0.034 (         ): cat/11966 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
     0.036 ( 0.008 ms): cat/11966 openat(dfd: CWD, filename: 0x4c1e4ce0, flags: CLOEXEC) = 3
     0.375 (         ): cat/11966 openat(dfd: CWD, filename: /etc/passwd)
     0.377 ( 0.005 ms): cat/11966 openat(dfd: CWD, filename: 0xe87906b) = 3
  #

This cset should show all the aspects of establishing a protocol between
an eBPF syscall arg augmenter program, tools/perf/examples/bpf/augmented_syscalls.c and
a 'perf trace' beautifier, the one associated with all 'char *' point
syscall args with names that can heuristically be associated with
filenames.

Now to wire up 'open' to show a second syscall using this scheme, all we
have to do now is to change tools/perf/examples/bpf/augmented_syscalls.c,
as 'perf trace' will notice that the perf_sample.raw_size is more than
what is expected for a particular syscall payload as defined by its
tracefs format file and will then use the augmented payload in the
'filename' syscall arg beautifier.

The same protocol will be used for structs such as 'struct sockaddr *',
'struct pollfd', etc, with additions for handling arrays.

This will all be done under the hood when 'perf trace' realizes the
system has the necessary components, and also can be done by providing
a precompiled augmented_syscalls.c eBPF ELF object.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-gj9kqb61wo7m3shtpzercbcr@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   | 10 ++++++++++
 tools/perf/examples/bpf/augmented_syscalls.c | 17 +++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e46ac9009172..5d841114a745 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1097,11 +1097,21 @@ static void thread__set_filename_pos(struct thread *thread, const char *bf,
 	ttrace->filename.entry_str_pos = bf - ttrace->entry_str;
 }
 
+static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, char *bf, size_t size)
+{
+	struct augmented_arg *augmented_arg = arg->augmented.args;
+
+	return scnprintf(bf, size, "%.*s", augmented_arg->size, augmented_arg->value);
+}
+
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
 					      struct syscall_arg *arg)
 {
 	unsigned long ptr = arg->val;
 
+	if (arg->augmented.args)
+		return syscall_arg__scnprintf_augmented_string(arg, bf, size);
+
 	if (!arg->trace->vfs_getname)
 		return scnprintf(bf, size, "%#x", ptr);
 
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 10e7997ab481..93960e891478 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -27,6 +27,12 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
        .max_entries = __NR_CPUS__,
 };
 
+struct augmented_filename {
+	int	size;
+	int	reserved;
+	char	value[256];
+};
+
 struct syscall_enter_openat_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
@@ -38,17 +44,20 @@ struct syscall_enter_openat_args {
 
 struct augmented_enter_openat_args {
 	struct syscall_enter_openat_args args;
-	char				 filename[64];
+	struct augmented_filename	 filename;
 };
 
 int syscall_enter(openat)(struct syscall_enter_openat_args *args)
 {
-	struct augmented_enter_openat_args augmented_args;
+	struct augmented_enter_openat_args augmented_args = { .filename.reserved = 0, };
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
-	probe_read_str(&augmented_args.filename, sizeof(augmented_args.filename), args->filename_ptr);
+	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
+						      sizeof(augmented_args.filename.value),
+						      args->filename_ptr);
 	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
-			  &augmented_args, sizeof(augmented_args));
+			  &augmented_args,
+			  sizeof(augmented_args) - sizeof(augmented_args.filename.value) + augmented_args.filename.size);
 	return 0;
 }
 
-- 
2.14.4

