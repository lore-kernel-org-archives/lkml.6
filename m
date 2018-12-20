Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4307E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbeLTScB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:32:01 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38659 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeLTScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:32:00 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIVoTU3687193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:31:50 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIVojT3687190;
        Thu, 20 Dec 2018 10:31:50 -0800
Date:   Thu, 20 Dec 2018 10:31:50 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-tb7jguv01u8p570piq13eioh@git.kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        lclaudio@redhat.com, namhyung@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, tglx@linutronix.de, acme@redhat.com,
        wangnan0@huawei.com, jolsa@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mingo@kernel.org,
          lclaudio@redhat.com, hpa@zytor.com, namhyung@kernel.org,
          tglx@linutronix.de, adrian.hunter@intel.com, wangnan0@huawei.com,
          acme@redhat.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add generator for fadvise64's 'advice'
 arg constants
Git-Commit-ID: 069c1c6cc3646454f9c8e83084a25f8eb8cab7ae
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

Commit-ID:  069c1c6cc3646454f9c8e83084a25f8eb8cab7ae
Gitweb:     https://git.kernel.org/tip/069c1c6cc3646454f9c8e83084a25f8eb8cab7ae
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 11:49:58 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:17:41 -0300

perf beauty: Add generator for fadvise64's 'advice' arg constants

  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
	[0] = "NORMAL",
	[1] = "RANDOM",
	[2] = "SEQUENTIAL",
	[3] = "WILLNEED",
	[4] = "DONTNEED",
	[5] = "NOREUSE",
  };
  $

This has a hack wrt the s390 difference.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tb7jguv01u8p570piq13eioh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fadvise.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/trace/beauty/fadvise.sh b/tools/perf/trace/beauty/fadvise.sh
new file mode 100755
index 000000000000..b15ae3875167
--- /dev/null
+++ b/tools/perf/trace/beauty/fadvise.sh
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+printf "static const char *fadvise_advices[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+POSIX_FADV_(\w+)[[:space:]]+([[:digit:]]+)[[:space:]]+.*'
+
+egrep $regex ${header_dir}/fadvise.h | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	sort | xargs printf "\t[%s] = \"%s\",\n" | \
+	grep -v "[6].*DONTNEED" | grep -v "[7].*NOREUSE"
+printf "};\n"
+
+# XXX Fix this properly:
+
+# The grep 6/7 DONTNEED/NOREUSE are a hack to filter out the s/390 oddity See
+# tools/include/uapi/linux/fadvise.h for details.
+
+# Probably fix this when generating the string tables per arch so that We can
+# reliably process on arch FOO a perf.data file collected by 'perf trace
+# record' on arch BAR, e.g. collect on s/390 and process on x86.
