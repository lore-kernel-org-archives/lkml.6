Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED26FC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFE0218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358020;
	bh=AR5Zme5b2RcK0E1wPLcf0RbXXMCHn0KlH8RJpvLoIow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ff+BO0GsWZgFt77tC1GFimcaepcW966zThZr6RgSplbF24jOh6AMOJmol3UUqmax3
	 XMU7mBVkIQrCyKnXt75vDii/RkmdL03L6rjh3OZfn2WCxNGfKDz5XGDRNU6zQmHgNj
	 tIYC1q8P1jfbexOzqbNlZe0rMmqTcdssXxIHOBp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbfAXT07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729218AbfAXT04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:26:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAED9218FC;
        Thu, 24 Jan 2019 19:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358016;
        bh=AR5Zme5b2RcK0E1wPLcf0RbXXMCHn0KlH8RJpvLoIow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=srmygYUKBfVHcWBFCxt2huX+CBo4WB5UBRTBikUE57hdSzvHlBU7ZmSzKTnbNldHP
         3QGK8WxjXALC5m/xRzx0COtCmup7NgNa3xMp0tXOqWW0W818BOPTqc5FovPqtVgKP8
         Zb5LaM6egODCKk50uzzyWOtQ7jA+6c+32MYnRPGw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 041/104] arm64: Dont trap host pointer auth use to EL2
Date:   Thu, 24 Jan 2019 20:19:30 +0100
Message-Id: <20190124190159.891049721@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Backport of upstream commit b3669b1e1c09890d61109a1a8ece2c5b66804714 ]

To allow EL0 (and/or EL1) to use pointer authentication functionality,
we must ensure that pointer authentication instructions and accesses to
pointer authentication keys are not trapped to EL2.

This patch ensures that HCR_EL2 is configured appropriately when the
kernel is booted at EL2. For non-VHE kernels we set HCR_EL2.{API,APK},
ensuring that EL1 can access keys and permit EL0 use of instructions.
For VHE kernels host EL0 (TGE && E2H) is unaffected by these settings,
and it doesn't matter how we configure HCR_EL2.{API,APK}, so we don't
bother setting them.

This does not enable support for KVM guests, since KVM manages HCR_EL2
itself when running VMs.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: kvmarm@lists.cs.columbia.edu
Signed-off-by: Will Deacon <will.deacon@arm.com>
[kristina: backport to 4.4.y: adjust context]
Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/kvm_arm.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 013b7de45ee7..d7e7cf56e8d6 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -23,6 +23,8 @@
 #include <asm/types.h>
 
 /* Hyp Configuration Register (HCR) bits */
+#define HCR_API		(UL(1) << 41)
+#define HCR_APK		(UL(1) << 40)
 #define HCR_ID		(UL(1) << 33)
 #define HCR_CD		(UL(1) << 32)
 #define HCR_RW_SHIFT	31
@@ -81,7 +83,7 @@
 			 HCR_AMO | HCR_SWIO | HCR_TIDCP | HCR_RW)
 #define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
 #define HCR_INT_OVERRIDE   (HCR_FMO | HCR_IMO)
-#define HCR_HOST_NVHE_FLAGS (HCR_RW)
+#define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK)
 
 
 /* Hyp System Control Register (SCTLR_EL2) bits */
-- 
2.19.1



