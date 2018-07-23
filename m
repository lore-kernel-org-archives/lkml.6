Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B5DECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2404620685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2404620685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389688AbeGWNsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:48:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51470 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388725AbeGWNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:48:07 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 71CEFCA8;
        Mon, 23 Jul 2018 12:46:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        "Matt Helsley (VMware)" <matt.helsley@gmail.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Bo Gan <ganb@vmware.com>
Subject: [PATCH 4.4 096/107] x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG
Date:   Mon, 23 Jul 2018 14:42:30 +0200
Message-Id: <20180723122418.320458689@linuxfoundation.org>
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

commit 47c61b3955cf712cadfc25635bf9bc174af030ea upstream

Add the necessary logic for supporting the emulated VIRT_SPEC_CTRL MSR to
x86_virt_spec_ctrl().  If either X86_FEATURE_LS_CFG_SSBD or
X86_FEATURE_VIRT_SPEC_CTRL is set then use the new guest_virt_spec_ctrl
argument to check whether the state must be modified on the host. The
update reuses speculative_store_bypass_update() so the ZEN-specific sibling
coordination can be reused.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Srivatsa S. Bhat <srivatsa@csail.mit.edu>
Reviewed-by: Matt Helsley (VMware) <matt.helsley@gmail.com>
Reviewed-by: Alexey Makhalov <amakhalov@vmware.com>
Reviewed-by: Bo Gan <ganb@vmware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

 arch/x86/include/asm/spec-ctrl.h |    6 ++++++
 arch/x86/kernel/cpu/bugs.c       |   30 ++++++++++++++++++++++++++++++
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
@@ -160,6 +160,36 @@ x86_virt_spec_ctrl(u64 guest_spec_ctrl,
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
 


