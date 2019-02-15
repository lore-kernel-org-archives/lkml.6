Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB0BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288AE206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 18:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390619AbfBOShq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 13:37:46 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:59748 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388116AbfBOShq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 13:37:46 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2019 13:37:45 EST
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 441MG86q5jz8vB3;
        Fri, 15 Feb 2019 19:28:32 +0100 (CET)
Authentication-Results: mx-rz-1.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 93.217.154.217
Received: from fau.de (p5DD99AD9.dip0.t-ipconnect.de [93.217.154.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19ITf61O2P3j8Vrxl4taMRLsPw/0Jq1wYk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 441MG64fvQz8tZr;
        Fri, 15 Feb 2019 19:28:30 +0100 (CET)
From:   Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To:     linux-perf-users@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: update perf.data file format documentation
Date:   Fri, 15 Feb 2019 19:28:23 +0100
Message-Id: <20190215182823.303-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that the documentation of the flags section is some how
different from the actual format used and expected by the perf
tools. In this patch the according section of the file format
documentation is updated to conform to the expectations of the
perf tool suite.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 .../perf/Documentation/perf.data-file-format.txt  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index dfb218feaad9..6ea199f28330 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -43,13 +43,10 @@ struct perf_file_section {
 
 Flags section:
 
-The header is followed by different optional headers, described by the bits set
-in flags. Only headers for which the bit is set are included. Each header
-consists of a perf_file_section located after the initial header.
-The respective perf_file_section points to the data of the additional
-header and defines its size.
-
-Some headers consist of strings, which are defined like this:
+The Flags section is placed directly after the data section and consists of a
+variable amount of information described by the flags-bitset in the perf_header.
+A lot of the headers in the Flags section are simple strings and are represented
+like this:
 
 struct perf_header_string {
        uint32_t len;
@@ -82,7 +79,7 @@ assigned by the linker to an executable.
 struct build_id_event {
 	struct perf_event_header header;
 	pid_t			 pid;
-	uint8_t			 build_id[24];
+	uint8_t			 build_id[PERF_ALIGN(24, sizeof(u64))];
 	char			 filename[header.size - offsetof(struct build_id_event, filename)];
 };
 
@@ -131,7 +128,7 @@ An uint64_t with the total memory in bytes.
 
 	HEADER_CMDLINE = 11,
 
-A perf_header_string with the perf command line used to collect the data.
+A perf_header_string_list with the perf arg-vector used to collect the data.
 
 	HEADER_EVENT_DESC = 12,
 
-- 
2.17.1

