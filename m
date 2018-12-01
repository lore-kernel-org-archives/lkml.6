Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1EEC64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C2E20673
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oi65Xcau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C2E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeLBC4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:56:47 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45783 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbeLBC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:56:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so6170272lfa.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CgRR+90JWv8gR+gSEB5kTOuthdYHQ6mxQhQYRmTbfw=;
        b=Oi65XcausA4ocb0TftYJ94TJok1CjEdAkNY/2tuZIN431IDPyMaE2tsgQbNl3Qb17V
         0gseDoWXkSwGoOdVCE6wgG6kkC9/hPwx8rNamEcooDNl/iXgFC7vROrDnKec39cbBzSQ
         7UcXSHyELDRov9C4a7GFGT4r7faJ0AfUQ3iR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9CgRR+90JWv8gR+gSEB5kTOuthdYHQ6mxQhQYRmTbfw=;
        b=UEM7VuAbemb+j2xdPAc5O15GOjkrVFY/u6TrNEbPqYzsxPQrFX/m7DcVj7mKpIFEJ5
         GEKr5oFuwu7z2KMMpBEQQj8W4aqR4kIXv2Gj6RRB3bO9ged2QPoIOAgftOr/GwMuNQ78
         5/84IoAHbPcmAeffAkI6urPMB/fXM8xDhsJdUaCW3KaSagkjxdhsdRdZH59j4bCA2lUx
         Bls3yMog4xIqkEM183ENiavX7RxYuABnCfN99EKO+0Ij/sP6Stgh4r9yhPgtGajo4LEz
         O+pXo2AaPWYuU0ryUPu+pDNpr4kuxS+XHLmAzjBtwsFchdeNDXksOjGa2phUU3cWIP2G
         shEQ==
X-Gm-Message-State: AA+aEWaJx518cyKQNzq4oKvClUgij7+SYLBC/JW/ujMMurHhGiZzMWVV
        pd5fDquQy7qE6YqTXeAqTh249g==
X-Google-Smtp-Source: AFSGD/WmVp0SFYWT+//jGwHti7Pr0PJj+Z4wFTjZ8x80Qr4bWyiHmGFvOZuavrH/Z5qmZpiU8+BJlg==
X-Received: by 2002:a19:978c:: with SMTP id z134mr6207536lfd.109.1543679037016;
        Sat, 01 Dec 2018 07:43:57 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:43:55 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/13 v2] Regulator ena_gpiod fixups
Date:   Sat,  1 Dec 2018 16:41:38 +0100
Message-Id: <20181201154151.14890-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a second iteration of these fixups after thinking
over Charles Keepax excellent comments on the first series
of fixes.

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

4. Invent devm_gpiod_unhinge() that will remove the devres
   monitoring of a devm_* allocated GPIO descriptor
   right before handling it over to the regulator core,
   and use this in the otherwise hairy da9211,
   s5m8767, tps65090 and s2mps11 drivers.

Linus Walleij (13):
  regulator: core: Track dangling GPIO descriptors
  regulator: fixed: Let core handle GPIO descriptor
  regulator: lm363x: Let core handle GPIO descriptor
  regulator: lp8788-ldo: Let core handle GPIO descriptor
  regulator: max8952: Let core handle GPIO descriptor
  regulator: max8973: Let core handle GPIO descriptor
  gpio: Export gpiod_get_from_of_node()
  regulator: max77686: Let core handle GPIO descriptor
  gpio: Add devm_gpiod_unhinge()
  regulator: da9211: Hand over GPIO to regulator core
  regulator: s5m8767: Hand over GPIO to regulator core
  regulator: tps65090: Hand over GPIO to regulator core
  regulator: s2mps11: Hand over GPIO to regulator core

 Documentation/driver-model/devres.txt  |  1 +
 drivers/gpio/gpiolib-devres.c          | 17 ++++++++
 drivers/gpio/gpiolib.h                 |  6 ---
 drivers/regulator/core.c               | 55 +++++++++++++++++++++-----
 drivers/regulator/da9211-regulator.c   |  6 +++
 drivers/regulator/fixed.c              |  6 ++-
 drivers/regulator/lm363x-regulator.c   |  8 +++-
 drivers/regulator/lp8788-ldo.c         |  8 +++-
 drivers/regulator/max77686-regulator.c | 14 ++++---
 drivers/regulator/max8952.c            | 10 +++--
 drivers/regulator/max8973-regulator.c  | 23 +++++++----
 drivers/regulator/s2mps11.c            |  7 +++-
 drivers/regulator/s5m8767.c            |  9 ++++-
 drivers/regulator/tps65090-regulator.c |  6 +++
 include/linux/gpio/consumer.h          | 23 +++++++++++
 15 files changed, 161 insertions(+), 38 deletions(-)

-- 
2.19.1

