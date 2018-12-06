Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB60320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h3gz2Ymj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB60320892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbeLFMn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:43:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41255 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeLFMn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:43:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id k15-v6so269593ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 04:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDv0HoDn90Hhcjvzlh5UDnoYvUl54AC2kxpV/hX3q1s=;
        b=h3gz2YmjkfF2i4kD1Fk9BcMKEspG1Rnxc3m38zChj8GoFron1eQqBerljxlO2mkh1I
         OLThFKlbkQ08UJEC2w4K1AVDD1R7oQwn70RT3SjcqPPAr/igCp04F6GpYXwJLHjwrOMH
         I4hvGVfc8NrvGaVi/yAYNT62aauLEKddIpZGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDv0HoDn90Hhcjvzlh5UDnoYvUl54AC2kxpV/hX3q1s=;
        b=eOton4IVjsyt0DXGT9O/GscPtq+MMXAZVSdHkn5ri1zbdVgo16lL5rTY2tiYtd2Y1I
         za6QdFbObHx/BU6rs0hkxDUl+E6IC1zhCxaVofqTbUJvo8JphSPXWzBRSMvRPmc4qbw8
         JsyTZ6RGX8estmwOWPcN/maDCk6bHTCQZhciNjUONARVh74iL4/xvRnTcxOgal5w2lVA
         U7+WoZC/1nXid9uPAvUvVncRXIKBsZ4yQeVbyNAYpNfkL5BAAb/PfLiE7pyN+Ym1s5/S
         uiyCGHRtAhYfruNRaj8djc8yVpd1cSR835hQEOQtXcMUsMNKbzcp4ZPp+pEYxwYcQjQf
         6ERw==
X-Gm-Message-State: AA+aEWaRG6u1UiLEPWe0zBpW1BTrKOtIDz4HSgy8kLTFPXu9+LZLHewa
        rQyrCgdmzzSf+kykdVVd0WBjC9epob6tEA==
X-Google-Smtp-Source: AFSGD/WbaqJcERNqzJoNGcn4mQWOxACLI7X68lXJOeJDzRuwyJ1fVtZVM83Gt0apNZgN91HUWJ30Aw==
X-Received: by 2002:a2e:b00a:: with SMTP id y10-v6mr17479054ljk.109.1544100236344;
        Thu, 06 Dec 2018 04:43:56 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j25-v6sm44071lji.77.2018.12.06.04.43.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 04:43:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/15 v4] Regulator ena_gpiod fixups
Date:   Thu,  6 Dec 2018 13:43:36 +0100
Message-Id: <20181206124351.10155-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a fourth iteration of these fixups after fixing
the (hopefullt last) bugs found in the v3 version.

Also available in git branch
gpio-descriptors-regulator-fixup in the GPIO git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=gpio-descriptors-regulator-fixup

I added two fixup item to the list: making the gpiod
from of node respect nonexlusive flags and fixing the
shared regulators in devm_gpiod_get*.

To make sure GPIO descriptors are never left dangling
(as far as I can tell!) I use this stepwise approach:

1. Fix the regulator_register() in the core to guarantee
   that after calling this with a valid GPIO descriptor
   in ena_gpiod it will be gpiod_put() if there is any
   problem.

2. Fix up simple descriptor consumers to just gpiod_get()
   and let the core take over the descriptor. Only handle
   the errorpath up to this point.

3. Export gpiod_get_from_of_node() and let max77686
   obtain a GPIO descriptor from the device tree without
   any devres make-up in the DT parsing callback.

4. Make gpiod_get_from_of_node() respect the
   GPIOD_FLAGS_BIT_NONEXCLUSIVE flag.

5. Fix up devm_gpiod_get_* to respect the
   GPIOD_FLAGS_BIT_NONEXCLUSIVE flag.

6. Invent devm_gpiod_unhinge() that will remove the devres
   monitoring of a devm_* allocated GPIO descriptor
   right before handling it over to the regulator core,
   and use this in the otherwise hairy max8973, da9211,
   s5m8767, tps65090 and s2mps11 drivers.


Linus Walleij (15):
  regulator: core: Track dangling GPIO descriptors
  regulator: fixed: Let core handle GPIO descriptor
  regulator: lm363x: Let core handle GPIO descriptor
  regulator: lp8788-ldo: Let core handle GPIO descriptor
  regulator: max8952: Let core handle GPIO descriptor
  gpio: Export gpiod_get_from_of_node()
  regulator: max77686: Let core handle GPIO descriptor
  gpio: Enable nonexclusive gpiods from DT nodes
  gpio: devres: Handle nonexclusive GPIOs
  gpio: Add devm_gpiod_unhinge()
  regulator: max8973: Let core handle GPIO descriptor
  regulator: da9211: Hand over GPIO to regulator core
  regulator: s5m8767: Hand over GPIO to regulator core
  regulator: tps65090: Hand over GPIO to regulator core
  regulator: s2mps11: Hand over GPIO to regulator core

 Documentation/driver-model/devres.txt  |  1 +
 drivers/gpio/gpiolib-devres.c          | 80 ++++++++++++++++++++++----
 drivers/gpio/gpiolib.c                 |  2 +
 drivers/gpio/gpiolib.h                 |  6 --
 drivers/regulator/core.c               | 55 ++++++++++++++----
 drivers/regulator/da9211-regulator.c   |  6 ++
 drivers/regulator/fixed.c              |  6 +-
 drivers/regulator/lm363x-regulator.c   |  8 ++-
 drivers/regulator/lp8788-ldo.c         |  8 ++-
 drivers/regulator/max77686-regulator.c | 14 +++--
 drivers/regulator/max8952.c            | 10 +++-
 drivers/regulator/max8973-regulator.c  |  8 ++-
 drivers/regulator/s2mps11.c            |  7 ++-
 drivers/regulator/s5m8767.c            |  9 ++-
 drivers/regulator/tps65090-regulator.c |  6 ++
 include/linux/gpio/consumer.h          | 23 ++++++++
 16 files changed, 205 insertions(+), 44 deletions(-)

-- 
2.19.2

