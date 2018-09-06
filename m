Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600ABC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEBC520857
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBC520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeIFRvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:51:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbeIFRvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:51:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86DG9a1305021
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:16:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86DG9o4305018;
        Thu, 6 Sep 2018 06:16:09 -0700
Date:   Thu, 6 Sep 2018 06:16:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-k2eu68lsphnm2fthc32gq76c@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        dsahern@gmail.com, tglx@linutronix.de, namhyung@kernel.org,
        wangnan0@huawei.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, dsahern@gmail.com, tglx@linutronix.de,
          namhyung@kernel.org, wangnan0@huawei.com, mingo@kernel.org,
          jolsa@kernel.org, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace augmented_syscalls: Augment sendto's
 'addr' arg
Git-Commit-ID: 6ebb686225a83200b94777cfc651c94f4e0f6f50
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

Commit-ID:  6ebb686225a83200b94777cfc651c94f4e0f6f50
Gitweb:     https://git.kernel.org/tip/6ebb686225a83200b94777cfc651c94f4e0f6f50
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 29 Aug 2018 08:47:08 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 15:52:20 -0300

perf trace augmented_syscalls: Augment sendto's 'addr' arg

Its a 'struct sockaddr' pointer, augment it with the same beautifier as
for 'connect' and 'bind', that all receive from userspace that pointer.

Doing it in the other direction remains to be done, hooking at the
syscalls:sys_exit_{accept4?,recvmsg} tracepoints somehow.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-k2eu68lsphnm2fthc32gq76c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                   |  3 ++-
 tools/perf/examples/bpf/augmented_syscalls.c | 13 +++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 537bb30895df..759d14e3fe6b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -795,7 +795,8 @@ static struct syscall_fmt {
 	{ .name	    = "sendmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "sendto",
-	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
+	  .arg = { [3] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ },
+		   [4] = { .scnprintf = SCA_SOCKADDR, /* addr */ }, }, },
 	{ .name	    = "set_tid_address", .errpid = true, },
 	{ .name	    = "setitimer",
 	  .arg = { [0] = STRARRAY(which, itimers), }, },
diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 71edb7ad8698..be06d2c9e8c9 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -142,4 +142,17 @@ struct syscall_enter_connect_args {
 
 augmented_sockaddr_syscall_enter(connect);
 
+struct syscall_enter_sendto_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   fd;
+	void		   *buff;
+	long		   len;
+	unsigned long	   flags;
+	struct sockaddr	   *addr_ptr;
+	long		   addr_len;
+};
+
+augmented_sockaddr_syscall_enter(sendto);
+
 license(GPL);
