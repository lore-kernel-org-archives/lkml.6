Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD71C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EC6208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gGA/STc7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EC6208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbeH0Wql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:46:41 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34778 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeH0Wqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:46:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id u10-v6so16576pgr.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=MuJPMK4gtkcReeLE8Pey7LehoFRXSmm0PHZ8jD8PPRQ=;
        b=gGA/STc70VHtNte4UJbLcbYY1w3uej4OzWVZZYkSI2fIWx82Gb3TkiuyyidnPa1qHi
         z7ijI/F08rJMRGYRLHRJa4K0alFbKCtBKR1md60mBvBCLNrxioj0vMEEfbTo5kvhDIW5
         HTog8bT0QzJP0KEe4fsQ0pyBPsmOfBgTtHRQL+mLZovrJhFRP7oJRwScPDoADHWnJ6Mo
         ieYdcw5eC6V34EqvzDH834DlV6t0frL0uhGPkv0hpjoSjSJhgwE8p9SM0BiFsHehEQV6
         HktY3yWKp8XYasGY7T8hYmXeUKz6Ug6HEiXszVlTiTRkSYGLgXMMg6gT3zOUVfy0ofS3
         tDDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=MuJPMK4gtkcReeLE8Pey7LehoFRXSmm0PHZ8jD8PPRQ=;
        b=W7sfAtUzZunNZ7zwIc+RQiQPW6MZ44ZMCNsHhpdaTBXIgK9V7o6d4icxIP5sTDsGCk
         R9kreqFYh6LDCUsnGjg9eW16x7vJcC+4o9vosDiiJ9VTFV1b9jLlvkesJrT8JozCXtKL
         IhQsmtVU3qNuiZV6BNiG0MgMx3QaK2NrEZcDUgsi/9mVIaO6txt77iEC7or3BbLabVCF
         qIoXUokzj3pv4m6FUu/OswuEbCIq3ys3V0jv01kBxEd4GkbCYdeh6Ynd2kkSf8SWKwae
         kIyM37QyNO5Y+D0j/LcRF7ABBejbVqa/wvj5mBDK50b7mHUdt6vbDzX64JhAiM0K+efP
         o7WQ==
X-Gm-Message-State: APzg51D9WY3X15NFGDfvnvApBrA1l4Hoqporqp6CLfQ+KSDjlb/Qelqq
        avI3HGzV96g5+2XJALptyumIBQ==
X-Google-Smtp-Source: ANB0VdZW82Nb95fgu8B3JjIC1gbzob25ARmXCD5AT220gkufNcujYmLeRvHHv87GpIVPPbF/MRh10Q==
X-Received: by 2002:a65:6292:: with SMTP id f18-v6mr13183581pgv.85.1535396330577;
        Mon, 27 Aug 2018 11:58:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j15-v6sm9758pfn.52.2018.08.27.11.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 11:58:49 -0700 (PDT)
Subject: [PATCH 6/8] RISC-V: Use mmgrab()
Date:   Mon, 27 Aug 2018 11:42:41 -0700
Message-Id: <20180827184243.25344-7-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827184243.25344-1-palmer@sifive.com>
References: <20180827184243.25344-1-palmer@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, atish.patra@wdc.com,
        dmitriy@oss-tech.org, catalin.marinas@arm.com,
        ard.biesheuvel@linaro.org, Greg KH <gregkh@linuxfoundation.org>,
        jeremy.linton@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:      linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f1f1007644ff ("mm: add new mmgrab() helper") added a helper that we
missed out on.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index e1f6a5ad0416..5437a04babcd 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -30,6 +30,7 @@
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/sched/task_stack.h>
+#include <linux/sched/mm.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -79,8 +80,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	 * the spinning harts that they can continue the boot process.
 	 */
 	smp_mb();
-	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
-	__cpu_up_task_pointer[cpu] = tidle;
+	WRITE_ONCE(__cpu_up_stack_pointer[cpu], task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_up_task_pointer[cpu], tidle);
 
 	while (!cpu_online(cpu))
 		cpu_relax();
@@ -100,7 +101,7 @@ asmlinkage void __init smp_callin(void)
 	struct mm_struct *mm = &init_mm;
 
 	/* All kernel threads share the same mm context.  */
-	atomic_inc(&mm->mm_count);
+	mmgrab(mm);
 	current->active_mm = mm;
 
 	trap_init();
-- 
2.16.4

