Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8ABC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B0120874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B0120874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388306AbeGXHZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 03:25:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388161AbeGXHZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 03:25:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 00182402332F;
        Tue, 24 Jul 2018 06:20:16 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-106.brq.redhat.com [10.40.204.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 363D52166BA0;
        Tue, 24 Jul 2018 06:20:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, rodia@autistici.org
Subject: [PATCH] perf c2c report: Fix crash for empty browser
Date:   Tue, 24 Jul 2018 08:20:08 +0200
Message-Id: <20180724062008.26126-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 06:20:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 24 Jul 2018 06:20:17 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not try to display entry details if there's
not any. Currently this ends up in crash:
  $ perf c2c report
  perf: Segmentation fault

Reported-by: rodia@autistici.org
Link: http://lkml.kernel.org/n/tip-3d7qjz9x49ay9ncerfordcv3@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
2.17.1

