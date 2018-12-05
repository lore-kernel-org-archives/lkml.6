Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3EEC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B5220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B5220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeLERTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:19:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:41226 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbeLERTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:19:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="125350042"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2018 09:19:45 -0800
Received: from [10.251.85.233] (abudanko-mobl.ccr.corp.intel.com [10.251.85.233])
        by linux.intel.com (Postfix) with ESMTP id 5D404580375;
        Wed,  5 Dec 2018 09:19:43 -0800 (PST)
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v1] perf record: fix memory leak on AIO objects deallocation
Organization: Intel Corp.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <e5d3154e-1583-83bb-9527-28ddbc6dbf9d@linux.intel.com>
Date:   Wed, 5 Dec 2018 20:19:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sending a part which was missed between v12 and v13 of the patch set
introducing AIO trace streaming for perf record mode. 

The part is essential to avoid memory leakage during deallocation
of AIO related trace data buffers.

It is applied on top of acme perf/core repo.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
tools/perf/util/mmap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index ab30555d2afc..169d02973757 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -207,8 +207,18 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 
 static void perf_mmap__aio_munmap(struct perf_mmap *map)
 {
+	int i;
+
+	for (i = 0; i < map->aio.nr_cblocks; ++i) {
+		if (map->aio.data[i])
+			zfree(&map->aio.data[i]);
+	}
 	if (map->aio.data)
 		zfree(&map->aio.data);
+	if (map->aio.cblocks)
+		zfree(&map->aio.cblocks);
+	if (map->aio.aiocb)
+		zfree(&map->aio.aiocb);
 }
 
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
