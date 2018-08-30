Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8FFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE8420837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVF+g8T5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE8420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeH3WI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:08:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34562 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeH3WIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:08:51 -0400
Received: by mail-lj1-f193.google.com with SMTP id f8-v6so8019663ljk.1;
        Thu, 30 Aug 2018 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8oMFGxXF6QUlJj5F31ofFC/byB4gOQFq079DGk4vXTU=;
        b=WVF+g8T56Wa5yvSO7+HtBo/1wWJw2I+/Gt1i4ISB6wcx6pPaYrW5Mk5YrslapLh1XV
         RoyXYDloAFZb4EYqwmDJV4M9Ui7vvFW4LKb1oSO031/VQq8XnI0vkKc3JjXOW+rDCoG0
         GRehMi0xhBYoBo2jet0h/k5GwJnak7lPjYSa8IQgPwQgWh2YDuIFmGQ96colrthjlnzO
         GdSNp5ZkszVDbqJYTsUr2yl+iGb5uwyHrTeY6ILIbxWsWnQu15oOzG3OEh5F2rk4iKoX
         yXTZJPGfzsfFhxAFS8D1PLzYbiJvh2KBz9TLr5Ug7OqXo2idlqv9fS/uX+hLWKlt/fpd
         R/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8oMFGxXF6QUlJj5F31ofFC/byB4gOQFq079DGk4vXTU=;
        b=MYy7mtMqZpUNCrOgMaVR21Q7Q0+ZDHuL+CN5E0TRLUdtwHKKcCiGlge0StTwgcwRAu
         njd0m6Me7T50hulweio5oUbdQdEL9kjCwWPdB+M3tbDnXi1HRK39sJpBSYve/ESZbNuE
         GRE33crrtYXQcUGhoT5bDscbyAhbE9j4khH4bys7A4Ix88ha4vXSYXJMJj7Ht+81cn4p
         FgBNzA3Qw6HaSzkhhObn3qvrnLJUeRynFYvyxvCr12GPCx1+XFR3jcEhla10mmZP78Ft
         Ni/hayAbDeZk6SSKZ36839Or5U0Ikoq9tiHZTf14WwsX2UxgQB3qNpqeJwCvYfDaZGzb
         JbyA==
X-Gm-Message-State: APzg51BTVvzCgxDU+m/7PLgUS6Pj8rbyzYbVjxEbUE32irJwUUm1Exhy
        XyoAJvJ3oADL94rZSBIg+SY=
X-Google-Smtp-Source: ANB0VdbuSB/JaEZO4HXFI+IdiQJOsLmtRkKAAAwzNcz8e2DHekyQh9V3BpF4V53XDh+4HW8SBgCNaw==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr7864981ljj.103.1535652329646;
        Thu, 30 Aug 2018 11:05:29 -0700 (PDT)
Received: from localhost.localdomain (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1420789lfy.87.2018.08.30.11.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:05:29 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] ARM: tegra: Add firmware calls required for suspend-resume
Date:   Thu, 30 Aug 2018 21:04:21 +0300
Message-Id: <20180830180421.6415-9-digetx@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830180421.6415-1-digetx@gmail.com>
References: <20180830180421.6415-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to resume CPU from suspend via trusted Foundations firmware,
the LP1/LP2 boot vectors shall be specified using the firmware calls.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/pm.c            |  7 ++++++
 arch/arm/mach-tegra/reset-handler.S | 33 +++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 66c8cd63dd86..12341ffabb99 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -33,6 +33,7 @@
 #include <soc/tegra/pmc.h>
 
 #include <asm/cacheflush.h>
+#include <asm/firmware.h>
 #include <asm/idmap.h>
 #include <asm/proc-fns.h>
 #include <asm/smp_plat.h>
@@ -150,6 +151,10 @@ bool tegra_set_cpu_in_lp2(void)
 		tegra20_cpu_set_resettable_soon();
 
 	spin_unlock(&tegra_lp2_lock);
+
+	if (last_cpu)
+		call_firmware_op(prepare_idle, TF_PM_MODE_LP2);
+
 	return last_cpu;
 }
 
@@ -316,6 +321,8 @@ static void tegra_suspend_enter_lp1(void)
 		tegra_lp1_iram.start_addr, iram_save_size);
 
 	*((u32 *)tegra_cpu_lp1_mask) = 1;
+
+	call_firmware_op(prepare_idle, TF_PM_MODE_LP1);
 }
 
 static void tegra_suspend_exit_lp1(void)
diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 4973ea053bd7..0e208b2e246e 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -69,7 +69,7 @@ ENTRY(tegra_resume)
 
 	mov32	r9, 0xc09
 	cmp	r8, r9
-	bne	end_ca9_scu_resume
+	bne	end_ca9_scu_l2_resume
 #ifdef CONFIG_HAVE_ARM_SCU
 	/* enable SCU */
 	mov32	r0, TEGRA_ARM_PERIF_BASE
@@ -77,14 +77,43 @@ ENTRY(tegra_resume)
 	orr	r1, r1, #1
 	str	r1, [r0]
 #endif
+	bl	tegra_resume_trusted_foundations
 
-end_ca9_scu_resume:
+#ifdef CONFIG_CACHE_L2X0
+	/* L2 cache resume & re-enable */
+	bleq	l2c310_early_resume		@ No, resume cache early
+#endif
+end_ca9_scu_l2_resume:
 	mov32	r9, 0xc0f
 	cmp	r8, r9
 	bleq	tegra_init_l2_for_a15
 
 	b	cpu_resume
 ENDPROC(tegra_resume)
+
+/*
+ *	tegra_resume_trusted_foundations
+ *
+ *	  Trusted Foundations firmware initialization.
+ *
+ *	Doesn't return if firmware presents.
+ *	Corrupted registers: r1, r2
+ */
+ENTRY(tegra_resume_trusted_foundations)
+	/* Check whether Trusted Foundations firmware presents. */
+	mov32	r2, TEGRA_IRAM_BASE + TEGRA_IRAM_RESET_HANDLER_OFFSET
+	ldr	r1, =__tegra_cpu_reset_handler_data_offset + \
+							RESET_DATA(TF_PRESENT)
+	ldr	r1, [r2, r1]
+	cmp	r1, #0
+	reteq	lr
+
+ .arch_extension sec
+	/* First call after suspend wakes firmware. No arguments required. */
+	smc	#0
+
+	b	cpu_resume
+ENDPROC(tegra_resume_trusted_foundations)
 #endif
 
 	.align L1_CACHE_SHIFT
-- 
2.18.0

