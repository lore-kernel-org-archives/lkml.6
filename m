Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99871ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDBF20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDBF20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbeGQI6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:58:38 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:62768 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQI6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:58:38 -0400
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="14237666"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 01:27:12 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 01:27:11 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux@armlinux.org.uk>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/4] rework ULP1 patches
Date:   Tue, 17 Jul 2018 11:26:53 +0300
Message-ID: <1531816017-31986-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on the discussion at [1] and private discussion I had with Alexandre
Belloni on IRC, I reworked ULP1 patches to remove device tree bindings
proposed in [1].

The implementation from this patches (mostly patch 4/4) is using
device_may_wakeup() API that current Linux code provides and the fact that
for the ULP1 the wakeup souces are known and well defined.
Basically, this rework (mostly patch 4/4) loops through well defined ULP1
wakeup sources and check if those wakeup sources were configured to wake
up the system (vid DT or sysfs) and, based on that (and in case of RTC,
based on SHDWC.MR), set the PMC fast startup mode and polarity registers.
In [1] PMC fast startup mode and polarity registers were configured by
introducing new DT bindings.

Since with these patches SHDWC registers are used in ULP1 wakeup sources
configuration the patch 4/4 changed a bit the PM initialization phase for
SAMA5D2 in order to have mapped also the SHDWC in case ULP1 needs to be
initialized. In case ULP1 configuration fails the ULP0 mode is used (same
approach as in backup mode case).

I measure the delay introduced in suspend sequence by using an oscilloscope
connected to a GPIO and calling gpio_direction_output(PIN, 0) at the beginning
of at91_pm_config_ws() and gpio_direction_output(PIN, 1) at the end of
at91_pm_config_ws(). With these I measureed on oscilloscope the difference
b/w the front changes. The measured time was *1.56ms*. Keep in mind that
gpio_direction_output() will call, in the end,
atmel_gpio_direction_output() which access 4 registers to toggle the PIN
(in at91_pm_config_ws() there are also 4 peripheral register accesses).

Besides this rework, I took the chance and I appended few other patches to
this series, based on Wenyou Yang's previous work, related to ULP modes.

Patch 1/4: replaces slow clock with ULP0
Patch 2/4: is the Wenyou's patch wich adds ULP1 support
Patch 3/4: is defining PMC fast startup registers

The patches were based on v4.18-rc1.

[1] https://patchwork.kernel.org/patch/8595091/

Claudiu Beznea (3):
  ARM: at91: pm: Use ULP0 naming instead of slow clock
  ARM: at91: pm: add PMC fast startup registers defines
  ARM: at91: pm: configure wakeup sources for ULP1 mode

Wenyou Yang (1):
  ARM: at91: pm: Add ULP1 mode support

 arch/arm/mach-at91/pm.c         | 184 +++++++++++++++++++++++++++++++++-------
 arch/arm/mach-at91/pm.h         |   6 +-
 arch/arm/mach-at91/pm_suspend.S | 142 ++++++++++++++++++++++++++-----
 include/linux/clk/at91_pmc.h    |  15 ++++
 4 files changed, 294 insertions(+), 53 deletions(-)

-- 
2.7.4

