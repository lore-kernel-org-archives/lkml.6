Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDC0C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C5321871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbeLRO2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:28:17 -0500
Received: from terminus.zytor.com ([198.137.202.136]:59561 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbeLRO2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:28:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBIEPpTt2857836
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 18 Dec 2018 06:25:51 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBIEPpjV2857830;
        Tue, 18 Dec 2018 06:25:51 -0800
Date:   Tue, 18 Dec 2018 06:25:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Alexey Budankov <tipbot@zytor.com>
Message-ID: <tip-c8dd6ee51a4d0a119c8b4121d83008215e3209ed@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        alexey.budankov@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        alexander.shishkin@linux.intel.com
Reply-To: alexey.budankov@linux.intel.com, jolsa@redhat.com,
          acme@redhat.com, peterz@infradead.org, mingo@kernel.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          tglx@linutronix.de, namhyung@kernel.org, ak@linux.intel.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
References: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Fix memory leak on AIO objects
 deallocation
Git-Commit-ID: c8dd6ee51a4d0a119c8b4121d83008215e3209ed
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

Commit-ID:  c8dd6ee51a4d0a119c8b4121d83008215e3209ed
Gitweb:     https://git.kernel.org/tip/c8dd6ee51a4d0a119c8b4121d83008215e3209ed
Author:     Alexey Budankov <alexey.budankov@linux.intel.com>
AuthorDate: Wed, 5 Dec 2018 20:19:41 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Dec 2018 14:59:34 -0300

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
