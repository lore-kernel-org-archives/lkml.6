Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC625C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF94218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DF94218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbeHQMvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbeHQMvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BF14940201C4;
        Fri, 17 Aug 2018 09:48:17 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51C6A1745B;
        Fri, 17 Aug 2018 09:48:16 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 01/13] perf tools: Get rid of dso__needs_decompress call in read_object_code
Date:   Fri, 17 Aug 2018 11:48:01 +0200
Message-Id: <20180817094813.15086-2-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 17 Aug 2018 09:48:17 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to call dso__needs_decompress twice
in the function.

Link: http://lkml.kernel.org/n/tip-ze5ga3ioou08aq94pe59vzzu@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.1

