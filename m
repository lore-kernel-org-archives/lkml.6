Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60A8C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1EB21DEC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 14:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xOI9bSOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A1EB21DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbeHIRYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732295AbeHIRYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:24:48 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC752214FF;
        Thu,  9 Aug 2018 14:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826771;
        bh=jff3FAmb6LkFhtjgYNcyYGXF8KdhPQHf5dcNLUaR5Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOI9bSOUh9Mx+5zRRFOuETatIvwHRvCRrtatZxWLXYD2Fusvwa7K65NL73pxyiCoM
         ou70cE2IQ8XS8a4w++BVMeSUi6NfbSMPsURN8bDFx3PEz3Xe4LXu0bgWJxcJHhPGNj
         MKieXN2tQ7++PRzxhjfwk3ETZLszWyUUS3XhxMNY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Yury Norov <ynorov@caviumnetworks.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        David Carrillo-Cisneros <davidcc@google.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/44] perf tools: Drop unneeded bitmap_zero() calls
Date:   Thu,  9 Aug 2018 11:57:49 -0300
Message-Id: <20180809145822.21391-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yury Norov <ynorov@caviumnetworks.com>

bitmap_zero() is called after bitmap_alloc() in perf code. But
bitmap_alloc() internally uses calloc() which guarantees that allocated
area is zeroed. So following bitmap_zero is unneeded. Drop it.

This happened because of confusing name for bitmap allocator. It
should has name bitmap_zalloc instead of bitmap_alloc.

This series:

  https://lkml.org/lkml/2018/6/18/841

introduces a new API for bitmap allocations in kernel, and functions
there are named correctly. Following patch propogates the API to tools,
and fixes naming issue.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: David Carrillo-Cisneros <davidcc@google.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Link: http://lkml.kernel.org/r/20180623073502.16321-1-ynorov@caviumnetworks.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bitmap.c   | 2 --
 tools/perf/tests/mem2node.c | 2 --
 tools/perf/util/header.c    | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 47bedf25ba69..96e7fc1ad3f9 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -16,8 +16,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
-
 		for (i = 0; i < map->nr; i++)
 			set_bit(map->map[i], bm);
 	}
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
index 0c3c87f86e03..9e9e4d37cc77 100644
--- a/tools/perf/tests/mem2node.c
+++ b/tools/perf/tests/mem2node.c
@@ -24,8 +24,6 @@ static unsigned long *get_bitmap(const char *str, int nbits)
 	bm = bitmap_alloc(nbits);
 
 	if (map && bm) {
-		bitmap_zero(bm, nbits);
-
 		for (i = 0; i < map->nr; i++) {
 			set_bit(map->map[i], bm);
 		}
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5af58aac91ad..5f1af7b07b96 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -279,8 +279,6 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 	if (!set)
 		return -ENOMEM;
 
-	bitmap_zero(set, size);
-
 	p = (u64 *) set;
 
 	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
@@ -1285,7 +1283,6 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
 		return -ENOMEM;
 	}
 
-	bitmap_zero(n->set, size);
 	n->node = idx;
 	n->size = size;
 
-- 
2.14.4

