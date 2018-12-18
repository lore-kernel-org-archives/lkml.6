Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CE9C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA0C218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170933;
	bh=IxWHIqmovtS+UWsrH0FlOxZaCEpiu4DkNbvZ0E8Q5LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q5R1oParN8xagHe7LVy6GAJNR3Sr1BuyYJ3IQabB6j9yzfo7zbhXohR67bs3npa0s
	 vn2uMNnOE1CSiaNcZsgVqAPwLn5hSktKkxmgSv/R/XWv3dWhOq7Vhh3p/8aou6fvsS
	 c4aAmo3XICr7PuZl9mFd0aXZ5Mzv7+IvlRZApASQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeLRWIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:08:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:36722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbeLRWIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:08:48 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E5D0218AD;
        Tue, 18 Dec 2018 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170927;
        bh=IxWHIqmovtS+UWsrH0FlOxZaCEpiu4DkNbvZ0E8Q5LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mqLDXQU7XOnxAKZe8VFlter4yOLwqK1HBNwz926NmHRLZYNm9+G5tAWLS2VZx3+rn
         DTUf2uhxZGTcXt5IAeP79v17CUpQCvZZrjx1TwTd9+ckTJWSfFZ5gcOWkWQLDeqsIc
         UNfIYps3m7NOjukkgUIuLHZvOaGSAYtXE7AHmih0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 09/63] perf beauty: Add a string table generator for renameat2's flags constants
Date:   Tue, 18 Dec 2018 19:06:39 -0300
Message-Id: <20181218220733.15839-10-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 create mode 100755 tools/perf/trace/beauty/rename_flags.sh

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
-- 
2.19.2

