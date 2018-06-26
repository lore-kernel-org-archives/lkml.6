Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E6AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAF326844
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Tma9h48M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EAF326844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934703AbeFZKXS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:23:18 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53557 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933581AbeFZKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:23:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id x6-v6so1249802wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DzeYj6ElkzLaUIKpccyn7XcKlrzDS1w5BGuT0bVCHBI=;
        b=Tma9h48Mr0iA9G+2dmEK3963jpQ9o8Am+J5Fwce+PVkd18yi1FkBkO+AMZP1D4uImj
         VbVZvm4ToT+fyZxztWfCV21730VSha7hFznv4h+6ELXAZJNk77zmmSLuYUyQJ8MdYf7D
         5TpwVD0NrNIr+4w3lJ00YOxFRFAxyNGR6Vap4TOICpjyChxZLVSUEjSqgxtFOhvpWFJP
         HNIg+xDQrLLM51bNn5+G0vvQmoY23lQwgDwhBBPFt0+KWq3fxRc7hA7D6Wrwmod0mYxd
         p+TOauMiissfLL6MDQmS1FeejF3OZ6xmVCbJRIxVqvFiexUuz0fZcnMlQ0YKLhtLN9Xw
         sy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DzeYj6ElkzLaUIKpccyn7XcKlrzDS1w5BGuT0bVCHBI=;
        b=a5cQIAOfTirThBahQQAxjsEKAm0vZbiMIHDEoiGyv69Yet9yRaO0jHXc1NSj1+DfCW
         Na3pSszlLlCO5N+fI03hvHu+7onIMaNVE29OwssBJEbIX7pCYmX0FxViVEAO4p/YZT42
         3oQIYS+X11T0G+qVR/uzUV2XU+q8bsgntD3L53JR59cDWKhQXZwP4w/gwvALUqcw21Pv
         6iulFomJG3+tChOzTXK9Zwrwrlit3m9iIz80dhk6byIcsMU0jkfBiJ7zuSqQSohBYCqX
         2s0DJ3CJpamth++Y+oWTEfBI8P7rHKkZVapNMG1MrKtqLP7jUXagCOuicb3EMmBgZnEw
         Xrgw==
X-Gm-Message-State: APt69E1ldA/cd3kjV9qaPYEWY9Gs5aAuI97tkTFhxmdukwm9I6upgWRi
        WEj3GndmJI5YfQ8Oj7zTyN76FQ==
X-Google-Smtp-Source: AAOMgpeFaQtoHwACWRHoB7EGloFMYw3SJ09j+jr5alBvxnzUE//MmnAmyFz2G5Je/2QncOoA/AeG5A==
X-Received: by 2002:a1c:e80f:: with SMTP id f15-v6mr1086457wmh.137.1530008593384;
        Tue, 26 Jun 2018 03:23:13 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-NIC-1-55-10.w2-15.abo.wanadoo.fr. [2.15.147.10])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2573852wmp.23.2018.06.26.03.23.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:23:12 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 00/15] ARM: davinci: step towards removing at24_platform_data
Date:   Tue, 26 Jun 2018 12:22:30 +0200
Message-Id: <20180626102245.30711-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Since I took over maintainership of the at24 driver I've been working
towards removing at24_platform_data in favor for device properties.

DaVinci is the only platform that's still using it - all other users
have already been converted.

One of the obstacles in case of DaVinci is removing the setup() callback
from the pdata struct, the only user of which are some davinci boards.

Most boards use the EEPROM to store the MAC address. This series adds
support for cell lookups to the nvmem framework, registers relevant
cells for all users, converts the davinci_emac driver to using them
and replaces at24_platform_data with device properties.

The only board that's still using this callback is now mityomapl138.
Unfortunately it stores more info in EEPROM than just the MAC address
and will require some more work. Unfortunately I don't have access
to this board so I can't test any actual solutions on a live hardware.

Tested on a dm365-evm board.

v1 -> v2:
- for backward compatiblity: fall back to using of_get_mac_address() if
  we can't get an nvmem cell in patch 7
- add patch 15 which removes dead code

Bartosz Golaszewski (15):
  nvmem: add support for cell lookups
  ARM: davinci: dm365-evm: use nvmem lookup for mac address
  ARM: davinci: dm644-evm: use nvmem lookup for mac address
  ARM: davinci: dm646x-evm: use nvmem lookup for mac address
  ARM: davinci: da830-evm: use nvmem lookup for mac address
  ARM: davinci: mityomapl138: add nvmem cells lookup entries
  net: davinci_emac: use nvmem to retrieve the mac address
  ARM: davinci: mityomapl138: don't read the MAC address from machine
    code
  ARM: davinci: dm365-evm: use device properties for at24 eeprom
  ARM: davinci: da830-evm: use device properties for at24 eeprom
  ARM: davinci: dm644x-evm: use device properties for at24 eeprom
  ARM: davinci: dm646x-evm: use device properties for at24 eeprom
  ARM: davinci: sffsdr: fix the at24 eeprom device name
  ARM: davinci: sffsdr: use device properties for at24 eeprom
  ARM: davinci: remove dead code

 arch/arm/mach-davinci/board-da830-evm.c    | 25 +++++++---
 arch/arm/mach-davinci/board-dm365-evm.c    | 25 +++++++---
 arch/arm/mach-davinci/board-dm644x-evm.c   | 24 ++++++---
 arch/arm/mach-davinci/board-dm646x-evm.c   | 25 +++++++---
 arch/arm/mach-davinci/board-mityomapl138.c | 30 +++++++++---
 arch/arm/mach-davinci/board-sffsdr.c       | 13 +++--
 arch/arm/mach-davinci/common.c             | 15 ------
 drivers/net/ethernet/ti/davinci_emac.c     | 33 +++++++++----
 drivers/nvmem/core.c                       | 57 +++++++++++++++++++++-
 include/linux/davinci_emac.h               |  2 -
 include/linux/nvmem-consumer.h             |  6 +++
 include/linux/nvmem-provider.h             |  6 +++
 12 files changed, 186 insertions(+), 75 deletions(-)

-- 
2.17.1

