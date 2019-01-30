Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B3FC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6283A20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UTY1SGIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732830AbfA3T4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:56:24 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37889 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbfA3T4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:56:24 -0500
Received: by mail-yw1-f67.google.com with SMTP id d190so326180ywb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fMic4/srpVB+DYsvA4QhAeK3qc4LoYvthxknL+iJMzg=;
        b=UTY1SGIZ17Ji4JCx/FaPpx8PjOGUHB1YMloX7gBk7quvXg1Tb7ZXOaBphB3Z/rE2yM
         uNvyOdiD2p8otfbWN46RSJpSRiGqqegvTEfvHG/szoiTTufyH9/LHpC9Xt53gTwdW7Wc
         Cc2dAneaZr3lrHY2tB6a/YfpDmi0Lyp0z1pPJqMCKJYjcMFBsenC9y/FPrFTlVEQwSZ4
         MwGgueU8QsYcSBwPiB34VffZgoPfzi8FSiCHuq3QjNNr3Rrbf278bXavmAD4dZiwTxGF
         OMUJE/8Cq5D2oXnHZdG26hXxxrHMDLWoalrFXUrBkwBszmriCxREvbIydRSsXWWF9C+c
         490g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fMic4/srpVB+DYsvA4QhAeK3qc4LoYvthxknL+iJMzg=;
        b=N5YF6n7RC7JRPvvYq4EwzmA36lvmP3Xg5w5oJJ6xwefsihItXD7WI6pfMXbfQSWEeL
         tO6Xc0mxxxTIgPNzxXEIEmnReEsA9T5HJFprzmB8rsC5Yfpvet0g61/Y6UCM1CN3wyZw
         o7e/33zg4BSZhHWfehgF6vlFy/ZcpH3oURaoQc9+QKE6wPPIlFq8h0E0GLacttZdnVLD
         OOHmIYiWTctxjDFh+SN4H+6KDJOLPb72MgtBIMzDy9ePSngVsqen/JBsd6qDRYjE63pU
         dqg2EWtoEMtknQfotWgeb9c7chd2/SeQhpQPv6ATLoivYv9gRZCKmwoazZ68rsy+QUfm
         oDUw==
X-Gm-Message-State: AJcUukfpMt7mZCNtnrVebA3fNyj2pU9/XjpKgRk3ehbhVQ18oHYf8LSx
        iZAf1/8bewIuSBcfDvQQXgzV2g==
X-Google-Smtp-Source: ALg8bN7HqBO9STMJIV8i63SRT4xNUi8UarGnlr9uchTmKqZ29LiXhgoLAeCh6t6qEjj+HpD73JZlHg==
X-Received: by 2002:a81:b61a:: with SMTP id u26mr30162920ywh.250.1548878183201;
        Wed, 30 Jan 2019 11:56:23 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6c95])
        by smtp.gmail.com with ESMTPSA id d3sm910796ywh.58.2019.01.30.11.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:56:22 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:56:21 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH] x86: avoid confusion over the new RESCTRL config prompt
Message-ID: <20190130195621.GA30653@cmpxchg.org>
References: <20190129225218.15441-1-hannes@cmpxchg.org>
 <20190129230845.GG28773@zn.tnic>
 <20190130164626.GA17841@cmpxchg.org>
 <20190130171933.GC21221@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130171933.GC21221@zn.tnic>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:19:33PM +0100, Borislav Petkov wrote:
> On Wed, Jan 30, 2019 at 11:46:26AM -0500, Johannes Weiner wrote:
> > This is still awefully close to the cgroup CPU resource
> > controller. Since it's more hardware-specific, and the config symbol
> > also has the x86 in it, how about "x86 CPU resource control support"?
> 
> Fine by me.
> 
> What about
> 
> s/X86_RESCTRL/X86_CPU_RESCTRL/g

Good idea.

Tony, Babu, that look okay to you guys as well?

---

From 9ca5fa615f9f5d270c141266c454059a3de2cd39 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Tue, 29 Jan 2019 17:44:36 -0500
Subject: [PATCH] x86: avoid confusion over the new X86_RESCTRL config

"Resource Control" is a very broad term for this CPU feature, and a
term that is also associated with containers, cgroups etc. This can
easily cause confusion.

Make the user prompt more specific. Match the config symbol name.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/x86/resctrl_ui.txt     | 2 +-
 arch/x86/Kconfig                     | 6 +++---
 arch/x86/include/asm/resctrl_sched.h | 4 ++--
 arch/x86/kernel/cpu/Makefile         | 2 +-
 arch/x86/kernel/cpu/resctrl/Makefile | 4 ++--
 include/linux/sched.h                | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/x86/resctrl_ui.txt b/Documentation/x86/resctrl_ui.txt
index e8e8d14d3c4e..c1f95b59e14d 100644
--- a/Documentation/x86/resctrl_ui.txt
+++ b/Documentation/x86/resctrl_ui.txt
@@ -9,7 +9,7 @@ Fenghua Yu <fenghua.yu@intel.com>
 Tony Luck <tony.luck@intel.com>
 Vikas Shivappa <vikas.shivappa@intel.com>
 
-This feature is enabled by the CONFIG_X86_RESCTRL and the x86 /proc/cpuinfo
+This feature is enabled by the CONFIG_X86_CPU_RESCTRL and the x86 /proc/cpuinfo
 flag bits:
 RDT (Resource Director Technology) Allocation - "rdt_a"
 CAT (Cache Allocation Technology) - "cat_l3", "cat_l2"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..68261430fe6e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -446,12 +446,12 @@ config RETPOLINE
 	  branches. Requires a compiler with -mindirect-branch=thunk-extern
 	  support for full protection. The kernel may run slower.
 
-config X86_RESCTRL
-	bool "Resource Control support"
+config X86_CPU_RESCTRL
+	bool "x86 CPU resource control support"
 	depends on X86 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select KERNFS
 	help
-	  Enable Resource Control support.
+	  Enable x86 CPU resource control support.
 
 	  Provide support for the allocation and monitoring of system resources
 	  usage by the CPU.
diff --git a/arch/x86/include/asm/resctrl_sched.h b/arch/x86/include/asm/resctrl_sched.h
index 40ebddde6ac2..f6b7fe2833cc 100644
--- a/arch/x86/include/asm/resctrl_sched.h
+++ b/arch/x86/include/asm/resctrl_sched.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_X86_RESCTRL_SCHED_H
 #define _ASM_X86_RESCTRL_SCHED_H
 
-#ifdef CONFIG_X86_RESCTRL
+#ifdef CONFIG_X86_CPU_RESCTRL
 
 #include <linux/sched.h>
 #include <linux/jump_label.h>
@@ -88,6 +88,6 @@ static inline void resctrl_sched_in(void)
 
 static inline void resctrl_sched_in(void) {}
 
-#endif /* CONFIG_X86_RESCTRL */
+#endif /* CONFIG_X86_CPU_RESCTRL */
 
 #endif /* _ASM_X86_RESCTRL_SCHED_H */
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index b6fa0869f7aa..cfd24f9f7614 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -39,7 +39,7 @@ obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
-obj-$(CONFIG_X86_RESCTRL)		+= resctrl/
+obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/resctrl/Makefile b/arch/x86/kernel/cpu/resctrl/Makefile
index 1cabe6fd8e11..4a06c37b9cf1 100644
--- a/arch/x86/kernel/cpu/resctrl/Makefile
+++ b/arch/x86/kernel/cpu/resctrl/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_X86_RESCTRL)	+= core.o rdtgroup.o monitor.o
-obj-$(CONFIG_X86_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
+obj-$(CONFIG_X86_CPU_RESCTRL)	+= core.o rdtgroup.o monitor.o
+obj-$(CONFIG_X86_CPU_RESCTRL)	+= ctrlmondata.o pseudo_lock.o
 CFLAGS_pseudo_lock.o = -I$(src)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2f90fa92468..bba3afb4e9bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -995,7 +995,7 @@ struct task_struct {
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
 #endif
-#ifdef CONFIG_X86_RESCTRL
+#ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
 	u32				rmid;
 #endif
-- 
2.20.1

