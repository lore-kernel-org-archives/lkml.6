Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96371C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D72B21726
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfAZKNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:13:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:13:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QADQ8m514230
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:13:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QADQNa514227;
        Sat, 26 Jan 2019 02:13:26 -0800
Date:   Sat, 26 Jan 2019 02:13:26 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-23z08bgizqnbc3qdsyl7jyyg@git.kernel.org>
Cc:     wangnan0@huawei.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        lclaudio@redhat.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          acme@redhat.com, lclaudio@redhat.com, wangnan0@huawei.com,
          jolsa@kernel.org, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_syscalls: Convert to bpf_map()
Git-Commit-ID: 76a06125dd57ed2c7559410168b543313fa0cc51
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

Commit-ID:  76a06125dd57ed2c7559410168b543313fa0cc51
Gitweb:     https://git.kernel.org/tip/76a06125dd57ed2c7559410168b543313fa0cc51
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 Jan 2019 16:02:17 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:11 +0100

perf augmented_syscalls: Convert to bpf_map()

To make the code more compact, end result is the same:

  # perf trace -e /home/acme/git/perf/tools/perf/examples/bpf/augmented_syscalls.c sleep 1
     0.000 ( 0.008 ms): sleep/9663 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
     0.022 ( 0.005 ms): sleep/9663 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
     0.226 ( 0.006 ms): sleep/9663 openat(dfd: CWD, filename: "/usr/lib/locale/locale-archive", flags: RDONLY|CLOEXEC) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-23z08bgizqnbc3qdsyl7jyyg@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index b7dba114e36c..524fdb8534b3 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -19,12 +19,8 @@
 #include <stdio.h>
 #include <linux/socket.h>
 
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-       .key_size = sizeof(int),
-       .value_size = sizeof(u32),
-       .max_entries = __NR_CPUS__,
-};
+/* bpf-output associated map */
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct syscall_exit_args {
 	unsigned long long common_tp_fields;
