Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A56ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C293E20856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZH56gFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C293E20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGSQpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeGSQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:10 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6622084E;
        Thu, 19 Jul 2018 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016081;
        bh=W0S0JzDjUzFUb+4ZJU+qpI3XbI7YB9UgK5LgII43hgs=;
        h=From:To:Subject:Date:From;
        b=RZH56gFIUzCuMFKinu8XHNy+QsTHisc6bkVejjXXzVxPtRh6akC5Gdy25+1PNf64Q
         MYJv4X7diNdFeMgw+PO2+MpzdsfJ8+vM1Xvp4vROzMGWTopi6b7wAFGt9rRYl/QBOk
         QXQRkG+0cXN5J6HXHrPFnEDEUlDWYJ+KJJQwbpSM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 00/10] pinctrl: samsung: Remove ugly hack for sharing eint_wakeup_mask
Date:   Thu, 19 Jul 2018 18:00:40 +0200
Message-Id: <20180719160050.22566-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Tests
=====
This is both request for comments and requests for tests. Only basic
tests were done, including suspend to RAM on Odroid U3 (Exynos4412)
with max7768 RTC wakeup. Please kindly test it with devices capable of
suspending and resuming. I am mostly thinking about S5Pv210-based (Aria),
Trats, Trats2 and TM2 (Exynos5433). Existing platforms should not be
broken however changing external interrupt wakeup mask was not done
on Exynos5433.


Description
===========
The Exynos/S5Pv210 machine suspend code needs to write the external
interrupt mask during suspend.  The mask is controlled by pin controller
driver: the exynos_wkup_irq_set_wake() in IRQ chip for these wakeup
interrupts.

Therefore pinctrl driver code exposed an exynos_get_eint_wake_mask()
function which was later used as an extern in machine code.

This is quite ugly way of combining driver and machine code,
not portable triggering Sparse and GCC warnings.


This might break suspend capability S5Pv210 on with older DTBs (thus
breaks DTB compatibility), however:
1. just "might" because in case of using older DTB, the wakeup mask
   will not be changed during suspend and default reset value (all
   interrupts non-masked) should work,
2. mainline support for S5Pv210 with DTB is limited and suspend
   to RAM already might be broken.


Dependencies
============
1. The first seven patches should be taken through one tree,
   preferably samsung-pinctrl,
2. The DTS patch (7/10) for S5Pv210 should go into next cycle,
3. The remaining patches (8-10) should go after all previous,
   so probably another release cycle.


Best regards,
Krzysztof


Krzysztof Kozlowski (10):
  pinctrl: samsung: Define suspend and resume callbacks for all banks
    and SoCs
  pinctrl: samsung: Document suspend and resume members
  pinctrl: samsung: Document hidden requirement about one external
    wakeup
  pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup
    interrupts
  ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and
    Exynos5433
  pinctrl: samsung: Write external interrupt mask
  ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup
    compatible
  ARM: s5pv210: Remove legacy setting of external wakeup interrupts
  ARM: exynos: Remove legacy setting of external wakeup interrupts
  pinctrl: samsung: Remove legacy API for handling external wakeup
    interrupts mask

 .../bindings/pinctrl/samsung-pinctrl.txt           | 11 ++-
 arch/arm/boot/dts/s5pv210.dtsi                     |  2 +-
 arch/arm/mach-exynos/common.h                      |  2 -
 arch/arm/mach-exynos/suspend.c                     | 16 +++--
 arch/arm/mach-s5pv210/common.h                     |  1 -
 arch/arm/mach-s5pv210/pm.c                         | 16 +++--
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       | 16 +++++
 drivers/pinctrl/samsung/pinctrl-exynos.c           | 78 +++++++++++++++++++---
 drivers/pinctrl/samsung/pinctrl-samsung.h          | 11 +++
 include/linux/soc/samsung/exynos-regs-pmu.h        |  8 ++-
 10 files changed, 136 insertions(+), 25 deletions(-)

-- 
2.14.1

