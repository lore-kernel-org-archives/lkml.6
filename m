Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DFFC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA2C20449
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865120;
	bh=Ysl3Kknxu9YBXrA78bILict4LY9HZ8kJFS4TNX6/toI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yi0c3HoY/X0/4JEcAHt4jh8g+xanke5U/e6u8nANMpLIkIfkb4RsLgFwkgBSfD7lk
	 PCkbi3BivmIMG81dstw/bJ3RAatpVgV21avvaYTLjSGSpWscyBRLd0isI1XIxjZzAl
	 fbvcJknMGsAobQiUTyDAdCDyzTx6xnYvqVUW8F6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbfAGMpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:45:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727841AbfAGMpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:45:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CF2B20449;
        Mon,  7 Jan 2019 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865116;
        bh=Ysl3Kknxu9YBXrA78bILict4LY9HZ8kJFS4TNX6/toI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8UUdzd9ovHSYn8Q1+6suCQd3PK0/JatdulPYVAVhHtN4u9Uf7biSPQg7lNFdG9C7
         vJ+AwQZq1SAdaK6p400crSijU9k+8j9UF51rR9/PoellYQBzHbCZgkEFTKI1RFqpTp
         VoUvqjVkwhK/vi0drUqKTl6fyU0niuPBlBbbBpuw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 4.20 131/145] arm64: KVM: Avoid setting the upper 32 bits of VTCR_EL2 to 1
Date:   Mon,  7 Jan 2019 13:32:48 +0100
Message-Id: <20190107104454.330167322@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -104,7 +104,7 @@
 			 TCR_EL2_ORGN0_MASK | TCR_EL2_IRGN0_MASK | TCR_EL2_T0SZ_MASK)
 
 /* VTCR_EL2 Registers bits */
-#define VTCR_EL2_RES1		(1 << 31)
+#define VTCR_EL2_RES1		(1U << 31)
 #define VTCR_EL2_HD		(1 << 22)
 #define VTCR_EL2_HA		(1 << 21)
 #define VTCR_EL2_PS_SHIFT	TCR_EL2_PS_SHIFT


