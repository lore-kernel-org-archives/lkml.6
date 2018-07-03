Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10522C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69F121915
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 01:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="wjAlZk7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69F121915
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753608AbeGCBYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 21:24:35 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:46417 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGCBYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 21:24:32 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id w631MU1n030863;
        Tue, 3 Jul 2018 10:22:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com w631MU1n030863
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1530580951;
        bh=BsBHv7H09wQg3HtJBRmrhTfMzbB9YKroTIVNIiZU3mI=;
        h=From:To:Cc:Subject:Date:From;
        b=wjAlZk7kWensR7nVTrVVjVZlVyDSfMK0JwabEyY5aeYqaVL68ThtDEqTY/uZBGOzq
         ZxsaFyanrIggN3THhOrNxUuxI+ek42hJBbkqsIpHPuJhYQTMnFYsGOtaSCYZ8N4kts
         j7w4rP657P037TDY7MmWIaKSUy7/1qILykL34QMl3V7u0UZRErh9NwiQ1dqVZxjbZ1
         gk7Y6946NrkQyoR6NEfgXLeWArkz6B9Z3F+AHGj+RESBFz1WLRlfQfbV3XoxrWde3U
         wEHDVlVqzGXs+rp7xPCDx+8EW9DCv4WrRjXYmBVPCL0UVoVcgTDbnSPWWFF9d5mihF
         MN25hj/QJgv0Q==
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
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: [PATCH 0/3] arm,arm64,microblaze: add endianness options to LDFLAGS instead of LD
Date:   Tue,  3 Jul 2018 10:21:58 +0900
Message-Id: <1530580921-23340-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


We are able to evaluate compiler / toolchain capability in the
Kconfig phase.
(If you do not know the background of this work, please read
 the commit log of 316d55d55f49eca442e4fd948f5fa92bab0c8312)

To achieve this, 'CC', 'LD', etc. must be passed to Kconfig.

arch/*/Makefile should not tweak such environment variables
depending on CONFIG options - this would cause circular dependency.
  - We want to pass $(LD) from Makefile to Kconfig
  - CONFIG_CPU_BIG_ENDIAN is defined by Kconfig, then given
    back to Makefile

Nicholas already fixed this issue for PowerPC in commit 1421dc6d48296a.

I need to fix arm, arm64, microblaze as well
before I start moving linker option tests to Kconfig from Makefile.

arch maintainers:
Please pick up a proper patch for your tree.



Masahiro Yamada (3):
  ARM: add endianness option to LDFLAGS instead of LD
  arm64: add endianness option to LDFLAGS instead of LD
  microblaze: add endianness options to LDFLAGS instead of LD

 arch/arm/Makefile        | 4 ++--
 arch/arm64/Makefile      | 6 ++----
 arch/microblaze/Makefile | 4 ++--
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.7.4

