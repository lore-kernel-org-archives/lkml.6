Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67807ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2775720856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2775720856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbeGWNuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:50:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51200 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389625AbeGWNsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:06 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 96980BB3;
        Mon, 23 Jul 2018 12:46:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 094/107] x86/bugs: Remove x86_spec_ctrl_set()
Date:   Mon, 23 Jul 2018 14:42:28 +0200
Message-Id: <20180723122418.223314612@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723122413.003644357@linuxfoundation.org>
References: <20180723122413.003644357@linuxfoundation.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

commit 4b59bdb569453a60b752b274ca61f009e37f4dae upstream

x86_spec_ctrl_set() is only used in bugs.c and the extra mask checks there
provide no real value as both call sites can just write x86_spec_ctrl_base
to MSR_SPEC_CTRL. x86_spec_ctrl_base is valid and does not need any extra
masking or checking.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/nospec-branch.h |    2 --
 arch/x86/kernel/cpu/bugs.c           |   13 ++-----------
 2 files changed, 2 insertions(+), 13 deletions(-)

--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -172,8 +172,6 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_IBRS,
 };
 
-extern void x86_spec_ctrl_set(u64);
-
 /* The Speculative Store Bypass disable variants */
 enum ssb_mitigation {
 	SPEC_STORE_BYPASS_NONE,
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -131,15 +131,6 @@ static const char *spectre_v2_strings[]
 
 static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
-void x86_spec_ctrl_set(u64 val)
-{
-	if (val & x86_spec_ctrl_mask)
-		WARN_ONCE(1, "SPEC_CTRL MSR value 0x%16llx is unknown.\n", val);
-	else
-		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base | val);
-}
-EXPORT_SYMBOL_GPL(x86_spec_ctrl_set);
-
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
@@ -501,7 +492,7 @@ static enum ssb_mitigation __init __ssb_
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
-			x86_spec_ctrl_set(SPEC_CTRL_SSBD);
+			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
 		case X86_VENDOR_AMD:
 			x86_amd_ssb_disable();
@@ -613,7 +604,7 @@ int arch_prctl_spec_ctrl_get(struct task
 void x86_spec_ctrl_setup_ap(void)
 {
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
-		x86_spec_ctrl_set(x86_spec_ctrl_base & ~x86_spec_ctrl_mask);
+		wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
 	if (ssb_mode == SPEC_STORE_BYPASS_DISABLE)
 		x86_amd_ssb_disable();


