Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC43C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801562077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCOLRbuN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801562077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeIFChs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:37:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeIFChr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:37:47 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF88120839;
        Wed,  5 Sep 2018 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185135;
        bh=0xompWM1BlahRca4Toab10TIxCmYO2//Yg+/KPpfmLI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UCOLRbuNzh0lVPJnci/rfe4KVyncLDxoKSKU80euHchSNRC92PsoDnJ4qNEytGUsV
         wuV0CqnH8w7raq+zaHwwWYdVMhansnPlc06QX96vGJAEzJWYyK4QRregmsBfRV5+aB
         SRLpwPUizQffsfuWn9RU6WuxBwjgU8ZuXpkjJ+z0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/77] perf trace augmented_syscalls: Augment bind's 'myaddr' sockaddr arg
Date:   Wed,  5 Sep 2018 19:03:39 -0300
Message-Id: <20180905220440.20256-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

