Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14455C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE57E20839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbsN2UzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE57E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeIFCh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:26 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52B362073D;
        Wed,  5 Sep 2018 22:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185114;
        bh=+nJuvvoQebIqCBYCcECJp3QOxyRmK5K0DwLlS2ei+AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbsN2UzL4liULQga5rXlW402jOf6Ybn07o+Z1Z35zB7xhvb5V22l/Gi7Nk2ABwWG/
         ZGhEBWm2aOZyNm2rvz/HQkqjmSAa03Q2WFOH4hzzbv8b3VLtIokbwz0h15pIRm/SO6
         pTxy1Scwmzs2SXwZjCudsRHrergazbIlD21RcMS8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/77] perf trace: Augment inotify_add_watch pathname syscall arg
Date:   Wed,  5 Sep 2018 19:03:31 -0300
Message-Id: <20180905220440.20256-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

