Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D53AC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A1E20820
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ldiW9XVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbfAYH6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:58:45 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:17313 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbfAYH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:58:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0P7vbeQ015362;
        Fri, 25 Jan 2019 16:57:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeQ015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548403059;
        bh=sQk/Dl7wT+orikM5quGi46hn80YeahxI8cR8k21DNNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ldiW9XVUC/PtcuxprwPTitYPJcLNuct06cwidyKmc3cWNRozxN49E0CzZyTHjHuEM
         LxEk+58t1/ttcZ0ek4p8twvltL6Eu/rxjoQH2zC9c3Ev7laYbbQMmSi8OFh9so3qaU
         9YOqe1QdnuN1oqqW4NMbIMLcBpbk2kOOt84Zhbjo5iXNzPCBL6ccaP+7ybA35fK3ot
         j9IGhVlAc+LCzgv1Cfu5SIJzwcr1okRmA4QjCxCJlJ/0KRcf4hseJaalozg/3REkve
         Uw2VzNR2D6nwa1AGaCMaEFdG3sxiRRpKimjwdl8KDceMvCJEl1Mkxiw6q2qH8AU6/z
         WtnlUbPBpAt8Q==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 2/3] KVM: arm/arm64: remove -I. header search paths
Date:   Fri, 25 Jan 2019 16:57:29 +0900
Message-Id: <1548403050-6585-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The header search path -I. in kernel Makefiles is very suspicious;
it allows the compiler to search for headers in the top of $(srctree),
where obviously no header file exists.

I was able to build without these extra header search paths.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/kvm/Makefile   | 3 +--
 arch/arm64/kvm/Makefile | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index 48de846..bca775e 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -9,8 +9,7 @@ ifeq ($(plus_virt),+virt)
 endif
 
 ccflags-y += -Iarch/arm/kvm -Ivirt/kvm/arm/vgic
-CFLAGS_arm.o := -I. $(plus_virt_def)
-CFLAGS_mmu.o := -I.
+CFLAGS_arm.o := $(plus_virt_def)
 
 AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
 AFLAGS_interrupts.o := -Wa,-march=armv7-a$(plus_virt)
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 0f2a135..3089b31 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -4,8 +4,6 @@
 #
 
 ccflags-y += -Iarch/arm64/kvm -Ivirt/kvm/arm/vgic
-CFLAGS_arm.o := -I.
-CFLAGS_mmu.o := -I.
 
 KVM=../../../virt/kvm
 
-- 
2.7.4

