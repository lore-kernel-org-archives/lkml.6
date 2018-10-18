Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597B8ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC470208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 08:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YuxunfCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC470208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeJRQYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 12:24:21 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36453 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbeJRQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 12:24:21 -0400
Received: by mail-pg1-f193.google.com with SMTP id f18-v6so13861487pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 01:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lQ4qM7GVWLol2Q0OL4g4jfd2pwuqVD0wkT6TvnQ9zEY=;
        b=YuxunfCakbkPChj/mEm6Z3PK98m5UoevAT/QvMtCbQqUB8Rw7pOKlHw4rQtZMDxhNr
         B/i62CRmyVgi4JxH8YByPhgXH12aQYXOmS4u7FBiObX1BDo4Gst2k4U5syMruhGru5TK
         q9ipi9ryA9hsmxgjdMVY1VH6Eahk+2mE+AcAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lQ4qM7GVWLol2Q0OL4g4jfd2pwuqVD0wkT6TvnQ9zEY=;
        b=SPa2i5aNNxikZ0nHsWdHz+r5C2dDbpSlRP9RL9ErbFn0OvrJAiTII9cr46L+Tk5KqA
         PgvXJj0+nsdqy+SwzjoqBq2vHE0eqAnVK4X7LGiIGAdDCpbZzc0x2/bAuCGRreB6w+v5
         aWSQMlB3zqAxu0cnzDKYJqJUI5ggeMIqxweOJ1ITbp4NcCGid3BiuM4itvCU71a1cNdc
         hyG+XEFkQXcn/1HnHlbMuw5xBcMh06o7zjeSFxWr1SXlxL+qhXQmkap2iRrLF1BE5A4j
         EF54jvH6sFEKYeQvXL4/fl5Uija53B4T2j316cuQqq6dhuJnAJ7zf43sZPjkqv9Bpr+4
         fUuw==
X-Gm-Message-State: ABuFfoh4sszX4Vf7V03TxCffFfSncLCm60pmD/w0jYJvRYqRX7myqf5C
        O7BlxXkyMwfjfM+HWTMftx1P9A==
X-Google-Smtp-Source: ACcGV62CQ1AfBglm9yOGYNwyeFh8efoO20DS0F1pM1Wet8/f2Et28cNa5aKh2SEt9mjaWRRfZv4COA==
X-Received: by 2002:a65:498b:: with SMTP id r11-v6mr27357237pgs.153.1539851069283;
        Thu, 18 Oct 2018 01:24:29 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o76-v6sm36743049pfi.162.2018.10.18.01.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 01:24:28 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <Marc.Zyngier@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] ARM: prevent tracing IPI_CPU_BACKTRACE
Date:   Thu, 18 Oct 2018 16:23:59 +0800
Message-Id: <1539851039-15778-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
References: <1538019697-14673-1-git-send-email-chunyan.zhang@unisoc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When function tracing for IPIs is enabled, we get a warning for an
overflow of the ipi_types array with the IPI_CPU_BACKTRACE type
as triggered by raise_nmi():

arch/arm/kernel/smp.c: In function 'raise_nmi':
arch/arm/kernel/smp.c:489:2: error: array subscript is above array bounds [-Werror=array-bounds]
	trace_ipi_raise(target, ipi_types[ipinr]);

This is a correct warning as we actually overflow the array here.

This patch raise_nmi() to call __smp_cross_call() instead of
smp_cross_call(), to avoid calling into ftrace. For clarification,
I'm also adding a two new code comments describing how this one
is special.

The warning appears to have shown up after patch e7273ff49acf
("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI"), which
changed the number assignment from '15' to '8', but as far as I can
tell has existed since the IPI tracepoints were first introduced.
If we decide to backport this patch to stable kernels, we probably
need to backport e7273ff49acf as well.

Resubmitting this patch is because that I found coverity is complaining
the issue this patch fixed, and also I got the traces like below:
"ipi_raise: target_mask=00000001 (machine_suspend)" which actually was
the TPS of suspend_resume[1] rather that ipi_raise.

[1]
https://elixir.bootlin.com/linux/latest/source/kernel/power/suspend.c#L80

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: e7273ff49acf ("ARM: 8488/1: Make IPI_CPU_BACKTRACE a "non-secure" SGI")
Fixes: 365ec7b17327 ("ARM: add IPI tracepoints") # v3.17
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 arch/arm/include/asm/hardirq.h | 1 +
 arch/arm/kernel/smp.c          | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index cba23ea..7a88f16 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -6,6 +6,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
+/* number of IPIS _not_ including IPI_CPU_BACKTRACE */
 #define NR_IPI	7
 
 typedef struct {
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 0978282..ddd48e2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -75,6 +75,10 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 	IPI_IRQ_WORK,
 	IPI_COMPLETION,
+	/*
+	 * CPU_BACKTRACE is special and not included in NR_IPI
+	 * or tracable with trace_ipi_*
+	 */
 	IPI_CPU_BACKTRACE,
 	/*
 	 * SGI8-15 can be reserved by secure firmware, and thus may
@@ -755,7 +759,7 @@ core_initcall(register_cpufreq_notifier);
 
 static void raise_nmi(cpumask_t *mask)
 {
-	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+	__smp_cross_call(mask, IPI_CPU_BACKTRACE);
 }
 
 void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-- 
2.7.4

