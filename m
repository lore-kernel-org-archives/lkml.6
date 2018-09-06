Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1877C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42402075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:20:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42402075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeIFRzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:55:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbeIFRzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:55:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DK0np305536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:20:00 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DK0n1305533;
        Thu, 6 Sep 2018 06:20:00 -0700
Date:   Thu, 6 Sep 2018 06:20:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-cyav42qj5yylolw4attcw99z@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        dsahern@gmail.com, namhyung@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, mingo@kernel.org, acme@redhat.com,
          dsahern@gmail.com, jolsa@kernel.org, namhyung@kernel.org,
          hpa@zytor.com, adrian.hunter@intel.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace augmented_syscalls: Hook into
 syscalls:sys_exit_SYSCALL too
Git-Commit-ID: f5b076dc01e77fa016de8439f8ac21d1c310c5be
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

Commit-ID:  f5b076dc01e77fa016de8439f8ac21d1c310c5be
Gitweb:     https://git.kernel.org/tip/f5b076dc01e77fa016de8439f8ac21d1c310c5be
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 30 Aug 2018 12:32:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:21 -0300

perf trace augmented_syscalls: Hook into syscalls:sys_exit_SYSCALL too

Hook the pair enter/exit when using augmented_{filename,sockaddr,etc}_syscall(),
this way we'll be able to see what entries are in the ELF sections generated
from augmented_syscalls.c and filter them out from the main raw_syscalls:*
tracepoints used by 'perf trace'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cyav42qj5yylolw4attcw99z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 253b3ccbd17d..1419a9186937 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -26,6 +26,12 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
        .max_entries = __NR_CPUS__,
 };
 
+struct syscall_exit_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   ret;
+};
+
 struct augmented_filename {
 	int	size;
 	int	reserved;
@@ -49,6 +55,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
 			   augmented_args.filename.size));					\
 	return 0;										\
+}												\
+int syscall_exit(syscall)(struct syscall_exit_args *args)					\
+{												\
+       return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */	\
 }
 
 struct syscall_enter_openat_args {
@@ -116,6 +126,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 			  &augmented_args, 							\
 			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);	\
 	return 0;										\
+}												\
+int syscall_exit(syscall)(struct syscall_exit_args *args)					\
+{												\
+       return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */	\
 }
 
 struct sockaddr;
