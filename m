Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2250FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF0C020C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 08:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+VtQQLc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0C020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeIXOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 10:49:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37273 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbeIXOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 10:48:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id a82-v6so548008lfa.4;
        Mon, 24 Sep 2018 01:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6EtsiX4dVSUFCHVjq+4RPr9o1tjvrOWFDvhK8fisacc=;
        b=B+VtQQLcDBrn7jPHbm8D8XEze7UPCtG6BPBr7m6bC2Ko0ndY6EJahb10YoLiey+eBn
         gy3HI7z0asRNybdhuGf8/2ehm5JiUqhmIVTeVAdQ47dj/QLbfRHxOWy9K1I+YRsg5I1B
         MiOEX4VShMj9Ij7nkdfDWIXCp7d/D03vKpLmTzSwcvTqfSuEXwcZRNWMnakd6OG688mI
         bMzQQZieKC4x6HPmr0/r2l5s/bDTfn+w3MJP0ht8GtIoGbC2ntGfT71DXOO2ljaYxnTE
         lco2nd2gllR+oKQex12fPhYc6qrQIdSDpADPaK+mLkjzFgC4y798h3QPKp7tDIhwQFvL
         pF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6EtsiX4dVSUFCHVjq+4RPr9o1tjvrOWFDvhK8fisacc=;
        b=sg4FXE29xh6Zke8H7LomHGolRZ9X6r7fgStJEeVYnaTU1qXPaABnnC5JoHRCihRHWz
         8r9HeS+AjdHFdMG7PVNveiCSUrtVn9H7EW+qlqElkDJRsct1ghqwa3mgx6VKpuHPY9v2
         5LtcjWGeciITboZBftQrzxBVdDu49aGAJlOKgQv9P0nBmTOLUPwlyDCoifWzZI6Mr2UO
         QiHMrnpbZ59nSeTjLVXluuOjxx91eeJ053htgrMBPDoI0LfCQajFBHK/mv7zCuvD5DaG
         6LwkUEG96ZSGsG+0tCXYfO7AQL0jCt2Q+twwzDVW11k8JvV3VMzN+HUAA0PR8yr6Y3lY
         EMlA==
X-Gm-Message-State: APzg51CxBYE6cI5d7//jQaR4wXMF2xXndl/Y0YoptlCXwb5ZMfaz5dvq
        B3iI5QOiUZ1SJSeT8KvLd9s=
X-Google-Smtp-Source: ANB0VdZjHwMsd9fqRnAkKNyzP5GPytvdC3YNqT4BFwUxlYbZ75NxqIbXZcpaPvo9P9qG0TFi1R1Ozw==
X-Received: by 2002:a19:1709:: with SMTP id n9-v6mr5771150lfi.74.1537778878923;
        Mon, 24 Sep 2018 01:47:58 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id f22-v6sm6283537ljk.11.2018.09.24.01.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 01:47:58 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1g4MX6-0004wo-2l; Mon, 24 Sep 2018 10:47:56 +0200
Date:   Mon, 24 Sep 2018 10:47:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v5] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180924084756.GD5101@localhost>
References: <20180923160330.2184-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180923160330.2184-1-pados@pados.hu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 06:03:30PM +0200, Karoly Pados wrote:
> This patch allows using the CBUS pins of FT-X devices as GPIO in CBUS
> bitbanging mode. There is no conflict between the GPIO and VCP
> functionality in this mode. Tested on FT230X and FT231X.
> 
> As there is no way to request the current CBUS register configuration
> from the device, all CBUS pins are set to a known state when the first
> GPIO is requested. This allows using libftdi to set the GPIO pins
> before loading this module for UART functionality, a behavior that
> existing applications might be relying upon (though no specific case
> is known to the authors of this patch).
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> Changelog:
> - v2: Fix compile error when CONFIG_GPIOLIB is not defined.
> - v3: Incorporate review feedback.
> - v4: Include linux/gpio/driver.h unconditionally.
>       Replace and invert gpio_input with gpio_output.
>       Make ftdi_gpio_direction_get return 0/1.
>       Change dev_err msg in ftdi_set_bitmode_req.
>       Change formatting of error checking in ftdi_gpio_get.
>       Drop dev_err in ftdi_gpio_set.
>       Remove some line breaks and empty lines.
>       Change error handling in ftdi_read_eeprom (and adjust caller).
>       Replace SIO->FTX in FTDI_SIO_CBUS_MUX_GPIO macro name.
> - v5: Read only 4 bytes from eeprom in ftx_gpioconf_init.
>       Compare ftdi_read_eeprom result with 0 instead of eq. cehck.
>       Reserve 4 GPIOs even for FT234X.
>       Release CBUS after gpiochip deregister to avoid possible race.
>       Adjust comment on FTDI_SIO_SET_BITMODE macro.
>       Protect GPIO value/dir setting with mutex.

This patch doesn't add any locking so I'm assuming you posted the wrong
version of the patch.

>       Add support for gpiochip.get_multiple and set_multiple.
>       Add names to GPIO lines.

I'll wait for v6.

Thanks,
Johan
