Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AF2C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B5020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MnCTFfKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B5020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeIKOc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:32:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33851 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbeIKOc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:32:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id g33-v6so25075199wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 02:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2sK79dQY5jgBb+luqTUqyaZCQIxZDCHZVfzIFMbfYQ4=;
        b=MnCTFfKij+zu/cRbuLkdVzB+NYcg0hSowSfRvYTZWAObtJ1zAe3xM88+tUfkQB187g
         O/0F1Ptmrc3bWb+qV1cYziIGK2dRwO+8ZjBu3PZoFiRTiSPfgOU2VVjEoiZzBLCKkoLz
         5PNslPpGXlUg82KE0/HgFKEKOtbV+coUZeHl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2sK79dQY5jgBb+luqTUqyaZCQIxZDCHZVfzIFMbfYQ4=;
        b=VYbJVQx5QdxB/44oXQ4mD+WkI8E/62UxaNgIoUEra3phQ+5GStZ1IZhdhT03ALc47N
         tAzlXjNE0r/H4UdsONnZ3X71oRqxOXxVzMCp6zOoB7aYAgh1FU3bZt4l/x4MUJS3au+D
         jy2YuhysG6BiecIm/3C5CltzSOfrLMojoYcUINZ+gkfZLSXjIB9jjPFt61mMPl/r+zGa
         THDKIlC91udI8z4A9goNuzqZ7Xe+sJnRsFqhSRUBBrClnpnOLE+r7NaTTPJxTgcmpRCq
         9KUrLIUO4sZIUokziE4l5a9VwBXxm4Xk5Go2d4Ayp/BwLIkwkVyLmnJwxKiNuvKDyolz
         +b5w==
X-Gm-Message-State: APzg51DGWjVse0Qa7/8Cg3As9Vn5H5IPACdKN5heik1rWI2JQgaFtTQE
        9AcFfhvgku3VkWTNIfsnWFopSw==
X-Google-Smtp-Source: ANB0VdYMBWgBSxU4VW5Q6ZWIpxt0XD3PAc3Of3qiVKc/KM6px/Dbi1LH1EPUHVz1vNEdfP9d1JEXAQ==
X-Received: by 2002:a1c:bd89:: with SMTP id n131-v6mr727964wmf.97.1536658439637;
        Tue, 11 Sep 2018 02:33:59 -0700 (PDT)
Received: from dell ([2.27.167.7])
        by smtp.gmail.com with ESMTPSA id m68-v6sm934453wmb.10.2018.09.11.02.33.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 02:33:58 -0700 (PDT)
Date:   Tue, 11 Sep 2018 10:33:56 +0100
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
Subject: Re: [PATCH v12 0/6] Driver for at91 usart in spi mode
Message-ID: <20180911093356.GE4185@dell>
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

On Tue, 04 Sep 2018, Radu Pirea wrote:
> Radu Pirea (6):
>   MAINTAINERS: add at91 usart mfd driver
>   dt-bindings: add binding for atmel-usart in SPI mode
>   mfd: at91-usart: added mfd driver for usart
>   MAINTAINERS: add at91 usart spi driver
>   spi: at91-usart: add driver for at91-usart as spi
>   tty/serial: atmel: change the driver to work under at91-usart mfd
> 
>  .../bindings/{serial => mfd}/atmel-usart.txt  |  25 +-
>  MAINTAINERS                                   |  16 +
>  drivers/mfd/Kconfig                           |   9 +
>  drivers/mfd/Makefile                          |   1 +
>  drivers/mfd/at91-usart.c                      |  71 +++
>  drivers/spi/Kconfig                           |   8 +
>  drivers/spi/Makefile                          |   1 +
>  drivers/spi/spi-at91-usart.c                  | 432 ++++++++++++++++++
>  drivers/tty/serial/Kconfig                    |   1 +
>  drivers/tty/serial/atmel_serial.c             |  42 +-
>  include/dt-bindings/mfd/at91-usart.h          |  17 +
>  11 files changed, 606 insertions(+), 17 deletions(-)
>  rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
>  create mode 100644 drivers/mfd/at91-usart.c
>  create mode 100644 drivers/spi/spi-at91-usart.c
>  create mode 100644 include/dt-bindings/mfd/at91-usart.h

Seeing as this patch-set has caused some issues this morning, I took
the liberty to peruse back into its history to figure out where things
started to go wrong.  I also re-reviewed the MFD driver - and I'm glad
I did!

My Acked-by has been attached to the MFD portion since v5, which is
why the code hasn't caught my eye before today.  I reviewed the
relocation of the *binding document* (serial => mfd with no changes)
in v4 and nothing else.  It appears as though you mistakenly added it
to the *MFD driver* instead.  This explains my confusion in v10 when I
told you I'd already reviewed the binding document.

As I said, I have re-reviewed the MFD driver and I'm afraid to say
that I do not like what I see.  Besides the missing header file and
the whitespace tabbing errors, I do not agree with the implementation.
Using MFD as a shim to hack around driver selection is not a valid
use-case.

What's stopping you from just using the compatible string directly to
select which driver you need to probe?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
