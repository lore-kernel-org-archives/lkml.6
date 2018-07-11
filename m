Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D55C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CD3208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9CD3208E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbeGKOBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:01:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36346 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388376AbeGKOBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:01:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4456C16A3;
        Wed, 11 Jul 2018 06:57:23 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 343533F5B1;
        Wed, 11 Jul 2018 06:57:21 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will.deacon@arm.com
Cc:     catalin.marinas@arm.com, dave.martin@arm.com, hch@infradead.org,
        james.morse@arm.com, linux@dominikbrodowski.net,
        linux-fsdevel@vger.kernel.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, viro@zeniv.linux.org.uk
Subject: [PATCHv5 04/21] arm64: kill change_cpacr()
Date:   Wed, 11 Jul 2018 14:56:39 +0100
Message-Id: <20180711135656.20670-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180711135656.20670-1-mark.rutland@arm.com>
References: <20180711135656.20670-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have sysreg_clear_set(), we can use this instead of
change_cpacr().

Note that the order of the set and clear arguments differs between
change_cpacr() and sysreg_clear_set(), so these are flipped as part of
the conversion. Also, sve_user_enable() redundantly clears
CPACR_EL1_ZEN_EL0EN before setting it; this is removed for clarity.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Dave Martin <dave.martin@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 84c68b14f1b2..a98a7f96aff1 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -159,23 +159,14 @@ static void sve_free(struct task_struct *task)
 	__sve_free(task);
 }
 
-static void change_cpacr(u64 val, u64 mask)
-{
-	u64 cpacr = read_sysreg(CPACR_EL1);
-	u64 new = (cpacr & ~mask) | val;
-
-	if (new != cpacr)
-		write_sysreg(new, CPACR_EL1);
-}
-
 static void sve_user_disable(void)
 {
-	change_cpacr(0, CPACR_EL1_ZEN_EL0EN);
+	sysreg_clear_set(cpacr_el1, CPACR_EL1_ZEN_EL0EN, 0);
 }
 
 static void sve_user_enable(void)
 {
-	change_cpacr(CPACR_EL1_ZEN_EL0EN, CPACR_EL1_ZEN_EL0EN);
+	sysreg_clear_set(cpacr_el1, 0, CPACR_EL1_ZEN_EL0EN);
 }
 
 /*
-- 
2.11.0

