Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E774218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549478977;
	bh=irdz0LaEAkApAdEsoYBBwzkIR5mag/Wt3T6YV6ha3aA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0ttQUAGOL7tA7qGh2JmtdGl+adQ9lq2wqUGKWTw4Ot0lLIgQn7W6+DiZ1w6Jmb7z
	 ej7Zj2dQd4A8Yy4oUWxrdl1zCGpCG+zzaXKFWBN6zsRIhUD59mtWHaBJk+ORR81zFy
	 eGnrbMepqLbaygkWoDuKuSsqkOnJxsrgt1lUPEC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBFStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:49:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:43848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbfBFStc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:49:32 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52715206DD;
        Wed,  6 Feb 2019 18:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549478971;
        bh=irdz0LaEAkApAdEsoYBBwzkIR5mag/Wt3T6YV6ha3aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSiaeW7KAi9SGB40fwljKTbHSwwfEWENvO7gCNhRVkr4yTSJssO58E3+3NrMRYXhT
         5tpjCXfTCInZZqnOAr2X7avizn/Ca3myelNy2bBF9AsKBS6P7u1caXEBnX2VYJdIaS
         VCh8ZKEXJC4c8OwTNcW7pk92sifW1E3V9lMhvDUs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 05/53] perf symbols: Introduce map_symbol.h
Date:   Wed,  6 Feb 2019 15:48:15 -0300
Message-Id: <20190206184903.24054-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To allow headers just wanting this definition to be able to get it
without all the things in symbol.h, to reduce the include dep tree.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-l32z2qyhs6fe8unf4gk2ead2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.h  |  2 +-
 tools/perf/util/hist.h       |  1 +
 tools/perf/util/map_symbol.h | 22 ++++++++++++++++++++++
 tools/perf/util/sort.h       |  3 ++-
 tools/perf/util/symbol.h     | 14 +-------------
 5 files changed, 27 insertions(+), 15 deletions(-)
 create mode 100644 tools/perf/util/map_symbol.h

diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b6f18c2d4b14..80e056a3d882 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -5,7 +5,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include "event.h"
-#include "symbol.h"
+#include "map_symbol.h"
 #include "branch.h"
 
 struct map;
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 08267af7439c..f50aad24928e 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -8,6 +8,7 @@
 #include "evsel.h"
 #include "header.h"
 #include "color.h"
+#include "symbol.h"
 #include "ui/progress.h"
 
 struct hist_entry;
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
new file mode 100644
index 000000000000..5a1aed9f6bb4
--- /dev/null
+++ b/tools/perf/util/map_symbol.h
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef __PERF_MAP_SYMBOL
+#define __PERF_MAP_SYMBOL 1
+
+#include <linux/types.h>
+
+struct map;
+struct symbol;
+
+struct map_symbol {
+	struct map    *map;
+	struct symbol *sym;
+};
+
+struct addr_map_symbol {
+	struct map    *map;
+	struct symbol *sym;
+	u64	      addr;
+	u64	      al_addr;
+	u64	      phys_addr;
+};
+#endif // __PERF_MAP_SYMBOL
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index dd6312876492..2fbee0b1011c 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -9,7 +9,8 @@
 #include <linux/list.h>
 #include "cache.h"
 #include <linux/rbtree.h>
-#include "symbol.h"
+#include "map_symbol.h"
+#include "symbol_conf.h"
 #include "string.h"
 #include "callchain.h"
 #include "values.h"
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 56e2bcb907cc..9a8fe012910a 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
+#include "map_symbol.h"
 #include "branch.h"
 #include "path.h"
 #include "symbol_conf.h"
@@ -115,19 +116,6 @@ struct ref_reloc_sym {
 	u64		unrelocated_addr;
 };
 
-struct map_symbol {
-	struct map    *map;
-	struct symbol *sym;
-};
-
-struct addr_map_symbol {
-	struct map    *map;
-	struct symbol *sym;
-	u64	      addr;
-	u64	      al_addr;
-	u64	      phys_addr;
-};
-
 struct branch_info {
 	struct addr_map_symbol from;
 	struct addr_map_symbol to;
-- 
2.20.1

