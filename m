Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD8AC64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5076B2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544131866;
	bh=Gv8kkWdXwJNDJjMSKa0MqCWQxaf4vtXSKH85QmEKGV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qUoTUru2FjFk//oosmsnmWJPBWeA8sQNFwHZLFRDyzouxckvmXRLucoylmz7cDAXE
	 EKyrd/ehByEpLSk1eBn5AXQodantNg6CpfbGEVM5LVLDSDQfW77jIxV90DYcxgRHN0
	 0SyVbaeqorRv/LjCxAQuV/LD0i1WrclhI1sPyc2Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5076B2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeLFVbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:31:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbeLFVa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:30:59 -0500
Received: from quaco.ghostprotocols.net (179.187.13.223.dynamic.adsl.gvt.net.br [179.187.13.223])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C5022082B;
        Thu,  6 Dec 2018 21:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544131858;
        bh=Gv8kkWdXwJNDJjMSKa0MqCWQxaf4vtXSKH85QmEKGV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qyyxtuuk37kKYflDiClw/8aQ6KZESzqL3PAVsQbjSTwt9rBsUkLRSGUe18catNr11
         sfTimYhCpGZ5+rq9nwxG/zxNx0grF2doV7TCqODiOncaY/V10TJIZ0GR7MAKiXFJRt
         nzsYBMl2Qkz8JFHOwsMlM/5q5bPcR4+ne4ZvtsDM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 69/75] perf record: Fix memory leak on AIO objects deallocation
Date:   Thu,  6 Dec 2018 18:25:56 -0300
Message-Id: <20181206212602.20474-70-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Budankov <alexey.budankov@linux.intel.com>

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
-- 
2.19.2

