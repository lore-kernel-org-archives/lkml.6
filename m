Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49401C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF0120861
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF0120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbeIFRq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:46:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34573 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbeIFRq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:46:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DAofA304135
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:10:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DAodh304132;
        Thu, 6 Sep 2018 06:10:50 -0700
Date:   Thu, 6 Sep 2018 06:10:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-upmogc57uatljr6el6u8537l@git.kernel.org>
Cc:     mingo@kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        adrian.hunter@intel.com, dsahern@gmail.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        tglx@linutronix.de
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com,
          acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, jolsa@kernel.org, hpa@zytor.com,
          mingo@kernel.org, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Augment the 'open' syscall 'filename'
 arg
Git-Commit-ID: daa1284af3b9a8d73b1dadaa12bc4068a4ce22ab
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

Commit-ID:  daa1284af3b9a8d73b1dadaa12bc4068a4ce22ab
Gitweb:     https://git.kernel.org/tip/daa1284af3b9a8d73b1dadaa12bc4068a4ce22ab
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 21 Aug 2018 12:20:06 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:19 -0300

perf trace: Augment the 'open' syscall 'filename' arg

As described in the previous cset, all we had to do was to touch the
augmented_syscalls.c eBPF program, fire up 'perf trace' with that new
eBPF script in system wide mode and wait for 'open' syscalls, in
addition to 'openat' ones to see that it works:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
       0.000 StreamT~s #200/16150 openat(dfd: CWD, filename: /home/acme/.mozilla/firefox/fqxhj76d.default/prefs.js, flags: CREAT|EXCL|TRUNC|WRONLY, mode: IRUSR|IWUSR)
       0.065 StreamT~s #200/16150 openat(dfd: CWD, filename: /home/acme/.mozilla/firefox/fqxhj76d.default/prefs-1.js, flags: CREAT|EXCL|TRUNC|WRONLY, mode: IRUSR|IWUSR)
       0.435 StreamT~s #200/16150 openat(dfd: CWD, filename: /home/acme/.mozilla/firefox/fqxhj76d.default/prefs-1.js, flags: CREAT|TRUNC|WRONLY, mode: IRUSR|IWUSR)
       1.875 perf/16772 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_openat/form)
    1227.260 gnome-shell/1463 openat(dfd: CWD, filename: /proc/self/stat)
    1227.397 gnome-shell/2125 openat(dfd: CWD, filename: /proc/self/stat)
    7227.619 gnome-shell/1463 openat(dfd: CWD, filename: /proc/self/stat)
    7227.661 gnome-shell/2125 openat(dfd: CWD, filename: /proc/self/stat)
   10018.079 gnome-shell/1463 openat(dfd: CWD, filename: /proc/self/stat)
   10018.514 perf/16772 openat(dfd: CWD, filename: /proc/1237/status)
   10018.568 perf/16772 openat(dfd: CWD, filename: /proc/1237/status)
   10022.409 gnome-shell/2125 openat(dfd: CWD, filename: /proc/self/stat)
   10090.044 NetworkManager/1237 openat(dfd: CWD, filename: /proc/2125/stat)
   10090.351 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   10090.407 perf/16772 openat(dfd: CWD, filename: /sys/kernel/debug/tracing/events/syscalls/sys_enter_open/format)
   10091.763 NetworkManager/1237 openat(dfd: CWD, filename: /proc/2125/stat)
   10091.812 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   10092.807 NetworkManager/1237 openat(dfd: CWD, filename: /proc/2125/stat)
   10092.851 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   10094.650 NetworkManager/1237 openat(dfd: CWD, filename: /proc/1463/stat)
   10094.926 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   10096.010 NetworkManager/1237 openat(dfd: CWD, filename: /proc/1463/stat)
   10096.057 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   10097.056 NetworkManager/1237 openat(dfd: CWD, filename: /proc/1463/stat)
   10097.099 NetworkManager/1237 open(filename: /etc/passwd, flags: CLOEXEC)
   13228.345 gnome-shell/1463 openat(dfd: CWD, filename: /proc/self/stat)
   13232.734 gnome-shell/2125 openat(dfd: CWD, filename: /proc/self/stat)
   15198.956 lighttpd/16748 open(filename: /proc/loadavg, mode: ISGID|IXOTH)
  ^C#

It even catches 'perf' itself looking at the sys_enter_open and
sys_enter_openat tracefs format dictionaries when it first finds them in
the trace... :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-upmogc57uatljr6el6u8537l@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 93960e891478..154379463c95 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -61,4 +61,31 @@ int syscall_enter(openat)(struct syscall_enter_openat_args *args)
 	return 0;
 }
 
+struct syscall_enter_open_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	char		   *filename_ptr;
+	long		   flags;
+	long		   mode;
+};
+
+struct augmented_enter_open_args {
+	struct syscall_enter_open_args args;
+	struct augmented_filename      filename;
+};
+
+int syscall_enter(open)(struct syscall_enter_open_args *args)
+{
+	struct augmented_enter_open_args augmented_args = { .filename.reserved = 0, };
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+	augmented_args.filename.size = probe_read_str(&augmented_args.filename.value,
+						      sizeof(augmented_args.filename.value),
+						      args->filename_ptr);
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU,
+			  &augmented_args,
+			  sizeof(augmented_args) - sizeof(augmented_args.filename.value) + augmented_args.filename.size);
+	return 0;
+}
+
 license(GPL);
