Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B5BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3A6206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D3A6206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeIZPGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:06:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34081 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:06:22 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8sMZY3772819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:54:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8sMKO3772816;
        Wed, 26 Sep 2018 01:54:22 -0700
Date:   Wed, 26 Sep 2018 01:54:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-ff645daf30cafb6fa74bee9a73733700bac2aff7@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, mingo@kernel.org, ak@linux.intel.com
Reply-To: hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          ak@linux.intel.com, jolsa@redhat.com, acme@redhat.com
In-Reply-To: <20180920130048.31432-3-adrian.hunter@intel.com>
References: <20180920130048.31432-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf db-export: Add trace begin / end branch type
 variants
Git-Commit-ID: ff645daf30cafb6fa74bee9a73733700bac2aff7
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

Commit-ID:  ff645daf30cafb6fa74bee9a73733700bac2aff7
Gitweb:     https://git.kernel.org/tip/ff645daf30cafb6fa74bee9a73733700bac2aff7
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 20 Sep 2018 16:00:44 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 20 Sep 2018 11:10:25 -0300

perf db-export: Add trace begin / end branch type variants

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
 
