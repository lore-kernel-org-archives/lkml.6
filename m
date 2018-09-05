Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E32C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CA52083D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Imukw6la"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CA52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbeIFChn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:42 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426D52077C;
        Wed,  5 Sep 2018 22:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185130;
        bh=numTWpY8y+eWGDe7t/vQlQWxglVarrWNuUD+Szkz82g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Imukw6laQSnNvmZTfhuehk2OQOJh1MNzQFi92UAsZrk1jEdBSt25i2twuAZZMwjEB
         R5pAUE3zZc4OdxAmk0udKb5Svbp16EOWxjiSwaPmTS+Ttk/3tRRksrxwtnC1GxLbrc
         ZtFSrrNz2CE802EFedtDnfyxmQ3TIgMpA9Dn9AhY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/77] perf trace augmented_syscalls: Augment connect's 'sockaddr' arg
Date:   Wed,  5 Sep 2018 19:03:37 -0300
Message-Id: <20180905220440.20256-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As the first example of augmenting something other than a 'filename',
augment the 'struct sockaddr' argument for the 'connect' syscall:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c ssh -6 fedorapeople.org
     0.000 ssh/29669 connect(fd: 3, uservaddr: { .family: LOCAL, path: /var/run/nscd/socket }, addrlen: 110)
     0.042 ssh/29669 connect(fd: 3, uservaddr: { .family: LOCAL, path: /var/run/nscd/socket }, addrlen: 110)
     1.329 ssh/29669 connect(fd: 3, uservaddr: { .family: LOCAL, path: /var/run/nscd/socket }, addrlen: 110)
     1.362 ssh/29669 connect(fd: 3, uservaddr: { .family: LOCAL, path: /var/run/nscd/socket }, addrlen: 110)
     1.458 ssh/29669 connect(fd: 3, uservaddr: { .family: LOCAL, path: /var/run/nscd/socket }, addrlen: 110)
     1.478 ssh/29669 connect(fd: 3, uservaddr: { .family: LOCAL, path: /var/run/nscd/socket }, addrlen: 110)
     1.683 ssh/29669 connect(fd: 3<socket:[125942]>, uservaddr: { .family: INET, port: 53, addr: 192.168.43.1 }, addrlen: 16)
     4.710 ssh/29669 connect(fd: 3<socket:[125942]>, uservaddr: { .family: INET6, port: 22, addr: 2610:28:3090:3001:5054:ff:fea7:9474 }, addrlen: 28)
  root@fedorapeople.org: Permission denied (publickey).
  #

This is still just augmenting the syscalls:sys_enter_connect part, later
we'll wire this up to augment the enter+exit combo, like in the
tradicional 'perf trace' and 'strace' outputs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-s7l541cbiqb22ifio6z7dpf6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   | 12 +-----
 tools/perf/examples/bpf/augmented_syscalls.c | 34 +++++++++++++++-
 tools/perf/trace/beauty/Build                |  1 +
 tools/perf/trace/beauty/beauty.h             |  5 +++
 tools/perf/trace/beauty/sockaddr.c           | 58 ++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/trace/beauty/sockaddr.c

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 5d841114a745..ab2ed30b8dcc 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -498,16 +498,6 @@ static const char *clockid[] = {
 };
 static DEFINE_STRARRAY(clockid);
 
-static const char *socket_families[] = {
-	"UNSPEC", "LOCAL", "INET", "AX25", "IPX", "APPLETALK", "NETROM",
-	"BRIDGE", "ATMPVC", "X25", "INET6", "ROSE", "DECnet", "NETBEUI",
-	"SECURITY", "KEY", "NETLINK", "PACKET", "ASH", "ECONET", "ATMSVC",
-	"RDS", "SNA", "IRDA", "PPPOX", "WANPIPE", "LLC", "IB", "CAN", "TIPC",
-	"BLUETOOTH", "IUCV", "RXRPC", "ISDN", "PHONET", "IEEE802154", "CAIF",
-	"ALG", "NFC", "VSOCK",
-};
-static DEFINE_STRARRAY(socket_families);
-
 static size_t syscall_arg__scnprintf_access_mode(char *bf, size_t size,
 						 struct syscall_arg *arg)
 {
@@ -645,6 +635,8 @@ static struct syscall_fmt {
 		   [4] = { .name = "tls",	    .scnprintf = SCA_HEX, }, }, },
 	{ .name	    = "close",
 	  .arg = { [0] = { .scnprintf = SCA_CLOSE_FD, /* fd */ }, }, },
+	{ .name	    = "connect",
+	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* servaddr */ }, }, },
 	{ .name	    = "epoll_ctl",
 	  .arg = { [1] = STRARRAY(op, epoll_ctl_ops), }, },
 	{ .name	    = "eventfd2",
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index a9695c7f7aab..6dfead0be74e 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -19,6 +19,7 @@
  */
 
 #include <stdio.h>
+#include <linux/socket.h>
 
 struct bpf_map SEC("maps") __augmented_syscalls__ = {
        .type = BPF_MAP_TYPE_PERF_EVENT_ARRAY,
@@ -33,7 +34,7 @@ struct augmented_filename {
 	char	value[256];
 };
 
-#define augmented_filename_syscall_enter(syscall) 							\
+#define augmented_filename_syscall_enter(syscall)						\
 struct augmented_enter_##syscall##_args {			 				\
 	struct syscall_enter_##syscall##_args	args;				 		\
 	struct augmented_filename		filename;				 	\
@@ -94,4 +95,35 @@ struct syscall_enter_newstat_args {
 
 augmented_filename_syscall_enter(newstat);
 
+struct sockaddr;
+
+struct syscall_enter_connect_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	struct sockaddr	   *addr_ptr;
+	unsigned long	   addrlen;
+};
+
+struct augmented_enter_connect_args {
+	struct syscall_enter_connect_args args;
+	struct sockaddr_storage		  addr;
+};
+
+int syscall_enter(connect)(struct syscall_enter_connect_args *args)
+{
+	struct augmented_enter_connect_args augmented_args;
+	unsigned long addrlen = sizeof(augmented_args.addr);
+
+	probe_read(&augmented_args.args, sizeof(augmented_args.args), args);
+#ifdef FIXME_CLANG_OPTIMIZATION_THAT_ACCESSES_USER_CONTROLLED_ADDRLEN_DESPITE_THIS_CHECK
+	if (addrlen > augmented_args.args.addrlen)
+		addrlen = augmented_args.args.addrlen;
+#endif
+	probe_read(&augmented_args.addr, addrlen, args->addr_ptr); 
+	perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, &augmented_args, 
+			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);
+	return 0;
+}
+
 license(GPL);
diff --git a/tools/perf/trace/beauty/Build b/tools/perf/trace/beauty/Build
index f528ba35e140..c3b0afd67760 100644
--- a/tools/perf/trace/beauty/Build
+++ b/tools/perf/trace/beauty/Build
@@ -7,5 +7,6 @@ endif
 libperf-y += kcmp.o
 libperf-y += pkey_alloc.o
 libperf-y += prctl.o
+libperf-y += sockaddr.o
 libperf-y += socket.o
 libperf-y += statx.o
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 6ca044d3d851..2570152d3909 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -30,6 +30,8 @@ struct thread;
 
 size_t pid__scnprintf_fd(struct trace *trace, pid_t pid, int fd, char *bf, size_t size);
 
+extern struct strarray strarray__socket_families;
+
 /**
  * augmented_arg: extra payload for syscall pointer arguments
  
@@ -135,6 +137,9 @@ size_t syscall_arg__scnprintf_prctl_arg2(char *bf, size_t size, struct syscall_a
 size_t syscall_arg__scnprintf_prctl_arg3(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PRCTL_ARG3 syscall_arg__scnprintf_prctl_arg3
 
+size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_SOCKADDR syscall_arg__scnprintf_sockaddr
+
 size_t syscall_arg__scnprintf_socket_protocol(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_SK_PROTO syscall_arg__scnprintf_socket_protocol
 
diff --git a/tools/perf/trace/beauty/sockaddr.c b/tools/perf/trace/beauty/sockaddr.c
new file mode 100644
index 000000000000..3944a7d54d3c
--- /dev/null
+++ b/tools/perf/trace/beauty/sockaddr.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+
+#include "trace/beauty/beauty.h"
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/un.h>
+#include <arpa/inet.h>
+
+static const char *socket_families[] = {
+	"UNSPEC", "LOCAL", "INET", "AX25", "IPX", "APPLETALK", "NETROM",
+	"BRIDGE", "ATMPVC", "X25", "INET6", "ROSE", "DECnet", "NETBEUI",
+	"SECURITY", "KEY", "NETLINK", "PACKET", "ASH", "ECONET", "ATMSVC",
+	"RDS", "SNA", "IRDA", "PPPOX", "WANPIPE", "LLC", "IB", "CAN", "TIPC",
+	"BLUETOOTH", "IUCV", "RXRPC", "ISDN", "PHONET", "IEEE802154", "CAIF",
+	"ALG", "NFC", "VSOCK",
+};
+DEFINE_STRARRAY(socket_families);
+
+static size_t syscall_arg__scnprintf_augmented_sockaddr(struct syscall_arg *arg, char *bf, size_t size)
+{
+	struct sockaddr_in *sin = (struct sockaddr_in *)arg->augmented.args;
+	char family[32];
+	size_t printed;
+
+	strarray__scnprintf(&strarray__socket_families, family, sizeof(family), "%d", sin->sin_family);
+	printed = scnprintf(bf, size, "{ .family: %s", family);
+
+	if (sin->sin_family == AF_INET) {
+		char tmp[512];
+		printed += scnprintf(bf + printed, size - printed, ", port: %d, addr: %s", ntohs(sin->sin_port),
+				     inet_ntop(sin->sin_family, &sin->sin_addr, tmp, sizeof(tmp)));
+	} else if (sin->sin_family == AF_INET6) {
+		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)sin;
+		u32 flowinfo = ntohl(sin6->sin6_flowinfo);
+		char tmp[512];
+
+		printed += scnprintf(bf + printed, size - printed, ", port: %d, addr: %s", ntohs(sin6->sin6_port),
+				     inet_ntop(sin6->sin6_family, &sin6->sin6_addr, tmp, sizeof(tmp)));
+		if (flowinfo != 0)
+			printed += scnprintf(bf + printed, size - printed, ", flowinfo: %lu", flowinfo);
+		if (sin6->sin6_scope_id != 0)
+			printed += scnprintf(bf + printed, size - printed, ", scope_id: %lu", sin6->sin6_scope_id);
+	} else if (sin->sin_family == AF_LOCAL) {
+		struct sockaddr_un *sun = (struct sockaddr_un *)sin;
+		printed += scnprintf(bf + printed, size - printed, ", path: %s", sun->sun_path);
+	}
+
+	return printed + scnprintf(bf + printed, size - printed, " }");
+}
+
+size_t syscall_arg__scnprintf_sockaddr(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->augmented.args)
+		return syscall_arg__scnprintf_augmented_sockaddr(arg, bf, size);
+
+	return scnprintf(bf, size, "%#x", arg->val);
+}
-- 
2.14.4

