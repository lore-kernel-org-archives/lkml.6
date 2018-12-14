Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7D5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 036D7208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731121AbeLNU7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:59:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60709 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730757AbeLNU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:59:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKwmiU1459862
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:58:48 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKwmaf1459859;
        Fri, 14 Dec 2018 12:58:48 -0800
Date:   Fri, 14 Dec 2018 12:58:48 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-c713acc7090b32ca1c157f6528d607a087e807a8@git.kernel.org>
Cc:     ak@linux.intel.com, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        mingo@kernel.org, alexey.budankov@linux.intel.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          alexey.budankov@linux.intel.com, mingo@kernel.org,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, jolsa@redhat.com
In-Reply-To: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
References: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Fix memory leak on AIO objects
 deallocation
Git-Commit-ID: c713acc7090b32ca1c157f6528d607a087e807a8
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

Commit-ID:  c713acc7090b32ca1c157f6528d607a087e807a8
Gitweb:     https://git.kernel.org/tip/c713acc7090b32ca1c157f6528d607a087e807a8
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Wed, 5 Dec 2018 20:19:41 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 16:43:27 -0300

perf record: Fix memory leak on AIO objects deallocation

Sending a part which was missed between v12 and v13 of the patch set
introducing AIO trace streaming for perf record mode.

The part is essential to avoid memory leakage during deallocation of AIO
related trace data buffers.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com
[ No need to test for NULL before calling zfree() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab30555d2afc..8fc39311a30d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -207,8 +207,14 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 
 static void perf_mmap__aio_munmap(struct perf_mmap *map)
 {
+	int i;
+
+	for (i = 0; i < map->aio.nr_cblocks; ++i)
+		zfree(&map->aio.data[i]);
 	if (map->aio.data)
 		zfree(&map->aio.data);
+	zfree(&map->aio.cblocks);
+	zfree(&map->aio.aiocb);
 }
 
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
