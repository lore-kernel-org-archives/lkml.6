Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF97C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF1621915
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="19n8IXRG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF1621915
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932339AbeGCBZF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:25:05 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:46619 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753639AbeGCBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:24:39 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w631MU1q030863;
        Tue, 3 Jul 2018 10:22:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w631MU1q030863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530580954;
        bh=zQEMhk9FQiWmNIMha6n4KD51gYhzRbPo/CA6JmnJjyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19n8IXRGQ3WuqK+ya3EilbxmR9BNxuULE+SV5CBszfzsbk13mA8S9Guf6tFKtAYjf
         QoeYXdn7rlCk3+N68SHiNFqcxuGM8ngDyFNXSr6lcryS3KNE/gDZJCyCRa6lwciG4n
         SzwZHqRF90RzIMjwJzq9BGXy3zKgitOfJ11zTZx3eII5lUaQqXug1ss97ZvJGzQlsp
         79A1a2g+V/r0sqUV73zQGOvS8oiletU69DzpASbrJwF26bMCKVBrOcvMLVDnVlJ0e8
         of7A9jG5bgGpsgITSea0uuSOyzRrw9npVZ0975+WQGKHPzU+dhK15TWgRTNjkxoWN5
         gqhdDz1+6j2Kw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Michal Simek <monstr@monstr.eu>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] microblaze: add endianness options to LDFLAGS instead of LD
Date:   Tue,  3 Jul 2018 10:22:01 +0900
Message-Id: <1530580921-23340-4-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent syntax extension, Kconfig is now able to evaluate the
compiler / toolchain capability.

However, accumulating flags to 'LD' is not compatible with the way
it works; 'LD' must be passed to Kconfig to call $(ld-option,...)
from Kconfig files.  If you tweak 'LD' in arch Makefile depending on
CONFIG_CPU_BIG_ENDIAN, this would end up with circular dependency
between Makefile and Kconfig.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index d269dd4b..7333036 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -40,11 +40,11 @@ CPUFLAGS-$(CONFIG_XILINX_MICROBLAZE0_USE_PCMP_INSTR) += -mxl-pattern-compare
 ifdef CONFIG_CPU_BIG_ENDIAN
 KBUILD_CFLAGS += -mbig-endian
 KBUILD_AFLAGS += -mbig-endian
-LD += -EB
+LDFLAGS += -EB
 else
 KBUILD_CFLAGS += -mlittle-endian
 KBUILD_AFLAGS += -mlittle-endian
-LD += -EL
+LDFLAGS += -EL
 endif
 
 CPUFLAGS-1 += $(call cc-option,-mcpu=v$(CPU_VER))
-- 
2.7.4

