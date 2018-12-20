Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A919BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87422217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388402AbeLTSCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:02:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53707 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbeLTSCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:02:38 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKI2V5R3680256
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:02:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKI2Vw33680253;
        Thu, 20 Dec 2018 10:02:31 -0800
Date:   Thu, 20 Dec 2018 10:02:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ta2jbh03spkymp4sbdh489g8@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, mingo@kernel.org
Reply-To: tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
          adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, namhyung@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty: Add a string table generator for
 renameat2's flags constants
Git-Commit-ID: bdc2a9d64a4c4c77c63ce2561bd644d233fcb1fc
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

Commit-ID:  bdc2a9d64a4c4c77c63ce2561bd644d233fcb1fc
Gitweb:     https://git.kernel.org/tip/bdc2a9d64a4c4c77c63ce2561bd644d233fcb1fc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 11 Dec 2018 10:16:42 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 12:23:55 -0300

perf beauty: Add a string table generator for renameat2's flags constants

Using the already copied tools/include/uapi/linux/fs.h file:

  $ tools/perf/trace/beauty/rename_flags.sh
  static const char *rename_flags[] = {
	[0 + 1] = "NOREPLACE",
	[1 + 1] = "EXCHANGE",
	[2 + 1] = "WHITEOUT",
  };
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ta2jbh03spkymp4sbdh489g8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/rename_flags.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/trace/beauty/rename_flags.sh b/tools/perf/trace/beauty/rename_flags.sh
new file mode 100755
index 000000000000..54c87c782ab2
--- /dev/null
+++ b/tools/perf/trace/beauty/rename_flags.sh
@@ -0,0 +1,15 @@
+#!/bin/sh
+# Copyright (C) 2018, Red Hat Inc, Arnaldo Carvalho de Melo <acme@redhat.com>
+# SPDX-License-Identifier: LGPL-2.1
+
+[ $# -eq 1 ] && header_dir=$1 || header_dir=tools/include/uapi/linux/
+
+fs_header=${header_dir}/fs.h
+
+printf "static const char *rename_flags[] = {\n"
+regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
+egrep -q $regex ${fs_header} && \
+(egrep $regex ${fs_header} | \
+	sed -r "s/$regex/\2 \1/g"	| \
+	xargs printf "\t[%d + 1] = \"%s\",\n")
+printf "};\n"
