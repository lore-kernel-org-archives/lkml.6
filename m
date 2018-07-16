Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F3ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0344E2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0344E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389525AbeGPILI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:11:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48424 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbeGPILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:11:07 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4914CC03;
        Mon, 16 Jul 2018 07:45:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Dave Hansen <dave@sr71.net>, Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 33/43] x86/cpufeature, x86/mm/pkeys: Fix broken compile-time disabling of pkeys
Date:   Mon, 16 Jul 2018 09:36:38 +0200
Message-Id: <20180716073515.536549288@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit e8df1a95b685af84a81698199ee206e0e66a8b44 upstream

When I added support for the Memory Protection Keys processor
feature, I had to reindent the REQUIRED/DISABLED_MASK macros, and
also consult the later cpufeature words.

I'm not quite sure how I bungled it, but I consulted the wrong
word at the end.  This only affected required or disabled cpu
features in cpufeature words 14, 15 and 16.  So, only Protection
Keys itself was screwed over here.

The result was that if you disabled pkeys in your .config, you
might still see some code show up that should have been compiled
out.  There should be no functional problems, though.

In verifying this patch I also realized that the DISABLE_PKU/OSPKE
macros were defined backwards and that the cpu_has() check in
setup_pku() was not doing the compile-time disabled checks.

So also fix the macro for DISABLE_PKU/OSPKE and add a compile-time
check for pkeys being enabled in setup_pku().

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <stable@vger.kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Dave Hansen <dave@sr71.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: dfb4a70f20c5 ("x86/cpufeature, x86/mm/pkeys: Add protection keys related CPUID definitions")
Link: http://lkml.kernel.org/r/20160513221328.C200930B@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/cpufeature.h        |   12 ++++++------
 arch/x86/include/asm/disabled-features.h |    6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -64,9 +64,9 @@ extern const char * const x86_bug_flags[
 	   (((bit)>>5)==11 && (1UL<<((bit)&31) & REQUIRED_MASK11)) ||	\
 	   (((bit)>>5)==12 && (1UL<<((bit)&31) & REQUIRED_MASK12)) ||	\
 	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK13)) ||	\
-	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK14)) ||	\
-	   (((bit)>>5)==13 && (1UL<<((bit)&31) & REQUIRED_MASK15)) ||	\
-	   (((bit)>>5)==14 && (1UL<<((bit)&31) & REQUIRED_MASK16)) )
+	   (((bit)>>5)==14 && (1UL<<((bit)&31) & REQUIRED_MASK14)) ||	\
+	   (((bit)>>5)==15 && (1UL<<((bit)&31) & REQUIRED_MASK15)) ||	\
+	   (((bit)>>5)==16 && (1UL<<((bit)&31) & REQUIRED_MASK16)) )
 
 #define DISABLED_MASK_BIT_SET(bit)					\
 	 ( (((bit)>>5)==0  && (1UL<<((bit)&31) & DISABLED_MASK0 )) ||	\
@@ -83,9 +83,9 @@ extern const char * const x86_bug_flags[
 	   (((bit)>>5)==11 && (1UL<<((bit)&31) & DISABLED_MASK11)) ||	\
 	   (((bit)>>5)==12 && (1UL<<((bit)&31) & DISABLED_MASK12)) ||	\
 	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK13)) ||	\
-	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK14)) ||	\
-	   (((bit)>>5)==13 && (1UL<<((bit)&31) & DISABLED_MASK15)) ||	\
-	   (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
+	   (((bit)>>5)==14 && (1UL<<((bit)&31) & DISABLED_MASK14)) ||	\
+	   (((bit)>>5)==15 && (1UL<<((bit)&31) & DISABLED_MASK15)) ||	\
+	   (((bit)>>5)==16 && (1UL<<((bit)&31) & DISABLED_MASK16)) )
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -31,11 +31,11 @@
 #endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-# define DISABLE_PKU		(1<<(X86_FEATURE_PKU))
-# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE))
-#else
 # define DISABLE_PKU		0
 # define DISABLE_OSPKE		0
+#else
+# define DISABLE_PKU		(1<<(X86_FEATURE_PKU & 31))
+# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
 /*


