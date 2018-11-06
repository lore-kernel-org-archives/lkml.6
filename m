Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A25C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F17F2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXBNT4fk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F17F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbeKFVcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:32:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387404AbeKFVcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:32:20 -0500
Received: from jouet.infradead.org (unknown [189.40.102.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667732086A;
        Tue,  6 Nov 2018 12:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541506046;
        bh=1E57kVC5CAqpQ/1AUNypNmHBhu/qZFT806b1hPIzMDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXBNT4fkihfsUE68dNrxE4NVOL4zXFDZZj1HMUjyqTXB6moLkPSsRveLYQCSczRPP
         +xGWwkp2v8zPprjqRJrsJ4tjy9dumrkeLuHKxfDk45itApVQXUVakQsLToQEVnN/Fd
         SJJ5YYqXmj7fSpPY4G38z8B+0OmaNDbCQj2tB6go=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 16/18] perf beauty: Use SRCARCH, ARCH=x86_64 must map to "x86" to find the headers
Date:   Tue,  6 Nov 2018 09:06:10 -0300
Message-Id: <20181106120612.8262-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181106120612.8262-1-acme@kernel.org>
References: <20181106120612.8262-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.4

