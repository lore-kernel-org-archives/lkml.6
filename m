Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8172EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ACD2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfAYSjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:39:44 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.156]:36569 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726321AbfAYSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:39:44 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id CEEB611544
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 12:39:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id n6OEg1Xrk2qH7n6OEgd9mN; Fri, 25 Jan 2019 12:39:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=41968 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gn6Nd-001VHt-3h; Fri, 25 Jan 2019 12:39:42 -0600
Date:   Fri, 25 Jan 2019 12:39:03 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/kernel: Mark expected switch fall-throughs
Message-ID: <20190125183903.GA4712@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gn6Nd-001VHt-3h
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:41968
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch
cases where we are expecting to fall through.

This patch fixes the following warnings:

arch/x86/kernel/hw_breakpoint.c:278:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kernel/cpu/cacheinfo.c:250:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kernel/kgdb.c:468:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kernel/uprobes.c:747:8: warning: this statement may fall through [-Wimplicit-fallthrough=]
arch/x86/kernel/apic/io_apic.c: In function ‘irq_trigger’:
./include/linux/printk.h:305:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/printk.h:306:17: note: in expansion of macro ‘pr_warning’
 #define pr_warn pr_warning
                 ^~~~~~~~~~
arch/x86/kernel/apic/io_apic.c:861:3: note: in expansion of macro ‘pr_warn’
   pr_warn("IOAPIC: Invalid trigger mode 2 defaulting to level\n");
   ^~~~~~~
arch/x86/kernel/apic/io_apic.c:862:2: note: here
  case MP_IRQTRIG_LEVEL:
  ^~~~
arch/x86/kernel/apic/io_apic.c: In function ‘irq_polarity’:
./include/linux/printk.h:305:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
  printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/printk.h:306:17: note: in expansion of macro ‘pr_warning’
 #define pr_warn pr_warning
                 ^~~~~~~~~~
arch/x86/kernel/apic/io_apic.c:814:3: note: in expansion of macro ‘pr_warn’
   pr_warn("IOAPIC: Invalid polarity: 2, defaulting to low\n");
   ^~~~~~~
arch/x86/kernel/apic/io_apic.c:815:2: note: here
  case MP_IRQPOL_ACTIVE_LOW:
  ^~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/kernel/apic/io_apic.c  | 2 ++
 arch/x86/kernel/cpu/cacheinfo.c | 1 +
 arch/x86/kernel/hw_breakpoint.c | 1 +
 arch/x86/kernel/kgdb.c          | 1 +
 arch/x86/kernel/uprobes.c       | 1 +
 5 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 2953bbf05c08..264e3221d923 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -812,6 +812,7 @@ static int irq_polarity(int idx)
 		return IOAPIC_POL_HIGH;
 	case MP_IRQPOL_RESERVED:
 		pr_warn("IOAPIC: Invalid polarity: 2, defaulting to low\n");
+		/* fall through */
 	case MP_IRQPOL_ACTIVE_LOW:
 	default: /* Pointless default required due to do gcc stupidity */
 		return IOAPIC_POL_LOW;
@@ -859,6 +860,7 @@ static int irq_trigger(int idx)
 		return IOAPIC_EDGE;
 	case MP_IRQTRIG_RESERVED:
 		pr_warn("IOAPIC: Invalid trigger mode 2 defaulting to level\n");
+		/* fall through */
 	case MP_IRQTRIG_LEVEL:
 	default: /* Pointless default required due to do gcc stupidity */
 		return IOAPIC_LEVEL;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c4d1023fb0ab..395d46f78582 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -248,6 +248,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	switch (leaf) {
 	case 1:
 		l1 = &l1i;
+		/* fall through */
 	case 0:
 		if (!l1->val)
 			return;
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 34a5c1715148..7d6f91f2869a 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -279,6 +279,7 @@ static int arch_build_bp_info(struct perf_event *bp,
 			hw->len = X86_BREAKPOINT_LEN_X;
 			return 0;
 		}
+		/* fall through */
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 5db08425063e..4ff6b4cdb941 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -467,6 +467,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 		ptr = &remcomInBuffer[1];
 		if (kgdb_hex2long(&ptr, &addr))
 			linux_regs->ip = addr;
+		/* fall through */
 	case 'D':
 	case 'k':
 		/* clear the trace bit */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 843feb94a950..ccf03416e434 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -745,6 +745,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		 * OPCODE1() of the "short" jmp which checks the same condition.
 		 */
 		opc1 = OPCODE2(insn) - 0x10;
+		/* fall through */
 	default:
 		if (!is_cond_jmp_opcode(opc1))
 			return -ENOSYS;
-- 
2.20.1

