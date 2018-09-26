Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CA3C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC8B204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AC8B204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeIZPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:06:51 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:06:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8Q8roul3772611
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Sep 2018 01:53:50 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8Q8ro503772608;
        Wed, 26 Sep 2018 01:53:50 -0700
Date:   Wed, 26 Sep 2018 01:53:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-62cb1b8868a70c932b15959a98594df537df2ffc@git.kernel.org>
Cc:     acme@redhat.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, ak@linux.intel.com, adrian.hunter@intel.com,
        hpa@zytor.com, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          acme@redhat.com, jolsa@redhat.com, adrian.hunter@intel.com,
          hpa@zytor.com, ak@linux.intel.com, mingo@kernel.org
In-Reply-To: <20180920130048.31432-2-adrian.hunter@intel.com>
References: <20180920130048.31432-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script: Enhance sample flags for trace begin /
 end
Git-Commit-ID: 62cb1b8868a70c932b15959a98594df537df2ffc
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

Commit-ID:  62cb1b8868a70c932b15959a98594df537df2ffc
Gitweb:     https://git.kernel.org/tip/62cb1b8868a70c932b15959a98594df537df2ffc
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 20 Sep 2018 16:00:43 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 20 Sep 2018 11:09:55 -0300

perf script: Enhance sample flags for trace begin / end

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
