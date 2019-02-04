Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B041C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C52217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="pzBVpVAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbfBDRSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:18:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36825 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727650AbfBDRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:18:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so705245wrv.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 09:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66nnaKJCVmtQRr3HmoWTmZyWvGHRqZpdMrcRelYSBHQ=;
        b=pzBVpVAUTQ4gygdLB4HxT/hcoU+IzJ/Qbdft8XUGWZDcjdVA7IAS+iFq1jwfqiINtU
         o8YRmN1lzOdXnoMvy34IYLwRg3OENuoqfIEMr59pKkR9SphF0oYntNbkU1tCCYyMgXh5
         sb2WQ1/zT4k8rg7O6OU6sekyYKeXsD4tDccN3dkBnWJ7qWmzzBMYHUX0zePL4SGdzy2p
         u9esKDer64YFa8jfkFdQ15ey4xn9d4oCZz9FFo9Potmo4AynrhmHMHf0GQmIgzb1Yl2L
         bKLONz+DinwowxpZXbyWajL23WImDP28/IgywHgrLKeUpBa3pK3H0d1VxtWKp9l6I6kf
         vo7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=66nnaKJCVmtQRr3HmoWTmZyWvGHRqZpdMrcRelYSBHQ=;
        b=fupujydBlSEEmTGRKZiOq6irYnT+OoVBR89awuFiaZja6u9eR+DAqhq41OeRQzMm1b
         ajVxit0g0nvaYai6UezwgTG6XAxeiaI9IKOIKAO+CVsWU6BsQYeqc9FX7vlWpihbc6SY
         9Co5M42JnfmSReE7L3NDnYOKuqw/2J6fDciQDg7REwSYrmhzhKiRz/YAU0S/bJtrijVa
         Dwj7VJhdxJnVhppy/8/gwnTis5pFVL9KIVtW9Kr/YilXqlg70BJR7tquvAbaVoebWHe2
         K9Qr8KDexdeoUthXbiEUYQECId/OTHwrN+IUlFnoPWrRzMuiKHdQLmnx9zv7VI/50joN
         VhQA==
X-Gm-Message-State: AHQUAuZaqnQ+UFWhFWE4HhnuZy124J0FuiiKzzOVEzfX7WeQkuwhYhCB
        lfnaecgzXXhMnZw5p7vne1CFtQ==
X-Google-Smtp-Source: AHgI3IY3XUrc1SQTEO1Ev7xwwh1xvh3c1t3Lfnv7VYDgatua0fQQSFr1xPY7CqCsJ9sEQ0h9jGbSBg==
X-Received: by 2002:adf:9ec8:: with SMTP id b8mr365216wrf.164.1549300686921;
        Mon, 04 Feb 2019 09:18:06 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-8-223.w90-86.abo.wanadoo.fr. [90.86.125.223])
        by smtp.gmail.com with ESMTPSA id q9sm11197506wrv.26.2019.02.04.09.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:18:06 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 00/12] ARM: davinci: modernize the timer support
Date:   Mon,  4 Feb 2019 18:17:45 +0100
Message-Id: <20190204171757.32073-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series removes the legacy timer code from mach-davinci in favor of
a new clocksource driver it introduces.

The first patch fixes a device tree bug that's been around for a while.
Unfortunately any systems shipped with the buggy device will stop booting
once they switch to the new clocksource driver.

Patch 2 adds a new clocksource driver for davinci.

Patch 3 enables the new driver for device-tree based systems.

Patch 4 adds a WARN_ON() to the machine code of all davinci boards
which is triggered if clk_get() for the timer clock fails. This is needed
as the new driver expects the clock to be functional and doesn't check it.

Patches 5-6 and 8-11 switch the board files to using the new
clocksource driver while patch 7 moves some necessary defines to
a different place since we'll be removing the file that contains them.

Patch 12 removes legacy timer code.

v1 -> v2:

- changed the license to GPL-only
- dropped regmap usage due to the additional code paths making the
  code too slow
- minor code rearrangement
- fixed the da830 timer configuration
- correctly assign the timer halfs to clocksource and clockevent
- sqashed the commits adding WARN() when clk_get() fails
- used WARN_ON() and added a return when clk_get() fails to avoid
  entering the timer driver without a valid clock
- request the register range before iomapping it
- simplified the configuration structure (dropped the additional cmp struct)

Bartosz Golaszewski (12):
  ARM: dts: da850: fix interrupt numbers for clocksource
  clocksource: davinci-timer: new driver
  ARM: davinci: enable the clocksource driver for DT mode
  ARM: davinci: WARN_ON() if clk_get() fails
  ARM: davinci: da850: switch to using the clocksource driver
  ARM: davinci: da830: switch to using the clocksource driver
  ARM: davinci: move timer definitions to davinci.h
  ARM: davinci: dm355: switch to using the clocksource driver
  ARM: davinci: dm365: switch to using the clocksource driver
  ARM: davinci: dm644x: switch to using the clocksource driver
  ARM: davinci: dm646x: switch to using the clocksource driver
  ARM: davinci: remove legacy timer support

 arch/arm/Kconfig                            |   1 +
 arch/arm/boot/dts/da850.dtsi                |   2 +-
 arch/arm/mach-davinci/Makefile              |   3 +-
 arch/arm/mach-davinci/da830.c               |  53 ++-
 arch/arm/mach-davinci/da850.c               |  60 ++-
 arch/arm/mach-davinci/davinci.h             |   3 +
 arch/arm/mach-davinci/devices-da8xx.c       |   1 -
 arch/arm/mach-davinci/devices.c             |  19 -
 arch/arm/mach-davinci/dm355.c               |  40 +-
 arch/arm/mach-davinci/dm365.c               |  34 +-
 arch/arm/mach-davinci/dm644x.c              |  40 +-
 arch/arm/mach-davinci/dm646x.c              |  40 +-
 arch/arm/mach-davinci/include/mach/common.h |  17 -
 arch/arm/mach-davinci/include/mach/time.h   |  35 --
 arch/arm/mach-davinci/time.c                | 414 -------------------
 drivers/clocksource/Kconfig                 |   5 +
 drivers/clocksource/Makefile                |   1 +
 drivers/clocksource/timer-davinci.c         | 431 ++++++++++++++++++++
 include/clocksource/timer-davinci.h         |  44 ++
 19 files changed, 647 insertions(+), 596 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/time.h
 delete mode 100644 arch/arm/mach-davinci/time.c
 create mode 100644 drivers/clocksource/timer-davinci.c
 create mode 100644 include/clocksource/timer-davinci.h

-- 
2.20.1

