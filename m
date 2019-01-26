Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2E3C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A5D217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbfAZKMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:12:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43145 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:12:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QABVXD513911
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:11:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QABV5L513908;
        Sat, 26 Jan 2019 02:11:31 -0800
Date:   Sat, 26 Jan 2019 02:11:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-pjlf38sv3i1hbn5vzkr4y3ol@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, lclaudio@redhat.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, kafai@fb.com,
        yhs@fb.com, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, jolsa@kernel.org,
          wangnan0@huawei.com, lclaudio@redhat.com, daniel@iogearbox.net,
          kafai@fb.com, yhs@fb.com, acme@redhat.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Use bpf_map()
Git-Commit-ID: 56d8175a4d05ed31fe9c3053a83a5f8e08a284ee
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

Commit-ID:  56d8175a4d05ed31fe9c3053a83a5f8e08a284ee
Gitweb:     https://git.kernel.org/tip/56d8175a4d05ed31fe9c3053a83a5f8e08a284ee
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 24 Jan 2019 15:17:23 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf augmented_raw_syscalls: Use bpf_map()

To make the code more compact and also paving the way to have the BTF
annotation to be done transparently.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-pjlf38sv3i1hbn5vzkr4y3ol@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 9e9d4c66e53c..f9b2161e1ca4 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -18,23 +18,13 @@
 #include <pid_filter.h>
 
 /* bpf-output associated map */
-struct bpf_map SEC("maps") __augmented_syscalls__ = {
-	.type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
-	.key_size = sizeof(int),
-	.value_size = sizeof(u32),
-	.max_entries = __NR_CPUS__,
-};
+bpf_map(__augmented_syscalls__, PERF_EVENT_ARRAY, int, u32, __NR_CPUS__);
 
 struct syscall {
 	bool	enabled;
 };
 
-struct bpf_map SEC("maps") syscalls = {
-	.type	     = BPF_MAP_TYPE_ARRAY,
-	.key_size    = sizeof(int),
-	.value_size  = sizeof(struct syscall),
-	.max_entries = 512,
-};
+bpf_map(syscalls, ARRAY, int, struct syscall, 512);
 
 struct syscall_enter_args {
 	unsigned long long common_tp_fields;
