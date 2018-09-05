Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AB2C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E192083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Unrgw52D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E192083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbeIFCkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeIFCke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:40:34 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08F082077C;
        Wed,  5 Sep 2018 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185302;
        bh=64NVrwrnh5qlL8KxC+g21/FT6/l6L6NNMAHm1G/IYlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Unrgw52D7BH/3Q2LC+1ctpSXpQdj5GIpFw9TUmXohXtrGygyArkvSeA54XTPNStnT
         LBZpASSilK9V+WjTLSY518mPUkaz1edYsqCC2KZHZCfo5KQDgsFdrR3BDY36Zu7lT4
         GuhlO0M+u9yXhP7pAMcukLLflwvymybhqYrzRzPM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 75/77] perf trace: Use the raw_syscalls:sys_enter for the augmented syscalls
Date:   Wed,  5 Sep 2018 19:04:38 -0300
Message-Id: <20180905220440.20256-76-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now we combine what comes from the "bpf-output" event, i.e. what is
added in the augmented_syscalls.c BPF program via the
__augmented_syscalls__ BPF map, i.e. the payload we get with
raw_syscalls:sys_enter tracepoints plus the pointer contents, right
after that payload, with the raw_syscall:sys_exit also added, without
augmentation, in the augmented_syscalls.c program.

The end result is that for the hooked syscalls, we get strace like
output with pointer expansion, something that wasn't possible before
with just raw_syscalls:sys_enter + raw_syscalls:sys_exit.

E.g.:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c ping -c 2 ::1
     0.000 ( 0.008 ms): ping/19573 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.036 ( 0.006 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libcap.so.2, flags: CLOEXEC) = 3
     0.070 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libidn.so.11, flags: CLOEXEC) = 3
     0.095 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libcrypto.so.1.1, flags: CLOEXEC) = 3
     0.127 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libresolv.so.2, flags: CLOEXEC) = 3
     0.156 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libm.so.6, flags: CLOEXEC) = 3
     0.181 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.212 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libz.so.1, flags: CLOEXEC) = 3
     0.242 ( 0.004 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libdl.so.2, flags: CLOEXEC) = 3
     0.266 ( 0.003 ms): ping/19573 openat(dfd: CWD, filename: /lib64/libpthread.so.0, flags: CLOEXEC) = 3
     0.709 ( 0.006 ms): ping/19573 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
  PING ::1(::1) 56 data bytes
     1.133 ( 0.011 ms): ping/19573 connect(fd: 5, uservaddr: { .family: INET6, port: 1025, addr: ::1 }, addrlen: 28) = 0
  64 bytes from ::1: icmp_seq=1 ttl=64 time=0.033 ms
     1.234 ( 0.036 ms): ping/19573 sendto(fd: 4<socket:[1498931]>, buff: 0x555e5b975720, len: 64, addr: { .family: INET6, port: 58, addr: ::1 }, addr_len: 28) = 64
  64 bytes from ::1: icmp_seq=2 ttl=64 time=0.120 ms

  --- ::1 ping statistics ---
  2 packets transmitted, 2 received, 0% packet loss, time 1000ms
  rtt min/avg/max/mdev = 0.033/0.076/0.120/0.044 ms
  1002.060 ( 0.129 ms): ping/19573 sendto(fd: 4<socket:[1498931]>, buff: 0x555e5b975720, len: 64, flags: CONFIRM, addr: { .family: INET6, port: 58, addr: ::1 }, addr_len: 28) = 64
  #
  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c cat tools/perf/examples/bpf/hello.c
  #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
	  puts("Hello, world\n");
	  return 0;
  }

  license(GPL);
     0.000 ( 0.008 ms): cat/20054 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC) = 3
     0.020 ( 0.005 ms): cat/20054 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC) = 3
     0.176 ( 0.011 ms): cat/20054 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC) = 3
     0.243 ( 0.006 ms): cat/20054 openat(dfd: CWD, filename: tools/perf/examples/bpf/hello.c) = 3
  #

Now to think how to hook on all syscalls, fallbacking to the non-augmented
raw_syscalls:sys_enter payload.

Probably the best way is to use a BPF_MAP_TYPE_PROG_ARRAY just like
samples/bpf/tracex5_kern.c does.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-nlt60y69o26xi59z5vtpdrj5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 41 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2b99a02355cf..7ce277d22a91 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -288,6 +288,13 @@ static int perf_evsel__init_augmented_syscall_tp_args(struct perf_evsel *evsel)
 	return __tp_field__init_ptr(&sc->args, sc->id.offset + sizeof(u64));
 }
 
+static int perf_evsel__init_augmented_syscall_tp_ret(struct perf_evsel *evsel)
+{
+	struct syscall_tp *sc = evsel->priv;
+
+	return __tp_field__init_uint(&sc->ret, sizeof(u64), sc->id.offset + sizeof(u64), evsel->needs_swap);
+}
+
 static int perf_evsel__init_raw_syscall_tp(struct perf_evsel *evsel, void *handler)
 {
 	evsel->priv = malloc(sizeof(struct syscall_tp));
@@ -3346,12 +3353,8 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
-	if (evsel) {
-		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
-		    perf_evsel__init_augmented_syscall_tp_args(evsel))
-			goto out;
+	if (evsel)
 		trace.syscalls.events.augmented = evsel;
-	}
 
 	err = bpf__setup_stdout(trace.evlist);
 	if (err) {
@@ -3396,6 +3399,34 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
+	/*
+	 * If we are augmenting syscalls, then combine what we put in the
+	 * __augmented_syscalls__ BPF map with what is in the
+	 * syscalls:sys_exit_FOO tracepoints, i.e. just like we do without BPF,
+	 * combining raw_syscalls:sys_enter with raw_syscalls:sys_exit.
+	 *
+	 * We'll switch to look at two BPF maps, one for sys_enter and the
+	 * other for sys_exit when we start augmenting the sys_exit paths with
+	 * buffers that are being copied from kernel to userspace, think 'read'
+	 * syscall.
+	 */
+	if (trace.syscalls.events.augmented) {
+		evsel = trace.syscalls.events.augmented;
+
+		if (perf_evsel__init_augmented_syscall_tp(evsel) ||
+		    perf_evsel__init_augmented_syscall_tp_args(evsel))
+			goto out;
+		evsel->handler = trace__sys_enter;
+
+		evlist__for_each_entry(trace.evlist, evsel) {
+			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
+				perf_evsel__init_augmented_syscall_tp(evsel);
+				perf_evsel__init_augmented_syscall_tp_ret(evsel);
+				evsel->handler = trace__sys_exit;
+			}
+		}
+	}
+
 	if ((argc >= 1) && (strcmp(argv[0], "record") == 0))
 		return trace__record(&trace, argc-1, &argv[1]);
 
-- 
2.14.4

