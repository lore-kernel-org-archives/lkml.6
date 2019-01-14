Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2854C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDF820656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfANKfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:35:44 -0500
Received: from foss.arm.com ([217.140.101.70]:58464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfANKfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:35:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48F9C1596;
        Mon, 14 Jan 2019 02:35:41 -0800 (PST)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.196.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398603F5BD;
        Mon, 14 Jan 2019 02:35:40 -0800 (PST)
From:   Marc Zyngier <marc.zyngier@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 2/2] arm64: Use firmware to detect CPUs that are not affected by Spectre-v2
Date:   Mon, 14 Jan 2019 10:35:28 +0000
Message-Id: <20190114103528.52931-3-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114103528.52931-1-marc.zyngier@arm.com>
References: <20190114103528.52931-1-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMCCC ARCH_WORKAROUND_1 service can indicate that although the
firmware knows about the Spectre-v2 mitigation, this particular
CPU is not vulnerable, and it is thus not necessary to call
the firmware on this CPU.

Let's use this information to our benefit.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kernel/cpu_errata.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 145f8b5d093d..b44f87e7360d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -231,26 +231,38 @@ static int detect_harden_bp_fw(void)
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0) {
+		switch ((int)res.a0) {
+		case 1:
+			/* Firmware says we're just fine */
+			return 0;
+		case 0:
+			cb = call_hvc_arch_workaround_1;
+			/* This is a guest, no need to patch KVM vectors */
+			smccc_start = NULL;
+			smccc_end = NULL;
+			break;
+		default:
 			__hardenbp_enab = false;
 			return -1;
 		}
-		cb = call_hvc_arch_workaround_1;
-		/* This is a guest, no need to patch KVM vectors */
-		smccc_start = NULL;
-		smccc_end = NULL;
 		break;
 
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if ((int)res.a0 < 0) {
+		switch ((int)res.a0) {
+		case 1:
+			/* Firmware says we're just fine */
+			return 0;
+		case 0:
+			cb = call_smc_arch_workaround_1;
+			smccc_start = __smccc_workaround_1_smc_start;
+			smccc_end = __smccc_workaround_1_smc_end;
+			break;
+		default:
 			__hardenbp_enab = false;
 			return -1;
 		}
-		cb = call_smc_arch_workaround_1;
-		smccc_start = __smccc_workaround_1_smc_start;
-		smccc_end = __smccc_workaround_1_smc_end;
 		break;
 
 	default:
-- 
2.20.1

