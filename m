Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A03620844
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:06:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A03620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbeIFRl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:41:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44693 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeIFRlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:41:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w86D5eFg303190
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 6 Sep 2018 06:05:40 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w86D5erh303187;
        Thu, 6 Sep 2018 06:05:40 -0700
Date:   Thu, 6 Sep 2018 06:05:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Chris Phlipot <tipbot@zytor.com>
Message-ID: <tip-a72f64261359b7451f8478f2a2bf357b4e6c757f@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, cphlipot0@gmail.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, namhyung@kernel.org
Reply-To: namhyung@kernel.org, cphlipot0@gmail.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org
In-Reply-To: <20180829061954.18871-1-cphlipot0@gmail.com>
References: <20180829061954.18871-1-cphlipot0@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf util: Fix bad memory access in trace info.
Git-Commit-ID: a72f64261359b7451f8478f2a2bf357b4e6c757f
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

Commit-ID:  a72f64261359b7451f8478f2a2bf357b4e6c757f
Gitweb:     https://git.kernel.org/tip/a72f64261359b7451f8478f2a2bf357b4e6c757f
Author:     Chris Phlipot <cphlipot0@gmail.com>
AuthorDate: Tue, 28 Aug 2018 23:19:54 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 30 Aug 2018 14:50:50 -0300

perf util: Fix bad memory access in trace info.

In the write to the output_fd in the error condition of
record_saved_cmdline(), we are writing 8 bytes from a memory location on
the stack that contains a primitive that is only 4 bytes in size.
Change the primitive to 8 bytes in size to match the size of the write
in order to avoid reading unknown memory from the stack.

Signed-off-by: Chris Phlipot <cphlipot0@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829061954.18871-1-cphlipot0@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/trace-event-info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/trace-event-info.c b/tools/perf/util/trace-event-info.c
index c85d0d1a65ed..7b0ca7cbb7de 100644
--- a/tools/perf/util/trace-event-info.c
+++ b/tools/perf/util/trace-event-info.c
@@ -377,7 +377,7 @@ out:
 
 static int record_saved_cmdline(void)
 {
-	unsigned int size;
+	unsigned long long size;
 	char *path;
 	struct stat st;
 	int ret, err = 0;
