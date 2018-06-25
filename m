Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00039C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B8225F80
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 17:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccbLng6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B8225F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964953AbeFYRle (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 13:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964934AbeFYRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 13:41:28 -0400
Received: from jouet.infradead.org (unknown [177.79.80.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E825E25F77;
        Mon, 25 Jun 2018 17:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529948488;
        bh=V8hXqFb+hQ9DhRBGnAikGcAGBhFNL/Rb9tBEEMAI53M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ccbLng6BQtVRCcSq8mJ3vrkcr4NE7Z3Zs/EIfsZp+JJwVMwNtZH2A6b8fCB9bDCSG
         JPsjPzpuNE94+coZycluhDWUjkFc+WKfH2hMyBVeBeSanddlnMZcrrJ5LWzrPmc58/
         MIgyHNwzucBHeA6jop5780ea2uZEj5LndRJVT05c=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 08/19] perf tools: Update x86's syscall_64.tbl, adding 'io_pgetevents' and 'rseq'
Date:   Mon, 25 Jun 2018 14:40:34 -0300
Message-Id: <20180625174045.25765-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180625174045.25765-1-acme@kernel.org>
References: <20180625174045.25765-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3

