Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA71CC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872AD26591
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 06:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872AD26591
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeFZGzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 02:55:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751171AbeFZGzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 02:55:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5Q6tK0v1591493
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 25 Jun 2018 23:55:20 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5Q6tKRa1591490;
        Mon, 25 Jun 2018 23:55:20 -0700
Date:   Mon, 25 Jun 2018 23:55:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tfvyz51sabuzemrszbrhzxni@git.kernel.org>
Cc:     jolsa@kernel.org, wangnan0@huawei.com,
        mathieu.desnoyers@efficios.com, acme@redhat.com, dsahern@gmail.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, namhyung@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hch@lst.de
Reply-To: mingo@kernel.org, hch@lst.de, namhyung@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, acme@redhat.com, dsahern@gmail.com,
          mathieu.desnoyers@efficios.com, jolsa@kernel.org,
          wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Update x86's syscall_64.tbl, adding
 'io_pgetevents' and 'rseq'
Git-Commit-ID: b1494ec029af6d6ea189cbc96ad66463f8df3579
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

Commit-ID:  b1494ec029af6d6ea189cbc96ad66463f8df3579
Gitweb:     https://git.kernel.org/tip/b1494ec029af6d6ea189cbc96ad66463f8df3579
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 15 Jun 2018 11:48:43 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Jun 2018 11:59:36 -0300

perf tools: Update x86's syscall_64.tbl, adding 'io_pgetevents' and 'rseq'

This updates the tools/perf/ copy of the system call table for x86 which makes
'perf trace' become aware of the new 'io_pgetevents' and 'rseq' syscalls, no
matter in which system it gets built, i.e. older systems where the syscalls are
not available in the running kernel (via tracefs) or in the system headers will
still be aware of these syscalls/.

These are the csets introducing the source drift:

  05c17cedf85b ("x86: Wire up restartable sequence system call")
  7a074e96dee6 ("aio: implement io_pgetevents")

This results in this build time change:

  $ diff -u /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.old /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
  --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.old	2018-06-15 11:48:17.648948094 -0300
  +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2018-06-15 11:48:22.133942480 -0300
  @@ -332,5 +332,7 @@
          [330] = "pkey_alloc",
          [331] = "pkey_free",
          [332] = "statx",
  +       [333] = "io_pgetevents",
  +       [334] = "rseq",
   };
  -#define SYSCALLTBL_x86_64_MAX_ID 332
  +#define SYSCALLTBL_x86_64_MAX_ID 334
  $

This silences the following tools/perf/ build warning:

  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tfvyz51sabuzemrszbrhzxni@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 4dfe42666d0c..f0b1709a5ffb 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -341,6 +341,8 @@
 330	common	pkey_alloc		__x64_sys_pkey_alloc
 331	common	pkey_free		__x64_sys_pkey_free
 332	common	statx			__x64_sys_statx
+333	common	io_pgetevents		__x64_sys_io_pgetevents
+334	common	rseq			__x64_sys_rseq
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
