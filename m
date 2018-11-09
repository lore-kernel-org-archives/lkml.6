Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCD2C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D310A20818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D310A20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbeKJIAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 03:00:40 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53376 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeKJIAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 03:00:40 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KMeVoO7jLcQp; Fri,  9 Nov 2018 23:18:05 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B04631EC02A3;
        Fri,  9 Nov 2018 23:18:04 +0100 (CET)
Date:   Fri, 9 Nov 2018 23:17:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Matz <matz@suse.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Yi Wang <wang.yi59@zte.com.cn>, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, suravee.suthikulpanit@amd.com, puwen@hygon.cn,
        davidwang@zhaoxin.com, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn
Subject: Re: [PATCH v2] x86/cpu: fix prototype warning
Message-ID: <20181109221750.GA4971@zn.tnic>
References: <1541639548-11149-1-git-send-email-wang.yi59@zte.com.cn>
 <20181108150318.GD7543@zn.tnic>
 <20181108153226.GF7543@zn.tnic>
 <alpine.LSU.2.21.1811081538120.21712@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.21.1811081538120.21712@wotan.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 03:47:32PM +0000, Michael Matz wrote:
> What tglx said.  If you don't intend such functions to be called 
> from other units make them static, if you do intend them to be callable 
> declare the properly.

Well, I'll be damned!

That just caught two bugs, the smp_thermal_interrupt() is *exactly* what
the warning is supposed to catch - functions with changed prototype!

---
From: Borislav Petkov <bp@suse.de>
Date: Fri, 9 Nov 2018 23:13:13 +0100
Subject: [PATCH] x86/mce: Fix -Wmissing-prototypes warnings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the proper includes and make smca_get_name() static.

Fix an actual bug too which the warning triggered:

  arch/x86/kernel/cpu/mcheck/therm_throt.c:395:39: error: conflicting \
  types for ‘smp_thermal_interrupt’
   asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
                                         ^~~~~~~~~~~~~~~~~~~~~
  In file included from arch/x86/kernel/cpu/mcheck/therm_throt.c:29:
  ./arch/x86/include/asm/traps.h:107:17: note: previous declaration of \
	  ‘smp_thermal_interrupt’ was here
   asmlinkage void smp_thermal_interrupt(void);

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mcheck/mce_amd.c     | 3 ++-
 arch/x86/kernel/cpu/mcheck/therm_throt.c | 3 ++-
 arch/x86/kernel/cpu/mcheck/threshold.c   | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index dd33c357548f..87499b997039 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -23,6 +23,7 @@
 #include <linux/string.h>
 
 #include <asm/amd_nb.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
@@ -99,7 +100,7 @@ static u32 smca_bank_addrs[MAX_NR_BANKS][NR_BLOCKS] __ro_after_init =
 	[0 ... MAX_NR_BANKS - 1] = { [0 ... NR_BLOCKS - 1] = -1 }
 };
 
-const char *smca_get_name(enum smca_bank_types t)
+static const char *smca_get_name(enum smca_bank_types t)
 {
 	if (t >= N_SMCA_BANK_TYPES)
 		return NULL;
diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
index 0d3f6b6a5739..70a05de7ea59 100644
--- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
+++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
@@ -26,6 +26,7 @@
 #include <linux/cpu.h>
 
 #include <asm/processor.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
@@ -391,7 +392,7 @@ static void unexpected_thermal_interrupt(void)
 
 static void (*smp_thermal_vector)(void) = unexpected_thermal_interrupt;
 
-asmlinkage __visible void __irq_entry smp_thermal_interrupt(struct pt_regs *r)
+asmlinkage __visible void __irq_entry smp_thermal_interrupt(void)
 {
 	entering_irq();
 	trace_thermal_apic_entry(THERMAL_APIC_VECTOR);
diff --git a/arch/x86/kernel/cpu/mcheck/threshold.c b/arch/x86/kernel/cpu/mcheck/threshold.c
index 2b584b319eff..b0c60beb6312 100644
--- a/arch/x86/kernel/cpu/mcheck/threshold.c
+++ b/arch/x86/kernel/cpu/mcheck/threshold.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 
 #include <asm/irq_vectors.h>
+#include <asm/traps.h>
 #include <asm/apic.h>
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
