Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F35C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B67520647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 20:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBKEe1QQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B67520647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbeH3ArD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 20:47:03 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45827 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbeH3ArC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 20:47:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id r4-v6so5397900lff.12;
        Wed, 29 Aug 2018 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XKcb53aYaZBYeG3pZ4PHNbQDfCqe6cWj/PGgG/0MtzY=;
        b=kBKEe1QQSB6SVLP6uVo1p8FPQtRAXkp5eP/35rYGUh4UiX0tmH7TAmJ378Geiqp+cW
         DzgCvs64m72cBgLTxH+mvS4+y6S2JF7H3odz2DdWCLIi0rfRmsWsXCfsLN1FCZSjG22Z
         SMGgJX1ALtApzTgJl89xU5sMoHE70SF+F5EvV5vO8Eqx1/7kVXbfl7Xa/mB9Oet2lDRR
         hFM8r3ixHnUUyKUR3MzoPFbxonO1d2dDfhjRMxVred4yFYm+Y0b87m350XJSsYlYroXy
         1hb3Jh28T+wSvPRzHUtfIv88/MuHe8R63cLZEiJBBWM4bnNu9rtXLLmbJGBGWRU0GbGK
         TmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XKcb53aYaZBYeG3pZ4PHNbQDfCqe6cWj/PGgG/0MtzY=;
        b=TDGprpl4/sDXL6kg70AMqt6VhgJ4rb2B9U/dhsTNL1hACXTjeZxxOEH4DbA5uAeef1
         v6qLkllgykbu6BvFjwyn/+xkCerqCurm9h7eMTaE+UkRs65tkNGRJhcOEogP4KFCKvuN
         hy+rdwPfCwAlChWNo2/L4KVi9h5tkxm/lt6Mob62hixCzic6CT5UGz+2BhjWjbadBXcX
         wIvZDttdX72AJSzqxHyIysWwpOXh98ZCppMHuzIsx2/sSOuHmoohla9ogIL4ljyN5xAY
         FpPD32nvepCB2dK3wAkzJs1e+E2JT82j7/D+Ru1n3J1GAD2Xc+59HFOliS1+p7gy+Mvn
         G6Ow==
X-Gm-Message-State: APzg51BlWztTckyqxYvOEqbcU21KryzXzJWLJxPVEVk7yBKv3cdiYNu+
        +fEmC2ZTmh+CRgqULLnJIdc=
X-Google-Smtp-Source: ANB0Vdb8GZMTp0tjIPXVlQ/cYXHJAW1yNnYWRiSrsm+M2Wz2GuvV3jCaItpvPm7yS2rHJdMUZtjhiQ==
X-Received: by 2002:a19:5e12:: with SMTP id s18-v6mr5189174lfb.5.1535575702734;
        Wed, 29 Aug 2018 13:48:22 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f66-v6sm947619lji.23.2018.08.29.13.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 13:48:21 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATH v5 0/4] gpiolib: speed up GPIO array processing
Date:   Wed, 29 Aug 2018 22:48:56 +0200
Message-Id: <20180829204900.19390-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820234341.5271-1-jmkrzyszt@gmail.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The goal is to boost performance of get/set array functions while
processing GPIO arrays which represent pins of a signle chip in
hardware order.  If resulting performance is close to PIO, GPIO API
can be used for data I/O without much loss of speed.

Created and tested on a low end Amstrad Delta board with NAND driver
updated to use GPIO API for data I/O.  Performance degrade compared to
PIO is much better than before the optimization but still not quite
satisfactory.

Janusz Krzysztofik (4):
      gpiolib: Pass bitmaps, not integer arrays, to get/set array
      gpiolib: Identify arrays matching GPIO hardware
      gpiolib: Pass array info to get/set array functions
      gpiolib: Implement fast processing path in get/set array

Changelog:
v5:
[PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to get/set
- drivers/i2c/muxes/i2c-mux-gpio.c:
  - drop assigment of values to struct gpiomux.values, as recommended
    by Peter Rosin - thanks!,
  - mark the .values member of the structure as obsolete,
- drivers/mux/gpio.c:
  - drop assigment of values to struct mux_gpio.val, also recommended
    by Peter Rosin - thanks!,
  - merk the .val member of the structure as obsolete,
- drivers/auxdisplay/hd44780.c:
  - fix incorrect bitmap size,
  - use >>= operator to simplify notation,
  both catched by Miguel Ojeda - thanks!,
- add Cc: clauses as well as Acked-by: collected so far.
[PATCH v5 2/4] gpiolib: Identify arrays matching GPIO hardware
- add Cc: clause.
[PATCH v5 3/4] gpiolib: Pass array info to get/set array functions
- add Cc: clauses as well as Acked-by: collected so far.
[PATCH v5 4/4] gpiolib: Implement fast processing path in get/set
- add Cc: clause.

v4:
That series was a follow up of the former "mtd: rawnand: ams-delta: Use
gpio-omap accessors for data I/O" which already contained some changes
to gpiolib.  Those previous attempts were commented by Borris Brezillon
who suggested using GPIO API modified to accept bitmaps, and by Linus
Walleij who suggested still more great ideas for further immprovement
of the proposed API changes - thanks!

diffstat:
 Documentation/driver-api/gpio/board.rst     |   15 +
 Documentation/driver-api/gpio/consumer.rst  |   48 +++-
 drivers/auxdisplay/hd44780.c                |   64 +++---
 drivers/bus/ts-nbus.c                       |   25 --
 drivers/gpio/gpio-max3191x.c                |   23 +-
 drivers/gpio/gpiolib.c                      |  279 ++++++++++++++++++++++------
 drivers/gpio/gpiolib.h                      |   15 +
 drivers/i2c/muxes/i2c-mux-gpio.c            |   10 -
 drivers/mmc/core/pwrseq_simple.c            |   15 -
 drivers/mux/gpio.c                          |   12 -
 drivers/net/phy/mdio-mux-gpio.c             |    5 
 drivers/pcmcia/soc_common.c                 |   14 -
 drivers/phy/motorola/phy-mapphone-mdm6600.c |   21 +-
 drivers/staging/iio/adc/ad7606.c            |   12 -
 drivers/tty/serial/serial_mctrl_gpio.c      |    9 
 include/linux/gpio/consumer.h               |   35 ++-
 16 files changed, 412 insertions(+), 190 deletions(-)

