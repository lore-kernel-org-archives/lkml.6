Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3051BC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C2F20865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6q4YlHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C2F20865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbeIKNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:44:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43729 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeIKNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:44:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so24696033wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Kfafixxya1Y0r4nGmLNv0HSPyzQ59zoR+/bUxAcLnOM=;
        b=E6q4YlHkZOvwGnohLocCiLa9IVXTxv+EOyE5EOAzgzmqsowHf377D+RPS9BHGLjZAn
         PLFTasJKtyjuIGBvC6yht+SiWWsRqLLUnPz0bdqoev+PXiVpDbk938kd5T3zy67Yoa6e
         0TX2UYgdia29o39f0EFAyozqSy3WkWNiUWJjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Kfafixxya1Y0r4nGmLNv0HSPyzQ59zoR+/bUxAcLnOM=;
        b=hPSheLVQqP+vDAFPFqTBMLkaKn9JkcZBpnJOLNg5NmNuaFlGwv8RVo7mGE5U1lO5uC
         hjOsn7a6VEJMMXhGw7vZu+oFwskv0b9/WOJ80Yv8Kscg8gz7cmhwYatwpkltvnPB1PUA
         sFm9pIBByGBUpiKCEOeV2ej31ngV9il1qTeXZI6k4TNhWkbKhKE/EMACQZmy2JcyhYP9
         try61ksRhFqpVYIVxqP94CHbn76t8XXi8Fj9qDnafTO/4O7RAo2TCXqnQgi+eHMuLnW+
         +Gqeuevyt7uH7TYuSE2hyJQHLlL36xrYpbnmgPCDh5XYIFj5WSL7n/4F452ha37wksYd
         vEvA==
X-Gm-Message-State: APzg51BPVLkeGEpQAtPFcKLZ9UXBQ8mZRCcF7fzOQ8mZAZotwf4NLqOZ
        L2MZiql74UGsIBA/5MoOdqhlFw==
X-Google-Smtp-Source: ANB0VdaNnBfuA36GciFsc15KTuOY7XtBJs6gBh/6Dyggo6HP7ya43+du1AA3hQrdrKVF/O/k9vhzsg==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr17637308wrg.230.1536655550572;
        Tue, 11 Sep 2018 01:45:50 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id m8-v6sm12493116wrn.72.2018.09.11.01.45.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 01:45:49 -0700 (PDT)
Date:   Tue, 11 Sep 2018 09:45:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Radu Pirea <radu.pirea@microchip.com>
Cc:     broonie@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, richard.genoud@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] Immutable branch between MFD, SPI and TTY due for the
 v4.20 merge window
Message-ID: <20180911084548.GC4185@dell>
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

On Mon, 10 Sep 2018, Lee Jones wrote:

> Enjoy!
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-spi-tty-v4.20
> 
> for you to fetch changes up to c24d25317a7c6bb3053d4c193b3cf57d1e9a3e4b:
> 
>   tty/serial: atmel: Change the driver to work under at91-usart MFD (2018-09-10 16:12:43 +0100)
> 
> ----------------------------------------------------------------
> Immutable branch between MFD, SPI and TTY due for the v4.20 merge window

Due to a comedy of errors, I'm voiding this pull-request.

Please stand-by for a follow-up.

> Radu Pirea (6):
>       MAINTAINERS: Add AT91 USART MFD entry
>       dt-bindings: Add binding for atmel-usart in SPI mode
>       mfd: at91-usart: Add MFD driver for USART
>       MAINTAINERS: Add AT91 USART SPI entry
>       spi: at91-usart: Add driver for at91-usart as SPI
>       tty/serial: atmel: Change the driver to work under at91-usart MFD
> 
>  .../bindings/{serial => mfd}/atmel-usart.txt       |  25 +-
>  MAINTAINERS                                        |  16 +
>  drivers/mfd/Kconfig                                |   9 +
>  drivers/mfd/Makefile                               |   1 +
>  drivers/mfd/at91-usart.c                           |  71 ++++
>  drivers/spi/Kconfig                                |   8 +
>  drivers/spi/Makefile                               |   1 +
>  drivers/spi/spi-at91-usart.c                       | 432 +++++++++++++++++++++
>  drivers/tty/serial/Kconfig                         |   1 +
>  drivers/tty/serial/atmel_serial.c                  |  42 +-
>  include/dt-bindings/mfd/at91-usart.h               |  17 +
>  11 files changed, 606 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 drivers/spi/spi-at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
