Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88A0C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6582E279F6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:47:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6582E279F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeF2RrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:47:04 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37954 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933284AbeF2RrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1961682;
        Fri, 29 Jun 2018 10:47:00 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4513F5AD;
        Fri, 29 Jun 2018 10:46:59 -0700 (PDT)
Date:   Fri, 29 Jun 2018 12:46:58 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        =?ISO-8859-1?Q? "Hendrik_Br=FCckner" ?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: [PATCH v2 4/4] perf test shell: prevent temporary editor files from
 being considered test scripts
Message-Id: <20180629124658.15a506b41fc4539c08eb9426@arm.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows a perf shell test developer to concurrently edit and run their
test scripts, avoiding perf test attempts to execute their editor
temporary files, such as seen here:

 $ sudo taskset -c 0 ./perf test -vvvvvvvv -F 63
 63: 0VIM 8.0                                              :
 --- start ---
 sh: 1: ./tests/shell/.record+probe_libc_inet_pton.sh.swp: Permission denied
 ---- end ----
 0VIM 8.0: FAILED!

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
---
v2: new this series

 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2bde505e2e7e..dd850a26d579 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -422,7 +422,7 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(dir, base, ent)	\
 	while ((ent = readdir(dir)) != NULL)	\
-		if (!is_directory(base, ent))
+		if (!is_directory(base, ent) && ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
-- 
2.17.1

