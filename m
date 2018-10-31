Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C57C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DE120664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbeKAHHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:07:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:32951 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbeKAHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:07:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VM7gTw2560899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 15:07:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VM7grK2560896;
        Wed, 31 Oct 2018 15:07:42 -0700
Date:   Wed, 31 Oct 2018 15:07:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xydeh491z8fkgglcmqnl5thj@git.kernel.org>
Cc:     wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, mingo@kernel.org,
        acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, wangnan0@huawei.com,
          dsahern@gmail.com, jolsa@kernel.org, hpa@zytor.com,
          acme@redhat.com, tglx@linutronix.de, adrian.hunter@intel.com,
          namhyung@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Add a generator for MAP_ mmap's flag
 constants
Git-Commit-ID: 80ee5668b8a755039ca6180c6272a6e8efee5aad
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

Commit-ID:  80ee5668b8a755039ca6180c6272a6e8efee5aad
Gitweb:     https://git.kernel.org/tip/80ee5668b8a755039ca6180c6272a6e8efee5aad
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 30 Oct 2018 15:26:47 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 31 Oct 2018 09:57:52 -0300

perf beauty: Add a generator for MAP_ mmap's flag constants

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
