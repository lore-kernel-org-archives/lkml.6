Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD57C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E6A20815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfBCODW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:03:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52974 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727977AbfBCNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:46 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9Y-0003w8-3T; Sun, 03 Feb 2019 13:49:44 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006xA-V1; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Liran Alon" <liran.alon@oracle.com>,
        "Jim Mattson" <jmattson@google.com>,
        "Abhiroop Dabral" <adabral@paloaltonetworks.com>,
        "Peter Shier" <pshier@google.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.845258814@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 094/305] KVM: nVMX: Always reflect #NM VM-exits to L1
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jim Mattson <jmattson@google.com>

commit 3c6e099fa15fdb6fb1892199ed8709012e1294f2 upstream.

When bit 3 (corresponding to CR0.TS) of the VMCS12 cr0_guest_host_mask
field is clear, the VMCS12 guest_cr0 field does not necessarily hold
the current value of the L2 CR0.TS bit, so the code that checked for
L2's CR0.TS bit being set was incorrect. Moreover, I'm not sure that
the CR0.TS check was adequate. (What if L2's CR0.EM was set, for
instance?)

Fortunately, lazy FPU has gone away, so L0 has lost all interest in
intercepting #NM exceptions. See commit bd7e5b0899a4 ("KVM: x86:
remove code for lazy FPU handling"). Therefore, there is no longer any
question of which hypervisor gets first dibs. The #NM VM-exit should
always be reflected to L1. (Note that the corresponding bit must be
set in the VMCS12 exception_bitmap field for there to be an #NM
VM-exit at all.)

Fixes: ccf9844e5d99c ("kvm, vmx: Really fix lazy FPU on nested guest")
Reported-by: Abhiroop Dabral <adabral@paloaltonetworks.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Tested-by: Abhiroop Dabral <adabral@paloaltonetworks.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16:
 - is_no_device() hadn't been converted to use is_exception_n()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kvm/vmx.c | 8 --------
 1 file changed, 8 deletions(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -847,13 +847,6 @@ static inline bool is_page_fault(u32 int
 		(INTR_TYPE_HARD_EXCEPTION | PF_VECTOR | INTR_INFO_VALID_MASK);
 }
 
-static inline bool is_no_device(u32 intr_info)
-{
-	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
-			     INTR_INFO_VALID_MASK)) ==
-		(INTR_TYPE_HARD_EXCEPTION | NM_VECTOR | INTR_INFO_VALID_MASK);
-}
-
 static inline bool is_invalid_opcode(u32 intr_info)
 {
 	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
@@ -6939,9 +6932,6 @@ static bool nested_vmx_exit_handled(stru
 			return 0;
 		else if (is_page_fault(intr_info))
 			return enable_ept;
-		else if (is_no_device(intr_info) &&
-			 !(vmcs12->guest_cr0 & X86_CR0_TS))
-			return 0;
 		return vmcs12->exception_bitmap &
 				(1u << (intr_info & INTR_INFO_VECTOR_MASK));
 	case EXIT_REASON_EXTERNAL_INTERRUPT:

