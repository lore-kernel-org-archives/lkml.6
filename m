Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1C8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9BFC208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p8KZ5K5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BFC208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeLEUJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:09:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:41426 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeLEUJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:09:17 -0500
Received: from zn.tnic (p200300EC2BC09900ED3DB18DCE3E6DEF.dip0.t-ipconnect.de [IPv6:2003:ec:2bc0:9900:ed3d:b18d:ce3e:6def])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5758F1EC0B89;
        Wed,  5 Dec 2018 21:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544040555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZJK1+K8g3o0hszzc92rk41OSC1TG0mlEGoJV2Nqo8Xg=;
        b=p8KZ5K5zcldL2ZRXQRsflsfB5Ngb8rdnVC5iKO4KfqGLXWpU9/XWA7HriQNTBS3Q7PK/IT
        Ueb3JWj2fmsmno+oQWYGxOleD/WVtebAbC6wEWUlTub2CbQ3W++0Ar+wYVLzrtAMG0dufv
        GbWUTKhZF+wAHS+5+jq32uPCc+6+++s=
Date:   Wed, 5 Dec 2018 21:09:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH] x86/mce: Unify pr_* prefix
Message-ID: <20181205200913.GR29510@zn.tnic>
References: <20181205141323.14995-1-bp@alien8.de>
 <20181205165711.GA23186@agluck-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181205165711.GA23186@agluck-desk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 08:57:16AM -0800, Luck, Tony wrote:
> Acked-by: Tony Luck <tony.luck@intel.com>

One more thing we need to do ontop, otherwise the prefix changes:

-mce: CPU supports 23 MCE banks
+core: CPU supports 23 MCE banks

---
Move the pr_fmt prefix to internal.h and include it everywhere. This
way, all pr_* printed strings will be prepended with "mce: ".

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/core.c        | 2 --
 arch/x86/kernel/cpu/mce/dev-mcelog.c  | 2 --
 arch/x86/kernel/cpu/mce/internal.h    | 3 +++
 arch/x86/kernel/cpu/mce/p5.c          | 2 ++
 arch/x86/kernel/cpu/mce/therm_throt.c | 2 ++
 arch/x86/kernel/cpu/mce/threshold.c   | 2 ++
 arch/x86/kernel/cpu/mce/winchip.c     | 2 ++
 7 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index b0ae12cf7827..ad8f62a0c706 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -8,8 +8,6 @@
  * Author: Andi Kleen
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/thread_info.h>
 #include <linux/capability.h>
 #include <linux/miscdevice.h>
diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 41d9169d27fa..9690ec5c8051 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -8,8 +8,6 @@
  * Author: Andi Kleen
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/miscdevice.h>
 #include <linux/slab.h>
 #include <linux/kmod.h>
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index ceb67cd5918f..af5eab1e65e2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -2,6 +2,9 @@
 #ifndef __X86_MCE_INTERNAL_H__
 #define __X86_MCE_INTERNAL_H__
 
+#undef pr_fmt
+#define pr_fmt(fmt) "mce: " fmt
+
 #include <linux/device.h>
 #include <asm/mce.h>
 
diff --git a/arch/x86/kernel/cpu/mce/p5.c b/arch/x86/kernel/cpu/mce/p5.c
index 5cddf831720f..4ae6df556526 100644
--- a/arch/x86/kernel/cpu/mce/p5.c
+++ b/arch/x86/kernel/cpu/mce/p5.c
@@ -14,6 +14,8 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 /* By default disabled */
 int mce_p5_enabled __read_mostly;
 
diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
index 2da67b70ba98..df01ff8513a5 100644
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -30,6 +30,8 @@
 #include <asm/msr.h>
 #include <asm/trace/irq_vectors.h>
 
+#include "internal.h"
+
 /* How long to wait between reporting thermal events */
 #define CHECK_INTERVAL		(300 * HZ)
 
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 2b584b319eff..10586a85c23f 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -10,6 +10,8 @@
 #include <asm/mce.h>
 #include <asm/trace/irq_vectors.h>
 
+#include "internal.h"
+
 static void default_threshold_interrupt(void)
 {
 	pr_err("Unexpected threshold interrupt at vector %x\n",
diff --git a/arch/x86/kernel/cpu/mce/winchip.c b/arch/x86/kernel/cpu/mce/winchip.c
index 3b45b270a865..a30ea13cccc2 100644
--- a/arch/x86/kernel/cpu/mce/winchip.c
+++ b/arch/x86/kernel/cpu/mce/winchip.c
@@ -13,6 +13,8 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 
+#include "internal.h"
+
 /* Machine check handler for WinChip C6: */
 static void winchip_machine_check(struct pt_regs *regs, long error_code)
 {
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
