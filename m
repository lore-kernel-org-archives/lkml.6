Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A258BECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6727E214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 10:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6727E214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeIQQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 12:09:22 -0400
Received: from foss.arm.com ([217.140.101.70]:56462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728115AbeIQQJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 12:09:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCAC015BF;
        Mon, 17 Sep 2018 03:42:33 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51D793F5BD;
        Mon, 17 Sep 2018 03:42:31 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, will.deacon@arm.com,
        catalin.marinas@arm.com, james.morse@arm.com, dave.martin@arm.com,
        julien.grall@arm.com, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com
Subject: [PATCH v5 04/18] arm64: Add a helper for PARange to physical shift conversion
Date:   Mon, 17 Sep 2018 11:41:26 +0100
Message-Id: <20180917104144.19188-5-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917104144.19188-1-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, ID_AA64MMFR0_EL1.PARange encodes the maximum Physical
Address range supported by the CPU. Add a helper to decode this
to actual physical shift. If we hit an unallocated value, return
the maximum range supported by the kernel.
This will be used by KVM to set the VTCR_EL2.T0SZ, as it
is about to move its place. Having this helper keeps the code
movement cleaner.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Christoffer Dall <cdall@kernel.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V4:
 - Add a comment on the result for unknown values.
---
 arch/arm64/include/asm/cpufeature.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 1717ba1db35d..072cc1c970c2 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -530,6 +530,26 @@ void arm64_set_ssbd_mitigation(bool state);
 static inline void arm64_set_ssbd_mitigation(bool state) {}
 #endif
 
+static inline u32 id_aa64mmfr0_parange_to_phys_shift(int parange)
+{
+	switch (parange) {
+	case 0: return 32;
+	case 1: return 36;
+	case 2: return 40;
+	case 3: return 42;
+	case 4: return 44;
+	case 5: return 48;
+	case 6: return 52;
+	/*
+	 * A future PE could use a value unknown to the kernel.
+	 * However, by the "D10.1.4 Principles of the ID scheme
+	 * for fields in ID registers", ARM DDI 0487C.a, any new
+	 * value is guaranteed to be higher than what we know already.
+	 * As a safe limit, we return the limit supported by the kernel.
+	 */
+	default: return CONFIG_ARM64_PA_BITS;
+	}
+}
 #endif /* __ASSEMBLY__ */
 
 #endif
-- 
2.19.0

