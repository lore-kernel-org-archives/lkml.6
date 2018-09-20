Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818B3ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4794121529
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4794121529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387920AbeITSqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:46:06 -0400
Received: from mga17.intel.com ([192.55.52.151]:5248 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387756AbeITSqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:46:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Sep 2018 06:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,398,1531810800"; 
   d="scan'208";a="74829215"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.98])
  by orsmga008.jf.intel.com with ESMTP; 20 Sep 2018 06:02:39 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/6] perf db-export: Add trace begin / end branch type variants
Date:   Thu, 20 Sep 2018 16:00:44 +0300
Message-Id: <20180920130048.31432-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920130048.31432-1-adrian.hunter@intel.com>
References: <20180920130048.31432-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add branch types to cover different combinations with "trace begin" or
"trace end".

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a trace
ends with a call. Before remedying that, prepare the database export to
export branch types with more combinations that include trace begin / end.
In those cases extend the descriptions to include 'trace begin' and
'trace end' separately.

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

