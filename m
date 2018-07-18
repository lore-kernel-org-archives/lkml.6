Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DBECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38A02084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7tIsCJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38A02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbeGRXX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:23:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:34752 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbeGRXX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:23:59 -0400
Received: by mail-io0-f194.google.com with SMTP id l7-v6so5485998ioj.1;
        Wed, 18 Jul 2018 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jgrciYf0+HkQoL428os9NtXOLbosVRLmgOa7wWgTA64=;
        b=r7tIsCJHt6bnu6SN9moZqiu3lAvx5VqfOdoXZ0utXc3GIf9Q/VILMcwVVXE3wmtaGz
         jFdjojfye4u0sGjUqc2P1MUzjOVoF1XcmxaJcCdrtthtrWUzimDhq5PG//gaO2WHNZnK
         uWpW544spXb1HE8LiYab0u2FhKtK87sfNXEbNKn4pKfBcdAjcchkcqSdZvXvfY08TNmm
         vPRTHyLmXL7OK4T2E/upyhiBGsG8M4QCBUUeiR5ivdtbFpw96yjHmSMgK+W974fm4smN
         4gC0H1tBkGu3FCsJcbCDnEdwyYSCmQ1tw2ASvuRFjihWI9W7DlHVpzEkbzAgfwhfrpQp
         mw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jgrciYf0+HkQoL428os9NtXOLbosVRLmgOa7wWgTA64=;
        b=GNoow6LEnff8+uRri9upNz4mqSJ3kMnsxhFbLyJ+c/6jw921qCFgYQSdO0JQpr9QJo
         dKEqTCO7TAYuhOt72WqR2zkqjG6IZgSHh4qKRzi3p9dca0EnI/mAP8h2amquQaVZtQTk
         PD8whIrWQu+0P1V8cmGw4Z9SpYGEfAjkEqO+4WXmE4Or+/7ol1ZwrncLoguh277vnWNA
         nPWj08cZ362PfnmiYPg5yiYoDKJXnJOW2/V6zjIS8GHD0GcxiXGo/K1/Z/d4bP59HlbQ
         815m/6aA51cR7e/JxOgZN8Cv9lP0nS/J3jdBzfLKD0hxTGEiNBQ6BkEv5FJlZleWOFLp
         0jkA==
X-Gm-Message-State: AOUpUlEhAXSHny0QkVLEUO0xlC0CdxkCTYfAmm6NYcrOkTdh6IWDM88h
        EUjnqA2NMkIshgt8t70iiCk3HhfDOxDi7ZG10g==
X-Google-Smtp-Source: AA+uWPyIU/rV9+BTk+HdyBlnyAY3KPeMxVksgL9sUOwVDzljbVd6F4vq2z7vaAYlY0iDMmo1awzQRZb8L5V7LR+EE98=
X-Received: by 2002:a6b:c693:: with SMTP id w141-v6mr6532495iof.79.1531953834927;
 Wed, 18 Jul 2018 15:43:54 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Wed, 18 Jul 2018 16:43:43 -0600
Message-ID: <CAL_JsqLCA0QLD-_EUS+bZPpa61y9+7Ym=eO3aSC7x_VerJZ+bQ@mail.gmail.com>
Subject: [GIT PULL] DeviceTree fixes for 4.18
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes. Details below.

Rob

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40=
:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-4.18

for you to fetch changes up to b9952b5218added5577e4a3443969bc20884cea9:

  of: overlay: update phandle cache on overlay apply and remove
(2018-07-16 08:41:32 -0600)

----------------------------------------------------------------
DeviceTree fixes for 4.18:

- Fix phandle cache to work with overlays

- Correct the default clock-frequency for QCom geni-i2c

- Binding doc quote and spelling fixes

----------------------------------------------------------------
Douglas Anderson (1):
      dt-bindings: soc: qcom: Fix default clock-freq for qcom,geni-i2c

Enric Balletbo i Serra (1):
      Documentation: devicetree: tilcdc: fix spelling mistake
"suppors" -> "supports"

Fabio Estevam (1):
      dt-bindings: w1-gpio: Remove unneeded unit address

Frank Rowand (1):
      of: overlay: update phandle cache on overlay apply and remove

Jonathan Neusch=C3=A4fer (1):
      dt-bindings: Fix unbalanced quotation marks

 .../devicetree/bindings/arm/samsung/samsung-boards.txt        |  2 +-
 Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt   |  2 +-
 .../devicetree/bindings/gpio/nintendo,hollywood-gpio.txt      |  2 +-
 .../devicetree/bindings/input/touchscreen/hideep.txt          |  2 +-
 .../bindings/interrupt-controller/nvidia,tegra20-ictlr.txt    |  2 +-
 .../bindings/interrupt-controller/st,stm32-exti.txt           |  2 +-
 Documentation/devicetree/bindings/mips/brcm/soc.txt           |  2 +-
 Documentation/devicetree/bindings/net/fsl-fman.txt            |  2 +-
 Documentation/devicetree/bindings/power/power_domain.txt      |  2 +-
 Documentation/devicetree/bindings/regulator/tps65090.txt      |  2 +-
 Documentation/devicetree/bindings/reset/st,sti-softreset.txt  |  2 +-
 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt   |  2 +-
 Documentation/devicetree/bindings/sound/qcom,apq8016-sbc.txt  |  2 +-
 Documentation/devicetree/bindings/sound/qcom,apq8096.txt      |  2 +-
 Documentation/devicetree/bindings/w1/w1-gpio.txt              |  2 +-
 drivers/of/base.c                                             |  6 +++---
 drivers/of/of_private.h                                       |  2 ++
 drivers/of/overlay.c                                          | 11 +++++++=
++++
 18 files changed, 31 insertions(+), 18 deletions(-)
