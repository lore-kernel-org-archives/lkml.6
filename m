Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F00C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595122077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 22:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ru10YoPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595122077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbeIFCiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:38:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbeIFCiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:38:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 725D220839;
        Wed,  5 Sep 2018 22:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536185156;
        bh=F4C+Qi61thimwcPF9Qxw3qtwaRdg/vl7+pINY+Mykf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ru10YoPtDII3rmnyiiXfKdXpLJNDCR/N0bUv2HelpD8wqbm8vjNyvC5xXKRB9cDl5
         5ieHyVAxvRCDIOdXGbImlfm2aIQrz5Yg9ALZWftLwqv7i1l4ge4HUx43NRRS9CMUX3
         VzZzfGHOB8qX0JluhYR/KrcX4JakGvJQt+VQSyhQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 24/77] perf trace augmented_syscalls: Hook into syscalls:sys_exit_SYSCALL too
Date:   Wed,  5 Sep 2018 19:03:47 -0300
Message-Id: <20180905220440.20256-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hook the pair enter/exit when using augmented_{filename,sockaddr,etc}_syscall(),
this way we'll be able to see what entries are in the ELF sections generated
from augmented_syscalls.c and filter them out from the main raw_syscalls:*
tracepoints used by 'perf trace'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-cyav42qj5yylolw4attcw99z@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_syscalls.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_syscalls.c b/tools/perf/examples/bpf/augmented_syscalls.c
index 253b3ccbd17d..1419a9186937 100644
--- a/tools/perf/examples/bpf/augmented_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_syscalls.c
@@ -26,6 +26,12 @@ struct bpf_map SEC("maps") __augmented_syscalls__ = {
        .max_entries = __NR_CPUS__,
 };
 
+struct syscall_exit_args {
+	unsigned long long common_tp_fields;
+	long		   syscall_nr;
+	long		   ret;
+};
+
 struct augmented_filename {
 	int	size;
 	int	reserved;
@@ -49,6 +55,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 			  (sizeof(augmented_args) - sizeof(augmented_args.filename.value) +	\
 			   augmented_args.filename.size));					\
 	return 0;										\
+}												\
+int syscall_exit(syscall)(struct syscall_exit_args *args)					\
+{												\
+       return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */	\
 }
 
 struct syscall_enter_openat_args {
@@ -116,6 +126,10 @@ int syscall_enter(syscall)(struct syscall_enter_##syscall##_args *args)				\
 			  &augmented_args, 							\
 			  sizeof(augmented_args) - sizeof(augmented_args.addr) + addrlen);	\
 	return 0;										\
+}												\
+int syscall_exit(syscall)(struct syscall_exit_args *args)					\
+{												\
+       return 1; /* 0 as soon as we start copying data returned by the kernel, e.g. 'read' */	\
 }
 
 struct sockaddr;
-- 
2.14.4

