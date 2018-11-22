Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9893DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6020865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:04:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF6020865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404883AbeKVRmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:42:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44061 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404856AbeKVRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:42:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM74KmK3690857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:04:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM74Jfe3690854;
        Wed, 21 Nov 2018 23:04:19 -0800
Date:   Wed, 21 Nov 2018 23:04:19 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1i9s27wqqdhafk3fappow84x@git.kernel.org>
Cc:     adrian.hunter@intel.com, wangnan0@huawei.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, mingo@kernel.org, acme@redhat.com,
        dsahern@gmail.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, dsahern@gmail.com, namhyung@kernel.org,
          acme@redhat.com, mingo@kernel.org, jolsa@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Use pid_filter
Git-Commit-ID: ed9a77ba7703f7da8f106d241cd0c734f8664b4d
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

Commit-ID:  ed9a77ba7703f7da8f106d241cd0c734f8664b4d
Gitweb:     https://git.kernel.org/tip/ed9a77ba7703f7da8f106d241cd0c734f8664b4d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 6 Nov 2018 16:09:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 12:00:31 -0300

perf augmented_syscalls: Use pid_filter

Just to test filtering a bunch of pids, now its time to go and get that
hooked up in 'perf trace', right after we load the bpf program, if we
find a "pids_filtered" map defined, we'll populate it with the filtered
pids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1i9s27wqqdhafk3fappow84x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 34 ++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 7d729319618c..5fed1eff889d 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -16,6 +16,7 @@
 
 #include <stdio.h>
 #include <unistd.h>
+#include <pid_filter.h>
 
 /* bpf-output associated map */
 struct bpf_map SEC("maps") __augmented_syscalls__ = {
@@ -48,6 +49,29 @@ struct augmented_filename {
 #define SYS_POLL 7
 #define SYS_OPENAT 257
 
+pid_filter(pids_filtered);
+
+static void pid_filter__init(void)
+{
+	/*
+	 * Filter a bunch of pids: gnome-shell, kvm, firefox threads,
+	 * avahi-daemon, etc, just for testing as we go along.
+	 *
+	 * These will come from 'perf trace --filter-pids' in a explicit way
+	 * and also it will filter out itself, to avoid the feedback loop:
+	 * syscalls 'perf trace' does gets caught, reported, causing new
+	 * syscalls to get emitted, rinse repeat forever.
+	 */
+	if (pid_filter__add(&pids_filtered, 2971))
+		return; /* pid_filter__init() was already called, bail out */
+	pid_filter__add(&pids_filtered, 20016);
+	pid_filter__add(&pids_filtered, 12018);
+	pid_filter__add(&pids_filtered, 2310);
+	pid_filter__add(&pids_filtered, 3759);
+	pid_filter__add(&pids_filtered, 25978);
+	pid_filter__add(&pids_filtered, 883);
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
@@ -57,8 +81,14 @@ int sys_enter(struct syscall_enter_args *args)
 	} augmented_args;
 	unsigned int len = sizeof(augmented_args);
 	const void *filename_arg = NULL;
+	/*
+ 	 * We still don't have a "main()" called first and only once
+ 	 * call it always, it will exit as soon as it realizes the
+ 	 * first hard coded filtered pid was already added.
+ 	 */
+	pid_filter__init();
 
-	if (getpid() == 2971)
+	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
 	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
@@ -132,7 +162,7 @@ int sys_enter(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_exit")
 int sys_exit(struct syscall_exit_args *args)
 {
-	return getpid() != 2971;
+	return !pid_filter__has(&pids_filtered, getpid());
 }
 
 license(GPL);
