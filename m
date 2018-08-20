Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387F0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E888B2172D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 16:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg+z2Mlm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E888B2172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeHTTcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 15:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeHTTcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 15:32:45 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8422173A;
        Mon, 20 Aug 2018 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534781789;
        bh=SDENc3VQWy9ufNyYvUM+PVUVpFLpM1lwUjHtCrWi5+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eg+z2Mlm+ErJzdWobDToBOiPstFFgUQWp4Fr28/LbdtdJAy248Lkik9Uy37QDCWRj
         6xnKPZW76BwnfrIAnD2ZHQGt3V2D7agUZou4SfXEQ+HrfYoQjJxhBmvP3e/vnT9mWM
         jE44mjbjn3cXMbVUQrWEmDU9zBK8U2JqSXdTQfbc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/21] perf tools: Get rid of dso__needs_decompress() call in read_object_code()
Date:   Mon, 20 Aug 2018 13:15:46 -0300
Message-Id: <20180820161602.6830-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4892bd2dc33e..6b049f3f5cf4 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -232,6 +232,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	u64 objdump_addr;
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
+	bool decomp = false;
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -305,6 +306,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			return -1;
 		}
 
+		decomp = true;
 		objdump_name = decomp_name;
 	}
 
@@ -312,7 +314,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	objdump_addr = map__rip_2objdump(al.map, al.addr);
 	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
 
-	if (dso__needs_decompress(al.map->dso))
+	if (decomp)
 		unlink(objdump_name);
 
 	if (ret > 0) {
-- 
2.14.4

