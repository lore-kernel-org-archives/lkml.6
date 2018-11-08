Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D280C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E9F20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abf6xFMf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E9F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeKIISW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:18:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729106AbeKIHdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:46 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6F0208E3;
        Thu,  8 Nov 2018 21:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714178;
        bh=EYsT8XcwoOQ5eUOK3mWwGyJBBeK4D0KCHaBKU71AgLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Abf6xFMfjS0Nbb83Mn5to6z2Vd4kdv6YWaA//VTOl2b5j5PkiZ59J+MxA78Bv+zl2
         Z+v88E/Z2Xm5SBJCs1bzx0UpX/s9E1KziVs+ltrdZGLGt0cVwMhiZIjsv0ZxykEw/q
         YQz5fqTa1W/AzRJXgPkPxVYVE+USd/jMVYa6MTcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 076/144] perf tools: Avoid build splat for syscall numbers with uclibc
Date:   Thu,  8 Nov 2018 13:50:47 -0800
Message-Id: <20181108215100.804805085@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ea1fe3a88763d4dfef7e2529ba606f96e8e6b271 ]

This is due to duplicated unistd inclusion (via uClibc headers + kernel headers)
Also seen on ARM uClibc based tools

   ------- ARC build ---------->8-------------

  CC       util/evlist.o
In file included from
~/arc/k.org/arch/arc/include/uapi/asm/unistd.h:25:0,
                 from util/../perf-sys.h:10,
                 from util/../perf.h:15,
                 from util/event.h:7,
                 from util/event.c:3:
~/arc/k.org/include/uapi/asm-generic/unistd.h:906:0:
warning: "__NR_fcntl64" redefined [enabled by default]
 #define __NR_fcntl64 __NR3264_fcntl
 ^
In file included from
~/arc/gnu/INSTALL_1412-arc-2014.12-rc1/arc-snps-linux-uclibc/sysroot/usr/include/sys/syscall.h:24:0,
                 from util/../perf-sys.h:6,
   ----------------->8-------------------

   ------- ARM build ---------->8-------------

  CC FPIC  plugin_scsi.o
In file included from util/../perf-sys.h:9:0,
                 from util/../perf.h:15,
                 from util/cache.h:7,
                 from perf.c:12:
~/arc/k.org/arch/arm/include/uapi/asm/unistd.h:28:0:
warning: "__NR_restart_syscall" redefined [enabled by default]
In file included from
~/buildroot/host/usr/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/include/sys/syscall.h:25:0,
                 from util/../perf-sys.h:6,
                 from util/../perf.h:15,
                 from util/cache.h:7,
                 from perf.c:12:
~/buildroot/host/usr/arm-buildroot-linux-uclibcgnueabi/sysroot/usr/include/bits/sysnum.h:17:0:
note: this is the location of the previous definition
   ----------------->8-------------------

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1421156604-30603-4-git-send-email-vgupta@synopsys.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/bench/sched-pipe.c | 2 +-
 tools/perf/builtin-top.c      | 1 -
 tools/perf/perf-sys.h         | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
index 07a8d7646a15..005cc283790c 100644
--- a/tools/perf/bench/sched-pipe.c
+++ b/tools/perf/bench/sched-pipe.c
@@ -19,12 +19,12 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <sys/wait.h>
-#include <linux/unistd.h>
 #include <string.h>
 #include <errno.h>
 #include <assert.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/syscall.h>
 
 #include <pthread.h>
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 8e37334db4fa..c5b9c3f01d85 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -66,7 +66,6 @@
 #include <sys/utsname.h>
 #include <sys/mman.h>
 
-#include <linux/unistd.h>
 #include <linux/types.h>
 
 static volatile int done;
diff --git a/tools/perf/perf-sys.h b/tools/perf/perf-sys.h
index a3b13d7dc1d4..6ef68165c9db 100644
--- a/tools/perf/perf-sys.h
+++ b/tools/perf/perf-sys.h
@@ -6,7 +6,6 @@
 #include <sys/syscall.h>
 #include <linux/types.h>
 #include <linux/perf_event.h>
-#include <asm/unistd.h>
 
 #if defined(__i386__)
 #define mb()		asm volatile("lock; addl $0,0(%%esp)" ::: "memory")
-- 
2.17.1



