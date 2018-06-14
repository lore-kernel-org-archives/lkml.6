Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0EF2AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B853E20864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1U+vJ30J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B853E20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966345AbeFNOQ6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:16:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966270AbeFNONh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1A620864;
        Thu, 14 Jun 2018 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985617;
        bh=aLaPIcGqQO3aCDLnIDHqLmofCvstZOQgW6f2P/UBThM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1U+vJ30Jwfo9geG1CkW8NmzhQKNZRE515l2W3oe1GZ0BjuWujRk+XnPXH5zoIx1lO
         grvTkqeBzCu7HQHYwoIBruMgCFPUBvcir31JKt3Y/K5BM8tBKXdSZNh6Zj/yoTCRRw
         PCkcBf6/GKGCzWpNr+on6/bpgkLiYQ0Dx7Ym9QOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Casasnovas <quentin.casasnovas@oracle.com>,
        Rik van Riel <riel@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        yu-cheng yu <yu-cheng.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.4 06/24] x86/fpu: Default eagerfpu=on on all CPUs
Date:   Thu, 14 Jun 2018 16:05:01 +0200
Message-Id: <20180614132724.737334115@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180614132724.483802160@linuxfoundation.org>
References: <20180614132724.483802160@linuxfoundation.org>
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

From: Andy Lutomirski <luto@kernel.org>

commit 58122bf1d856a4ea9581d62a07c557d997d46a19 upstream.

We have eager and lazy FPU modes, introduced in:

  304bceda6a18 ("x86, fpu: use non-lazy fpu restore for processors supporting xsave")

The result is rather messy.  There are two code paths in almost all
of the FPU code, and only one of them (the eager case) is tested
frequently, since most kernel developers have new enough hardware
that we use eagerfpu.

It seems that, on any remotely recent hardware, eagerfpu is a win:
glibc uses SSE2, so laziness is probably overoptimistic, and, in any
case, manipulating TS is far slower that saving and restoring the
full state.  (Stores to CR0.TS are serializing and are poorly
optimized.)

To try to shake out any latent issues on old hardware, this changes
the default to eager on all CPUs.  If no performance or functionality
problems show up, a subsequent patch could remove lazy mode entirely.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: yu-cheng yu <yu-cheng.yu@intel.com>
Link: http://lkml.kernel.org/r/ac290de61bf08d9cfc2664a4f5080257ffc1075a.1453675014.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/fpu/init.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

--- a/arch/x86/kernel/fpu/init.c
+++ b/arch/x86/kernel/fpu/init.c
@@ -252,7 +252,10 @@ static void __init fpu__init_system_xsta
  * not only saved the restores along the way, but we also have the
  * FPU ready to be used for the original task.
  *
- * 'eager' switching is used on modern CPUs, there we switch the FPU
+ * 'lazy' is deprecated because it's almost never a performance win
+ * and it's much more complicated than 'eager'.
+ *
+ * 'eager' switching is by default on all CPUs, there we switch the FPU
  * state during every context switch, regardless of whether the task
  * has used FPU instructions in that time slice or not. This is done
  * because modern FPU context saving instructions are able to optimize
@@ -263,7 +266,7 @@ static void __init fpu__init_system_xsta
  *   to use 'eager' restores, if we detect that a task is using the FPU
  *   frequently. See the fpu->counter logic in fpu/internal.h for that. ]
  */
-static enum { AUTO, ENABLE, DISABLE } eagerfpu = AUTO;
+static enum { ENABLE, DISABLE } eagerfpu = ENABLE;
 
 /*
  * Find supported xfeatures based on cpu features and command-line input.
@@ -340,15 +343,9 @@ static void __init fpu__init_system_ctx_
  */
 static void __init fpu__init_parse_early_param(void)
 {
-	/*
-	 * No need to check "eagerfpu=auto" again, since it is the
-	 * initial default.
-	 */
 	if (cmdline_find_option_bool(boot_command_line, "eagerfpu=off")) {
 		eagerfpu = DISABLE;
 		fpu__clear_eager_fpu_features();
-	} else if (cmdline_find_option_bool(boot_command_line, "eagerfpu=on")) {
-		eagerfpu = ENABLE;
 	}
 
 	if (cmdline_find_option_bool(boot_command_line, "no387"))


