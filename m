Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF73ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B7F2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvAU3e03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50B7F2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbeIXVJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbeIXVHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:07:42 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9565520C0A;
        Mon, 24 Sep 2018 15:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537801506;
        bh=7wJe8uZsCiQjDaeRy+3t9lvGh9ZLgiBxg5biYA/i/kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvAU3e03h/m41/jnmXSpxCvSN3f7COPchkYJFbNmBM+lnzlF/vXZHEaHGiKh15sfj
         tfPnLS8AEF4v9Tnb38PbRFtHOyAHG2xLvOEqU/BfNrzW0KbFQelMzpZ16iOvTSzdQU
         a4+e0JG+ESZy070DvVKi3RoJl2FHiqxjX2fA2vMA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/27] perf script: Enhance sample flags for trace begin / end
Date:   Mon, 24 Sep 2018 12:02:36 -0300
Message-Id: <20180924150242.14235-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Allow for different combinations of sample flags with "trace begin" or
"trace end".

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, prepare 'perf script' to
display sample flags with more combinations that include trace begin /
end. In those cases display 'tr start' and 'tr end' separately.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 7732346bd9dd..4da5e32b9e03 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1262,6 +1262,18 @@ static struct {
 	{0, NULL}
 };
 
+static const char *sample_flags_to_name(u32 flags)
+{
+	int i;
+
+	for (i = 0; sample_flags[i].name ; i++) {
+		if (sample_flags[i].flags == flags)
+			return sample_flags[i].name;
+	}
+
+	return NULL;
+}
+
 static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 {
 	const char *chars = PERF_IP_FLAG_CHARS;
@@ -1271,11 +1283,20 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	char str[33];
 	int i, pos = 0;
 
-	for (i = 0; sample_flags[i].name ; i++) {
-		if (sample_flags[i].flags == (flags & ~PERF_IP_FLAG_IN_TX)) {
-			name = sample_flags[i].name;
-			break;
-		}
+	name = sample_flags_to_name(flags & ~PERF_IP_FLAG_IN_TX);
+	if (name)
+		return fprintf(fp, "  %-15s%4s ", name, in_tx ? "(x)" : "");
+
+	if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_BEGIN));
+		if (name)
+			return fprintf(fp, "  tr strt %-7s%4s ", name, in_tx ? "(x)" : "");
+	}
+
+	if (flags & PERF_IP_FLAG_TRACE_END) {
+		name = sample_flags_to_name(flags & ~(PERF_IP_FLAG_IN_TX | PERF_IP_FLAG_TRACE_END));
+		if (name)
+			return fprintf(fp, "  tr end  %-7s%4s ", name, in_tx ? "(x)" : "");
 	}
 
 	for (i = 0; i < n; i++, flags >>= 1) {
@@ -1288,10 +1309,7 @@ static int perf_sample__fprintf_flags(u32 flags, FILE *fp)
 	}
 	str[pos] = 0;
 
-	if (name)
-		return fprintf(fp, "  %-7s%4s ", name, in_tx ? "(x)" : "");
-
-	return fprintf(fp, "  %-11s ", str);
+	return fprintf(fp, "  %-19s ", str);
 }
 
 struct printer_data {
-- 
2.14.4

