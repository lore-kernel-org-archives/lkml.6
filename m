Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60940C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9016820866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eqtdpgVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9016820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbeIKPzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:55:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37568 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeIKPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:55:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so25508579wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 03:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UKjZjkwg4BK3qJsH2/ql+9XDatznYEL1Ne4nTRVq838=;
        b=eqtdpgVvwBpF43euORJoOqHHImur/G/BCoM4LQcT0IDAsKm2wrJ2fb7i8sViZ61C0r
         JfHzoxgyRva1msVOnPLWlVHSqdqZebOziSCQWJiPS0vqlqqj/KmGk0CeTww1m353KApM
         yEQwhtQa1lmthL7R3EUUFL1kemJWikn5i98+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UKjZjkwg4BK3qJsH2/ql+9XDatznYEL1Ne4nTRVq838=;
        b=eSXUfO3xac0xEk6uiwqW3aKSW9lTP7k8gdU1AZjf1GYLi3DhIbtuWab54xr3rFQuDJ
         gduXxP8BOR6PGPpt7sAFjOlqQed68p1AIpTuEbPUw0xEHqqqzFSFw5BMDSkDJtGgurXJ
         TNtrj6raAjFFmDYbYEFyLYL82bqZsrT5lp6safuDHDsEwv0GBaMOEkhbpByNwRZayXBY
         xLh26I1SdXCceQCTJvGWxGKnOM8MRF4rTJN2qkQLjrvFE7Q5mzwxHNBDwRdnFsSUQEcl
         ObT/07uEHGjEUZ6meOm8+5odlmLmTnM4M1JtxDcvbQmbqDi0D2n4dUHSNltamKiSip8X
         cHSw==
X-Gm-Message-State: APzg51D9sBmGa4cy/9tUFAUh7o34qnzbPkMvL26qfilDuKDvw0FaaKsU
        zK3ei7VbjP8QhQhp8CVy0Fkskg==
X-Google-Smtp-Source: ANB0Vdb8QgDNxuFr6EKBiwKLEox0RITrG0zGtaI1No7fnlFoPK5SM/obdiHiC3izhQmPxxwPDMIeuQ==
X-Received: by 2002:a5d:5383:: with SMTP id d3-v6mr18293007wrv.191.1536663391231;
        Tue, 11 Sep 2018 03:56:31 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id d12-v6sm26134240wru.36.2018.09.11.03.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 03:56:30 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:56:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911105628.GI4185@dell>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180910151803.GX28860@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910151803.GX28860@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new pull-request contains the following changes since v1:

 - Uplift the submission version from v11 to v12
 - Include fix for build breakage due to missing Device Tree include file

Since it is based on the original pull-request, it can be pulled
in either directly on top of it or as a pull in its own right.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20-1

for you to fetch changes up to 65b80dfffeabd4eb253b93d07eadde4d89c18511:

  mfd: at91-usart: Include Device Tree header (2018-09-11 11:44:56 +0100)

----------------------------------------------------------------
Immutable branch between MFD, SPI and TTY due for the v4.20 merge window (v2)

----------------------------------------------------------------
Lee Jones (4):
      dt-bindings: mfd: atmel-usart: Correct interrupts property to include IRQ number
      MAINTAINERS: Change Radu's email address
      spi: at91-usart: Make local functions static
      mfd: at91-usart: Include Device Tree header

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
 drivers/mfd/at91-usart.c                           |  72 ++++
 drivers/spi/Kconfig                                |   8 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-at91-usart.c                       | 432 +++++++++++++++++++++
 drivers/tty/serial/Kconfig                         |   1 +
 drivers/tty/serial/atmel_serial.c                  |  42 +-
 include/dt-bindings/mfd/at91-usart.h               |  17 +
 11 files changed, 607 insertions(+), 17 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
