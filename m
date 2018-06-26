Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D0C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390E226477
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 03:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWqDtBpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 390E226477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965463AbeFZDAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 23:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:33252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965415AbeFZDAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 23:00:10 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2B22647D;
        Tue, 26 Jun 2018 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529982010;
        bh=zX6RcTmcOcwCkKcm1N9cd3h4nHEFPeGcv46T/OgOz0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWqDtBpkfItedSnNh3Z8QlI4vkEMLMdwFq6d8RgN3ELDdKLREY4m/Fb0WGQusBK2u
         vzN7hkchQfBaql1YIXbvSyZzL8uKzpweaQw85Fizr5Fkjvo7slh3h5ZmLR13Lp1KrO
         KcFZBC9ifb53rwBcp6/RMrKXSvkUeUOaaKuPDrXY=
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
Subject: [PATCH 09/12] xtensa: Implement hw_breakpoint_arch_parse()
Date:   Tue, 26 Jun 2018 04:58:56 +0200
Message-Id: <1529981939-8231-10-git-send-email-frederic@kernel.org>
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
 arch/xtensa/include/asm/hw_breakpoint.h |  6 +++++-
 arch/xtensa/kernel/hw_breakpoint.c      | 33 ++++++++++++---------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
index 2525bf6..f347c21 100644
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -30,13 +30,17 @@ struct arch_hw_breakpoint {
 	u16 type;
 };
 
+struct perf_event_attr;
 struct perf_event;
 struct pt_regs;
 struct task_struct;
 
 int hw_breakpoint_slots(int type);
 int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-int arch_validate_hwbkpt_settings(struct perf_event *bp);
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data);
 
diff --git a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
index 6e34c38..c2e387c 100644
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -47,50 +47,41 @@ int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw)
 /*
  * Construct an arch_hw_breakpoint from a perf_event.
  */
-static int arch_build_bp_info(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-
 	/* Type */
-	switch (bp->attr.bp_type) {
+	switch (attr->bp_type) {
 	case HW_BREAKPOINT_X:
-		info->type = XTENSA_BREAKPOINT_EXECUTE;
+		hw->type = XTENSA_BREAKPOINT_EXECUTE;
 		break;
 	case HW_BREAKPOINT_R:
-		info->type = XTENSA_BREAKPOINT_LOAD;
+		hw->type = XTENSA_BREAKPOINT_LOAD;
 		break;
 	case HW_BREAKPOINT_W:
-		info->type = XTENSA_BREAKPOINT_STORE;
+		hw->type = XTENSA_BREAKPOINT_STORE;
 		break;
 	case HW_BREAKPOINT_RW:
-		info->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
+		hw->type = XTENSA_BREAKPOINT_LOAD | XTENSA_BREAKPOINT_STORE;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	/* Len */
-	info->len = bp->attr.bp_len;
-	if (info->len < 1 || info->len > 64 || !is_power_of_2(info->len))
+	hw->len = attr->bp_len;
+	if (hw->len < 1 || hw->len > 64 || !is_power_of_2(hw->len))
 		return -EINVAL;
 
 	/* Address */
-	info->address = bp->attr.bp_addr;
-	if (info->address & (info->len - 1))
+	hw->address = attr->bp_addr;
+	if (hw->address & (hw->len - 1))
 		return -EINVAL;
 
 	return 0;
 }
 
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
-{
-	int ret;
-
-	/* Build the arch_hw_breakpoint. */
-	ret = arch_build_bp_info(bp);
-	return ret;
-}
-
 int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 				    unsigned long val, void *data)
 {
-- 
2.7.4

