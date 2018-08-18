Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80044C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E62146E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5E62146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbeHROcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:32:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40719 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:32:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBOktk1285516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:24:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBOkpj1285513;
        Sat, 18 Aug 2018 04:24:46 -0700
Date:   Sat, 18 Aug 2018 04:24:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yury Norov <tipbot@zytor.com>
Message-ID: <tip-3c8b81864080b710bdce446fd8401923f26fc4d4@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, willy@infradead.org,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, dsahern@gmail.com,
        andriy.shevchenko@linux.intel.com, davidcc@google.com,
        dmitry.torokhov@gmail.com, snitzer@redhat.com, hpa@zytor.com,
        ynorov@caviumnetworks.com, jolsa@redhat.com
Reply-To: mingo@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org,
          akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
          davidcc@google.com, dmitry.torokhov@gmail.com,
          snitzer@redhat.com, ynorov@caviumnetworks.com, jolsa@redhat.com,
          hpa@zytor.com, willy@infradead.org, peterz@infradead.org,
          pombredanne@nexb.com, kstewart@linuxfoundation.org,
          ak@linux.intel.com, yao.jin@linux.intel.com, dsahern@gmail.com
In-Reply-To: <20180623073502.16321-1-ynorov@caviumnetworks.com>
References: <20180623073502.16321-1-ynorov@caviumnetworks.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Drop unneeded bitmap_zero() calls
Git-Commit-ID: 3c8b81864080b710bdce446fd8401923f26fc4d4
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

Commit-ID:  3c8b81864080b710bdce446fd8401923f26fc4d4
Gitweb:     https://git.kernel.org/tip/3c8b81864080b710bdce446fd8401923f26fc4d4
Author:     Yury Norov <ynorov@caviumnetworks.com>
AuthorDate: Sat, 23 Jun 2018 10:35:01 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:55:44 -0300

perf tools: Drop unneeded bitmap_zero() calls

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
 
