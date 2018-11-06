Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DDAC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497FE20869
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497FE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbeKGEpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:45:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41417 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbeKGEpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:45:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA6JIYsJ912660
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Nov 2018 11:18:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA6JIXWc912656;
        Tue, 6 Nov 2018 11:18:33 -0800
Date:   Tue, 6 Nov 2018 11:18:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-e2c39f36c354a06c6e9d32d4fdf8660b41803d82@git.kernel.org>
Cc:     linux@roeck-us.net, tglx@linutronix.de, dsahern@gmail.com,
        williams@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, wangnan0@huawei.com, namhyung@kernel.org,
        jolsa@kernel.org
Reply-To: williams@redhat.com, tglx@linutronix.de, linux@roeck-us.net,
          dsahern@gmail.com, adrian.hunter@intel.com, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
          wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org
In-Reply-To: <20181105184612.GD7077@kernel.org>
References: <20181105184612.GD7077@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Use SRCARCH, ARCH=x86_64 must map to
 "x86" to find the headers
Git-Commit-ID: e2c39f36c354a06c6e9d32d4fdf8660b41803d82
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

Commit-ID:  e2c39f36c354a06c6e9d32d4fdf8660b41803d82
Gitweb:     https://git.kernel.org/tip/e2c39f36c354a06c6e9d32d4fdf8660b41803d82
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 5 Nov 2018 15:46:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Nov 2018 15:46:51 -0300

perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers

Guenter reported that using ARCH=x86_64 to build perf has regressed:

  $ make -C tools/perf O=/tmp/build/perf ARCH=x86_64
  make: Entering directory '/home/acme/git/perf/tools/perf'
    BUILD:   Doing 'make -j4' parallel build
    HOSTCC   /tmp/build/perf/fixdep.o
    HOSTLD   /tmp/build/perf/fixdep-in.o
    LINK     /tmp/build/perf/fixdep

  Auto-detecting system features:
  ...                         dwarf: [ on  ]
  <SNIP>
  ...                           bpf: [ on  ]

    GEN      /tmp/build/perf/common-cmds.h
  make[2]: *** No rule to make target '/home/acme/git/perf/tools/arch/x86_64/include/uapi/asm//mman.h', needed by '/tmp/build/perf/trace/beauty/generated/mmap_flags_array.c'.  Stop.
  make[2]: *** Waiting for unfinished jobs....
    PERF_VERSION = 4.19.gf6c23e3
  make[1]: *** [Makefile.perf:207: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $

This is because we must use $(SRCARCH) where we were using $(ARCH), so
that, just like the top level Makefile, we get this done:

  # Additional ARCH settings for x86
  ifeq ($(ARCH),i386)
          SRCARCH := x86
  endif
  ifeq ($(ARCH),x86_64)
          SRCARCH := x86
  endif

Which is done in tools/scripts/Makefile.arch, so switch to use
$(SRCARCH).

Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Clark Williams <williams@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: fbd7458db757 ("perf beauty: Wire up the mmap flags table generator to the Makefile")
Link: https://lkml.kernel.org/r/20181105184612.GD7077@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3ccb4f0bf088..d95655489f7e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -387,7 +387,7 @@ SHELL = $(SHELL_PATH)
 
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
 asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
-arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
+arch_asm_uapi_dir := $(srctree)/tools/arch/$(SRCARCH)/include/uapi/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
