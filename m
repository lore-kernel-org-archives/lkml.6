Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260D3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44C420861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44C420861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeIFRq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:46:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49199 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbeIFRq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:46:58 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DBL4g304205
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:11:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DBLni304202;
        Thu, 6 Sep 2018 06:11:21 -0700
Date:   Thu, 6 Sep 2018 06:11:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ol83juin2cht9vzquynec5hz@git.kernel.org>
Cc:     adrian.hunter@intel.com, dsahern@gmail.com, hpa@zytor.com,
        mingo@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, dsahern@gmail.com,
          mingo@kernel.org, jolsa@kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, acme@redhat.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Augment inotify_add_watch pathname
 syscall arg
Git-Commit-ID: 9779fc021410e7d8433d923a2202dac7e1384b05
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

Commit-ID:  9779fc021410e7d8433d923a2202dac7e1384b05
Gitweb:     https://git.kernel.org/tip/9779fc021410e7d8433d923a2202dac7e1384b05
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 13:21:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Augment inotify_add_watch pathname syscall arg

Again, just changing tools/perf/examples/bpf/augmented_syscalls.c, that
is starting to have too much boilerplate, some macro will come to the
rescue.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/cache/app-info/yaml, mask: 16789454)
     0.023 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/lib/app-info/xmls, mask: 16789454)
     0.028 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/lib/app-info/yaml, mask: 16789454)
     0.032 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /usr/share/app-info/yaml, mask: 16789454)
     0.039 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /usr/local/share/app-info/xmls, mask: 16789454)
     0.045 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /usr/local/share/app-info/yaml, mask: 16789454)
     0.049 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /home/acme/.local/share/app-info/yaml, mask: 16789454)
     0.056 gmain/2590 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: , mask: 16789454)
     0.010 gmain/2245 inotify_add_watch(fd: 7<anon_inode:inotify>, pathname: /home/acme/~, mask: 16789454)
     0.087 perf/20116 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_inotify_add)
     0.436 perf/20116 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/form)
    56.042 gmain/2791 inotify_add_watch(fd: 4<anon_inode:inotify>, pathname: /var/lib/fwupd/remotes.d/lvfs-testing, mask: 16789454)
   113.986 gmain/1721 inotify_add_watch(fd: 3<anon_inode:inotify>, pathname: /var/lib/gdm/~, mask: 16789454)
  3777.265 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
  3777.550 gsd-color/2408 openat(dfd: CWD, filename: /etc/localtime)
^C[root@jouet perf]#

Still not combining raw_syscalls:sys_enter + raw_syscalls:sys_exit, to
get it strace-like, but that probably will come very naturally with some
more wiring up...

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ol83juin2cht9vzquynec5hz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 154379463c95..6ec327850a15 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -88,4 +88,31 @@ int syscall_enter(open)(struct syscall_enter_open_args *args)
 	return 0;
 }
 
+struct syscall_enter_inotify_add_watch_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	char		   *pathname_ptr;
+	long		   mask;
+};
+
+struct augmented_enter_inotify_add_watch_args {
+	struct syscall_enter_inotify_add_watch_args args;
+	struct augmented_filename		    pathname;
+};
+
+int syscall_enter(inotify_add_watch)(struct syscall_enter_inotify_add_watch_args *args)
+{
+	struct augmented_enter_inotify_add_watch_args augmented_args = { .pathname.reserved = 0, };
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	augmented_args.pathname.size = probe_read_str(&augmented_args.pathname.value,
+						      sizeof(augmented_args.pathname.value),
+						      args->pathname_ptr);
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
+			  &augmented_args,
+			  sizeof(augmented_args) - sizeof(augmented_args.pathname.value) + augmented_args.pathname.size);
+	return 0;
+}
+
 license(GPL);
