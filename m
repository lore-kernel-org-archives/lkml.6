Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0B5C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A037218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458526;
	bh=Gt1z9RGyOba8PvNphGggrMs6KlXyVuosc7pfIGK4GCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8ufc1u2QY4Ts7Pi/xGw7jkE8eqyJAWb3QKSiAxuu3jKHLbjPhJ8PJXv47KEQkqiW
	 o2mtDESw9TBiuRczVAfghJIFddLfwinnbrVnQe6NZnB7rVt+KgXMQX23f4g8P7yIe1
	 QPBGIsFhkaNvCbezeYPimJf4CysPU0NTpb2m0eQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfAYXTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729522AbfAYXS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:18:58 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3FDA20844;
        Fri, 25 Jan 2019 23:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458337;
        bh=Gt1z9RGyOba8PvNphGggrMs6KlXyVuosc7pfIGK4GCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aulJq9jkzYcT/7jpTSTYso5LYmUFk46M7Dv1A5hv3znIbO1Kzcy7EQTZeWKq9FC9y
         xJYQXICjnRo/xdf/fxBnyuCXU+qgmnRB6jEa0gKU6JlksdzW117glGCve0fSYp1RUS
         XqEJ1qVzBVAM85S/GisYlxtFI8aiVdGqa184/bpM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 03/29] perf tools: Move branch structs to branch.h
Date:   Sat, 26 Jan 2019 00:18:17 +0100
Message-Id: <20190125231843.2895-4-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We already have it, move those there from events.h so that we untangle
the header dependencies a bit more.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pnbkqo8jxbi49d4f3yd3b5w3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/branch.h | 27 ++++++++++++++++++++++++---
 tools/perf/util/event.h  | 21 +--------------------
 tools/perf/util/symbol.h |  1 +
 3 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 1e3c7c5cdc63..64f96b79f1d7 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -1,8 +1,31 @@
 #ifndef _PERF_BRANCH_H
 #define _PERF_BRANCH_H 1
 
+#include <stdio.h>
 #include <stdint.h>
-#include "../perf.h"
+#include <linux/perf_event.h>
+#include <linux/types.h>
+
+struct branch_flags {
+	u64 mispred:1;
+	u64 predicted:1;
+	u64 in_tx:1;
+	u64 abort:1;
+	u64 cycles:16;
+	u64 type:4;
+	u64 reserved:40;
+};
+
+struct branch_entry {
+	u64			from;
+	u64			to;
+	struct branch_flags	flags;
+};
+
+struct branch_stack {
+	u64			nr;
+	struct branch_entry	entries[0];
+};
 
 struct branch_type_stat {
 	bool	branch_to;
@@ -13,8 +36,6 @@ struct branch_type_stat {
 	u64	cross_2m;
 };
 
-struct branch_flags;
-
 void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 		       u64 from, u64 to);
 
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index dad32b81fe71..feba1aa819b4 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -161,26 +161,7 @@ struct ip_callchain {
 	u64 ips[0];
 };
 
-struct branch_flags {
-	u64 mispred:1;
-	u64 predicted:1;
-	u64 in_tx:1;
-	u64 abort:1;
-	u64 cycles:16;
-	u64 type:4;
-	u64 reserved:40;
-};
-
-struct branch_entry {
-	u64			from;
-	u64			to;
-	struct branch_flags	flags;
-};
-
-struct branch_stack {
-	u64			nr;
-	struct branch_entry	entries[0];
-};
+struct branch_stack;
 
 enum {
 	PERF_IP_FLAG_BRANCH		= 1ULL << 0,
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 277841e3dbd1..956d9916e364 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <byteswap.h>
 #include <libgen.h>
+#include "branch.h"
 #include "build-id.h"
 #include "event.h"
 #include "path.h"
-- 
2.20.1

