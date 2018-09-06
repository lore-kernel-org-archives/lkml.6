Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F71C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE99206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE99206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeIFRuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:50:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbeIFRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:50:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DEW6q304659
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:14:32 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DEWgg304655;
        Thu, 6 Sep 2018 06:14:32 -0700
Date:   Thu, 6 Sep 2018 06:14:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-s7l541cbiqb22ifio6z7dpf6@git.kernel.org>
Cc:     dsahern@gmail.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: namhyung@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          hpa@zytor.com, mingo@kernel.org, wangnan0@huawei.com,
          jolsa@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace augmented_syscalls: Augment connect's
 'sockaddr' arg
Git-Commit-ID: d5a7e6613b00d46a4971e8b69e18e2cfd7b00df3
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

Commit-ID:  d5a7e6613b00d46a4971e8b69e18e2cfd7b00df3
Gitweb:     https://git.kernel.org/tip/d5a7e6613b00d46a4971e8b69e18e2cfd7b00df3
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 Aug 2018 16:24:44 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf trace augmented_syscalls: Augment connect's 'sockaddr' arg

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
