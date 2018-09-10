Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE54C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA89B20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNduZhlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA89B20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeIJUMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:12:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbeIJUMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:12:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so22348216wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oUi9NUe7lEYlUY3vz38hf+WNoDYElyYdIJKfOPJX2qI=;
        b=GNduZhlCsjOW6Mm7WGc466keTQ086QeObqx5olwVmx/v905vyx1TrW6Yes6L9jXsMV
         aBfBbSO+zdOQUoQfeASmWyeT4r7z7MhewtFmLGVLK0MG+IC6yl2EaB0CMRCwOaKcNg3Z
         acyP2nIn2AxZwoAOsZv4K6f90I8TSZ962/nmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oUi9NUe7lEYlUY3vz38hf+WNoDYElyYdIJKfOPJX2qI=;
        b=SBU7Yj367AiGgR0ntHCZKTNa1+EOI/3ncsZUCNoCBJGmOotzBGRyP0j06iK88yppF+
         tG61Si62ToitfFoRVYX9cK1kAl2PRfcGECpWeBJPoRCjGhRBDvTGD4jDI3upMGyEnQuu
         XVzq7xTNB3ARDlJ8YPt6OdJPksJlz0Dmu23a3tqFSP+k5m4HlhH+WfYX52xscwii2Cfd
         8XJxwFYGJ5gMDdrkFjKkr02olInJjzayaV7AiVPehOGQpp/K+zVNEZlmYPHb/jplGRdP
         xQE08svon9l0A1qVLG1SIyru5TEbv7ZDXqnRnxHABSZ2AKU935MyPxVGt7D1HHYix9Fx
         tVxw==
X-Gm-Message-State: APzg51BaI3jVAzK8ElgFEwRBSivRzi5dRtUY/avtNT5f273B8QMgDip2
        zgOrJzMXqrl4QKegPG/8T9ZxmQ==
X-Google-Smtp-Source: ANB0VdaXiNXakVRASWAz+HC1850ZV8BEyFjZonUnqGixQvPr6UjYmHkKQDkDZFMuMctO5itPw3hbeQ==
X-Received: by 2002:adf:f4ce:: with SMTP id h14-v6mr16508299wrp.259.1536592685709;
        Mon, 10 Sep 2018 08:18:05 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id q16-v6sm11006016wrn.41.2018.09.10.08.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:18:04 -0700 (PDT)
Date:   Mon, 10 Sep 2018 16:18:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180910151803.GX28860@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180713164736.26028-1-radu.pirea@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20

for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:

  tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)

----------------------------------------------------------------
Immutable branch between MFD, SPI and TTY due for the v4.20 merge window

----------------------------------------------------------------
Radu Pirea (6):
      MAINTAINERS: Add AT91 USART MFD entry
      dt-bindings: Add binding for atmel-usart in SPI mode
      mfd: at91-usart: Add MFD driver for USART
      MAINTAINERS: Add AT91 USART SPI entry
      spi: at91-usart: Add driver for at91-usart as SPI
      tty/serial: atmel: Change the driver to work under at91-usart MFD

 .../bindings/{serial => mfd}/atmel-usart.txt       |  25 +-
 MAINTAINERS                                        |  16 +
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/at91-usart.c                           |  71 ++++
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-at91-usart.c                       | 432 +++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/atmel_serial.c                  |  42 +-
 include/dt-bindings/mfd/at91-usart.h               |  17 +
 11 files changed, 606 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
