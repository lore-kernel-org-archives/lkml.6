Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19384C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E4720878
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fslmlRF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3E4720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404283AbeKVOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404188AbeKVOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:10 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20BD20870;
        Thu, 22 Nov 2018 03:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857805;
        bh=o8VUX1RIC82TqpDpDQnjMxilk37Wr7YdOX3FBvkkRzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fslmlRF8BdVUFC1YzsyCcqv5o55kfVsVXlbnPUI58FbAu9l1SOFxNeLB3ayg57EHk
         lLxLi6g49+Ij6mktoz91ESOzbJB9PGEx06U7ORKffekyxJT2Or7RYeMkoPLgNp5Q3O
         v8rzN5acJiohYxUoBY8xamWlPJMQQsdpHBJ2W7Q8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/28] perf augmented_syscalls: Use pid_filter
Date:   Thu, 22 Nov 2018 00:35:50 -0300
Message-Id: <20181122033611.15890-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.5

