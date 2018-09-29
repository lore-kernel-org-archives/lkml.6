Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1755C64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805BB2087A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 805BB2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeI3EVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:21:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52046 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728769AbeI3ESf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:35 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N6E-0000Gx-TD; Sat, 29 Sep 2018 22:48:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5w-0006sO-KN; Sat, 29 Sep 2018 22:48:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Borislav Petkov" <bp@suse.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.335156076@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 044/131] x86/bugs: Rework spec_ctrl base and mask logic
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

commit be6fcb5478e95bb1c91f489121238deb3abca46a upstream.

x86_spec_ctrL_mask is intended to mask out bits from a MSR_SPEC_CTRL value
which are not to be modified. However the implementation is not really used
and the bitmask was inverted to make a check easier, which was removed in
"x86/bugs: Remove x86_spec_ctrl_set()"

Aside of that it is missing the STIBP bit if it is supported by the
platform, so if the mask would be used in x86_virt_spec_ctrl() then it
would prevent a guest from setting STIBP.

Add the STIBP bit if supported and use the mask in x86_virt_spec_ctrl() to
sanitize the value which is supplied by the guest.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/cpu/bugs.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -41,7 +41,7 @@ EXPORT_SYMBOL_GPL(x86_spec_ctrl_base);
  * The vendor and possibly platform specific bits which can be modified in
  * x86_spec_ctrl_base.
  */
-static u64 x86_spec_ctrl_mask = ~SPEC_CTRL_IBRS;
+static u64 x86_spec_ctrl_mask = SPEC_CTRL_IBRS;
 
 /*
  * AMD specific MSR info for Speculative Store Bypass control.
@@ -125,6 +125,10 @@ void __init check_bugs(void)
 	if (boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
 		rdmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 
+	/* Allow STIBP in MSR_SPEC_CTRL if supported */
+	if (boot_cpu_has(X86_FEATURE_STIBP))
+		x86_spec_ctrl_mask |= SPEC_CTRL_STIBP;
+
 	/* Select the proper spectre mitigation before patching alternatives */
 	spectre_v2_select_mitigation();
 
@@ -197,18 +201,26 @@ static enum spectre_v2_mitigation spectr
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
+	u64 msrval, guestval, hostval = x86_spec_ctrl_base;
 	struct thread_info *ti = current_thread_info();
-	u64 msr, host = x86_spec_ctrl_base;
 
 	/* Is MSR_SPEC_CTRL implemented ? */
 	if (static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
+		/*
+		 * Restrict guest_spec_ctrl to supported values. Clear the
+		 * modifiable bits in the host base value and or the
+		 * modifiable bits from the guest value.
+		 */
+		guestval = hostval & ~x86_spec_ctrl_mask;
+		guestval |= guest_spec_ctrl & x86_spec_ctrl_mask;
+
 		/* SSBD controlled in MSR_SPEC_CTRL */
 		if (static_cpu_has(X86_FEATURE_SPEC_CTRL_SSBD))
-			host |= ssbd_tif_to_spec_ctrl(ti->flags);
+			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
-		if (host != guest_spec_ctrl) {
-			msr = setguest ? guest_spec_ctrl : host;
-			wrmsrl(MSR_IA32_SPEC_CTRL, msr);
+		if (hostval != guestval) {
+			msrval = setguest ? guestval : hostval;
+			wrmsrl(MSR_IA32_SPEC_CTRL, msrval);
 		}
 	}
 }
@@ -530,7 +542,7 @@ static enum ssb_mitigation __init __ssb_
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
 			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
-			x86_spec_ctrl_mask &= ~SPEC_CTRL_SSBD;
+			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
 			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
 			break;
 		case X86_VENDOR_AMD:

