Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDFFECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23882146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23882146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbeIREdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:33:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIREdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:33:23 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 39BC3C77;
        Mon, 17 Sep 2018 23:03:54 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, rodia@autistici.org,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Mario <jmario@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 048/126] perf c2c report: Fix crash for empty browser
Date:   Tue, 18 Sep 2018 00:41:36 +0200
Message-Id: <20180917211707.760500060@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 73978332572ccf5e364c31e9a70ba953f8202b46 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-c2c.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2229,6 +2229,9 @@ static int perf_c2c__browse_cacheline(st
 	" s             Togle full lenght of symbol and source line columns \n"
 	" q             Return back to cacheline list \n";
 
+	if (!he)
+		return 0;
+
 	/* Display compact version first. */
 	c2c.symbol_full = false;
 


