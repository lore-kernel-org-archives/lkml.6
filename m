Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDCAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E047321871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171295;
	bh=T0vwWK4oSLgvc5MihHmwIj4WMq0tCQqakcQ1cNWFWo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yyAnAii6YAhE5Nc+WobAnZCr/gcDeqr857GwQDc7kBq3BJa2YUqy+DFRenfJnzhTO
	 KHU0fe+luN4Z8iagq87qgFesd9of7Hxa+8KPZFwJgWDufCL4gPliVOVbQfKgH/Tah2
	 CBcPBre/msyYQWRvgUFezCnGA7Dywn6IqEHZFFk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeLRWOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:14:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:44302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbeLRWOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:14:52 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0FA521871;
        Tue, 18 Dec 2018 22:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171292;
        bh=T0vwWK4oSLgvc5MihHmwIj4WMq0tCQqakcQ1cNWFWo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEqTcDXfxVDy2KQL1gSt4eul1grP2WdbBc7bX9xqWr5oAqGSrUhTY7DgLJ7JxoX2F
         ACxkQHZyalCy2ItxiNvAUiQsD4jNOEvoGBSkhszia2I9TaG3Gaaly5vTAFwqqHWHXX
         0LA7wxpC4FaoXrq7wXCLxZ6xd6BDLkzyc2hCCpy4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 48/63] perf augmented_raw_syscalls: Copy 'access' arg as well
Date:   Tue, 18 Dec 2018 19:07:18 -0300
Message-Id: <20181218220733.15839-49-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This will all come from userspace, but to test the changes to make 'perf
trace' output similar to strace's, do this one more now manually.

To update the precompiled augmented_raw_syscalls.o binary I just run:

  # perf record -e ~acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.c sleep 1
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.022 MB perf.data ]
  #

Because to have augmented_raw_syscalls to be always used and a fast
startup and remove the need to have the llvm toolchain installed, I'm
using:

  # perf config | grep add_events
  trace.add_events=/home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  #

So when doing changes to augmented_raw_syscals.c one needs to rebuild
the .o file.

This will be done automagically later, i.e. have a 'make' behaviour of
recompiling when the .c gets changed.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-lw3i2atyq8549fpqwmszn3qp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 6c5db6baeb3a..53c233370fae 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -55,6 +55,7 @@ struct augmented_filename {
 };
 
 #define SYS_OPEN 2
+#define SYS_ACCESS 21
 #define SYS_OPENAT 257
 
 pid_filter(pids_filtered);
@@ -119,6 +120,7 @@ int sys_enter(struct syscall_enter_args *args)
 	 * 	 after the ctx memory access to prevent their down stream merging.
 	 */
 	switch (augmented_args.args.syscall_nr) {
+	case SYS_ACCESS:
 	case SYS_OPEN:	 filename_arg = (const void *)args->args[0];
 			__asm__ __volatile__("": : :"memory");
 			 break;
-- 
2.19.2

