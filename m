Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEADDC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826542075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826542075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeIFRvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:51:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43809 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeIFRvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:51:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DFcHZ304960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:15:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DFbH3304957;
        Thu, 6 Sep 2018 06:15:37 -0700
Date:   Thu, 6 Sep 2018 06:15:37 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a2drqpahpmc7uwb3n3gj2plu@git.kernel.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        adrian.hunter@intel.com
Reply-To: jolsa@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
          mingo@kernel.org, acme@redhat.com, wangnan0@huawei.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace augmented_syscalls: Augment bind's
 'myaddr' sockaddr arg
Git-Commit-ID: 02ef288420775542316e41dc610a6a88725aa83a
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

Commit-ID:  02ef288420775542316e41dc610a6a88725aa83a
Gitweb:     https://git.kernel.org/tip/02ef288420775542316e41dc610a6a88725aa83a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 28 Aug 2018 17:03:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf trace augmented_syscalls: Augment bind's 'myaddr' sockaddr arg

One more, to reuse the augmented_sockaddr_syscall_enter() macro
introduced from the augmentation of connect's sockaddr arg, also to get
a subset of the struct arg augmentations done using the manual method,
before switching to something automatic, using tracefs's format file or,
even better, BTF containing the syscall args structs.

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c
     0.000 sshd/11479 bind(fd: 3<socket:[170336]>, umyaddr: { .family: NETLINK }, addrlen: 12)
     1.752 sshd/11479 bind(fd: 3<socket:[170336]>, umyaddr: { .family: INET, port: 22, addr: 0.0.0.0 }, addrlen: 16)
     1.924 sshd/11479 bind(fd: 4<socket:[170338]>, umyaddr: { .family: INET6, port: 22, addr: :: }, addrlen: 28)
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-a2drqpahpmc7uwb3n3gj2plu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   |  2 ++
 tools/perf/examples/bpf/augmented_syscalls.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index ab2ed30b8dcc..537bb30895df 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -621,6 +621,8 @@ static struct syscall_fmt {
 } syscall_fmts[] = {
 	{ .name	    = "access",
 	  .arg = { [1] = { .scnprintf = SCA_ACCMODE,  /* mode */ }, }, },
+	{ .name	    = "bind",
+	  .arg = { [1] = { .scnprintf = SCA_SOCKADDR, /* umyaddr */ }, }, },
 	{ .name	    = "bpf",
 	  .arg = { [0] = STRARRAY(cmd, bpf_cmd), }, },
 	{ .name	    = "brk",	    .hexret = true,
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 5f417e528419..71edb7ad8698 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -122,6 +122,16 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 
 struct sockaddr;
 
+struct syscall_enter_bind_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	struct sockaddr	   *addr_ptr;
+	unsigned long	   addrlen;
+};
+
+augmented_sockaddr_syscall_enter(bind);
+
 struct syscall_enter_connect_args {
 	unsigned long long common_tp_fields;
 	long		   syscall_nr;
