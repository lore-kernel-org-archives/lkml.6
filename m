Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FBC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1721871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171457;
	bh=0h+ooaTAHHihevNRMBkWTu0RbdcU7TOItl827Nt1VCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CejDqzcjNzwTdvpM1Jl7UlnIqPISsnKkKG3WTD6M/+d/KzPnogVg7U1dahUw0sUuG
	 3/BCZJFgSpTIeeVPBTRmPIoz36cSRAUoiIyiQSHOYGePCijXWuJQovMeZQtT6+xKgA
	 eDPLKZFqjxnx9dkU2tSJc+FGrzfyCBlnNJpjVzMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeLRWRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:17:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeLRWRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:17:35 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C31E218A2;
        Tue, 18 Dec 2018 22:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171454;
        bh=0h+ooaTAHHihevNRMBkWTu0RbdcU7TOItl827Nt1VCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zOCO5KFlihwzCcWOpwMhXyVmC9bgHfWjYbAXdM71IKHVMJlbOmdMb5iFdkycURs8C
         K6yAmwRy5hJ++F941NOfiE1L/uMP/JzppdZGJQaGkwx5qUunPf3TZRbSnPeRcYMPxV
         aO2qqPTLCX1RnekkO7obv1zWdLdsNZS7JKN0svpk=
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
Subject: [PATCH 61/63] perf trace: Wire up the fadvise 'advice' table generator
Date:   Tue, 18 Dec 2018 19:07:31 -0300
Message-Id: <20181218220733.15839-62-acme@kernel.org>
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

That ends up generating this:

  $ cat /tmp/build/perf/trace/beauty/generated/fadvise_advice_array.c
  static const char *fadvise_advices[] = {
	[0] = "NORMAL",
	[1] = "RANDOM",
	[2] = "SEQUENTIAL",
	[3] = "WILLNEED",
	[4] = "DONTNEED",
	[5] = "NOREUSE",
  };
$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-zwbslubagram8a8zdc003u8h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3af432bccd3e..bd23e3f30895 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -410,6 +410,12 @@ _dummy := $(shell [ -d '$(beauty_ioctl_outdir)' ] || mkdir -p '$(beauty_ioctl_ou
 $(drm_ioctl_array): $(drm_hdr_dir)/drm.h $(drm_hdr_dir)/i915_drm.h $(drm_ioctl_tbl)
 	$(Q)$(SHELL) '$(drm_ioctl_tbl)' $(drm_hdr_dir) > $@
 
+fadvise_advice_array := $(beauty_outdir)/fadvise_advice_array.c
+fadvise_advice_tbl := $(srctree)/tools/perf/trace/beauty/fadvise.sh
+
+$(fadvise_advice_array): $(linux_uapi_dir)/in.h $(fadvise_advice_tbl)
+	$(Q)$(SHELL) '$(fadvise_advice_tbl)' $(linux_uapi_dir) > $@
+
 pkey_alloc_access_rights_array := $(beauty_outdir)/pkey_alloc_access_rights_array.c
 asm_generic_hdr_dir := $(srctree)/tools/include/uapi/asm-generic/
 pkey_alloc_access_rights_tbl := $(srctree)/tools/perf/trace/beauty/pkey_alloc_access_rights.sh
@@ -605,6 +611,7 @@ __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(if $(__build-dir),$(__build-dir),.)
 
 prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioctl_array) \
+	$(fadvise_advice_array) \
 	$(pkey_alloc_access_rights_array) \
 	$(sndrv_pcm_ioctl_array) \
 	$(sndrv_ctl_ioctl_array) \
@@ -902,6 +909,7 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(madvise_behavior_array) \
 		$(OUTPUT)$(mmap_flags_array) \
 		$(OUTPUT)$(mount_flags_array) \
-- 
2.19.2

