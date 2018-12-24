Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7FC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FC221850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ0Xpyz1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLXWAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:00:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39404 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:00:54 -0500
Received: by mail-wm1-f66.google.com with SMTP id f81so12599904wmd.4;
        Mon, 24 Dec 2018 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wETRVoQwq1FJW2ofgoSV5BYdsGt8DeR49CADrQfmLZQ=;
        b=uZ0Xpyz1noBUtZPxGKJ88kUMB4+4hExjDMX9qwFOotCt/KgmhEvrhd06QkosTAcFXO
         8vi+xlJIrZt5jIyzBvZ3+Q6Btapx2lrEwSl4g2FDulaYcKUUL8xEXNI/JVB/Tnzp9Lom
         HNJrqFbyNjp0QEnDTZxxMHKXL0feL6qwUMyTs18RWriJUjNKDxxOE0YUPxRyYjzQMcKJ
         VVnMP54amhQvIAEsJbOmvf7EphWqpLIzioEk5IIlMnVkAnSAvSN+fJfL0ubQDmyg2uzH
         AdWY8rxb19LM2dM7nUIbiDyTUzD3nVgOdIPhJpLM5i2p+cMJbwaXbbUDpvu422LFKWpL
         w7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wETRVoQwq1FJW2ofgoSV5BYdsGt8DeR49CADrQfmLZQ=;
        b=CQ3sSfbWbcbQsxEbzXXnM1OAjGdwaZItxRqmzXg5mdNPVEoowPqKh4bQzQAvsFCdH1
         kTG7RAZCs2Qt5yLEpV4lmLZu95uYQwMT4EfB8mfPdncpaaDpAUdkMXHgiSlyJceQAmaD
         VyB4PHxazVZZadR6SMNGYSi3OfPyYOr08KtqPax5+29PjQz9BYNvTJUXzGdtQKFTy7Rn
         1E/JgF4XyEGmdteBHIIuy6HJhsgB8M7xjZvvKP80v8zyZBszgX8aR9N/Gy06JnbHjTmb
         pho0nAmdy8NDwYCBNc2LSJemkwUGVwsmG50sWS28nosgHZ48iU2egxispYVF6NGPmZ48
         4QfQ==
X-Gm-Message-State: AA+aEWZHMV7TBe/VttF+0Z8uNDr8Qt5ZCwsuJzg/BAa1U/Rjd3DVYY24
        mGRS9kZaEqIEn4JAKymLHgVmxSbFiS0=
X-Google-Smtp-Source: ALg8bN6QPiUZSycrwzktCXQiDQnfq6CwkVEziEhl8FcqE9l6gWGjcjn21/n52shhQZmbM0RuFZfxGg==
X-Received: by 2002:a1c:f613:: with SMTP id w19mr13371149wmc.0.1545688852372;
        Mon, 24 Dec 2018 14:00:52 -0800 (PST)
Received: from gapa-Lenovo-IdeaPad-Y580.home (daw20.neoplus.adsl.tpnet.pl. [83.23.22.20])
        by smtp.gmail.com with ESMTPSA id d4sm23970153wrp.89.2018.12.24.14.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 14:00:51 -0800 (PST)
From:   cezary.gapinski@gmail.com
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Cezary Gapinski <cezary.gapinski@gmail.com>
Subject: [PATCH v2 00/14] Add support for STM32F4 SPI
Date:   Mon, 24 Dec 2018 23:00:26 +0100
Message-Id: <1545688840-23992-1-git-send-email-cezary.gapinski@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Gapinski <cezary.gapinski@gmail.com>

This series of patches adds support for first generation of SPI
interface for STM32F4 family.

This version of driver is mostly different to STM32H7 one. Based on
linux kernel I2C drivers for STM32 where drivers were splited into
STM32F4 and STM32F7 family the same approach seems to be sufficient for
SPI STM32 drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c
file and register and functions were renamed to be more specific to
STM32H7.

For current version master mode with full-duplex and 8/16 bit data
frame format are supported. There is no TX and RX FIFOs like
in STM32H7. DMA capabilility is supported for messages longer than
arbitrary number of bytes (that is set already to 16 bytes) when TX
and RX channels are set at the same time.

v2:
Based on Amelie Delaunay recommendation only one common file
spi-stm32.c is used. Before adding support for STM32F4 driver, first six
patches adds some improvements to actual driver.
Next patches rearrange driver to be more useful for new STM32F4 SPI
and adding support for this family.
This version also supports simplex-tx and 3wire-tx modes.

Cezary Gapinski (14):
  spi: stm32: switch to SPDX identifier
  spi: stm32: use NULL pointer instead of plain integer
  spi: stm32: fix DMA configuration with only one channel
  spi: fix typo in SPI_STM32 help text
  spi: stm32: use explicit CPOL and CPHA mode bits
  spi: stm32: remove SPI LOOP mode
  spi: stm32: rename STM32 SPI registers to STM32H7
  spi: stm32: rename interrupt function
  spi: stm32: split transfer one setup function
  spi: stm32: add start dma transfer function
  spi: stm32: introduce compatible data cfg
  spi: stm32: add support for STM32F4
  ARM: dts: stm32: add SPI support on STM32F429 SoC
  spi: stm32: add description about STM32F4 bindings

 .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
 drivers/spi/Kconfig                                |    2 +-
 drivers/spi/spi-stm32.c                            | 1403 +++++++++++++++-----
 4 files changed, 1139 insertions(+), 335 deletions(-)

-- 
2.7.4

