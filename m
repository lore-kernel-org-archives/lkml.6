Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6E0C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB2820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:08:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB2820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeKAHIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:08:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeKAHIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:08:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM8GeO2560957
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:08:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM8GDS2560954;
        Wed, 31 Oct 2018 15:08:16 -0700
Date:   Wed, 31 Oct 2018 15:08:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-t3fn7u3tjsupio6e6vkufx9m@git.kernel.org>
Cc:     namhyung@kernel.org, dsahern@gmail.com, acme@redhat.com,
        jolsa@kernel.org, wangnan0@huawei.com, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
          acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          wangnan0@huawei.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Wire up the mmap flags table
 generator to the Makefile
Git-Commit-ID: fbd7458db75790e37903c75be68513a4c087737c
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

Commit-ID:  fbd7458db75790e37903c75be68513a4c087737c
Gitweb:     https://git.kernel.org/tip/fbd7458db75790e37903c75be68513a4c087737c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 16:11:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:52 -0300

perf beauty: Wire up the mmap flags table generator to the Makefile

Now when we run 'make -C tools/perf O=/tmp/build/perf' we end up with:

  $ cat /tmp/build/perf/trace/beauty/generated/mmap_flags_array.c
  static const char *mmap_flags[] = {
	[ilog2(0x40) + 1] = "32BIT",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
	[ilog2(0x0100) + 1] = "GROWSDOWN",
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x2000) + 1] = "LOCKED",
	[ilog2(0x4000) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x80000) + 1] = "SYNC",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t3fn7u3tjsupio6e6vkufx9m@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a31c5c29d53a..3ccb4f0bf088 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1,4 +1,5 @@
 include ../scripts/Makefile.include
+include ../scripts/Makefile.arch
 
 # The default target of this Makefile is...
 all:
@@ -385,6 +386,8 @@ export INSTALL SHELL_PATH
 SHELL = $(SHELL_PATH)
 
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
+asm_generic_uapi_dir := $(srctree)/tools/include/uapi/asm-generic
+arch_asm_uapi_dir := $(srctree)/tools/arch/$(ARCH)/include/uapi/asm/
 
 beauty_outdir := $(OUTPUT)trace/beauty/generated
 beauty_ioctl_outdir := $(beauty_outdir)/ioctl
@@ -460,6 +463,12 @@ madvise_behavior_tbl := $(srctree)/tools/perf/trace/beauty/madvise_behavior.sh
 $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_tbl)
 	$(Q)$(SHELL) '$(madvise_behavior_tbl)' $(madvise_hdr_dir) > $@
 
+mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
+mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
+
+$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(arch_asm_uapi_dir)/mman.h $(mmap_flags_tbl)
+	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
+
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
 mount_flags_tbl := $(srctree)/tools/perf/trace/beauty/mount_flags.sh
 
@@ -583,6 +592,7 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
 	$(socket_ipproto_array) \
 	$(vhost_virtio_ioctl_array) \
 	$(madvise_behavior_array) \
+	$(mmap_flags_array) \
 	$(mount_flags_array) \
 	$(perf_ioctl_array) \
 	$(prctl_option_array) \
@@ -870,6 +880,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
 		$(OUTPUT)$(madvise_behavior_array) \
+		$(OUTPUT)$(mmap_flags_array) \
 		$(OUTPUT)$(mount_flags_array) \
 		$(OUTPUT)$(drm_ioctl_array) \
 		$(OUTPUT)$(pkey_alloc_access_rights_array) \
