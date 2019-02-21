Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20906C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfBUNMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:12:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUNMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:12:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E5B2356EA;
        Thu, 21 Feb 2019 13:12:50 +0000 (UTC)
Received: from prarit.khw1.lab.eng.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7721060C44;
        Thu, 21 Feb 2019 13:12:27 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        x86@kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] x86/fpu: Parse comma separated list passed in clearcpuid
Date:   Thu, 21 Feb 2019 08:12:25 -0500
Message-Id: <20190221131225.22063-1-prarit@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 21 Feb 2019 13:12:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Users cannot disable multiple CPU features with the kernel parameter
clearcpuid=.  For example, "clearcpuid=154 clearcpuid=227" only disables
CPUID bit 154.

Previous to commit 0c2a3913d6f5 ("x86/fpu: Parse clearcpuid= as early XSAVE
argument") it was possible to pass multiple clearcpuid options as kernel
parameters using individual entries.  With the new code it isn't easy to
replicate exactly that behaviour but a comma separated list can be easily
implemented, eg) "clearcpuid=154,227"

Make the clearcpuid parse a comma-separated list of values instead of only
a single value.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: x86@kernel.org
Cc: linux-doc@vger.kernel.org
---
 .../admin-guide/kernel-parameters.txt         | 10 ++++----
 arch/x86/kernel/fpu/init.c                    | 25 ++++++++++++++-----
 2 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 858b6c0b9a15..0084fb0a0781 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -559,11 +559,11 @@
 			systems.
 
 	clearcpuid=BITNUM [X86]
-			Disable CPUID feature X for the kernel. See
-			arch/x86/include/asm/cpufeatures.h for the valid bit
-			numbers. Note the Linux specific bits are not necessarily
-			stable over kernel options, but the vendor specific
-			ones should be.
+			Disable the comma-separated list of CPUID features for
+			the kernel. See arch/x86/include/asm/cpufeatures.h for
+			the valid bit numbers. Note the Linux specific bits
+			are not necessarily stable over kernel options, but
+			the vendor specific ones should be.
 			Also note that user programs calling CPUID directly
 			or using the feature without checking anything
 			will still see it. This just prevents it from
diff --git a/arch/x86/kernel/fpu/init.c b/arch/x86/kernel/fpu/init.c
index 6abd83572b01..14bb3ab769d2 100644
--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -251,7 +251,8 @@ static void __init fpu__init_parse_early_param(void)
 {
 	char arg[32];
 	char *argptr = arg;
-	int bit;
+	char *argptrend;
+	int bit, i, ret;
 
 	if (cmdline_find_option_bool(boot_command_line, "no387"))
 		setup_clear_cpu_cap(X86_FEATURE_FPU);
@@ -272,11 +273,23 @@ static void __init fpu__init_parse_early_param(void)
 		setup_clear_cpu_cap(X86_FEATURE_XSAVES);
 
 	if (cmdline_find_option(boot_command_line, "clearcpuid", arg,
-				sizeof(arg)) &&
-	    get_option(&argptr, &bit) &&
-	    bit >= 0 &&
-	    bit < NCAPINTS * 32)
-		setup_clear_cpu_cap(bit);
+				sizeof(arg))) {
+		argptrend = argptr + strlen(argptr) - 1;
+		for (i = 0; i < (argptrend - argptr); i++)
+			if (arg[i] == ',')
+				arg[i] = '\0';
+		while (argptr < argptrend) {
+			ret = kstrtoint(argptr, 10, &bit);
+			if (!ret && (bit >= 0 && bit < NCAPINTS * 32))
+				setup_clear_cpu_cap(bit);
+			else {
+				pr_warn("x86/fpu: clearcpuid invalid entry %s\n",
+					arg);
+				return;
+			}
+			argptr += strlen(argptr) + 1;
+		}
+	}
 }
 
 /*
-- 
2.17.2

