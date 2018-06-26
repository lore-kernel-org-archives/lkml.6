Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC67C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8671926470
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sjGdz29B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8671926470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965448AbeFZDAI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965415AbeFZDAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:00:05 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550D426475;
        Tue, 26 Jun 2018 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529982004;
        bh=sIzsS9pyv6Ks9/QjEq0l7znt1L0fDdXkBVv0EhhjBEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjGdz29BqTbnE7Dzwpx3GfGHlqpt53QXVGawctJWRU5qz988EWnBC98lbnzWaCL6H
         lRSR2mFf0m5BikPLhrZnXNAXTCt4SthxguxJ4pa+5yWQSpOQW+yfGj5nlhYr9PdWxQ
         QUwG7kjyZqriuP+xihGUpLf/+ybuEMLsAxgUqok8=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 08/12] sh: Implement hw_breakpoint_arch_parse()
Date:   Tue, 26 Jun 2018 04:58:55 +0200
Message-Id: <1529981939-8231-9-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Joel Fernandes <joel.opensrc@gmail.com>
---
 arch/sh/include/asm/hw_breakpoint.h |  6 +++++-
 arch/sh/kernel/hw_breakpoint.c      | 37 +++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/arch/sh/include/asm/hw_breakpoint.h b/arch/sh/include/asm/hw_breakpoint.h
index dae622d..867edcc 100644
--- a/arch/sh/include/asm/hw_breakpoint.h
+++ b/arch/sh/include/asm/hw_breakpoint.h
@@ -40,6 +40,7 @@ struct sh_ubc {
 	struct clk	*clk;	/* optional interface clock / MSTP bit */
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct task_struct;
 struct pmu;
@@ -54,7 +55,10 @@ static inline int hw_breakpoint_slots(int type)
 
 /* arch/sh/kernel/hw_breakpoint.c */
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 					   unsigned long val, void *data);
 
diff --git a/arch/sh/kernel/hw_breakpoint.c b/arch/sh/kernel/hw_breakpoint.c
index c453a0c..d9ff3b4 100644
--- a/arch/sh/kernel/hw_breakpoint.c
+++ b/arch/sh/kernel/hw_breakpoint.c
@@ -173,40 +173,40 @@ int arch_bp_generic_fields(int sh_len, int sh_type,
 	return 0;
 }
 
-static int arch_build_bp_info(struct perf_event *bp)
+static int arch_build_bp_info(struct perf_event *bp,
+			      const struct perf_event_attr *attr,
+			      struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
-	info->address = bp->attr.bp_addr;
+	hw->address = attr->bp_addr;
 
 	/* Len */
-	switch (bp->attr.bp_len) {
+	switch (attr->bp_len) {
 	case HW_BREAKPOINT_LEN_1:
-		info->len = SH_BREAKPOINT_LEN_1;
+		hw->len = SH_BREAKPOINT_LEN_1;
 		break;
 	case HW_BREAKPOINT_LEN_2:
-		info->len = SH_BREAKPOINT_LEN_2;
+		hw->len = SH_BREAKPOINT_LEN_2;
 		break;
 	case HW_BREAKPOINT_LEN_4:
-		info->len = SH_BREAKPOINT_LEN_4;
+		hw->len = SH_BREAKPOINT_LEN_4;
 		break;
 	case HW_BREAKPOINT_LEN_8:
-		info->len = SH_BREAKPOINT_LEN_8;
+		hw->len = SH_BREAKPOINT_LEN_8;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_R:
-		info->type = SH_BREAKPOINT_READ;
+		hw->type = SH_BREAKPOINT_READ;
 		break;
 	case HW_BREAKPOINT_W:
-		info->type = SH_BREAKPOINT_WRITE;
+		hw->type = SH_BREAKPOINT_WRITE;
 		break;
 	case HW_BREAKPOINT_W | HW_BREAKPOINT_R:
-		info->type = SH_BREAKPOINT_RW;
+		hw->type = SH_BREAKPOINT_RW;
 		break;
 	default:
 		return -EINVAL;
@@ -218,19 +218,20 @@ static int arch_build_bp_info(struct perf_event *bp)
 /*
  * Validate the arch-specific HW Breakpoint register settings
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	unsigned int align;
 	int ret;
 
-	ret = arch_build_bp_info(bp);
+	ret = arch_build_bp_info(bp, attr, hw);
 	if (ret)
 		return ret;
 
 	ret = -EINVAL;
 
-	switch (info->len) {
+	switch (hw->len) {
 	case SH_BREAKPOINT_LEN_1:
 		align = 0;
 		break;
@@ -251,7 +252,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * Check that the low-order bits of the address are appropriate
 	 * for the alignment implied by len.
 	 */
-	if (info->address & align)
+	if (hw->address & align)
 		return -EINVAL;
 
 	return 0;
-- 
2.7.4

