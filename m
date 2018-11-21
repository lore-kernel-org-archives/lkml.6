Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0469C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950FC21582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spa7RfU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950FC21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbeKVFq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729280AbeKVFq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC16D214DB;
        Wed, 21 Nov 2018 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827484;
        bh=FMqbs1/Lc3B2Cyi8rdihx3kab0hpkG3/8l2KwBMd09w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Spa7RfU+XlJwrkuth7BUfYQnOz0Qmvp8YKvrshUB8cFUME82Y4ZKHm2C/pwWL83jO
         oJh3NsVyYeReqD1lnWYPOw0nUeZCtl7CO49dDruLqJcfCk6niK2A4uCmcWTfCKTQxL
         5LHEG4oExNg8RYsbRXlGOKA/dm6hRp+2pzy2UjWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.9 49/59] ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date:   Wed, 21 Nov 2018 20:07:04 +0100
Message-Id: <20181121183510.213945179@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit b800acfc70d9fb81fbd6df70f2cf5e20f70023d0 upstream.

We want SMCCC_ARCH_WORKAROUND_1 to be fast. As fast as possible.
So let's intercept it as early as we can by testing for the
function call number as soon as we've identified a HVC call
coming from the guest.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Boot-tested-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: David A. Long <dave.long@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/kvm/hyp/hyp-entry.S |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- a/arch/arm/kvm/hyp/hyp-entry.S
+++ b/arch/arm/kvm/hyp/hyp-entry.S
@@ -16,6 +16,7 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/linkage.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
@@ -202,7 +203,7 @@ hyp_hvc:
 	lsr     r2, r2, #16
 	and     r2, r2, #0xff
 	cmp     r2, #0
-	bne	guest_trap		@ Guest called HVC
+	bne	guest_hvc_trap		@ Guest called HVC
 
 	/*
 	 * Getting here means host called HVC, we shift parameters and branch
@@ -235,6 +236,20 @@ THUMB(	orr	lr, #1)
 	pop	{r2, lr}
 1:	eret
 
+guest_hvc_trap:
+	movw	r2, #:lower16:ARM_SMCCC_ARCH_WORKAROUND_1
+	movt	r2, #:upper16:ARM_SMCCC_ARCH_WORKAROUND_1
+	ldr	r0, [sp]		@ Guest's r0
+	teq	r0, r2
+	bne	guest_trap
+	add	sp, sp, #12
+	@ Returns:
+	@ r0 = 0
+	@ r1 = HSR value (perfectly predictable)
+	@ r2 = ARM_SMCCC_ARCH_WORKAROUND_1
+	mov	r0, #0
+	eret
+
 guest_trap:
 	load_vcpu r0			@ Load VCPU pointer to r0
 


