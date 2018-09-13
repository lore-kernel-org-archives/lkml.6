Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78507C63685
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0E220882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 20:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eKKJSQwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0E220882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeINBfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 21:35:40 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:47702 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeINBfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 21:35:40 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 7598D24E050D;
        Thu, 13 Sep 2018 13:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536870276; bh=ToRwRFETujwP6OxXWhUjqW/H3piG/P269BZNfAlU3ig=;
        h=From:To:Cc:Subject:Date:From;
        b=eKKJSQwRb0FBuwHunIhRoy9kz+r02g/H4Cbq0dzAqbcVSd2OTQNw4FBkKqoJc3LFR
         dDc08l1IVca7Tkz4p8OwmXhrucY+hWO1HwfuR2LtQWaa3f7bWQVhxrOef6k4Ru/FS6
         Wl/bqMLs3oIKPFmxxJRZ4AZ38Ad3yMcG/Q2mHoPhoE3cNEyO3AQ9+gp5um01dPOaUk
         2485TubPmSG/5xeFBDSJuTEmVEHpeZ/QwK9r4EVgp1C11oFKq3cUviWM/nxriUsXh3
         fJ9SAx4MZv8C+iW+mFdghh72RkizsC+j/5C/qTEmeJhREEzYRrNKiPBazQUn/yfnIf
         niMsXhGCEWwMg==
Received: from abrodkin-7480l.internal.synopsys.com (unknown [10.225.15.87])
        by mailhost.synopsys.com (Postfix) with ESMTP id ED86F357E;
        Thu, 13 Sep 2018 13:24:34 -0700 (PDT)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH] ARC: Get rid of toolchain check
Date:   Thu, 13 Sep 2018 23:24:28 +0300
Message-Id: <20180913202428.7284-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This check is very naive: we simply test if GCC invoked without
"-mcpu=XXX" has ARC700 define set. In that case we think that GCC
was built with "--with-cpu=arc700" and has libgcc built for ARC700.

Otherwise if ARC700 is not defined we think that everythng was built
for ARCv2.

But in reality our life is much more interesting.

1. Regardless of GCC configuration (i.e. what we pass in "--with-cpu"
   it may generate code for any ARC core).

2. libgcc might be built with explicitly specified "--mcpu=YYY"

That's exactly what happens in case of multilibbed toolchains:
 - GCC is configured with default settings
 - All the libs built for many different CPU flavors

I.e. that check gets in the way of usage of multilibbed
toolchains. And even non-multilibbed toolchains are affected.
OpenEmbedded also builds GCC without "--with-cpu" because
each and every target component later is compiled with explicitly
set "-mcpu=ZZZ".

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
---
 arch/arc/Makefile | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 6c1b20dd76ad..16ae8675116e 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -20,20 +20,6 @@ cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 cflags-$(CONFIG_ISA_ARCOMPACT)	+= -mA7
 cflags-$(CONFIG_ISA_ARCV2)	+= -mcpu=archs
 
-is_700 = $(shell $(CC) -dM -E - < /dev/null | grep -q "ARC700" && echo 1 || echo 0)
-
-ifdef CONFIG_ISA_ARCOMPACT
-ifeq ($(is_700), 0)
-    $(error Toolchain not configured for ARCompact builds)
-endif
-endif
-
-ifdef CONFIG_ISA_ARCV2
-ifeq ($(is_700), 1)
-    $(error Toolchain not configured for ARCv2 builds)
-endif
-endif
-
 ifdef CONFIG_ARC_CURR_IN_REG
 # For a global register defintion, make sure it gets passed to every file
 # We had a customer reported bug where some code built in kernel was NOT using
-- 
2.17.1

