Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B00C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9962084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Adw2RJaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9962084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbeJ3C6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:58:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34011 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbeJ3C6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:58:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so4436149pfe.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CroHCjy2cXyW18SnvnT99u56hhAhS32VgKvRG9qriMk=;
        b=Adw2RJawkgnaC/jpDoSz7kz4ztVYqXNmBSnL2SvigdwN21Qq4qG0Pe+1/1PrUPKs9S
         bDz7ozuAXF3qkF3GBazKl/rEQgxQHcyekO1KrYK9RL32KkbqUTGP8wOmE1NGu3DekUXx
         VI2tl0dPwLK1ovDongsGFEfW+cu+jec5xtADY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CroHCjy2cXyW18SnvnT99u56hhAhS32VgKvRG9qriMk=;
        b=TPAjxkZteEDDaR3B6dFjbHVEpDjDTcRQB//2OT5/Nj6vX5Rr/BHcKts2n0opTuGYBE
         zMK9iRo01JCXjeMOMqbbDKcXZzX7euWcCoTVXGJ84/cMpzN6EtKE4GTuDcxWN6bjHzg1
         /MJFJ6V4MpddFyIkkMzvJ+hDAi2NUY9NV2gbM1VDAYy1uBPkBri70VnTjKAwvcUKDqFD
         XNHfkYwpEO+IdI8uhKa9RE6KLShpac72Axj9WtMqMvPhr4MQRN6rEp5ZG7kWtSxjQE/d
         QjgveNFF4HRcTR+Ay8IXf5S8HccIMQyMhwhagQ/GFgK9Jrr3UK20cO8ON/lP2LvmNorG
         nkXg==
X-Gm-Message-State: AGRZ1gLbOBLQtaCby8AXiqIAvc2kY4tF6sbkfR9k7qMOebT1IvPNjOaP
        yNNyinYcxVEZ1e73lLVnfrRW2g==
X-Google-Smtp-Source: AJdET5d1BEiS9eVnpREP9GcY6nBDc+TgRpo6cR3NLiALJXXRpfCKZMOIAtRRC3z9kZ0u7UVM6sOi9A==
X-Received: by 2002:a62:a50d:: with SMTP id v13-v6mr16095653pfm.18.1540836517190;
        Mon, 29 Oct 2018 11:08:37 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id u13-v6sm20537765pgp.18.2018.10.29.11.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 11:08:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        tglx@linutronix.de, mingo@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org,
        kgdb-bugreport@lists.sourceforge.net,
        Douglas Anderson <dianders@chromium.org>,
        kstewart@linuxfoundation.org, linux-mips@linux-mips.org,
        dalias@libc.org, linux-sh@vger.kernel.org,
        benh@kernel.crashing.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, paulus@samba.org,
        hpa@zytor.com, sparclinux@vger.kernel.org,
        linux-hexagon@vger.kernel.org, sfr@canb.auug.org.au,
        ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, catalin.marinas@arm.com,
        jhogan@kernel.org, linux-snps-arc@lists.infradead.org,
        ying.huang@intel.com, rppt@linux.vnet.ibm.com, bp@alien8.de,
        linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
        pombredanne@nexb.com, ralf@linux-mips.org, rkuo@codeaurora.org,
        paul.burton@mips.com, vgupta@synopsys.com,
        akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        davem@davemloft.net
Subject: [PATCH 7/7] kgdb: Remove irq flags and local_irq_enable/disable from roundup
Date:   Mon, 29 Oct 2018 11:07:07 -0700
Message-Id: <20181029180707.207546-8-dianders@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181029180707.207546-1-dianders@chromium.org>
References: <20181029180707.207546-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kgdb_roundup_cpus() was passed a parameter that was
documented as:

> the flags that will be used when restoring the interrupts. There is
> local_irq_save() call before kgdb_roundup_cpus().

Nobody used those flags.  Anyone who wanted to temporarily turn on
interrupts just did local_irq_enable() and local_irq_disable() without
looking at them.  So we can definitely remove the flags.

Speaking of calling local_irq_enable(), it seems like a bad idea and
it caused a nice splat on my system with lockdep turned on.
Specifically it hit:
  DEBUG_LOCKS_WARN_ON(current->hardirq_context)

See the previous patch in this series ("smp: Don't yell about IRQs
disabled in kgdb_roundup_cpus()") for more details, but the last few
things on the stack were this on my arm64 board:
  lockdep_hardirqs_on+0xf0/0x160
  trace_hardirqs_on+0x188/0x1ac
  kgdb_roundup_cpus+0x14/0x3c

As agrued in the the commit text of ("smp: Don't yell about IRQs
disabled in kgdb_roundup_cpus()"), it seems better to make
smp_call_function() lenient about kgdb than to locally turn on IRQs
here.  Thus let's totally remove all the local_irq_enable() and
local_irq_disable() calls from all of the kgdb_roundup_cpus() calls.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arc/kernel/kgdb.c     |  4 +---
 arch/arm/kernel/kgdb.c     |  4 +---
 arch/arm64/kernel/kgdb.c   |  4 +---
 arch/hexagon/kernel/kgdb.c | 11 ++---------
 arch/mips/kernel/kgdb.c    |  4 +---
 arch/powerpc/kernel/kgdb.c |  2 +-
 arch/sh/kernel/kgdb.c      |  4 +---
 arch/sparc/kernel/smp_64.c |  2 +-
 arch/x86/kernel/kgdb.c     |  9 ++-------
 include/linux/kgdb.h       |  9 ++-------
 kernel/debug/debug_core.c  |  2 +-
 11 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/arch/arc/kernel/kgdb.c b/arch/arc/kernel/kgdb.c
index 9a3c34af2ae8..d94d3cb7f9e8 100644
--- a/arch/arc/kernel/kgdb.c
+++ b/arch/arc/kernel/kgdb.c
@@ -197,11 +197,9 @@ static void kgdb_call_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), NULL);
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
-	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
 }
 
 struct kgdb_arch arch_kgdb_ops = {
diff --git a/arch/arm/kernel/kgdb.c b/arch/arm/kernel/kgdb.c
index caa0dbe3dc61..a80e9259f7e9 100644
--- a/arch/arm/kernel/kgdb.c
+++ b/arch/arm/kernel/kgdb.c
@@ -175,11 +175,9 @@ static void kgdb_call_nmi_hook(void *ignored)
        kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
-       local_irq_enable();
        smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-       local_irq_disable();
 }
 
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index a20de58061a8..5d171c26788f 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -289,11 +289,9 @@ static void kgdb_call_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
-	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
 }
 
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
diff --git a/arch/hexagon/kernel/kgdb.c b/arch/hexagon/kernel/kgdb.c
index 16c24b22d0b2..30fbc491cf45 100644
--- a/arch/hexagon/kernel/kgdb.c
+++ b/arch/hexagon/kernel/kgdb.c
@@ -119,17 +119,12 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
 
 /**
  * kgdb_roundup_cpus - Get other CPUs into a holding pattern
- * @flags: Current IRQ state
  *
  * On SMP systems, we need to get the attention of the other CPUs
  * and get them be in a known state.  This should do what is needed
  * to get the other CPUs to call kgdb_wait(). Note that on some arches,
  * the NMI approach is not used for rounding up all the CPUs. For example,
- * in case of MIPS, smp_call_function() is used to roundup CPUs. In
- * this case, we have to make sure that interrupts are enabled before
- * calling smp_call_function(). The argument to this function is
- * the flags that will be used when restoring the interrupts. There is
- * local_irq_save() call before kgdb_roundup_cpus().
+ * in case of MIPS, smp_call_function() is used to roundup CPUs.
  *
  * On non-SMP systems, this is not called.
  */
@@ -139,11 +134,9 @@ static void hexagon_kgdb_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
-	local_irq_enable();
 	smp_call_function(hexagon_kgdb_nmi_hook, NULL, 0);
-	local_irq_disable();
 }
 #endif
 
diff --git a/arch/mips/kernel/kgdb.c b/arch/mips/kernel/kgdb.c
index eb6c0d582626..6671a279966f 100644
--- a/arch/mips/kernel/kgdb.c
+++ b/arch/mips/kernel/kgdb.c
@@ -219,11 +219,9 @@ static void kgdb_call_nmi_hook(void *ignored)
 	set_fs(old_fs);
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
-	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
 }
 
 static int compute_signal(int tt)
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index 59c578f865aa..b0e804844be0 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -124,7 +124,7 @@ static int kgdb_call_nmi_hook(struct pt_regs *regs)
 }
 
 #ifdef CONFIG_SMP
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	smp_send_debugger_break();
 }
diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 4f04c6638a4d..86b3ea927e42 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -319,11 +319,9 @@ static void kgdb_call_nmi_hook(void *ignored)
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
 
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
-	local_irq_enable();
 	smp_call_function(kgdb_call_nmi_hook, NULL, 0);
-	local_irq_disable();
 }
 
 static int __kgdb_notify(struct die_args *args, unsigned long cmd)
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 4792e08ad36b..f45d876983f1 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1014,7 +1014,7 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 }
 
 #ifdef CONFIG_KGDB
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	smp_cross_call(&xcall_kgdb_capture, 0, 0, 0);
 }
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 8e36f249646e..ac6291a4178d 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -422,21 +422,16 @@ static void kgdb_disable_hw_debug(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
- *	@flags: Current IRQ state
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them be in a known state.  This should do what is needed
  *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
  *	the NMI approach is not used for rounding up all the CPUs. For example,
- *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
- *	this case, we have to make sure that interrupts are enabled before
- *	calling smp_call_function(). The argument to this function is
- *	the flags that will be used when restoring the interrupts. There is
- *	local_irq_save() call before kgdb_roundup_cpus().
+ *	in case of MIPS, smp_call_function() is used to roundup CPUs.
  *
  *	On non-SMP systems, this is not called.
  */
-void kgdb_roundup_cpus(unsigned long flags)
+void kgdb_roundup_cpus(void)
 {
 	apic->send_IPI_allbutself(APIC_DM_NMI);
 }
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index e465bb15912d..05e5b2eb0d32 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -178,21 +178,16 @@ kgdb_arch_handle_exception(int vector, int signo, int err_code,
 
 /**
  *	kgdb_roundup_cpus - Get other CPUs into a holding pattern
- *	@flags: Current IRQ state
  *
  *	On SMP systems, we need to get the attention of the other CPUs
  *	and get them into a known state.  This should do what is needed
  *	to get the other CPUs to call kgdb_wait(). Note that on some arches,
  *	the NMI approach is not used for rounding up all the CPUs. For example,
- *	in case of MIPS, smp_call_function() is used to roundup CPUs. In
- *	this case, we have to make sure that interrupts are enabled before
- *	calling smp_call_function(). The argument to this function is
- *	the flags that will be used when restoring the interrupts. There is
- *	local_irq_save() call before kgdb_roundup_cpus().
+ *	in case of MIPS, smp_call_function() is used to roundup CPUs.
  *
  *	On non-SMP systems, this is not called.
  */
-extern void kgdb_roundup_cpus(unsigned long flags);
+extern void kgdb_roundup_cpus(void);
 
 /**
  *	kgdb_arch_set_pc - Generic call back to the program counter
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 65c0f1363788..f3cadda45f07 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -593,7 +593,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 
 	/* Signal the other CPUs to enter kgdb_wait() */
 	else if ((!kgdb_single_step) && kgdb_do_roundup)
-		kgdb_roundup_cpus(flags);
+		kgdb_roundup_cpus();
 #endif
 
 	/*
-- 
2.19.1.568.g152ad8e336-goog

