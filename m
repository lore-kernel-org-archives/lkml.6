Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14392C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD54520851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD54520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbeHWMJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38377 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732206AbeHWMJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8d93m3188399
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:39:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8d9M53188396;
        Thu, 23 Aug 2018 01:39:09 -0700
Date:   Thu, 23 Aug 2018 01:39:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-bcd4287ead885e010cd49265d8c68f2373476b08@git.kernel.org>
Cc:     mpetlan@redhat.com, hpa@zytor.com, mingo@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dsahern@gmail.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          tglx@linutronix.de, namhyung@kernel.org, mpetlan@redhat.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          mingo@kernel.org, dsahern@gmail.com, peterz@infradead.org
In-Reply-To: <20180817094813.15086-2-jolsa@kernel.org>
References: <20180817094813.15086-2-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Get rid of dso__needs_decompress()
 call in read_object_code()
Git-Commit-ID: bcd4287ead885e010cd49265d8c68f2373476b08
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

Commit-ID:  bcd4287ead885e010cd49265d8c68f2373476b08
Gitweb:     https://git.kernel.org/tip/bcd4287ead885e010cd49265d8c68f2373476b08
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:01 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Get rid of dso__needs_decompress() call in read_object_code()

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
