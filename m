Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB6BC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A33F27DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A33F27DCE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965583AbeF2LRP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:17:15 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60366 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935996AbeF2LRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:17:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA68915AD;
        Fri, 29 Jun 2018 04:17:12 -0700 (PDT)
Received: from en101.cambridge.arm.com (en101.cambridge.arm.com [10.1.206.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 535DB3F266;
        Fri, 29 Jun 2018 04:17:10 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com,
        julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com,
        punit.agrawal@arm.com, qemu-devel@nongnu.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [kvmtool test PATCH 22/24] kvmtool: arm64: Add support for guest physical address size
Date:   Fri, 29 Jun 2018 12:15:42 +0100
Message-Id: <1530270944-11351-23-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an option to specify the physical address size used by this
VM.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arm/aarch64/include/kvm/kvm-config-arch.h | 5 ++++-
 arm/include/arm-common/kvm-config-arch.h  | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
index 04be43d..dabd22c 100644
--- a/arm/aarch64/include/kvm/kvm-config-arch.h
+++ b/arm/aarch64/include/kvm/kvm-config-arch.h
@@ -8,7 +8,10 @@
 			"Create PMUv3 device"),				\
 	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
 			"Specify random seed for Kernel Address Space "	\
-			"Layout Randomization (KASLR)"),
+			"Layout Randomization (KASLR)"),		\
+	OPT_INTEGER('\0', "phys-shift", &(cfg)->phys_shift,		\
+			"Specify maximum physical address size (not "	\
+			"the amount of memory)"),
 
 #include "arm-common/kvm-config-arch.h"
 
diff --git a/arm/include/arm-common/kvm-config-arch.h b/arm/include/arm-common/kvm-config-arch.h
index 6a196f1..e0b531e 100644
--- a/arm/include/arm-common/kvm-config-arch.h
+++ b/arm/include/arm-common/kvm-config-arch.h
@@ -11,6 +11,7 @@ struct kvm_config_arch {
 	bool		has_pmuv3;
 	u64		kaslr_seed;
 	enum irqchip_type irqchip;
+	int		phys_shift;
 };
 
 int irqchip_parser(const struct option *opt, const char *arg, int unset);
-- 
2.7.4

