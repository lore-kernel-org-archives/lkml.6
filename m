Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD3AC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38D9208A5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38D9208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932563AbeGHKIF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:08:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932227AbeGHKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:08:04 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fc6bq-00047Q-Jo; Sun, 08 Jul 2018 12:08:02 +0200
Date:   Sun, 8 Jul 2018 12:08:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86/pti updates for 4.18 
Message-ID: <alpine.DEB.2.21.1807081206320.1589@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-pti-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-pti-for-linus

Two small fixes correcting the handling of SSB mitigations on AMD
processors.

Thanks,

	tglx

------------------>
Tom Lendacky (2):
      x86/bugs: Update when to check for the LS_CFG SSBD mitigation
      x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR


 arch/x86/kernel/cpu/amd.c  | 4 +++-
 arch/x86/kernel/cpu/bugs.c | 8 +++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 082d7875cef8..38915fbfae73 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -543,7 +543,9 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		nodes_per_socket = ((value >> 3) & 7) + 1;
 	}
 
-	if (c->x86 >= 0x15 && c->x86 <= 0x17) {
+	if (!boot_cpu_has(X86_FEATURE_AMD_SSBD) &&
+	    !boot_cpu_has(X86_FEATURE_VIRT_SSBD) &&
+	    c->x86 >= 0x15 && c->x86 <= 0x17) {
 		unsigned int bit;
 
 		switch (c->x86) {
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 404df26b7de8..5c0ea39311fe 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -155,7 +155,8 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
 
 		/* SSBD controlled in MSR_SPEC_CTRL */
-		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
+		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) ||
+		    static_cpu_has(X86_FEATURE_AMD_SSBD))
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
 		if (hostval != guestval) {
@@ -533,9 +534,10 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
 		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
 		 * use a completely different MSR and bit dependent on family.
 		 */
-		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
+		if (!static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD) &&
+		    !static_cpu_has(X86_FEATURE_AMD_SSBD)) {
 			x86_amd_ssb_disable();
-		else {
+		} else {
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
 			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
