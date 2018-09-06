Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7685C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8053420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8053420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbeIFRsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:48:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58223 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbeIFRsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:48:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DCMfI304459
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:12:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DCMQS304456;
        Thu, 6 Sep 2018 06:12:22 -0700
Date:   Thu, 6 Sep 2018 06:12:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4lhabe7m4uzo76lnqpyfmnvk@git.kernel.org>
Cc:     dsahern@gmail.com, tglx@linutronix.de, jolsa@kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com, acme@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, namhyung@kernel.org
Reply-To: dsahern@gmail.com, tglx@linutronix.de, jolsa@kernel.org,
          adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Augment 'newstat' (aka 'stat') filename
 ptr
Git-Commit-ID: 16cc63593f67477e9ca62f10182e74e949af1acb
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

Commit-ID:  16cc63593f67477e9ca62f10182e74e949af1acb
Gitweb:     https://git.kernel.org/tip/16cc63593f67477e9ca62f10182e74e949af1acb
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 13:55:50 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Augment 'newstat' (aka 'stat') filename ptr

This one will need some more work, that 'statbuf' pointer requires a
beautifier in 'perf trace'.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 weechat/3596 stat(filename: /etc/localtime, statbuf: 0x7ffd87d11f60)
     0.186 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_stat/format)
     0.279 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_newstat/for)
     0.670 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/form)
    60.805 DNS Res~er #20/21308 stat(filename: /etc/resolv.conf, statbuf: 0x7ffa733fe4a0)
    60.836 DNS Res~er #20/21308 open(filename: /etc/hosts, flags: CLOEXEC)
    60.931 perf/29818 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_open/format)
   607.070 DNS Res~er #21/29812 stat(filename: /etc/resolv.conf, statbuf: 0x7ffa5e1fe3f0)
   607.098 DNS Res~er #21/29812 open(filename: /etc/hosts, flags: CLOEXEC)
   999.336 weechat/3596 stat(filename: /etc/localtime, statbuf: 0x7ffd87d11f60)
^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-4lhabe7m4uzo76lnqpyfmnvk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index e8486e8597de..a9695c7f7aab 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -83,4 +83,15 @@ struct syscall_enter_inotify_add_watch_args {
 
 augmented_filename_syscall_enter(inotify_add_watch);
 
+struct statbuf;
+
+struct syscall_enter_newstat_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	char		   *filename_ptr;
+	struct stat	   *statbuf;
+};
+
+augmented_filename_syscall_enter(newstat);
+
 license(GPL);
