Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA945C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E5E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 23:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="XP/tsVav"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E5E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbeGYA24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 20:28:56 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:38204 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbeGYA24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 20:28:56 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Paul Cercueil <paul@crapouillou.net>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org,
        linux-doc@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 00/21] Ingenic JZ47xx TCU patchset v5
Date:   Wed, 25 Jul 2018 01:19:37 +0200
Message-Id: <20180724231958.20659-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1532474406; bh=p7W0EZb/337WwscyN+pftnx9XCmwFkd1dB5EmPWxQGI=; h=From:To:Cc:Subject:Date:Message-Id; b=XP/tsVav1RnoGs8vcNnWreqM41pZMgYNTTFZNW6otNTz6tIE0ei8waIFMSEuYndVeJO8QLVSaiD+eYU+9bqLlo7GRRR0Jsun/AZO1XMVfIQJeksQdvqjkdWmlo4EKqkFozjiQaOGw29YG2sR3l/jsmkkdekM935Aj5EE7HDigzg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the V5 of my patchset that adds support to the Timer/Counter
Unit (TCU) present on Ingenic JZ47xx SoCs.

Way too much has changed since V4, we went from 8 patches in V4 up to
21 patches in V5.
I did not know if I had to submit it as V5 or start a new series.
In doubt, I sent a V5.

Very succint description of the changes:

- The interrupt, clocks, clocksource drivers have been merged into one;
  ingenic-timer now inits the TCU clocks, handles the interrupts,
  provides a system timer and optionally also a clocksource and
  sched_clock. The TCU channel #0 will be used as system timer, unless
  another channel is specified from devicetree.

- The simple-mfd and syscon are gone. The ingenic-timer driver will
  probe the drivers registered as children in the devicetree.

- The watchdog driver was updated to use the WDT clock and regmap
  provided by ingenic-timer. This breaks the devicetree ABI, but as
  explained in the corresponding commit message, right now all Ingenic
  boards compile the devicetree into the kernel anyway - so it's better
  to update it now before it's too late.

- The PWM driver was updated to use the TCU timer clocks as well as the
  regmap provided by ingenic-timer. Unused devicetree compatible strings
  were removed (the driver was never probed from devicetree), and
  support for the JZ4725B has been added.

- A new ingenic-ost driver was added, which provides a clocksource and
  a sched_clock that are more accurate than the ones provided by
  ingenic-timer (32 or 64-bit vs. 16-bit). It is not available on every
  SoC.

- Mostly tested on the JZ4725B and JZ4770. It would be great if somebody
  could test on the JZ4780 and JZ4740.

Thanks,
-Paul

