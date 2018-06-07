Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +k/PFb9ZGVueCgAAmS7hNA
	; Thu, 07 Jun 2018 16:14:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4D00C607E7; Thu,  7 Jun 2018 16:14:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D110C60115;
	Thu,  7 Jun 2018 16:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D110C60115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934982AbeFGQNb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:13:31 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39144 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932940AbeFGOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:08:59 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0005Zn-5k; Thu, 07 Jun 2018 15:08:56 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvax-0002gJ-1j; Thu, 07 Jun 2018 15:08:55 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Borislav Petkov" <bp@suse.de>, "Juergen Gross" <jgross@suse.com>,
        "Rolf Neugebauer" <rolf.neugebauer@docker.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.292456579@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 004/410] x86/microcode/AMD: Do not load when running
 on a hypervisor
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit a15a753539eca8ba243d576f02e7ca9c4b7d7042 upstream.

Doing so is completely void of sense for multiple reasons so prevent
it. Set dis_ucode_ldr to true and thus disable the microcode loader by
default to address xen pv guests which execute the AP path but not the
BSP path.

By having it turned off by default, the APs won't run into the loader
either.

Also, check CPUID(1).ECX[31] which hypervisors set. Well almost, not the
xen pv one. That one gets the aforementioned "fix".

Also, improve the detection method by caching the final decision whether
to continue loading in dis_ucode_ldr and do it once on the BSP. The APs
then simply test that value.

Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Acked-by: Juergen Gross <jgross@suse.com>
Link: http://lkml.kernel.org/r/20161218164414.9649-4-bp@alien8.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Rolf Neugebauer <rolf.neugebauer@docker.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16:
 - Early microcode loader is optional, so only set dis_ucode_ldr by default
   if it is enabled
 - Adjust context, filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -97,7 +97,7 @@ MODULE_LICENSE("GPL");
 
 static struct microcode_ops	*microcode_ops;
 
-bool dis_ucode_ldr;
+bool dis_ucode_ldr = IS_ENABLED(CONFIG_MICROCODE_EARLY);
 module_param(dis_ucode_ldr, bool, 0);
 
 /*
--- a/arch/x86/kernel/cpu/microcode/core_early.c
+++ b/arch/x86/kernel/cpu/microcode/core_early.c
@@ -76,6 +76,8 @@ static int x86_family(void)
 
 static bool __init check_loader_disabled_bsp(void)
 {
+	u32 a, b, c, d;
+
 #ifdef CONFIG_X86_32
 	const char *cmdline = (const char *)__pa_nodebug(boot_command_line);
 	const char *opt	    = "dis_ucode_ldr";
@@ -88,8 +90,23 @@ static bool __init check_loader_disabled
 	bool *res = &dis_ucode_ldr;
 #endif
 
-	if (cmdline_find_option_bool(cmdline, option))
-		*res = true;
+	if (!have_cpuid_p())
+		return *res;
+
+	a = 1;
+	c = 0;
+	native_cpuid(&a, &b, &c, &d);
+
+	/*
+	 * CPUID(1).ECX[31]: reserved for hypervisor use. This is still not
+	 * completely accurate as xen pv guests don't see that CPUID bit set but
+	 * that's good enough as they don't land on the BSP path anyway.
+	 */
+	if (c & BIT(31))
+		return *res;
+
+	if (cmdline_find_option_bool(cmdline, option) <= 0)
+		*res = false;
 
 	return *res;
 }
@@ -101,9 +118,6 @@ void __init load_ucode_bsp(void)
 	if (check_loader_disabled_bsp())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_vendor();
 	x86 = x86_family();
 
@@ -137,9 +151,6 @@ void load_ucode_ap(void)
 	if (check_loader_disabled_ap())
 		return;
 
-	if (!have_cpuid_p())
-		return;
-
 	vendor = x86_vendor();
 	x86 = x86_family();
 
