Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF13C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164A82098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff+FmhPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164A82098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730941AbeJQBNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729207AbeJQBNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:13:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857842089E;
        Tue, 16 Oct 2018 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710497;
        bh=VX+Zwg51U2Ysk4/xWv19YG42sjv5GbKnjkaBarC7pOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ff+FmhPOucaWn0iwylEAvbl+iUiR7usz7DCILHQpC+c5S9R14d0n8mue6o+25w5xz
         VXkJLIvzJbLFPZ0+EsjOK8AqoZ7ES9j81U6B7rwOzggILVH2SAzh4xISg8VNmxDz7o
         lAwnBkQVyNn5ly5Dd/kG6SJvOyjYY35qvm0LAuy4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "David A. Long" <dave.long@linaro.org>
Subject: [PATCH 4.14 098/109] ARM: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling
Date:   Tue, 16 Oct 2018 19:06:06 +0200
Message-Id: <20181016170530.309983468@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -253,6 +254,20 @@ THUMB(	orr	lr, #1)
 	pop	{r2, lr}
 	eret
 
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
 


