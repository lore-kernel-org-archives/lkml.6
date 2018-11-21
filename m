Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB1221527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAf9Gkie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB1221527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbeKVFq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732198AbeKVFq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEB1214D9;
        Wed, 21 Nov 2018 19:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827454;
        bh=DP0ypG7Y200a6kG52IlyamfPFl2mW+DQ+8Ni/mcJSeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CAf9GkieUbI9oAx1wdBDCpJfZ1VVGfyEZ3Sb9LKlIH/h1PdTm6jIoVXuPUwi2PoZD
         EQfbqwwJwyUaseNI5RfZZ9zyGr9IsFixlQfQAjbqPGtb0TbVgsv1qsa2XWBNbYNMTT
         JfX/bFX0SEzDYnTIDfsD+IbAmhqQ4zzEis4gxUSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.9 38/59] ARM: bugs: hook processor bug checking into SMP and suspend paths
Date:   Wed, 21 Nov 2018 20:06:53 +0100
Message-Id: <20181121183509.746658152@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 26602161b5ba795928a5a719fe1d5d9f2ab5c3ef upstream.

Check for CPU bugs when secondary processors are being brought online,
and also when CPUs are resuming from a low power mode.  This gives an
opportunity to check that processor specific bug workarounds are
correctly enabled for all paths that a CPU re-enters the kernel.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/include/asm/bugs.h |    2 ++
 arch/arm/kernel/bugs.c      |    5 +++++
 arch/arm/kernel/smp.c       |    4 ++++
 arch/arm/kernel/suspend.c   |    2 ++
 4 files changed, 13 insertions(+)

--- a/arch/arm/include/asm/bugs.h
+++ b/arch/arm/include/asm/bugs.h
@@ -14,8 +14,10 @@ extern void check_writebuffer_bugs(void)
 
 #ifdef CONFIG_MMU
 extern void check_bugs(void);
+extern void check_other_bugs(void);
 #else
 #define check_bugs() do { } while (0)
+#define check_other_bugs() do { } while (0)
 #endif
 
 #endif
--- a/arch/arm/kernel/bugs.c
+++ b/arch/arm/kernel/bugs.c
@@ -3,7 +3,12 @@
 #include <asm/bugs.h>
 #include <asm/proc-fns.h>
 
+void check_other_bugs(void)
+{
+}
+
 void __init check_bugs(void)
 {
 	check_writebuffer_bugs();
+	check_other_bugs();
 }
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -29,6 +29,7 @@
 #include <linux/irq_work.h>
 
 #include <linux/atomic.h>
+#include <asm/bugs.h>
 #include <asm/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cpu.h>
@@ -400,6 +401,9 @@ asmlinkage void secondary_start_kernel(v
 	 * before we continue - which happens after __cpu_up returns.
 	 */
 	set_cpu_online(cpu, true);
+
+	check_other_bugs();
+
 	complete(&cpu_running);
 
 	local_irq_enable();
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -1,6 +1,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
+#include <asm/bugs.h>
 #include <asm/cacheflush.h>
 #include <asm/idmap.h>
 #include <asm/pgalloc.h>
@@ -34,6 +35,7 @@ int cpu_suspend(unsigned long arg, int (
 		cpu_switch_mm(mm->pgd, mm);
 		local_flush_bp_all();
 		local_flush_tlb_all();
+		check_other_bugs();
 	}
 
 	return ret;


