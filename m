Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281B7C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E587420C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB/rvm4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E587420C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeJIBsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbeJIBsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:48:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A3D620C0A;
        Mon,  8 Oct 2018 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023752;
        bh=dhdFRbR7bYS1h7uBw/6hGCfMnBJqogwbjVwo17E7dZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dB/rvm4BE6ncHWcXqxcp73+HJOR8dks+tIM0PhTjyIb9yeV0U3fubVK7Mrec9EPZY
         dBGXDLyCox/bQXuGT//XB5R/ncjP1LcyNzCz7BquRiB4R7TAwtUxOk2ZNmiTje45eD
         PhoMed0WHC0lDH197LbK93u4eTxWThTt9dhqhFyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yury Norov <ynorov@caviumnetworks.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 4.4 071/113] arm64: cpufeature: Track 32bit EL0 support
Date:   Mon,  8 Oct 2018 20:31:12 +0200
Message-Id: <20181008175534.869402013@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

commit 042446a31e3803d81c7e618dd80928dc3dce70c5 upstream.

Add cpu_hwcap bit for keeping track of the support for 32bit EL0.

Tested-by: Yury Norov <ynorov@caviumnetworks.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cpufeature.h |    8 +++++++-
 arch/arm64/include/asm/sysreg.h     |    1 +
 arch/arm64/kernel/cpufeature.c      |    8 ++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -31,8 +31,9 @@
 #define ARM64_WORKAROUND_CAVIUM_23154		6
 #define ARM64_WORKAROUND_834220			7
 #define ARM64_WORKAROUND_CAVIUM_27456		8
+#define ARM64_HAS_32BIT_EL0			9
 
-#define ARM64_NCAPS				9
+#define ARM64_NCAPS				10
 
 #ifndef __ASSEMBLY__
 
@@ -180,6 +181,11 @@ static inline bool cpu_supports_mixed_en
 	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
 }
 
+static inline bool system_supports_32bit_el0(void)
+{
+	return cpus_have_cap(ARM64_HAS_32BIT_EL0);
+}
+
 static inline bool system_supports_mixed_endian_el0(void)
 {
 	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -109,6 +109,7 @@
 #define ID_AA64PFR0_ASIMD_SUPPORTED	0x0
 #define ID_AA64PFR0_EL1_64BIT_ONLY	0x1
 #define ID_AA64PFR0_EL0_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
 
 /* id_aa64mmfr0 */
 #define ID_AA64MMFR0_TGRAN4_SHIFT	28
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -653,6 +653,14 @@ static const struct arm64_cpu_capabiliti
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+	{
+		.desc = "32-bit EL0 Support",
+		.capability = ARM64_HAS_32BIT_EL0,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_EL0_SHIFT,
+		.min_field_value = ID_AA64PFR0_EL0_32BIT_64BIT,
+	},
 	{},
 };
 


