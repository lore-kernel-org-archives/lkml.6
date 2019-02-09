Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BA9C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0803621773
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 13:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBINAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 08:00:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:35025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBINAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 08:00:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19D0C2p2634322
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 05:00:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19D0C0c2634319;
        Sat, 9 Feb 2019 05:00:12 -0800
Date:   Sat, 9 Feb 2019 05:00:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-c3fcadf0bb765faf45d6d562246e1d08885466df@git.kernel.org>
Cc:     mingo@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@redhat.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com,
          jolsa@redhat.com, hpa@zytor.com
In-Reply-To: <20190206103947.15750-2-adrian.hunter@intel.com>
References: <20190206103947.15750-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf auxtrace: Define auxtrace record alignment
Git-Commit-ID: c3fcadf0bb765faf45d6d562246e1d08885466df
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

Commit-ID:  c3fcadf0bb765faf45d6d562246e1d08885466df
Gitweb:     https://git.kernel.org/tip/c3fcadf0bb765faf45d6d562246e1d08885466df
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 6 Feb 2019 12:39:43 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:25:39 -0300

perf auxtrace: Define auxtrace record alignment

Define auxtrace record alignment so that it can be referenced elsewhere.

Note this is preparation for patch "perf intel-pt: Fix overlap calculation
for padding"

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20190206103947.15750-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 4 ++--
 tools/perf/util/auxtrace.h | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 94a22cc8004c..ad186d3255d1 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1279,9 +1279,9 @@ static int __auxtrace_mmap__read(struct perf_mmap *map,
 	}
 
 	/* padding must be written by fn() e.g. record__process_auxtrace() */
-	padding = size & 7;
+	padding = size & (PERF_AUXTRACE_RECORD_ALIGNMENT - 1);
 	if (padding)
-		padding = 8 - padding;
+		padding = PERF_AUXTRACE_RECORD_ALIGNMENT - padding;
 
 	memset(&ev, 0, sizeof(ev));
 	ev.auxtrace.header.type = PERF_RECORD_AUXTRACE;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8e50f96d4b23..fac32482db61 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -40,6 +40,9 @@ struct record_opts;
 struct auxtrace_info_event;
 struct events_stats;
 
+/* Auxtrace records must have the same alignment as perf event records */
+#define PERF_AUXTRACE_RECORD_ALIGNMENT 8
+
 enum auxtrace_type {
 	PERF_AUXTRACE_UNKNOWN,
 	PERF_AUXTRACE_INTEL_PT,
