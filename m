Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164000AbeE1NID (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163910AbeE1Kv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 238/496] arm64: Relax ARM_SMCCC_ARCH_WORKAROUND_1 discovery
Date: Mon, 28 May 2018 12:00:23 +0200
Message-Id: <20180528100329.934895415@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit e21da1c992007594d391e7b301779cf30f438691 ]

A recent update to the ARM SMCCC ARCH_WORKAROUND_1 specification
allows firmware to return a non zero, positive value to describe
that although the mitigation is implemented at the higher exception
level, the CPU on which the call is made is not affected.

Let's relax the check on the return value from ARCH_WORKAROUND_1
so that we only error out if the returned value is negative.

Fixes: b092201e0020 ("arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support")
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/cpu_errata.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -178,7 +178,7 @@ static int enable_smccc_arch_workaround_
 	case PSCI_CONDUIT_HVC:
 		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if (res.a0)
+		if ((int)res.a0 < 0)
 			return 0;
 		cb = call_hvc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_hvc_start;
@@ -188,7 +188,7 @@ static int enable_smccc_arch_workaround_
 	case PSCI_CONDUIT_SMC:
 		arm_smccc_1_1_smc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
 				  ARM_SMCCC_ARCH_WORKAROUND_1, &res);
-		if (res.a0)
+		if ((int)res.a0 < 0)
 			return 0;
 		cb = call_smc_arch_workaround_1;
 		smccc_start = __smccc_workaround_1_smc_start;
