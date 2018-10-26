Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF86AC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CED920834
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CED920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeJZQGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 12:06:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34305 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeJZQGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 12:06:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9Q7U8n4136578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 26 Oct 2018 00:30:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9Q7U8WJ136573;
        Fri, 26 Oct 2018 00:30:08 -0700
Date:   Fri, 26 Oct 2018 00:30:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hongxu Jia <tipbot@zytor.com>
Message-ID: <tip-1qrgq840ci0c5cy4oww957ge@git.kernel.org>
Cc:     sboisvert@gydle.com, tmricht@linux.vnet.ibm.com, acme@redhat.com,
        mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        brueckner@linux.vnet.ibm.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au, jolsa@redhat.com,
        kim.phillips@arm.com, ravi.bangoria@linux.vnet.ibm.com,
        hpa@zytor.com, peterz@infradead.org, hongxu.jia@windriver.com
Reply-To: acme@redhat.com, tmricht@linux.vnet.ibm.com, sboisvert@gydle.com,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, namhyung@kernel.org,
          brueckner@linux.vnet.ibm.com, mingo@kernel.org,
          mpe@ellerman.id.au, kim.phillips@arm.com, jolsa@redhat.com,
          hongxu.jia@windriver.com, peterz@infradead.org, hpa@zytor.com,
          ravi.bangoria@linux.vnet.ibm.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf arm64: Fix generate system call table failed
 with /tmp mounted with noexec
Git-Commit-ID: 389373d3306553896a9e218493e5b6175c844eb0
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

Commit-ID:  389373d3306553896a9e218493e5b6175c844eb0
Gitweb:     https://git.kernel.org/tip/389373d3306553896a9e218493e5b6175c844eb0
Author:     Hongxu Jia <hongxu.jia@windriver.com>
AuthorDate: Thu, 18 Oct 2018 16:26:13 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 19 Oct 2018 11:56:57 -0300

perf arm64: Fix generate system call table failed with /tmp mounted with noexec

When /tmp is mounted with noexec, mksyscalltbl fails.

  [snip]
  |perf-1.0/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl:
  /tmp/create-table-6VGPSt: Permission denied
  [snip]

Add variable TMPDIR as prefix dir of the temporary file, if it is set,
replace default /tmp.

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: Sébastien Boisvert <sboisvert@gydle.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")
LPU-Reference: 1539851173-14959-1-git-send-email-hongxu.jia@windriver.com
Link: https://lkml.kernel.org/n/tip-1qrgq840ci0c5cy4oww957ge@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 2dbb8cade048..c88fd32563eb 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -23,7 +23,7 @@ create_table_from_c()
 {
 	local sc nr last_sc
 
-	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
+	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
 
 	{
 
