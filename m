Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0EC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126C82084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D0y+UpMF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 126C82084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLKV0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:26:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47059 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKV0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:26:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so11873771lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 13:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvWHCEFXqlZumAoP7ka9IcoWHn0Q5//NZSQXcynDaMA=;
        b=D0y+UpMFpRjwZScjg9E10AB+NLzLVG6oec3tmSHPn3P+UNRmD9FJUFkeFOAIsLikej
         CaPEmW7YxGCcBDnTt436hgZ+7jyklTvORKfX6rpxirCqJw7Rlsm7gOIykYv7yIwNTbIR
         HF7O5CmFbV5dXudMMXzd2TSzVuygRprJn0Apo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lvWHCEFXqlZumAoP7ka9IcoWHn0Q5//NZSQXcynDaMA=;
        b=XGsnXWLrrE8UBnVGmLzNV3g7acXIFyBwDLkcqyF7UGaEJV6ku9/Hh7iaO+VRUTessq
         krWzJgI//MhohLM8dP5Ux+PwU4a18e1TMbBFnnieUFFd6fT4pECA1YPDbtiOmrCeLLYS
         WrBLTTZ8pux6reLeQDQv2AHXE6Jf9+tUtDW17fg1UeakM4Y7upvKWRxbzojSgJzo2oEF
         E71fKb/d6CBjrFk4mmGAOAmvjaT+4GV2/Q7ZZlUZ7toCROBKldWsY20Hwcuyh2JqbrgL
         2YdajEjSAwZDBuTMiWUL5yX5V26r0M8Cu+WV0YUy12k9ItJFh6a/v965G+x51+LGjvlQ
         gi7A==
X-Gm-Message-State: AA+aEWZ25e/XGeOHnlS4Ot8mriyyy3Q05BgXlTe1pNS3BrdLX6s9P8pv
        yNYkHxhis5GU9soogcguRvrm4Q==
X-Google-Smtp-Source: AFSGD/WaSvuo+dl2x7bv4iOQ71IVijrbwK279qRYSxSm6TN/jMAf73trjYxDepu5kAys0aScPAUzxQ==
X-Received: by 2002:a19:9dd1:: with SMTP id g200mr9888009lfe.127.1544563592399;
        Tue, 11 Dec 2018 13:26:32 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id y11-v6sm2873870ljc.85.2018.12.11.13.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 13:26:31 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/5 v8] Regulator GPIO descriptors endgame
Date:   Tue, 11 Dec 2018 22:24:23 +0100
Message-Id: <20181211212428.28327-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These five patches finalize the regulator GPIO descriptor
migration and wipes up the debris.

- Migrate the GPIO regulator driver to use descriptors,
  switch the few board files using it over in the process.

- Update the device tree bindings for the GPIO regulator.
  (This is kind of an independent patch, but a side effect
  of using the gpiolib DT parsing code.)

- Pull all inversion and open drain handling into gpiolib
  by just passing the right flags in the GPIO descriptor
  tables and deleting the local inversion implementation.

- As the GPIO regulator was the last user of the global
  GPIO numberspace, we can finally delete the non-descriptor
  handling in the regulator core.

Linus Walleij (5):
  regulator: gpio: Convert to use descriptors
  regulator: fixed/gpio: Pull inversion/OD into gpiolib
  regulator: fixed/gpio: Update device tree bindings
  regulator: gpio: Simplify probe path
  regulator: core: Only support passing enable GPIO descriptors

 .../bindings/regulator/fixed-regulator.txt    |  13 +-
 .../bindings/regulator/gpio-regulator.txt     |   4 +
 arch/arm/mach-imx/mach-mx21ads.c              |   1 -
 arch/arm/mach-imx/mach-mx27ads.c              |   2 +-
 arch/arm/mach-mmp/brownstone.c                |   1 -
 arch/arm/mach-omap1/board-ams-delta.c         |   2 -
 arch/arm/mach-omap2/pdata-quirks.c            |   1 -
 arch/arm/mach-pxa/em-x270.c                   |   1 -
 arch/arm/mach-pxa/ezx.c                       |   3 +-
 arch/arm/mach-pxa/hx4700.c                    |  23 ++-
 arch/arm/mach-pxa/magician.c                  |  23 ++-
 arch/arm/mach-pxa/raumfeld.c                  |   1 -
 arch/arm/mach-pxa/zeus.c                      |   3 +-
 arch/arm/mach-sa1100/assabet.c                |   1 -
 arch/sh/boards/mach-ecovec24/setup.c          |   2 -
 .../intel-mid/device_libs/platform_bcm43xx.c  |   1 -
 drivers/regulator/core.c                      |  40 +---
 drivers/regulator/da9055-regulator.c          |   1 -
 drivers/regulator/fixed.c                     |  35 +---
 drivers/regulator/gpio-regulator.c            | 189 +++++++-----------
 include/linux/regulator/driver.h              |  12 +-
 include/linux/regulator/fixed.h               |  10 -
 include/linux/regulator/gpio-regulator.h      |  18 +-
 23 files changed, 143 insertions(+), 244 deletions(-)

-- 
2.19.2

