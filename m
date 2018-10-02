Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4026C64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F36E206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F36E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730938AbeJBUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:14:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730838AbeJBUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:14:37 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4C82FBF0;
        Tue,  2 Oct 2018 13:31:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        Michael Neuling <mikey@neuling.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.18 225/228] KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM workarounds
Date:   Tue,  2 Oct 2018 06:25:22 -0700
Message-Id: <20181002132512.631123118@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Neuling <mikey@neuling.org>

commit f14040bca89258b8a1c71e2112e430462172ce93 upstream.

When we come into the softpatch handler (0x1500), we use r11 to store
the HSRR0 for later use by the denorm handler.

We also use the softpatch handler for the TM workarounds for
POWER9. Unfortunately, in kvmppc_interrupt_hv we later store r11 out
to the vcpu assuming it's still what we got from userspace.

This causes r11 to be corrupted in the VCPU and hence when we restore
the guest, we get a corrupted r11. We've seen this when running TM
tests inside guests on P9.

This fixes the problem by only touching r11 in the denorm case.

Fixes: 4bb3c7a020 ("KVM: PPC: Book3S HV: Work around transactional memory bugs in POWER9")
Cc: <stable@vger.kernel.org> # 4.17+
Test-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/exceptions-64s.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1321,9 +1321,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x15
 
 #ifdef CONFIG_PPC_DENORMALISATION
 	mfspr	r10,SPRN_HSRR1
-	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
 	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
-	addi	r11,r11,-4		/* HSRR0 is next instruction */
 	bne+	denorm_assist
 #endif
 
@@ -1389,6 +1387,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
  */
 	XVCPSGNDP32(32)
 denorm_done:
+	mfspr	r11,SPRN_HSRR0
+	subi	r11,r11,4
 	mtspr	SPRN_HSRR0,r11
 	mtcrf	0x80,r9
 	ld	r9,PACA_EXGEN+EX_R9(r13)


