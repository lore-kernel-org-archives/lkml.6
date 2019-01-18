Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D29C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E08C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ggFhKgct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfARNnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:43:07 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52798 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfARNnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:43:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4546786wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBHeeklKS+LdG+HjCPTWI+5lyggXxMxCTqPEKt91RAk=;
        b=ggFhKgctk44iYMnHf/VB5X2elWgeKO7fI3rggmsUCoum00r/TZHeKzaeoR+alqfB04
         4moFiNGJPzmaL3AtiRUtPioJTQNaypO6ohAEBdfBBJP+GiE7sflztsWUdd+QmAIVtuub
         NXF0FIrts6S0J7TzLJNsuYG1pJRelZxeUj+Q5kUqtPl+updRSJ4JWup1X/Ax5E1UddsH
         7l2QJ7/n0gK/feP7hQtr3hDccxhmR3rzJlJKFp3N7KOoe6AliOVRVN1xynI0SBvZNUPk
         szux6BUYC9MPUQUlt+KFh++5T47j52YFvqCjxjNq1A1Hu7yguI72ALwZkCTXZOHdAteL
         aMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YBHeeklKS+LdG+HjCPTWI+5lyggXxMxCTqPEKt91RAk=;
        b=Z0tJADp28huIsZGKk1UtOUWHPQgFWfZd77aOLazMib0kJsyQD2qPMg8mtiqDLbKqa3
         t+TgC0fyS4uwQ39l6VhoBl1s2zVxF9xwMZULOTf7BlW0+WojW6zaYUI1KwOvJcZ2C9Te
         3O+u3dNPS4O3wlWodb8wlrh4gRpsi/dapN1soglR6LEcqCO26irO8L9+bOfeXlQ6eX5U
         T2X5v+LgkcErTdC3I/RtNiLtg6+jWtA0gp7MIFyWrh3YeJy8vrfjgl7GM9UciPJ2Zw9Q
         iVS3ModSddvMfv1HIwUoN3AhPbT9ev+G+PZrJ0NSb6EF/UtdAjSC+BQCqXO224dkrW4W
         SWkg==
X-Gm-Message-State: AJcUukcP1Hs9b33l6uTrL9D5+DXXhnPpQj89ZUJxEn/AEz0Ip1sQQbgh
        z+ztXQtDY45cCHFhr4fYQmICeg==
X-Google-Smtp-Source: ALg8bN6Xb4rTPAdVFkUanagFgLukePL/vZeVeA2FGKN9SrCBSM281oT7hS2MW9rUPcGs2L2XKq8hgg==
X-Received: by 2002:a1c:578e:: with SMTP id l136mr15283828wmb.124.1547818983537;
        Fri, 18 Jan 2019 05:43:03 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a132sm51033934wmh.5.2019.01.18.05.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:43:02 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 00/13] mfd: add support for max77650 PMIC
Date:   Fri, 18 Jan 2019 14:42:31 +0100
Message-Id: <20190118134244.22253-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This series adds support for max77650 ultra low-power PMIC. It provides
the core mfd driver and a set of five sub-drivers for the regulator,
power supply, gpio, leds and input subsystems.

Patches 1-6 add the DT binding documents. Patches 7-12 add all drivers.
Last patch adds a MAINTAINERS entry for this device.

Note that patch 8/13 depends on commit 03c87b95ac04 ("regulator: provide
rdev_get_regmap()") which was picked up by Mark Brown for v5.1.

Bartosz Golaszewski (13):
  dt-bindings: mfd: add DT bindings for max77650
  dt-bindings: regulator: add DT bindings for max77650
  dt-bindings: power: supply: add DT bindings for max77650
  dt-bindings: gpio: add DT bindings for max77650
  dt-bindings: leds: add DT bindings for max77650
  dt-bindings: input: add DT bindings for max77650
  mfd: max77650: new core mfd driver
  regulator: max77650: add regulator support
  power: supply: max77650: add support for battery charger
  gpio: max77650: add GPIO support
  leds: max77650: add LEDs support
  input: max77650: add onkey support
  MAINTAINERS: add an entry for max77650 mfd driver

 .../bindings/gpio/gpio-max77650.txt           |  34 ++
 .../bindings/input/max77650-onkey.txt         |  26 +
 .../bindings/leds/leds-max77650.txt           |  57 ++
 .../devicetree/bindings/mfd/max77650.txt      |  28 +
 .../power/supply/max77650-charger.txt         |  27 +
 .../bindings/regulator/max77650-regulator.txt |  41 ++
 MAINTAINERS                                   |  14 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-max77650.c                  | 189 ++++++
 drivers/input/misc/Kconfig                    |   9 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/max77650-onkey.c           | 135 +++++
 drivers/leds/Kconfig                          |   6 +
 drivers/leds/Makefile                         |   1 +
 drivers/leds/leds-max77650.c                  | 162 ++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/max77650.c                        | 212 +++++++
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/max77650-charger.c       | 347 +++++++++++
 drivers/regulator/Kconfig                     |   8 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77650-regulator.c        | 537 ++++++++++++++++++
 include/linux/mfd/max77650.h                  |  73 +++
 26 files changed, 1936 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/input/max77650-onkey.txt
 create mode 100644 Documentation/devicetree/bindings/leds/leds-max77650.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/max77650.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/max77650-charger.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/max77650-regulator.txt
 create mode 100644 drivers/gpio/gpio-max77650.c
 create mode 100644 drivers/input/misc/max77650-onkey.c
 create mode 100644 drivers/leds/leds-max77650.c
 create mode 100644 drivers/mfd/max77650.c
 create mode 100644 drivers/power/supply/max77650-charger.c
 create mode 100644 drivers/regulator/max77650-regulator.c
 create mode 100644 include/linux/mfd/max77650.h

-- 
2.19.1

