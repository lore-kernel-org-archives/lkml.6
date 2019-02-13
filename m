Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 966F2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6ED206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRfj7dqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394869AbfBMVdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40509 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436800AbfBMVcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id j36so4456250qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lLS6GiZ4CUXJ8rZLEaclNEJmcH/KdjbjQyrYJi4C1Xc=;
        b=PRfj7dqkDYgvl5XUoxlfk1tlHRkWzgxQhq1sMVagMpNVzKlDR52K21Rjn/fawFuCaJ
         TuCb/U23JS3bvYI1GwVEoQjMYvlf7f0nHa0ddmLeeC7U9rZ4QGwd/lcXiLqxbxlN7phc
         T52SsYUsITCJ0JnbWKHIP8fYozOMpwtDihFjB01ItbUYZQEOqEK0Y6CS4isldusG5Q2T
         rgfxA/YbMeHUEZShZtMXHpdQvu3Uqrm0242LlOigdf0bFpFyQSmxm0Ry42RU2nB0o7XI
         jcdlcbh++VLX565AnURx4tiMzD0hlWdntZNSh/eXi+KhqR0aEktIGzTLu93g5HdPjhqr
         PXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lLS6GiZ4CUXJ8rZLEaclNEJmcH/KdjbjQyrYJi4C1Xc=;
        b=UhLYX0c9N2m59T7X92UmtjNz34BDRJffdkvUyRVQd62OjjI2Iqlr1ZKF2SPXLcHqrB
         AvKewD1GfZ/H4zq30pwnFg4ram2eNZOeD5Q/zYxlp8CPSm7H4V80hslWHfN7gA7EjE7r
         pD92ggqo4T1g8N6wihur2iwI7N8hFpvfNRuKxOZqeSaMpcNNaMiJojzwLzpsE0jllmvG
         JLyamtRyf1dhsgnCmK+CnCFmzs/bjkoN+LDzAc9uIAcCmbqW/gh5NHPO/0WiMgru5I4J
         HpuizDaFaSNmFjlAmdn/uhShMsAkzdw45JQuvwgYAwDAp+gC+POxBo8E+BpSGntlrMCD
         Q2ig==
X-Gm-Message-State: AHQUAuY/higqRaswzGd5MfUbdIo5u8MdnZ157ntX+vw8Z13eISHEWxIu
        /EG5QPcVSMLItxrjiS1+BeEd3w==
X-Google-Smtp-Source: AHgI3IbPF4fPqbClV2fCpcnwO2Iou7NLJVsbXAsV7htoA+WblfJgTeFYwF4LjOFZtBSHa/m3Z0adGw==
X-Received: by 2002:a0c:9587:: with SMTP id s7mr207806qvs.155.1550093564953;
        Wed, 13 Feb 2019 13:32:44 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:44 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.19 14/17] ARM: add PROC_VTABLE and PROC_TABLE macros
Date:   Wed, 13 Feb 2019 16:32:20 -0500
Message-Id: <20190213213223.916-15-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit e209950fdd065d2cc46e6338e47e52841b830cba upstream.

Allow the way we access members of the processor vtable to be changed
at compile time.  We will need to move to per-CPU vtables to fix the
Spectre variant 2 issues on big.Little systems.

However, we have a couple of calls that do not need the vtable
treatment, and indeed cause a kernel warning due to the (later) use
of smp_processor_id(), so also introduce the PROC_TABLE macro for
these which always use CPU 0's function pointers.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/proc-fns.h | 39 ++++++++++++++++++++++-----------
 arch/arm/kernel/setup.c         |  4 +---
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 30c499146320..c259cc49c641 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -23,7 +23,7 @@ struct mm_struct;
 /*
  * Don't change this structure - ASM code relies on it.
  */
-extern struct processor {
+struct processor {
 	/* MISC
 	 * get data abort address/flags
 	 */
@@ -79,9 +79,13 @@ extern struct processor {
 	unsigned int suspend_size;
 	void (*do_suspend)(void *);
 	void (*do_resume)(void *);
-} processor;
+};
 
 #ifndef MULTI_CPU
+static inline void init_proc_vtable(const struct processor *p)
+{
+}
+
 extern void cpu_proc_init(void);
 extern void cpu_proc_fin(void);
 extern int cpu_do_idle(void);
@@ -98,18 +102,27 @@ extern void cpu_reset(unsigned long addr, bool hvc) __attribute__((noreturn));
 extern void cpu_do_suspend(void *);
 extern void cpu_do_resume(void *);
 #else
-#define cpu_proc_init			processor._proc_init
-#define cpu_check_bugs			processor.check_bugs
-#define cpu_proc_fin			processor._proc_fin
-#define cpu_reset			processor.reset
-#define cpu_do_idle			processor._do_idle
-#define cpu_dcache_clean_area		processor.dcache_clean_area
-#define cpu_set_pte_ext			processor.set_pte_ext
-#define cpu_do_switch_mm		processor.switch_mm
 
-/* These three are private to arch/arm/kernel/suspend.c */
-#define cpu_do_suspend			processor.do_suspend
-#define cpu_do_resume			processor.do_resume
+extern struct processor processor;
+#define PROC_VTABLE(f)			processor.f
+#define PROC_TABLE(f)			processor.f
+static inline void init_proc_vtable(const struct processor *p)
+{
+	processor = *p;
+}
+
+#define cpu_proc_init			PROC_VTABLE(_proc_init)
+#define cpu_check_bugs			PROC_VTABLE(check_bugs)
+#define cpu_proc_fin			PROC_VTABLE(_proc_fin)
+#define cpu_reset			PROC_VTABLE(reset)
+#define cpu_do_idle			PROC_VTABLE(_do_idle)
+#define cpu_dcache_clean_area		PROC_TABLE(dcache_clean_area)
+#define cpu_set_pte_ext			PROC_TABLE(set_pte_ext)
+#define cpu_do_switch_mm		PROC_VTABLE(switch_mm)
+
+/* These two are private to arch/arm/kernel/suspend.c */
+#define cpu_do_suspend			PROC_VTABLE(do_suspend)
+#define cpu_do_resume			PROC_VTABLE(do_resume)
 #endif
 
 extern void cpu_resume(void);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 8fd7baa158a4..f269f4440496 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -693,9 +693,7 @@ static void __init setup_processor(void)
 	cpu_name = list->cpu_name;
 	__cpu_architecture = __get_cpu_architecture();
 
-#ifdef MULTI_CPU
-	processor = *list->proc;
-#endif
+	init_proc_vtable(list->proc);
 #ifdef MULTI_TLB
 	cpu_tlb = *list->tlb;
 #endif
-- 
2.17.1

