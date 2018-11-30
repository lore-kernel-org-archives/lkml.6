Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5CF8C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28BE2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqs6+uNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28BE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeLAFiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:38:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbeLAFiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:38:19 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62E6214ED;
        Fri, 30 Nov 2018 18:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543602489;
        bh=2GAqy1OUSEf4zeXYiJywLPQoczIbKBJTb0usM9yyqZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rqs6+uNPAD86qVPrCjiaAfsk2i1c8YOnnsEff/TJz50tpgWrSKl0OpPTY5XpxHW+o
         cRy/6CYM9s9ueh19XSSpoYnpthfeLLHo06o51f/s4I1dLLhPWmdiHLoGGZEfsBCfGM
         OYQvHrdPLW/geFsAaQyhGQYvbGGCiIz8YxaKMbJU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 21/22] perf beauty mmap_flags: Check if the arch has a mmap.h file
Date:   Fri, 30 Nov 2018 15:26:51 -0300
Message-Id: <20181130182652.23620-22-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130182652.23620-1-acme@kernel.org>
References: <20181130182652.23620-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

If not, then just use what is in asm-generic. This fixes the build for
my sh4, m68k and riscv64 perf test build containers that were failing
due to 80ee5668b8a7 ("perf beauty: Add a generator for MAP_ mmap's flag
constants"), that were not covered in the cset introducing those
tools/arch/*/include/uapi/asm/mman.h files.

  f3539c12d819 ("tools include: Add uapi mman.h for each architecture")

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 80ee5668b8a7 ("perf beauty: Add a generator for MAP_ mmap's flag constants")
Link: https://lkml.kernel.org/n/tip-rpy9t2e0wxpnum1yvxhreafe@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf              | 2 +-
 tools/perf/trace/beauty/mmap_flags.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 67e9adbe6ee8..bfdaefd500ab 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -474,7 +474,7 @@ $(madvise_behavior_array): $(madvise_hdr_dir)/mman-common.h $(madvise_behavior_t
 mmap_flags_array := $(beauty_outdir)/mmap_flags_array.c
 mmap_flags_tbl := $(srctree)/tools/perf/trace/beauty/mmap_flags.sh
 
-$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(arch_asm_uapi_dir)/mman.h $(mmap_flags_tbl)
+$(mmap_flags_array): $(asm_generic_uapi_dir)/mman.h $(asm_generic_uapi_dir)/mman-common.h $(mmap_flags_tbl)
 	$(Q)$(SHELL) '$(mmap_flags_tbl)' $(asm_generic_uapi_dir) $(arch_asm_uapi_dir) > $@
 
 mount_flags_array := $(beauty_outdir)/mount_flags_array.c
diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
index 22c3fdca8975..cd41023107d7 100755
--- a/tools/perf/trace/beauty/mmap_flags.sh
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -20,12 +20,12 @@ egrep -q $regex ${arch_mman} && \
 (egrep $regex ${arch_mman} | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} &&
+[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} ] &&
 (egrep $regex ${header_dir}/mman-common.h | \
 	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} &&
+[ ! -f ${arch_mman} || egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} ] &&
 (egrep $regex ${header_dir}/mman.h | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
-- 
2.19.1

