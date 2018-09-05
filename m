Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A705FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291BC2083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mumjldrC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291BC2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeIFChu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFCht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:49 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62F1F20652;
        Wed,  5 Sep 2018 22:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185138;
        bh=RHleLS95RrIRFygpB6++04e/XDsiLDBxXRgxSKtWL8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mumjldrCGKWMFSw2GiSE8+ns154yd9cebs4hq30MAcfkCkC4siyKchhIxgKuX/mNk
         o6gv6jemTz0cTuE1+CUTLyMYF/3CBQCzP/TGujR+lMKkBFsQbXQsDsWQolgxAuYp4N
         a4ZjjzkhG7GlZ67oE7eV9BGfafNadkzATPnGZZT0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 17/77] perf trace augmented_syscalls: Augment sendto's 'addr' arg
Date:   Wed,  5 Sep 2018 19:03:40 -0300
Message-Id: <20180905220440.20256-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

