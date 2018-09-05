Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77274C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 217142083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2po0MnEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 217142083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeIFChY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F662083E;
        Wed,  5 Sep 2018 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185111;
        bh=N3TyeQXLGAXgTIi++Q9/A7EssG9eP0RC0TMJOjGq3vY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2po0MnEj0FthPBYY1rupBQfnRlfKyZYhSk7g+iMINEQtj9gY1zmxujZAmPYnfq4oH
         yORyrURauLILL+SuV4S9e+f+99/2kBkvgNZ92GPe1jk+MWLtYY7arsZySu4iv9ilft
         oT3ZUYzGhDYBCD9BRFS+wItXjUX/FJAzd1gI0WMc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/77] perf trace: Augment the 'open' syscall 'filename' arg
Date:   Wed,  5 Sep 2018 19:03:30 -0300
Message-Id: <20180905220440.20256-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

