Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACB72147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866601;
	bh=W8Vb0Diax1rZbJGpUCoDpu9ER0RQKIufM6RDe6gZt1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dJyZ8VVK1FB0FQyXDN6/jv/MKv/Cgva8dJ70YOmCye5i7X+fAAE8/kSBWIOrsWcqG
	 hpyB+qifFA/EzQXIykNVqy4A/FP4fa0/MR/VzwvHsPZepPYblGi5VFSHfJ1fD0a/+w
	 JlD0EwI8ThF/LDjlTaoGCLZ684KsGUJD1eVS8/kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfAGNKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:10:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731912AbfAGNJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:09:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04EDE2089F;
        Mon,  7 Jan 2019 13:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866595;
        bh=W8Vb0Diax1rZbJGpUCoDpu9ER0RQKIufM6RDe6gZt1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iupX4HCq8LinqDRcJPz0mNwrlY9WkwNb10UzFw/BdiGrORB1C3/vfTIcd0dFmJcBZ
         Qes+dHrZdN5BZehScGUa4UjoEKeq+uuo++o8SaCXQDUO2l+vDzRNUruvDG2h6pMNzr
         SLH98b6oFzgm9oI1Nmg2WkMGFSwbU1bC183Yn6Qk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.9 69/71] arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1
Date:   Mon,  7 Jan 2019 13:33:38 +0100
Message-Id: <20190107105336.685495832@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will.deacon@arm.com>

commit df655b75c43fba0f2621680ab261083297fd6d16 upstream.

Although bit 31 of VTCR_EL2 is RES1, we inadvertently end up setting all
of the upper 32 bits to 1 as well because we define VTCR_EL2_RES1 as
signed, which is sign-extended when assigning to kvm->arch.vtcr.

Lucky for us, the architecture currently treats these upper bits as RES0
so, whilst we've been naughty, we haven't set fire to anything yet.

Cc: <stable@vger.kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/kvm_arm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -99,7 +99,7 @@
 			 TCR_EL2_ORGN0_MASK | TCR_EL2_IRGN0_MASK | TCR_EL2_T0SZ_MASK)
 
 /* VTCR_EL2 Registers bits */
-#define VTCR_EL2_RES1		(1 << 31)
+#define VTCR_EL2_RES1		(1U << 31)
 #define VTCR_EL2_HD		(1 << 22)
 #define VTCR_EL2_HA		(1 << 21)
 #define VTCR_EL2_PS_MASK	TCR_EL2_PS_MASK


