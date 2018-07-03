Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09FD724EB7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ltr0tFLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09FD724EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932962AbeGCGch (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:32:37 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38148 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932730AbeGCGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:32:34 -0400
Received: by mail-wr0-f194.google.com with SMTP id j33-v6so663572wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 23:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=C/FqIBLgAUWVtD52AsRt6lJDNXAmYRzpSjXzDj6iCMg=;
        b=Ltr0tFLVrHYnN4U6+AW8pKA1ZxPbmpR1ItDdYPmfaLvQR6X/DJfceDK7GCde8Onk8t
         wmpbqO+VybmModIHXbcrkbzSYXGBj/WurkKq71pBijiTm7ZjfRX7vp9igredmIXxaI/b
         yRBi8qoj5ZKJ5Ng4n2SeROJ/Xj9VwQSDSMVGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=C/FqIBLgAUWVtD52AsRt6lJDNXAmYRzpSjXzDj6iCMg=;
        b=pEuVDKwLe8/yZyjU5rPF7AGesSGntIbZ/Syj0zqf/NGwMAb+S+aZlrVLARfwlT+BSc
         lMMWgtKwliygzVlCg6W6rcJg/4Hw6xZbn9yuP+EuviM+v780wuV+QWwWiCkAWc9LdKvX
         cL2a4ZcYJicoOhukgxuo3dP9CDXN6H79nvcMDfIzJb3BkER4kWTF/3kFFd8yAJSwcSuC
         5YbHGilhGa6lVUvA4Z0ZF8iCihOY382ITtwaQEbg4O5WcGJmbr7BR/F61KlBw69LJdR+
         onR5yZvdCAZfjYEjMfhixgwRtNdyA0uQcIsg3G5/4xAhU6ZfPN+kVi/qykoUgo4ndc9U
         aixg==
X-Gm-Message-State: APt69E07AYiU7JON4smuYn7fomEXmF4fBVJ0IUsAMS7BGc44Bh2CEpBh
        Tyr2GdIH21/1ZPMJEQ08/fXXMw==
X-Google-Smtp-Source: AAOMgpcq4vaaFhOtsqiMoLnDZWWKhduww9wRErRl2liwB4VpukRd+9xULK9S5RvOeQfW3IjH2z+pGQ==
X-Received: by 2002:a5d:5641:: with SMTP id j1-v6mr8678753wrw.209.1530599553484;
        Mon, 02 Jul 2018 23:32:33 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id i9-v6sm336639wrs.92.2018.07.02.23.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 23:32:32 -0700 (PDT)
Date:   Tue, 3 Jul 2018 07:32:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        kernel@collabora.com, Guenter Roeck <groeck@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] platform/chrome: Move cros-ec transport drivers to
 drivers/platform.
Message-ID: <20180703063230.GC4242@dell>
References: <20180702102201.13461-1-enric.balletbo@collabora.com>
 <20180702102201.13461-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702102201.13461-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Jul 2018, Enric Balletbo i Serra wrote:

> There are some cros-ec transport drivers (I2C, SPI) living in MFD, while
> others (LPC) living in drivers/platform. The transport drivers are more
> platform specific. So, move the I2C and SPI transport drivers to the
> platform/chrome directory. The patch also removes the MFD_ prefix of
> their Kconfig symbols.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  drivers/mfd/Kconfig                           | 20 -------------------
>  drivers/mfd/Makefile                          |  2 --
>  drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
>  drivers/platform/chrome/Makefile              |  2 ++
>  .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
>  .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
>  6 files changed, 22 insertions(+), 22 deletions(-)
>  rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
>  rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
