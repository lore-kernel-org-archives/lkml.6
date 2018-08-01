Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C11208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 21:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulqsf2AH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C11208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbeHAXZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 19:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbeHAXZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 19:25:21 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6240208A6;
        Wed,  1 Aug 2018 21:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533159453;
        bh=WwTrkKvdo1fs2DpKS/KVetrpEVKs6mPUnFaD6KWQb2c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ulqsf2AHbzcLe/0QMsamqtCbHmgRmTJ/k4oQOrBZb84Azp8Eo7aC70K/XcjGnpTSN
         0lAQAVCOysjDTqrhMU6Yr71JeCAbgamwk5dviYrn0pQy2XPqgCEzb4ECHTO4TvT9Is
         ud+UgRu3sUXZ4g9AdltD4PizlLJ/4EOlk94CiEKw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/21] perf c2c report: Fix crash for empty browser
Date:   Wed,  1 Aug 2018 18:36:37 -0300
Message-Id: <20180801213648.4814-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180801213648.4814-1-acme@kernel.org>
References: <20180801213648.4814-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
 
-- 
2.14.4

