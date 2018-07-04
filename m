Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE5DC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AB3240AA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 06:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYLq2w+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB3240AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933423AbeGDGT5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 02:19:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33376 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932840AbeGDGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 02:19:55 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so12146885wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=x3cGio7yW3Vs6BW52DrnnBw365Yi5XozZgCB5QMEBeA=;
        b=eYLq2w+FneNa39crAl3M6030DmBrO2ouagNRzy86Gl3CX+uLcIS+i57wcsPxK2OacI
         6i/xkbBsjxBIkhftMYvK53/IH68PCrZn+8fldKSM1pExSnowDQIDUIrlBZyC1XKGjZ/I
         iY72MpljxuQUQmtjZePvfOBqWp0lPSdLyn6QY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=x3cGio7yW3Vs6BW52DrnnBw365Yi5XozZgCB5QMEBeA=;
        b=EbYwh1G4qK5rBFNmGuH72+HNkLQ3y6ID9vfn5kHlT00PyobLRm4wmFLiadCq0hq/85
         ngRETyR7Sc7ex1RAm9CdEqhBY3dqx27CaICUJ3E6luPCB1nKTwmMexO2pvyLDtq61a6D
         i3bapm9AFwH4zYfOYNR337ObJ1e76ZqZME/l+NQgM2BsIiCktEPhydF3Iem4q5kqRqms
         iLchVcfVAS0hhDiF2s8YEJ7K9VTIQ1sZY1QGAfV7xjuuPHe1BUdcbTNDaFGwlaYRMUhu
         hUGmnppj1um2gmTds1le35dYtTFILrwCWscIJljG6Q1Y96DZW6LSEE6AUemiU9H5FphB
         WVPg==
X-Gm-Message-State: APt69E3QKkYj6bgOs/7uCCIOz78ksMkaMX/vOt376AyVA7sd/0/zc/Y+
        1aU0HsK1Bb5tOgLDlLOagwvTLw==
X-Google-Smtp-Source: AAOMgpe0uxOdlhma6qUTtowqhfcPo0pccu658FggOUj5hF1AH1w6Aabyh8zbW3U7i85F31ZYtZ0hXw==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr600100wmm.110.1530685194417;
        Tue, 03 Jul 2018 23:19:54 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id w2-v6sm5866415wme.45.2018.07.03.23.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 23:19:53 -0700 (PDT)
Date:   Wed, 4 Jul 2018 07:19:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD and Regulator due for the
 v4.19 merge window
Message-ID: <20180704061951.GW20176@dell>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[This set really should have a 0th patch (a.k.a. a cover-letter)]

Enjoy!

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-regulator-v4.19

for you to fetch changes up to c287572b739ad18b7fd298f3af3bec21037a55f7:

  mfd: da9063: Add DA9063L support (2018-07-04 07:17:13 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Regulator due for the v4.19 merge window

----------------------------------------------------------------
Marek Vasut (14):
      mfd: da9063: Replace regmap_add_irq_chip with devm counterpart
      mfd: da9063: Replace mfd_add_devices with devm counterpart
      mfd: da9063: Use regmap_reg_range
      mfd: da9063: Use REGMAP_IRQ_REG
      mfd: da9063: Use PLATFORM_DEVID_NONE
      mfd: da9063: Replace DA9063_NUM_IRQ with ARRAY_SIZE
      mfd: da9063: Rename PMIC_DA9063 to PMIC_CHIP_ID_DA9063
      mfd: da9063: Replace model with type
      mfd: da9063: Add DA9063L type
      mfd: da9063: Add custom regmap for DA9063L
      mfd: da9063: Add custom IRQ map for DA9063L
      mfd: da9063: Register RTC only on DA9063L
      regulator: da9063: Handle less LDOs on DA9063L
      mfd: da9063: Add DA9063L support

 drivers/mfd/da9063-core.c            |  44 +++---
 drivers/mfd/da9063-i2c.c             | 239 +++++++++++++------------------
 drivers/mfd/da9063-irq.c             | 264 ++++++++++++++++++-----------------
 drivers/regulator/da9063-regulator.c |  84 ++++++-----
 include/linux/mfd/da9063/core.h      |  15 +-
 5 files changed, 316 insertions(+), 330 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
