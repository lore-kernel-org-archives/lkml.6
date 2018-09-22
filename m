Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB94AECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3E420870
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3E420870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391957AbeIVGKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:10:46 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44150 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391933AbeIVGKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:10:45 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdv-0008BQ-6k; Sat, 22 Sep 2018 01:19:27 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g3Vdp-0000uR-7D; Sat, 22 Sep 2018 01:19:21 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Peter Zijlstra" <peterz@infradead.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kyle Huey" <khuey@kylehuey.com>,
        "Andy Lutomirski" <luto@kernel.org>, "Kyle Huey" <me@kylehuey.com>
Date:   Sat, 22 Sep 2018 01:15:42 +0100
Message-ID: <lsq.1537575342.558857038@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 59/63] x86/process: Correct and optimize
 TIF_BLOCKSTEP switch
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

From: Kyle Huey <me@kylehuey.com>

commit b9894a2f5bd18b1691cb6872c9afe32b148d0132 upstream.

The debug control MSR is "highly magical" as the blockstep bit can be
cleared by hardware under not well documented circumstances.

So a task switch relying on the bit set by the previous task (according to
the previous tasks thread flags) can trip over this and not update the flag
for the next task.

To fix this its required to handle DEBUGCTLMSR_BTF when either the previous
or the next or both tasks have the TIF_BLOCKSTEP flag set.

While at it avoid branching within the TIF_BLOCKSTEP case and evaluating
boot_cpu_data twice in kernels without CONFIG_X86_DEBUGCTLMSR.

x86_64: arch/x86/kernel/process.o
text	data	bss	dec	 hex
3024    8577    16      11617    2d61	Before
3008	8577	16	11601	 2d51	After

i386: No change

[ tglx: Made the shift value explicit, use a local variable to make the
code readable and massaged changelog]

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: http://lkml.kernel.org/r/20170214081104.9244-3-khuey@kylehuey.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/uapi/asm/msr-index.h |  1 +
 arch/x86/kernel/process.c             | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

--- a/arch/x86/include/uapi/asm/msr-index.h
+++ b/arch/x86/include/uapi/asm/msr-index.h
@@ -109,6 +109,7 @@
 
 /* DEBUGCTLMSR bits (others vary by model): */
 #define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_TR			(1UL <<  6)
 #define DEBUGCTLMSR_BTS			(1UL <<  7)
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -231,13 +231,15 @@ void __switch_to_xtra(struct task_struct
 
 	propagate_user_return_notify(prev_p, next_p);
 
-	if ((tifp ^ tifn) & _TIF_BLOCKSTEP) {
-		unsigned long debugctl = get_debugctlmsr();
+	if ((tifp & _TIF_BLOCKSTEP || tifn & _TIF_BLOCKSTEP) &&
+	    arch_has_block_step()) {
+		unsigned long debugctl, msk;
 
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 		debugctl &= ~DEBUGCTLMSR_BTF;
-		if (tifn & _TIF_BLOCKSTEP)
-			debugctl |= DEBUGCTLMSR_BTF;
-		update_debugctlmsr(debugctl);
+		msk = tifn & _TIF_BLOCKSTEP;
+		debugctl |= (msk >> TIF_BLOCKSTEP) << DEBUGCTLMSR_BTF_SHIFT;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
 	}
 
 	if ((tifp ^ tifn) & _TIF_NOTSC) {

