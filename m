Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F77C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB9A2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB9A2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbeI3ESi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:18:38 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52050 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728770AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000Gu-TS; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006sT-Li; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.353802822@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 045/131] x86/speculation, KVM: Implement support for
 VIRT_SPEC_CTRL/LS_CFG
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 47c61b3955cf712cadfc25635bf9bc174af030ea upstream.

Add the necessary logic for supporting the emulated VIRT_SPEC_CTRL MSR to
x86_virt_spec_ctrl().  If either X86_FEATURE_LS_CFG_SSBD or
X86_FEATURE_VIRT_SPEC_CTRL is set then use the new guest_virt_spec_ctrl
argument to check whether the state must be modified on the host. The
update reuses speculative_store_bypass_update() so the ZEN-specific sibling
coordination can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/spec-ctrl.h |  6 ++++++
 arch/x86/kernel/cpu/bugs.c       | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

--- a/arch/x86/include/asm/spec-ctrl.h
+++ b/arch/x86/include/asm/spec-ctrl.h
@@ -53,6 +53,12 @@ static inline u64 ssbd_tif_to_spec_ctrl(
 	return (tifn & _TIF_SSBD) >> (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
 }
 
+static inline unsigned long ssbd_spec_ctrl_to_tif(u64 spec_ctrl)
+{
+	BUILD_BUG_ON(TIF_SSBD < SPEC_CTRL_SSBD_SHIFT);
+	return (spec_ctrl & SPEC_CTRL_SSBD) << (TIF_SSBD - SPEC_CTRL_SSBD_SHIFT);
+}
+
 static inline u64 ssbd_tif_to_amd_ls_cfg(u64 tifn)
 {
 	return (tifn & _TIF_SSBD) ? x86_amd_ls_cfg_ssbd_mask : 0ULL;
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -223,6 +223,36 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
 			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
 		}
 	}
+
+	/*
+	 * If SSBD is not handled in MSR_SPEC_CTRL on AMD, update
+	 * MSR_AMD64_L2_CFG or MSR_VIRT_SPEC_CTRL if supported.
+	 */
+	if (!static_cpu_has(X86_FEATURE_LS_CFG_SSBD) &&
+	    !static_cpu_has(X86_FEATURE_VIRT_SSBD))
+		return;
+
+	/*
+	 * If the host has SSBD mitigation enabled, force it in the host's
+	 * virtual MSR value. If its not permanently enabled, evaluate
+	 * current's TIF_SSBD thread flag.
+	 */
+	if (static_cpu_has(X86_FEATURE_SPEC_STORE_BYPASS_DISABLE))
+		hostval = SPEC_CTRL_SSBD;
+	else
+		hostval = ssbd_tif_to_spec_ctrl(ti->flags);
+
+	/* Sanitize the guest value */
+	guestval = guest_virt_spec_ctrl & SPEC_CTRL_SSBD;
+
+	if (hostval != guestval) {
+		unsigned long tif;
+
+		tif = setguest ? ssbd_spec_ctrl_to_tif(guestval) :
+				 ssbd_spec_ctrl_to_tif(hostval);
+
+		speculative_store_bypass_update(tif);
+	}
 }
 EXPORT_SYMBOL_GPL(x86_virt_spec_ctrl);
 

