Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7257C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB98214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 11:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB98214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbeISRDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:03:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:53385 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731341AbeISRDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:03:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 04:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,393,1531810800"; 
   d="scan'208";a="74247598"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga007.jf.intel.com with ESMTP; 19 Sep 2018 04:25:30 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] perf db-export: Add trace begin / end branch type variants
Date:   Wed, 19 Sep 2018 14:23:34 +0300
Message-Id: <20180919112338.20347-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180919112338.20347-1-adrian.hunter@intel.com>
References: <20180919112338.20347-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add branch types to cover different combinations with "trace begin" or
"trace end".

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 7123746edcf4..69fbb0a72d0c 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -463,6 +463,28 @@ int db_export__branch_types(struct db_export *dbe)
 		if (err)
 			break;
 	}
+
+	/* Add trace begin / end variants */
+	for (i = 0; branch_types[i].name ; i++) {
+		const char *name = branch_types[i].name;
+		u32 type = branch_types[i].branch_type;
+		char buf[64];
+
+		if (type == PERF_IP_FLAG_BRANCH ||
+		    (type & (PERF_IP_FLAG_TRACE_BEGIN | PERF_IP_FLAG_TRACE_END)))
+			continue;
+
+		snprintf(buf, sizeof(buf), "trace begin / %s", name);
+		err = db_export__branch_type(dbe, type | PERF_IP_FLAG_TRACE_BEGIN, buf);
+		if (err)
+			break;
+
+		snprintf(buf, sizeof(buf), "%s / trace end", name);
+		err = db_export__branch_type(dbe, type | PERF_IP_FLAG_TRACE_END, buf);
+		if (err)
+			break;
+	}
+
 	return err;
 }
 
-- 
2.17.1

