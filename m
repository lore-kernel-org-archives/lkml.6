Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96188ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423272081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 16:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnHQrNpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423272081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbeKABpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 21:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729775AbeKABpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 21:45:14 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7872081B;
        Wed, 31 Oct 2018 16:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541004386;
        bh=aFVSFVmfx9QlqJ+lYnIXzR4xHiJgB4cLR8FHSupGi3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnHQrNpZjvqeX3OsIzr6elF/flXtPoSZIa1Dp7oyGVUZ36eW6JB8tudaHlXsKkJK8
         VlwXWzuixlmwh9r8kikQPSbj9vXilZkw4pm6ekfAs2Ih4i1nGVtvz4AeXp2qJ9U9M7
         tWhIJr8ZgzyEkcwyK5ExaBAgunHNs8I3aeLN/T1k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 18/28] perf beauty: Add a generator for MAP_ mmap's flag constants
Date:   Wed, 31 Oct 2018 13:44:58 -0300
Message-Id: <20181031164508.4784-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181031164508.4784-1-acme@kernel.org>
References: <20181031164508.4784-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It'll use tools/{arch}/*,include copies of mman.h to generate a table to
be used by tools, initially by the 'mmap' beautifiers in 'perf trace',
but that could also be used to translate from a string constant to the
integer value to be used in a eBPF or tracefs tracepoint filter.

Tested for all archs using:

$ for arch in `ls tools/arch/` ; \
	do echo $arch ; tools/perf/trace/beauty/mmap_flags.sh $arch ; \
   done | less

Example for alpha, an oddball, doesn't include any header, defines all
its stuff:

  $ tools/perf/trace/beauty/mmap_flags.sh alpha
  static const char *mmap_flags[] = {
	[ilog2(0x10) + 1] = "ANONYMOUS",
	[ilog2(0x02000) + 1] = "DENYWRITE",
	[ilog2(0x04000) + 1] = "EXECUTABLE",
	[ilog2(0x100) + 1] = "FIXED",
	[ilog2(0x01000) + 1] = "GROWSDOWN",
	[ilog2(0x100000) + 1] = "HUGETLB",
	[ilog2(0x08000) + 1] = "LOCKED",
	[ilog2(0x40000) + 1] = "NONBLOCK",
	[ilog2(0x10000) + 1] = "NORESERVE",
	[ilog2(0x20000) + 1] = "POPULATE",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x80000) + 1] = "STACK",
  };
  $

Common case, my workstation, defines one entry (MAP_32BIT), then
includes mman.h, which gets it to include mman-common.h too:

  $ tools/perf/trace/beauty/mmap_flags.sh
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
  $ uname -m
  x86_64
  $

Sparc, that defines a bunch then includes just mman-common.h:

  $ tools/perf/trace/beauty/mmap_flags.sh sparc
  static const char *mmap_flags[] = {
	[ilog2(0x0800) + 1] = "DENYWRITE",
	[ilog2(0x1000) + 1] = "EXECUTABLE",
	[ilog2(0x0200) + 1] = "GROWSDOWN",
	[ilog2(0x40000) + 1] = "HUGETLB",
	[ilog2(0x100) + 1] = "LOCKED",
	[ilog2(0x10000) + 1] = "NONBLOCK",
	[ilog2(0x40) + 1] = "NORESERVE",
	[ilog2(0x8000) + 1] = "POPULATE",
	[ilog2(0x20000) + 1] = "STACK",
	[ilog2(0x01) + 1] = "SHARED",
	[ilog2(0x02) + 1] = "PRIVATE",
	[ilog2(0x10) + 1] = "FIXED",
	[ilog2(0x20) + 1] = "ANONYMOUS",
	[ilog2(0x100000) + 1] = "FIXED_NOREPLACE",
  };
  [acme@jouet perf]$

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-xydeh491z8fkgglcmqnl5thj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap_flags.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100755 tools/perf/trace/beauty/mmap_flags.sh

diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
new file mode 100755
index 000000000000..22c3fdca8975
--- /dev/null
+++ b/tools/perf/trace/beauty/mmap_flags.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+if [ $# -ne 2 ] ; then
+	[ $# -eq 1 ] && hostarch=$1 || hostarch=`uname -m | sed -e s/i.86/x86/ -e s/x86_64/x86/`
+	header_dir=tools/include/uapi/asm-generic
+	arch_header_dir=tools/arch/${hostarch}/include/uapi/asm
+else
+	header_dir=$1
+	arch_header_dir=$2
+fi
+
+arch_mman=${arch_header_dir}/mman.h
+
+# those in egrep -vw are flags, we want just the bits
+
+printf "static const char *mmap_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
+egrep -q $regex ${arch_mman} && \
+(egrep $regex ${arch_mman} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.*' ${arch_mman} &&
+(egrep $regex ${header_dir}/mman-common.h | \
+	egrep -vw 'MAP_(UNINITIALIZED|TYPE|SHARED_VALIDATE)' | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+egrep -q '#[[:space:]]*include[[:space:]]+<uapi/asm-generic/mman.h>.*' ${arch_mman} &&
+(egrep $regex ${header_dir}/mman.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n")
+printf "};\n"
-- 
2.14.4

