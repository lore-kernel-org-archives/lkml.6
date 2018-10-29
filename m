Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C95EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C05E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ViKF3X5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C05E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbeJ3C6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:19 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39633 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeJ3C6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:18 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so4291188pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5KlK5EoYecHiEwx2KYOj1AK3WWuK24K/BTuRZp/Hgn0=;
        b=ViKF3X5QZz1G04Kuc+UrpCLOIvvtASddvUpgEhbE2NwCsDxuq6JsW/AfF3MtdzfNcH
         x4aFvJIFkNdrS8l2CQjvpOEnAdP+LsFKZAoe9CdyAH5M9odaITFSuzPbsiwDohBeU3UQ
         YDDibS0wr7JOOkRxMW/g3gib7jVbkYmN9FZJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5KlK5EoYecHiEwx2KYOj1AK3WWuK24K/BTuRZp/Hgn0=;
        b=YPLSTYL5pIODF1gUW+Np2OO6f12651bN34rEhPFvGkyuMIVW0v+AJiGr82vQSphoCd
         3PdNflqetAH9LUvJndNn/mqk8nXWtGgNDyLJlFzhR6LYO8Dpb+XA8qWP7IV2tt/TWqgh
         fvQ8Y7LV9RZIhc+ODEy+TAHEjK0zP63I0pyfAna5mnnw80TD0xWp8LBx13kirPUS0q2W
         MR+xlksdKlwFXxpapawTcHaLjmn4S7zrSz4Oo+xZslYKceAODjQfOTGyc27bDC5cuBG4
         DbT9RzxbQ/++pYGnV6Zc7H6bI763gN3DUNhTi3lG1iPwm+Una/tF/4TV6H00agSr+AnZ
         rqnQ==
X-Gm-Message-State: AGRZ1gJgU2jhwAk+0I/JCZ7AGyfDBL+RclWVgKMCQC4B/2ijm4eXNgzh
        B4gWuS6r8jSuHSvXhyDSXdIYag==
X-Google-Smtp-Source: AJdET5dnes+lqSdsKf+M8kej513uIWGXuNg0nbxyLNaYWMhztTpOmHr2lEByvMdxDcC5rsUHz1VWbw==
X-Received: by 2002:a62:7a92:: with SMTP id v140-v6mr9434788pfc.46.1540836514355;
        Mon, 29 Oct 2018 11:08:34 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:33 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        peterz@infradead.org, linux-hexagon@vger.kernel.org,
        frederic@kernel.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/7] smp: Don't yell about IRQs disabled in kgdb_roundup_cpus()
Date:   Mon, 29 Oct 2018 11:07:06 -0700
Message-Id: <20181029180707.207546-7-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kgdb_roundup_cpus() we've got code that looks like:
  local_irq_enable();
  smp_call_function(kgdb_call_nmi_hook, NULL, 0);
  local_irq_disable();

In certain cases when we drop into kgdb (like with sysrq-g on a serial
console) we'll get a big yell that looks like:

  sysrq: SysRq : DEBUG
  ------------[ cut here ]------------
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)
  WARNING: CPU: 0 PID: 0 at .../kernel/locking/lockdep.c:2875 lockdep_hardirqs_on+0xf0/0x160
  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.0 #27
  pstate: 604003c9 (nZCv DAIF +PAN -UAO)
  pc : lockdep_hardirqs_on+0xf0/0x160
  ...
  Call trace:
   lockdep_hardirqs_on+0xf0/0x160
   trace_hardirqs_on+0x188/0x1ac
   kgdb_roundup_cpus+0x14/0x3c
   kgdb_cpu_enter+0x53c/0x5cc
   kgdb_handle_exception+0x180/0x1d4
   kgdb_compiled_brk_fn+0x30/0x3c
   brk_handler+0x134/0x178
   do_debug_exception+0xfc/0x178
   el1_dbg+0x18/0x78
   kgdb_breakpoint+0x34/0x58
   sysrq_handle_dbg+0x54/0x5c
   __handle_sysrq+0x114/0x21c
   handle_sysrq+0x30/0x3c
   qcom_geni_serial_isr+0x2dc/0x30c
  ...
  ...
  irq event stamp: ...45
  hardirqs last  enabled at (...44): [...] __do_softirq+0xd8/0x4e4
  hardirqs last disabled at (...45): [...] el1_irq+0x74/0x130
  softirqs last  enabled at (...42): [...] _local_bh_enable+0x2c/0x34
  softirqs last disabled at (...43): [...] irq_exit+0xa8/0x100
  ---[ end trace adf21f830c46e638 ]---

Let's add kgdb to the list of reasons not to warn in
smp_call_function_many().  That will allow us (in a future patch) to
stop calling local_irq_enable() which will get rid of the original
splat.

NOTE: with this change comes the obvious question: will we start
deadlocking more often now when we drop into the debugger.  I can't
say that for sure one way or the other, but the fact that we do the
same logic for "oops_in_progress" makes me feel like it shouldn't
happen too often.  Also note that the old logic of turning on
interrupts temporarily wasn't exactly safe since (I presume) that
could have violated spin_lock_irqsave() semantics and ended up with a
deadlock of its own.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 163c451af42e..bb581e58c8dc 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/sched/idle.h>
 #include <linux/hypervisor.h>
+#include <linux/kgdb.h>
 
 #include "smpboot.h"
 
@@ -413,7 +414,8 @@ void smp_call_function_many(const struct cpumask *mask,
 	 * can't happen.
 	 */
 	WARN_ON_ONCE(cpu_online(this_cpu) && irqs_disabled()
-		     && !oops_in_progress && !early_boot_irqs_disabled);
+		     && !oops_in_progress && !early_boot_irqs_disabled
+		     && !in_dbg_master());
 
 	/* Try to fastpath.  So, what's a CPU they want? Ignoring this one. */
 	cpu = cpumask_first_and(mask, cpu_online_mask);
-- 
2.19.1.568.g152ad8e336-goog

