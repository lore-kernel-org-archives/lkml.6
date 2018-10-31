Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75DDECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8583A2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8583A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbeKAG6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:58:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeKAG6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:58:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9VLwZ4u2557920
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 31 Oct 2018 14:58:35 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9VLwYlT2557917;
        Wed, 31 Oct 2018 14:58:35 -0700
Date:   Wed, 31 Oct 2018 14:58:35 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-mgutbbkmip9gfnmd28ikg7xt@git.kernel.org>
Cc:     jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        benjamin@python.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, dsahern@gmail.com, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          wangnan0@huawei.com, acme@redhat.com, mingo@kernel.org,
          benjamin@python.org, dsahern@gmail.com, tglx@linutronix.de,
          hpa@zytor.com, namhyung@kernel.org, adrian.hunter@intel.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf beauty: Add a generator for MS_
 mount/umount's flag constants
Git-Commit-ID: ceaf8e5b49ce18e9e58d292130e92150d01a34e6
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

Commit-ID:  ceaf8e5b49ce18e9e58d292130e92150d01a34e6
Gitweb:     https://git.kernel.org/tip/ceaf8e5b49ce18e9e58d292130e92150d01a34e6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 24 Oct 2018 14:54:55 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 30 Oct 2018 11:46:23 -0300

perf beauty: Add a generator for MS_ mount/umount's flag constants

It'll use tools/include copy of linux/fs.h to generate a table to be
used by tools, initially by the 'mount' and 'umount' beautifiers in
'perf trace', but that could also be used to translate from a string
constant to the integer value to be used in a eBPF or tracefs tracepoint
filter.

When used without any args it produces:

  $ tools/perf/trace/beauty/mount_flags.sh
  static const char *mount_flags[] = {
	[1 ? (ilog2(1) + 1) : 0] = "RDONLY",
	[2 ? (ilog2(2) + 1) : 0] = "NOSUID",
	[4 ? (ilog2(4) + 1) : 0] = "NODEV",
	[8 ? (ilog2(8) + 1) : 0] = "NOEXEC",
	[16 ? (ilog2(16) + 1) : 0] = "SYNCHRONOUS",
	[32 ? (ilog2(32) + 1) : 0] = "REMOUNT",
	[64 ? (ilog2(64) + 1) : 0] = "MANDLOCK",
	[128 ? (ilog2(128) + 1) : 0] = "DIRSYNC",
	[1024 ? (ilog2(1024) + 1) : 0] = "NOATIME",
	[2048 ? (ilog2(2048) + 1) : 0] = "NODIRATIME",
	[4096 ? (ilog2(4096) + 1) : 0] = "BIND",
	[8192 ? (ilog2(8192) + 1) : 0] = "MOVE",
	[16384 ? (ilog2(16384) + 1) : 0] = "REC",
	[32768 ? (ilog2(32768) + 1) : 0] = "SILENT",
	[16 + 1] = "POSIXACL",
	[17 + 1] = "UNBINDABLE",
	[18 + 1] = "PRIVATE",
	[19 + 1] = "SLAVE",
	[20 + 1] = "SHARED",
	[21 + 1] = "RELATIME",
	[22 + 1] = "KERNMOUNT",
	[23 + 1] = "I_VERSION",
	[24 + 1] = "STRICTATIME",
	[25 + 1] = "LAZYTIME",
	[26 + 1] = "SUBMOUNT",
	[27 + 1] = "NOREMOTELOCK",
	[28 + 1] = "NOSEC",
	[29 + 1] = "BORN",
	[30 + 1] = "ACTIVE",
	[31 + 1] = "NOUSER",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Peterson <benjamin@python.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mgutbbkmip9gfnmd28ikg7xt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mount_flags.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/trace/beauty/mount_flags.sh b/tools/perf/trace/beauty/mount_flags.sh
new file mode 100755
index 000000000000..45547573a1db
--- /dev/null
+++ b/tools/perf/trace/beauty/mount_flags.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *mount_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+([[:digit:]]+)[[:space:]]*.*'
+egrep $regex ${header_dir}/fs.h | egrep -v '(MSK|VERBOSE|MGC_VAL)\>' | \
+	sed -r "s/$regex/\2 \2 \1/g" | sort -n | \
+	xargs printf "\t[%s ? (ilog2(%s) + 1) : 0] = \"%s\",\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MS_([[:alnum:]_]+)[[:space:]]+\(1<<([[:digit:]]+)\)[[:space:]]*.*'
+egrep $regex ${header_dir}/fs.h | \
+	sed -r "s/$regex/\2 \1/g" | \
+	xargs printf "\t[%s + 1] = \"%s\",\n"
+printf "};\n"
