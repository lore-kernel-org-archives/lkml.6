Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F252C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A96217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfAVXen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:34:43 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.171]:34883 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbfAVXen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:34:43 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 52C91916994
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 17:34:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id m5Z4gGEOIdnCem5Z4gJTca; Tue, 22 Jan 2019 17:34:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=36714 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gm5Z3-003h0a-GX; Tue, 22 Jan 2019 17:34:41 -0600
Date:   Tue, 22 Jan 2019 17:34:39 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] perf tests: evsel-tp-sched: Fix bitwise operator
Message-ID: <20190122233439.GA5868@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gm5Z3-003h0a-GX
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:36714
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Notice that the use of the bitwise OR operator '|' always leads to
true in this particular case, which seems a bit suspicious due to
the context in which this expression is being used.

Fix this by using bitwise AND operator '&' instead.

This bug was detected with the help of Coccinelle.

Fixes: 6a6cd11d4e57 ("perf test: Add test for the sched tracepoint format fields")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---

NOTE: Notice that this code has been there since 2012. So, it would
      be helpful if someone can double-check this. Thanks.

 tools/perf/tests/evsel-tp-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 5f8501c68da4..5cbba70bcdd0 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -17,7 +17,7 @@ static int perf_evsel__test_field(struct perf_evsel *evsel, const char *name,
 		return -1;
 	}
 
-	is_signed = !!(field->flags | TEP_FIELD_IS_SIGNED);
+	is_signed = !!(field->flags & TEP_FIELD_IS_SIGNED);
 	if (should_be_signed && !is_signed) {
 		pr_debug("%s: \"%s\" signedness(%d) is wrong, should be %d\n",
 			 evsel->name, name, is_signed, should_be_signed);
-- 
2.20.1

