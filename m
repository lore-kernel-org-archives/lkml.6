Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63EC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E882921726
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfAZKM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:12:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:12:58 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QACmoU514201
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:12:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QACljc514197;
        Sat, 26 Jan 2019 02:12:47 -0800
Date:   Sat, 26 Jan 2019 02:12:47 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-znhgz24p0daux2kay200ovc1@git.kernel.org>
Cc:     mingo@kernel.org, wangnan0@huawei.com, adrian.hunter@intel.com,
        namhyung@kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        lclaudio@redhat.com, acme@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, namhyung@kernel.org, adrian.hunter@intel.com,
          wangnan0@huawei.com, mingo@kernel.org, lclaudio@redhat.com,
          jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf examples: Convert etcsnoop to use
 bpf_map()
Git-Commit-ID: f52fdd64f6046ab121688155aebd66b52ce0077d
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

Commit-ID:  f52fdd64f6046ab121688155aebd66b52ce0077d
Gitweb:     https://git.kernel.org/tip/f52fdd64f6046ab121688155aebd66b52ce0077d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 Jan 2019 15:48:05 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:11 +0100

perf bpf examples: Convert etcsnoop to use bpf_map()

Making the code more compact, end result is the same:

  # trace -e /home/acme/git/perf/tools/perf/examples/bpf/etcsnoop.c
     0.000 (         ): sed/7385 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
  2727.723 (         ): cat/7389 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) ...
  2728.543 (         ): cat/7389 openat(dfd: CWD, filename: "/etc/passwd")                          ...
  ^C

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-znhgz24p0daux2kay200ovc1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/etcsnoop.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/examples/bpf/etcsnoop.c b/tools/perf/examples/bpf/etcsnoop.c
index 550e69c2e8d1..e81b535346c0 100644
--- a/tools/perf/examples/bpf/etcsnoop.c
+++ b/tools/perf/examples/bpf/etcsnoop.c
@@ -21,12 +21,8 @@
 
 #include <stdio.h>
 
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-       .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-       .key_size = sizeof(int),
-       .value_size = sizeof(u32),
-       .max_entries = __NR_CPUS__,
-};
+/* bpf-output associated map */
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct augmented_filename {
 	int	size;
