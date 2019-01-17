Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7001520855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfAQTsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:48:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:3559 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728173AbfAQTsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:48:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2019 11:48:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,489,1539673200"; 
   d="scan'208";a="115501789"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 17 Jan 2019 11:48:36 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E1309301C4E; Thu, 17 Jan 2019 11:48:35 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH] perf, script: Fix crash with printing mixed trace point and other events
Date:   Thu, 17 Jan 2019 11:48:34 -0800
Message-Id: <20190117194834.21940-1-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

perf script crashes currently when printing mixed trace points and other
events because the trace format does not handle events without trace
meta data. Add a simple check to avoid that.

% cat > test.c
main()
{
    printf("Hello world\n");
}
^D
% gcc -g -o test test.c
% sudo perf probe -x test 'test.c:3'
% perf record -e '{cpu/cpu-cycles,period=10000/,probe_test:main}:S' ./test
% perf script
<segfault>

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3728b50e52e2..ea2396b33a57 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1779,7 +1779,7 @@ static void process_event(struct perf_script *script,
 		return;
 	}
 
-	if (PRINT_FIELD(TRACE)) {
+	if (PRINT_FIELD(TRACE) && sample->raw_data) {
 		event_format__fprintf(evsel->tp_format, sample->cpu,
 				      sample->raw_data, sample->raw_size, fp);
 	}
-- 
2.17.2

