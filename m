Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBFEC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34EA257C6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 02:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCvNu0o8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A34EA257C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965371AbeFZC7r (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 22:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965346AbeFZC7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 22:59:41 -0400
Received: from localhost.localdomain (h2133.porttelecom.ru [193.189.69.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0256326472;
        Tue, 26 Jun 2018 02:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529981981;
        bh=4iYPws51uEm4iyQRRTUaKoWVoqGDpRMVKH2DGCkeHzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jCvNu0o8w+tavEAMkwUcGARVsf37EtlCYCJOpdAV85GHfjtH5DusBIMOn6ZQeypKz
         SQaqbfSfKwGKpFQ3dU2yB7XMhOGFv9Tn9DaVHxxZP8pzDxoR4GlXmt8pyRAjUr4bd7
         nD5brvGaX9EUXSWnZ93Ih52iVIm7aTGiMPkr0cHU=
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
Subject: [PATCH 04/12] powerpc: Implement hw_breakpoint_arch_parse()
Date:   Tue, 26 Jun 2018 04:58:51 +0200
Message-Id: <1529981939-8231-5-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529981939-8231-1-git-send-email-frederic@kernel.org>
References: <1529981939-8231-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
that clumsily mixes up architecture validation and commit

Acked-by: Michael Ellerman <mpe@ellerman.id.au>
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
 arch/powerpc/include/asm/hw_breakpoint.h |  6 ++++-
 arch/powerpc/kernel/hw_breakpoint.c      | 41 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 4d0b1bf..38ae180 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -52,6 +52,7 @@ struct arch_hw_breakpoint {
 #include <asm/reg.h>
 #include <asm/debug.h>
 
+struct perf_event_attr;
 struct perf_event;
 struct pmu;
 struct perf_sample_data;
@@ -61,7 +62,10 @@ struct perf_sample_data;
 extern int hw_breakpoint_slots(int type);
 extern int arch_bp_generic_fields(int type, int *gen_bp_type);
 extern int arch_check_bp_in_kernelspace(struct arch_hw_breakpoint *hw);
-extern int arch_validate_hwbkpt_settings(struct perf_event *bp);
+extern int hw_breakpoint_arch_parse(struct perf_event *bp,
+				    const struct perf_event_attr *attr,
+				    struct arch_hw_breakpoint *hw);
+#define hw_breakpoint_arch_parse hw_breakpoint_arch_parse
 extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 						unsigned long val, void *data);
 int arch_install_hw_breakpoint(struct perf_event *bp);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 899bcec..fec8a67 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -139,30 +139,31 @@ int arch_bp_generic_fields(int type, int *gen_bp_type)
 /*
  * Validate the arch-specific HW Breakpoint register settings
  */
-int arch_validate_hwbkpt_settings(struct perf_event *bp)
+int hw_breakpoint_arch_parse(struct perf_event *bp,
+			     const struct perf_event_attr *attr,
+			     struct arch_hw_breakpoint *hw)
 {
 	int ret = -EINVAL, length_max;
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
 	if (!bp)
 		return ret;
 
-	info->type = HW_BRK_TYPE_TRANSLATE;
-	if (bp->attr.bp_type & HW_BREAKPOINT_R)
-		info->type |= HW_BRK_TYPE_READ;
-	if (bp->attr.bp_type & HW_BREAKPOINT_W)
-		info->type |= HW_BRK_TYPE_WRITE;
-	if (info->type == HW_BRK_TYPE_TRANSLATE)
+	hw->type = HW_BRK_TYPE_TRANSLATE;
+	if (attr->bp_type & HW_BREAKPOINT_R)
+		hw->type |= HW_BRK_TYPE_READ;
+	if (attr->bp_type & HW_BREAKPOINT_W)
+		hw->type |= HW_BRK_TYPE_WRITE;
+	if (hw->type == HW_BRK_TYPE_TRANSLATE)
 		/* must set alteast read or write */
 		return ret;
-	if (!(bp->attr.exclude_user))
-		info->type |= HW_BRK_TYPE_USER;
-	if (!(bp->attr.exclude_kernel))
-		info->type |= HW_BRK_TYPE_KERNEL;
-	if (!(bp->attr.exclude_hv))
-		info->type |= HW_BRK_TYPE_HYP;
-	info->address = bp->attr.bp_addr;
-	info->len = bp->attr.bp_len;
+	if (!attr->exclude_user)
+		hw->type |= HW_BRK_TYPE_USER;
+	if (!attr->exclude_kernel)
+		hw->type |= HW_BRK_TYPE_KERNEL;
+	if (!attr->exclude_hv)
+		hw->type |= HW_BRK_TYPE_HYP;
+	hw->address = attr->bp_addr;
+	hw->len = attr->bp_len;
 
 	/*
 	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
@@ -176,12 +177,12 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
-		if ((bp->attr.bp_addr >> 9) !=
-		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 9))
+		if ((attr->bp_addr >> 9) !=
+		    ((attr->bp_addr + attr->bp_len - 1) >> 9))
 			return -EINVAL;
 	}
-	if (info->len >
-	    (length_max - (info->address & HW_BREAKPOINT_ALIGN)))
+	if (hw->len >
+	    (length_max - (hw->address & HW_BREAKPOINT_ALIGN)))
 		return -EINVAL;
 	return 0;
 }
-- 
2.7.4

