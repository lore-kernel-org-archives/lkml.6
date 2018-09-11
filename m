Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84755C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4E020833
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QLOhg8DW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4E020833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeIKQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:17:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36808 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbeIKQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:17:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id e1-v6so16573373wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kg6khZMy1SS5Il9Uizl2rRk6qdc5rQUkaBlFUx0xCFw=;
        b=QLOhg8DWjNTwU+i3XqIzbcQKJfXWbZq2uCddD1Z7rmCjG1mll/9/LTpiWx6J009e9L
         4TmtDSvxAVMeJHceWJJv/sONpSuflTX3hTkvIaD2uFOtP444fe4NiOF6LHR+rbE9n02d
         EnMkAYnaO+B0aInhR91FX2BXwwSLOU0Baue1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kg6khZMy1SS5Il9Uizl2rRk6qdc5rQUkaBlFUx0xCFw=;
        b=sZzVYafyA4zlDHJ8M1ak4jgKdAQQItQhNS45Bs9ADRBomnfQaGqHjP/mNQSN7P2Zl2
         VcFESXA5pOrCMZJA7qIU6ZxlWSAQ0xuj/SQvC5N0vMxbh4rHv+GEm/Son3W/mP9+BYIr
         1lsDIhq9ZvTu6vDMYLSWty8BSzD/pzdT9M0BngXvOJmVUxfx/vTD9zH4O619eLKTqna4
         2APWxVgln9Sl0oEzPASPImcz9G26lAM+A2cgqg3Z2a3ZCx5DcabbqGB5g4RIy8WNGn2V
         0bqhV3iDcW2sGUjVeHl+/JdWfmWfy+EqLRFWpc7+std3+DHwX6X02VgGWH8bqUDoYPTr
         zASw==
X-Gm-Message-State: APzg51DZHxbK9wVIW7QRz6XQg7jq3DwM6cmD5K222U7LHmV9whuuBeMt
        XDmZgP07ZDxHJHMXxgDnzkyT8w==
X-Google-Smtp-Source: ANB0VdZ7AG+cmi5DrFjODjxzpo2MC/kR79L9JyMNZKW6YziNnMGHDvSfITLUWjK6TSwJ4hjB5v3R4g==
X-Received: by 2002:a5d:4401:: with SMTP id z1-v6mr19417485wrq.227.1536664733529;
        Tue, 11 Sep 2018 04:18:53 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id l10-v6sm17353951wre.0.2018.09.11.04.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 04:18:52 -0700 (PDT)
Date:   Tue, 11 Sep 2018 12:18:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [GIT PULL v2] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911111850.GJ4185@dell>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[In case you missed it]

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
