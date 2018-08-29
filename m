Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F85C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF92205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:19:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF92205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeH2VQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:16:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:6998 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbeH2VQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:16:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2018 10:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="68826407"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2018 10:18:36 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 90732301BA8; Wed, 29 Aug 2018 10:18:36 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 05/10] perf, tools, script: Print DSO for callindent
Date:   Wed, 29 Aug 2018 10:18:29 -0700
Message-Id: <20180829171834.6590-6-andi@firstfloor.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829171834.6590-1-andi@firstfloor.org>
References: <20180829171834.6590-1-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Now that we don't need to print the IP/ADDR for callindent the DSO
is also not printed. It's useful for some cases, so add an own DSO
printout for callindent for the case when IP/ADDR is not enabled.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/builtin-script.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bae960c56763..6a470dd8f2d0 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1116,6 +1116,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	const char *name = NULL;
 	static int spacing;
 	int len = 0;
+	int dlen = 0;
 	u64 ip = 0;
 
 	/*
@@ -1142,6 +1143,12 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 			ip = sample->ip;
 	}
 
+	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
+		dlen += fprintf(fp, "(");
+		dlen += map__fprintf_dsoname(al->map, fp);
+		dlen += fprintf(fp, ")\t");
+	}
+
 	if (name)
 		len = fprintf(fp, "%*s%s", (int)depth * 4, "", name);
 	else if (ip)
@@ -1160,7 +1167,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
 	if (len < spacing)
 		len += fprintf(fp, "%*s", spacing - len, "");
 
-	return len;
+	return len + dlen;
 }
 
 static int perf_sample__fprintf_insn(struct perf_sample *sample,
-- 
2.17.1

