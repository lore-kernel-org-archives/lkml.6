Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1867C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8B2219FC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 16:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Uj35dlCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392292AbeLVQxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 11:53:48 -0500
Received: from condef-03.nifty.com ([202.248.20.68]:21017 "EHLO
        condef-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbeLVQxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 11:53:48 -0500
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Dec 2018 11:53:45 EST
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-03.nifty.com with ESMTP id wBM9sMrH011935;
        Sat, 22 Dec 2018 18:54:22 +0900
Received: from grover.tkatk1.zaq.ne.jp (zaqdadce369.zaq.ne.jp [218.220.227.105]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id wBM9p7DO014613;
        Sat, 22 Dec 2018 18:51:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com wBM9p7DO014613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1545472270;
        bh=wiIUzgc+fysfmDuxKAkmwaprsNIQhVxjxb/GXgFvzRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uj35dlCjpYUATghrAgk9dVF7mNbFFvEQ2gVPCbncqlT35c5N6+OIC2oU4Mt58orHo
         3f74sas/9hAo23IUa4hcwuvxME27/oaW92kP+oPV1eVeR1dSuH1GtD84aZXyWEYISe
         YupW5gqHOpRi3nDSJ/F/AYxw6xyG7ppPSInlYJeWUafCUn6nCcDi0rSUsnJsIxbYWr
         qkbAro2J2Ha3eWvKF93z8g/vCOUcP2CgmWMzDNhkkvITA+jsQM7gL2m+S6nIaI6C79
         jgUpEVzFZPikxvZcz341HYrPX19aPt4et2ICtNVZxR/pAdZnaq8+VsaMw40mIXrGpe
         h55lbS8smdkzw==
X-Nifty-SrcIP: [218.220.227.105]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Daniel Borkmann <daniel@iogearbox.net>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-um@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ingo Molnar <mingo@redhat.com>, linux-omap@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] treewide: add intermediate .s files to targets
Date:   Sat, 22 Dec 2018 18:50:34 +0900
Message-Id: <1545472235-12782-2-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
References: <1545472235-12782-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid unneeded recreation of these in the incremental build.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/mach-at91/Makefile         | 2 ++
 arch/arm/mach-omap2/Makefile        | 2 ++
 arch/ia64/kernel/Makefile           | 2 ++
 arch/x86/um/Makefile                | 1 +
 drivers/memory/Makefile.asm-offsets | 2 ++
 samples/bpf/Makefile                | 1 +
 6 files changed, 10 insertions(+)

diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index f87066b..31b61f0 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -23,3 +23,5 @@ include/generated/at91_pm_data-offsets.h: arch/arm/mach-at91/pm_data-offsets.s F
 	$(call filechk,offsets,__PM_DATA_OFFSETS_H__)
 
 arch/arm/mach-at91/pm_suspend.o: include/generated/at91_pm_data-offsets.h
+
+targets += pm_data-offsets.s
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55c482c..4afdf56 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -240,3 +240,5 @@ include/generated/ti-pm-asm-offsets.h: arch/arm/mach-omap2/pm-asm-offsets.s FORC
 	$(call filechk,offsets,__TI_PM_ASM_OFFSETS_H__)
 
 $(obj)/sleep33xx.o $(obj)/sleep43xx.o: include/generated/ti-pm-asm-offsets.h
+
+targets += pm-asm-offsets.s
diff --git a/arch/ia64/kernel/Makefile b/arch/ia64/kernel/Makefile
index 7372d99..4ba0514 100644
--- a/arch/ia64/kernel/Makefile
+++ b/arch/ia64/kernel/Makefile
@@ -52,3 +52,5 @@ include $(src)/Makefile.gate
 
 include/generated/nr-irqs.h: arch/$(SRCARCH)/kernel/nr-irqs.s FORCE
 	$(call filechk,offsets,__ASM_NR_IRQS_H__)
+
+targets += nr-irqs.s
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 1792464..2d686ae 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -38,6 +38,7 @@ USER_OBJS := bugs_$(BITS).o ptrace_user.o fault.o
 
 $(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	-Iarch/x86/include/generated
+targets += user-offsets.s
 
 include/generated/user_constants.h: $(obj)/user-offsets.s
 	$(call filechk,offsets,__USER_CONSTANT_H__)
diff --git a/drivers/memory/Makefile.asm-offsets b/drivers/memory/Makefile.asm-offsets
index f968dfa..0447e17 100644
--- a/drivers/memory/Makefile.asm-offsets
+++ b/drivers/memory/Makefile.asm-offsets
@@ -1,2 +1,4 @@
 include/generated/ti-emif-asm-offsets.h: drivers/memory/emif-asm-offsets.s FORCE
 	$(call filechk,offsets,__TI_EMIF_ASM_OFFSETS_H__)
+
+targets += emif-asm-offsets.s
diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 100a49d..82d5a38 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -230,6 +230,7 @@ $(LIBBPF): FORCE
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
 
+targets += syscall_nrs.s
 clean-files += syscall_nrs.h
 
 FORCE:
-- 
2.7.4

