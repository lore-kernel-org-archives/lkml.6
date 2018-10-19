Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5450C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890020645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8890020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeJSKKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:10:25 -0400
Received: from mail.windriver.com ([147.11.1.11]:58761 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSKKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:10:25 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w9J263Jt010256
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 18 Oct 2018 19:06:03 -0700 (PDT)
Received: from pek-lpg-core1-vm2.wrs.com (128.224.156.107) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Oct 2018 19:06:02 -0700
From:   Hongxu Jia <hongxu.jia@windriver.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <kim.phillips@arm.com>, <brueckner@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <mpe@ellerman.id.au>, <peterz@infradead.org>,
        <ravi.bangoria@linux.vnet.ibm.com>, <tmricht@linux.vnet.ibm.com>,
        <acme@redhat.com>, <namhyung@kernel.org>,
        <hongxu.jia@windriver.com>
Subject: [PATCH V2] perf arm64: Fix generate system call table failed with /tmp mounted with noexec
Date:   Fri, 19 Oct 2018 10:16:19 +0800
Message-ID: <1539915379-11910-1-git-send-email-hongxu.jia@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
References: <1c6964d0-a7d2-83ef-16f2-bdf349e3f0af@gydle.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When /tmp is mounted with noexec, mksyscalltbl fails.
[snip]
|perf-1.0/tools/perf/arch/arm64/entry/syscalls//mksyscalltbl:
/tmp/create-table-6VGPSt: Permission denied
[snip]

Add variable TMPDIR as prefix dir of the temporary file, if it is set,
replace default /tmp

Remove extra slash from `syscalls//mksyscalltbl'

Fixes: 2b5882435606 ("perf arm64: Generate system call table from asm/unistd.h")

Signed-off-by: Hongxu Jia <hongxu.jia@windriver.com>
---
 tools/perf/arch/arm64/Makefile                    | 2 +-
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index dbef716..bc2a284 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -13,7 +13,7 @@ out    := $(OUTPUT)arch/arm64/include/generated/asm
 header := $(out)/syscalls.c
 incpath := $(srctree)/tools
 sysdef := $(srctree)/tools/arch/arm64/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls/
+sysprf := $(srctree)/tools/perf/arch/arm64/entry/syscalls
 systbl := $(sysprf)/mksyscalltbl
 
 # Create output directory if not already present
diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index 2dbb8cad..c88fd32 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -23,7 +23,7 @@ create_table_from_c()
 {
 	local sc nr last_sc
 
-	create_table_exe=`mktemp /tmp/create-table-XXXXXX`
+	create_table_exe=`mktemp ${TMPDIR:-/tmp}/create-table-XXXXXX`
 
 	{
 
-- 
2.7.4

