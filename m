Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F09C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C2D2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C2D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbeHBKEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:04:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbeHBKEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:04:24 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w728C2al3431240
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Aug 2018 01:12:02 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w728C2Kj3431235;
        Thu, 2 Aug 2018 01:12:02 -0700
Date:   Thu, 2 Aug 2018 01:12:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-73978332572ccf5e364c31e9a70ba953f8202b46@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        jmario@redhat.com, dzickus@redhat.com, peterz@infradead.org,
        mingo@kernel.org, dsahern@gmail.com, tglx@linutronix.de,
        jolsa@kernel.org
Reply-To: jolsa@kernel.org, tglx@linutronix.de, dsahern@gmail.com,
          mingo@kernel.org, peterz@infradead.org, dzickus@redhat.com,
          jmario@redhat.com, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180724062008.26126-1-jolsa@kernel.org>
References: <20180724062008.26126-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf c2c report: Fix crash for empty browser
Git-Commit-ID: 73978332572ccf5e364c31e9a70ba953f8202b46
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

Commit-ID:  73978332572ccf5e364c31e9a70ba953f8202b46
Gitweb:     https://git.kernel.org/tip/73978332572ccf5e364c31e9a70ba953f8202b46
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 24 Jul 2018 08:20:08 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 31 Jul 2018 10:53:20 -0300

perf c2c report: Fix crash for empty browser

'perf c2c' scans read/write accesses and tries to find false sharing
cases, so when the events it wants were not asked for or ended up not
taking place, we get no histograms.

So do not try to display entry details if there's not any. Currently
this ends up in crash:

  $ perf c2c report # then press 'd'
  perf: Segmentation fault
  $

Committer testing:

Before:

Record a perf.data file without events of interest to 'perf c2c report',
then call it and press 'd':

  # perf record sleep 1
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
  # perf c2c report
  perf: Segmentation fault
  -------- backtrace --------
  perf[0x5b1d2a]
  /lib64/libc.so.6(+0x346df)[0x7fcb566e36df]
  perf[0x46fcae]
  perf[0x4a9f1e]
  perf[0x4aa220]
  perf(main+0x301)[0x42c561]
  /lib64/libc.so.6(__libc_start_main+0xe9)[0x7fcb566cff29]
  perf(_start+0x29)[0x42c999]
  #

After the patch the segfault doesn't take place, a follow up patch to
tell the user why nothing changes when 'd' is pressed would be good.

Reported-by: rodia@autistici.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: f1c5fd4d0bb9 ("perf c2c report: Add TUI cacheline browser")
Link: http://lkml.kernel.org/r/20180724062008.26126-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-c2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index f2ea85ee573f..f3aa9d02a5ab 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2349,6 +2349,9 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
 	" s             Toggle full length of symbol and source line columns \n"
 	" q             Return back to cacheline list \n";
 
+	if (!he)
+		return 0;
+
 	/* Display compact version first. */
 	c2c.symbol_full = false;
 
