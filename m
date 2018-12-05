Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F71BC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533F720851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cswpk6Te"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533F720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbeLEMrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:47:32 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35128 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbeLEMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:47:31 -0500
Received: by mail-lj1-f193.google.com with SMTP id x85-v6so18212733ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ZdeI+S0mKXmTl9lH41eV3IJqLOaBO08NcKqTZaINT8=;
        b=Cswpk6Te3/pE48LlZcysWCgvv9a5y+lfNoMIiwnX9EAAITplyt9r3wnJm5TET/d89L
         T+FA/Jbsw+pM+Cfolysl3C/2hYlv6LW0aW8rTuQAL1d3ZIbhliIVDw6ROq0zJudd1lEn
         zS6QKnTeLtwjhm8xh+9kEOW0ef4nBOypkLhtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2ZdeI+S0mKXmTl9lH41eV3IJqLOaBO08NcKqTZaINT8=;
        b=nNAuMoRLaMXUwN8UoIXknJBo0wjpTyu6Lmaq0QZ8bg4Bg1VZCQ+qdBbsdYOceVFOhm
         g7ioViEJBJSqWJEbqW9kvthEeklZS5JILy5TMDX7lSBTCeQR1UDb94c5p9NcWdq6jR1W
         nmUC1X1utXHZ9seAntWO+VnRBAwrcyvSrhLF5rWTgtFEbA9yZEkBpdyKHm+KO12OVh0R
         ZjGv3omQ4DfTbBX6SQ0iK7NstgoDTsEEQ1SofSA+Aeh86QncbVVQncTiTUdPzeBUYUTH
         fQUkkiQRn1RAks0dQWNRtKtyz8Rk3R7SBPTrGuffBI56d7N2xfurVuG9NiCLzsrUu3VY
         i4Mg==
X-Gm-Message-State: AA+aEWZePWLMKVEJBVRge9JydhDbKVlunRafHfnJNOy9F8iMa3iv8Ax/
        +NcOHO8OCZfNEZqewNqrwEYkFw==
X-Google-Smtp-Source: AFSGD/W4ubaDU91IwQr4p05MxGlZQRvIMCnaugkOsGs/P8m+a6BRrbYArdx5jDhSy7zDqs3YX3b4Ag==
X-Received: by 2002:a2e:8007:: with SMTP id j7-v6mr16061825ljg.22.1544014048723;
        Wed, 05 Dec 2018 04:47:28 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id e19-v6sm3797125ljf.67.2018.12.05.04.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 04:47:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 00/15 v3] Regulator ena_gpiod fixups
Date:   Wed,  5 Dec 2018 13:47:06 +0100
Message-Id: <20181205124721.26624-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a third iteration of these fixups after thinking
over Marek's remarks on the v2 version.

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
   and use this in the otherwise hairy da9211,
   s5m8767, tps65090 and s2mps11 drivers.

Linus Walleij (15):
  regulator: core: Track dangling GPIO descriptors
  regulator: fixed: Let core handle GPIO descriptor
  regulator: lm363x: Let core handle GPIO descriptor
  regulator: lp8788-ldo: Let core handle GPIO descriptor
  regulator: max8952: Let core handle GPIO descriptor
  regulator: max8973: Let core handle GPIO descriptor
  gpio: Export gpiod_get_from_of_node()
  regulator: max77686: Let core handle GPIO descriptor
  gpio: Enable nonexclusive gpiods from DT nodes
  gpio: devres: Handle nonexclusive GPIOs
  gpio: Add devm_gpiod_unhinge()
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
 drivers/regulator/max8973-regulator.c  | 23 +++++---
 drivers/regulator/s2mps11.c            |  7 ++-
 drivers/regulator/s5m8767.c            |  9 ++-
 drivers/regulator/tps65090-regulator.c |  6 ++
 include/linux/gpio/consumer.h          | 23 ++++++++
 16 files changed, 214 insertions(+), 50 deletions(-)

-- 
2.19.2

