Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADEDC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 02:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D17208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 02:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uE8Cdkbw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67D17208DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeGICLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 22:11:37 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:53479 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbeGICLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 22:11:36 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id w692AH9i012706;
        Mon, 9 Jul 2018 11:10:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w692AH9i012706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1531102217;
        bh=dYh/4wtKHhRNjXRlpl3UoxE9D8lYgF/ZT3lJrgvASdE=;
        h=From:To:Cc:Subject:Date:From;
        b=uE8CdkbwqvfXnq3+V5Y6Oei3pv39nd3eMZlI9GRG/NsaCyyCyzI91boibUCa29Pcq
         vsHZiDL5JGiC4SWjgfW/N3MQX7iXYwQC1kn6SFUS7HlUzM3d4bj4AQqTO+2MDB3mtQ
         PHfEPe+lOLY0+serL1MW7bJuZq8YsgezKvo8UZmABzwLpiWsyRO0RDiylVmhVtsIQY
         XQCq0IE5sDsFbKa9GrWC17R8qTx14ImuBz7EwhQe6lZLT1RE7Ss+YTMzaGqqeZnFOX
         7XRotakQeMO5fy5Lu/b3cScF8y8rHT1DfsLJWnYN4BI/aDjcdnlkPjnEljycU9GHyH
         E+EqaeVOeH83g==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: add endianness option to LDFLAGS instead of LD
Date:   Mon,  9 Jul 2018 11:09:42 +0900
Message-Id: <1531102182-13699-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
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

KernelVersion: v4.18-rc4


 arch/arm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fc26c3d..62ebeae 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -46,12 +46,12 @@ ifeq ($(CONFIG_CPU_BIG_ENDIAN),y)
 KBUILD_CPPFLAGS	+= -mbig-endian
 CHECKFLAGS	+= -D__ARMEB__
 AS		+= -EB
-LD		+= -EB
+LDFLAGS		+= -EB
 else
 KBUILD_CPPFLAGS	+= -mlittle-endian
 CHECKFLAGS	+= -D__ARMEL__
 AS		+= -EL
-LD		+= -EL
+LDFLAGS		+= -EL
 endif
 
 #
-- 
2.7.4

