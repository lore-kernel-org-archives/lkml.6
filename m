Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD109ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595A22086B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS5sCR1K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595A22086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbeIXVHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:07:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729871AbeIXVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:47 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AE2A2086B;
        Mon, 24 Sep 2018 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801511;
        bh=sXmmtCy5RyvJPjrAkMbzf4UonNdyYmabTvilzCE99k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dS5sCR1KliLFGHhuwelNupZu2EAsjfLgCTRexXk76HAcg6aOOa33eGCSXq5nxG+km
         WCFi0YXG8S7oYH6BqUwaeEQsMREDab4L35yI/yFM4ep54/ewLpkvtQQPNVzdM8aivv
         Em/iMaeLcY8iKPGR/gl7Z8JZSo8q56awu/2A9/qQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/27] perf db-export: Add trace begin / end branch type variants
Date:   Mon, 24 Sep 2018 12:02:37 -0300
Message-Id: <20180924150242.14235-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add branch types to cover different combinations with "trace begin" or
"trace end".

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, prepare the database
export to export branch types with more combinations that include trace
begin / end.  In those cases extend the descriptions to include 'trace
begin' and 'trace end' separately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

