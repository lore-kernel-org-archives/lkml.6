Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B91B20870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B91B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392450AbeIVGQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:16:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44119 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391847AbeIVGKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:44 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vds-0008BN-9h; Sat, 22 Sep 2018 01:19:24 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdn-0000pj-3e; Sat, 22 Sep 2018 01:19:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Fenghua Yu" <fenghua.yu@intel.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Dave Hansen" <dave.hansen@linux.intel.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.627989017@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 01/63] x86/fpu: Fix the 'nofxsr' boot parameter to
 also clear X86_FEATURE_FXSR_OPT
In-Reply-To: <lsq.1537575341.194909669@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.58-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit d364a7656c1855c940dfa4baf4ebcc3c6a9e6fd2 upstream.

I tried to simulate an ancient CPU via this option, and
found that it still has fxsr_opt enabled, confusing the
FPU code.

Make the 'nofxsr' option also clear FXSR_OPT flag.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/common.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -199,6 +199,15 @@ static int __init x86_noinvpcid_setup(ch
 }
 early_param("noinvpcid", x86_noinvpcid_setup);
 
+static int __init x86_fxsr_setup(char *s)
+{
+	setup_clear_cpu_cap(X86_FEATURE_FXSR);
+	setup_clear_cpu_cap(X86_FEATURE_FXSR_OPT);
+	setup_clear_cpu_cap(X86_FEATURE_XMM);
+	return 1;
+}
+__setup("nofxsr", x86_fxsr_setup);
+
 #ifdef CONFIG_X86_32
 static int cachesize_override = -1;
 static int disable_x86_serial_nr = 1;
@@ -210,14 +219,6 @@ static int __init cachesize_setup(char *
 }
 __setup("cachesize=", cachesize_setup);
 
-static int __init x86_fxsr_setup(char *s)
-{
-	setup_clear_cpu_cap(X86_FEATURE_FXSR);
-	setup_clear_cpu_cap(X86_FEATURE_XMM);
-	return 1;
-}
-__setup("nofxsr", x86_fxsr_setup);
-
 static int __init x86_sep_setup(char *s)
 {
 	setup_clear_cpu_cap(X86_FEATURE_SEP);

