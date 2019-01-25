Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E7C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1DA2195D
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="h/IXMmFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfAYH6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:58:47 -0500
Received: from conuserg-07.nifty.com ([210.131.2.74]:17310 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAYH6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:58:43 -0500
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x0P7vbeR015362;
        Fri, 25 Jan 2019 16:57:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x0P7vbeR015362
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1548403060;
        bh=2HM1Z4UoltBcG6m5akSE3Nja5SNuDxs/Gfy4F46J0AU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/IXMmFm+9OnIPhRk4tFU3LDe7yJEDBb7rSxT0j3Z8E9028pAw9gqyVrsefaErwNy
         DU/2Q8FDXYawfr1e2nqiQ+2HKZGBSaLS1g4rvG91QDaLeZhlxq8oPzaeAyyyaQ7Y+z
         kYape/qx01MsQjvKIMPG0x36KT5AG0dk/AQSEpUx96FA+1UyevV/8AtqLdGvZ40q3p
         hrmZerrjQ/jCsa4njzzMZJEmYY1GDSlbVxddZ3znDdohhtIHiCsVkSCTqlP82Gs145
         CzD8ATpisM8omTnmfX7IwIOrQlFUjK5WpIL1x4be0V6IrMwJ8J8l+lr336k07bivBw
         9iHNO4D9jRLQQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 3/3] KVM: arm/arm64: prefix header search paths with $(srctree)/
Date:   Fri, 25 Jan 2019 16:57:30 +0900
Message-Id: <1548403050-6585-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
References: <1548403050-6585-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the Kbuild core manipulates header search paths in a crazy
way [1].

To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
the search paths in the srctree. Some Makefiles are already written in
that way, but not all. The goal of this work is to make the notation
consistent, and finally get rid of the gross hacks.

Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
("kbuild: do not drop -I without parameter").

[1]: https://patchwork.kernel.org/patch/9632347/

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/kvm/Makefile   | 2 +-
 arch/arm64/kvm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index bca775e..531e59f 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -8,7 +8,7 @@ ifeq ($(plus_virt),+virt)
 	plus_virt_def := -DREQUIRES_VIRT=1
 endif
 
-ccflags-y += -Iarch/arm/kvm -Ivirt/kvm/arm/vgic
+ccflags-y += -I $(srctree)/$(src) -I $(srctree)/virt/kvm/arm/vgic
 CFLAGS_arm.o := $(plus_virt_def)
 
 AFLAGS_init.o := -Wa,-march=armv7-a$(plus_virt)
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 3089b31..690e033 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -3,7 +3,7 @@
 # Makefile for Kernel-based Virtual Machine module
 #
 
-ccflags-y += -Iarch/arm64/kvm -Ivirt/kvm/arm/vgic
+ccflags-y += -I $(srctree)/$(src) -I $(srctree)/virt/kvm/arm/vgic
 
 KVM=../../../virt/kvm
 
-- 
2.7.4

