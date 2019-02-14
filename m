Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079542229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QZegPqan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439235AbfBNOba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:31:30 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58298 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436802AbfBNOba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:31:30 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190214143127euoutp023cd980b16cf262fd43e5de99123a1999~DQXmmRQ_m3010730107euoutp02H;
        Thu, 14 Feb 2019 14:31:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190214143127euoutp023cd980b16cf262fd43e5de99123a1999~DQXmmRQ_m3010730107euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550154687;
        bh=vlYj+X3X9RwnfDOOKJf/4CgLBXV7Gi+2g7C3ppiBsIM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QZegPqanX4UlNXLMZ47eTy4aShF+MP0rgHsj0JWPXwawqY+RG0oxeabITwcakdXQH
         MnxdAxCjYEvu/XfGPh/7Sjc4UuP45KBf+3kqNtIR6dPzUvgyvh7NcbouPfnrRtWb2L
         i6vGMARnaybZXu+5n3vu4UOeNdORKAz/EsZqOj7c=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214143126eucas1p1d1cdb9383f1793632e18628f6136e82e~DQXmG9Faz0421904219eucas1p1x;
        Thu, 14 Feb 2019 14:31:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 5B.EB.04294.EBB756C5; Thu, 14
        Feb 2019 14:31:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190214143126eucas1p126506139ef72c1685654c8dac8957b3d~DQXldHN9N0535005350eucas1p1B;
        Thu, 14 Feb 2019 14:31:26 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-52-5c657bbe0303
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7E.EA.04128.EBB756C5; Thu, 14
        Feb 2019 14:31:26 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PMX00KTV706CB50@eusync1.samsung.com>;
        Thu, 14 Feb 2019 14:31:26 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marian Mihailescu <mihailescu2m@gmail.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>
Subject: [PATCH] ARM: pm: fix HYP/SVC mode mismatch when MCPM is used
Date:   Thu, 14 Feb 2019 15:31:14 +0100
Message-id: <20190214143114.24356-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsWy7djPc7r7qlNjDI63a1lsnLGe1eJn+xYm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67xfppP1ktPj37x25xqX8ik8WMyS/ZHLg9Ll+7
        yOzx/kYru8fOWXfZPTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJWx
        aPNc5oJ2sYq1164yNjCuF+pi5OSQEDCROLeol62LkYtDSGAFo8S0O8cZIZzPjBKLJk9jh6ma
        P2U/VNUyRommhauYIJwGJonTSx6zgVSxCRhKdL3tArNFBNwk/q07BNbBLNDOLPHiyXSwhLCA
        q0Rb501mEJtFQFWia8FOFhCbV8BWonVqKxvEOnmJ1RsOMIM0SwjMYZO4uu4BE0TCReLJjwuM
        ELaMxOXJ3SwQRc2MEu0zZrFDOD2MElvn7IAaZS1x+PhFVhCbWYBPYtK26UBjOYDivBIdbdAg
        8JDYtmwp2AIhgViJ793vmSYwii9gZFjFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRGJmn
        /x3/soNx15+kQ4wCHIxKPLwrMlJjhFgTy4orcw8xSnAwK4nw+lUChXhTEiurUovy44tKc1KL
        DzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTBy/pxygYPp3f+ci3sjTlf8nz2F70V7
        /SLeCW5xd57y/F/pn9Ts2N13dQczH0PEo7dpJt02YZFHbi85u0uh8NGjyNoprO8Zd+54rK9s
        ed5Vzfe8lp1O3uNjFzX4T9sHWrwI1LizYea6Dc5lETtuPOEUEF64pHhbYYW/ltbOP741W2Sb
        lIxuOe5TYinOSDTUYi4qTgQAMa8JfMgCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprELMWRmVeSWpSXmKPExsVy+t/xy7r7qlNjDA52clpsnLGe1eJn+xYm
        i/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67xfppP1ktPj37x25xqX8ik8WMyS/ZHLg9Ll+7
        yOzx/kYru8fOWXfZPTat6mTzuHNtD5vH5iX1Hn1bVjF6fN4kF8ARxWWTkpqTWZZapG+XwJWx
        aPNc5oJ2sYq1164yNjCuF+pi5OSQEDCRmD9lP1sXIxeHkMASRonvk1cyQjhNTBIb9v5jBqli
        EzCU6HrbxQZiiwi4Sfxbdwisg1mgk1li3vQ9LCAJYQFXibbOm2ANLAKqEl0LdoLFeQVsJVqn
        trJBrJOXWL3hAPMERq4FjAyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAkNq27GfW3Ywdr0L
        PsQowMGoxMO7IiM1Rog1say4MvcQowQHs5IIr18lUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
        eYPKKCGB9MSS1OzU1ILUIpgsEwenVAOjHFtIS+PUZ3fSv14S+2tSmcGoEPpe3WT3FiW1ZRZi
        M1ev+hm4teBI3cFzp1yVSi9bCc3n7zl7ZOfXxOMdu+w101d8e/xossKksPYuPkMrpjMK89Yx
        HjlmJF4TGWLH8rL4eW1OyLMbSrazPlgF5mb3bas8cXF+tcrE1rfH4vIW+hRsOjib40C1Ektx
        RqKhFnNRcSIAFgIjvyUCAAA=
X-CMS-MailID: 20190214143126eucas1p126506139ef72c1685654c8dac8957b3d
CMS-TYPE: 201P
X-CMS-RootMailID: 20190214143126eucas1p126506139ef72c1685654c8dac8957b3d
References: <CGME20190214143126eucas1p126506139ef72c1685654c8dac8957b3d@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCPM does a soft reset of the CPUs and uses common cpu_resume() routine to
perform low-level platform initialization. This results in a try to install
HYP stubs for the second time for each CPU and results in false HYP/SVC
mode mismatch detection. The HYP stubs are already installed at the
beginning of the kernel initialization on the boot CPU (head.S) or in the
secondary_startup() for other CPUs. To fix this issue MCPM code should use
a cpu_resume() routine without HYP stubs installation.

This change fixes HYP/SVC mode mismatch on Samsung Exynos5422-based Odroid
XU3/XU4/HC1 boards.

Fixes: 3721924c8154 ("ARM: 8081/1: MCPM: provide infrastructure to allow for MCPM loopback")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/common/mcpm_entry.c   |  2 +-
 arch/arm/include/asm/suspend.h |  1 +
 arch/arm/kernel/sleep.S        | 11 +++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/mcpm_entry.c b/arch/arm/common/mcpm_entry.c
index ad574d20415c..1b1b82b37ce0 100644
--- a/arch/arm/common/mcpm_entry.c
+++ b/arch/arm/common/mcpm_entry.c
@@ -381,7 +381,7 @@ static int __init nocache_trampoline(unsigned long _arg)
 	unsigned int cluster = MPIDR_AFFINITY_LEVEL(mpidr, 1);
 	phys_reset_t phys_reset;
 
-	mcpm_set_entry_vector(cpu, cluster, cpu_resume);
+	mcpm_set_entry_vector(cpu, cluster, cpu_resume_no_hyp);
 	setup_mm_for_reboot();
 
 	__mcpm_cpu_going_down(cpu, cluster);
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
index 452bbdcbcc83..506314265c6f 100644
--- a/arch/arm/include/asm/suspend.h
+++ b/arch/arm/include/asm/suspend.h
@@ -10,6 +10,7 @@ struct sleep_save_sp {
 };
 
 extern void cpu_resume(void);
+extern void cpu_resume_no_hyp(void);
 extern void cpu_resume_arm(void);
 extern int cpu_suspend(unsigned long, int (*)(unsigned long));
 
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index a8257fc9cf2a..b856d183691e 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -122,6 +122,11 @@ ENDPROC(cpu_resume_after_mmu)
 
 #ifdef CONFIG_MMU
 	.arm
+#ifdef CONFIG_MCPM
+ENTRY(cpu_resume_no_hyp)
+ARM_BE8(setend be)			@ ensure we are in BE mode
+	b	0f
+#endif
 ENTRY(cpu_resume_arm)
  THUMB(	badr	r9, 1f		)	@ Kernel is entered in ARM.
  THUMB(	bx	r9		)	@ If this is a Thumb-2 kernel,
@@ -135,6 +140,9 @@ ARM_BE8(setend be)			@ ensure we are in BE mode
 	bl	__hyp_stub_install_secondary
 #endif
 	safe_svcmode_maskall r1
+#ifdef CONFIG_MCPM
+0:
+#endif
 	mov	r1, #0
 	ALT_SMP(mrc p15, 0, r0, c0, c0, 5)
 	ALT_UP_B(1f)
@@ -163,6 +171,9 @@ ENDPROC(cpu_resume)
 
 #ifdef CONFIG_MMU
 ENDPROC(cpu_resume_arm)
+#endif
+#ifdef CONFIG_MCPM
+ENDPROC(cpu_resume_no_hyp)
 #endif
 
 	.align 2
-- 
2.17.1

