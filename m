Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE20C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C8B205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C8B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeKAU3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:29:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeKAU3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:29:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC13A78;
        Thu,  1 Nov 2018 04:26:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E93343F71D;
        Thu,  1 Nov 2018 04:26:58 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] locking/atomics: restore execute permission to scripts
Date:   Thu,  1 Nov 2018 11:26:54 +0000
Message-Id: <20181101112654.55898-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We accidentally dropped execute permissions from the atomics scripts,
which leads to the check-atomics.sh script failing at build time:

  CALL    scripts/atomic/check-atomics.sh
  scripts/atomic/check-atomics.sh: line 16:
  scripts/atomic/gen-atomic-instrumented.sh: Permission denied
  warning: include/asm-generic/atomic-instrumented.h is out-of-date.
  scripts/atomic/check-atomics.sh: line 16:
  scripts/atomic/gen-atomic-long.sh: Permission denied
  warning: include/asm-generic/atomic-long.h is out-of-date.
  scripts/atomic/check-atomics.sh: line 16:
  scripts/atomic/gen-atomic-fallback.sh: Permission denied
  warning: include/linux/atomic-fallback.h is out-of-date.

Fix this by restoring execute permissions to all the atomics scripts.

Fixes: ace9bad4df2684f3 ("locking/atomics: Add common header generation files")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
---
 scripts/atomic/atomic-tbl.sh              | 0
 scripts/atomic/check-atomics.sh           | 0
 scripts/atomic/gen-atomic-fallback.sh     | 0
 scripts/atomic/gen-atomic-instrumented.sh | 0
 scripts/atomic/gen-atomic-long.sh         | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 scripts/atomic/atomic-tbl.sh
 mode change 100644 => 100755 scripts/atomic/check-atomics.sh
 mode change 100644 => 100755 scripts/atomic/gen-atomic-fallback.sh
 mode change 100644 => 100755 scripts/atomic/gen-atomic-instrumented.sh
 mode change 100644 => 100755 scripts/atomic/gen-atomic-long.sh

diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
old mode 100644
new mode 100755
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
old mode 100644
new mode 100755
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
old mode 100644
new mode 100755
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
old mode 100644
new mode 100755
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-long.sh
old mode 100644
new mode 100755
-- 
2.11.0

