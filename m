Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB40C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75562145D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy5c1Tnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75562145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeLCKdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:33:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54950 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeLCKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:33:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id z18so5180513wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=chojXKWYe2518mzyGYJ7zbMzCzqr0ZX9h4tgKI/cldo=;
        b=Oy5c1TntXyQlfLYoECSnj5gXWzCnRn0Jwf1lYaRBQJ7H5nmXZQVf81A6j5vy0HlcdR
         9mtpLnn6+q07bgdHrVGRGcXZPxQdyRET/mCKlIOGjsS0bWJj9T71VvJzPvfBm7j8sCU0
         vMaqjrth69PAQ7JLj9GZHu5CVKLCJm9oN4rqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=chojXKWYe2518mzyGYJ7zbMzCzqr0ZX9h4tgKI/cldo=;
        b=cd4JDHP7S7dcw25RsCHXQbFzUjljXtOWcJKQ9JtON8ALyc+Qda5ZrCVVDivDqkgk1J
         ZlxPM6aWvMTGeaakTsa/IXIqcOjPa1uUAszukwGZ4EoAShOGeLtX/5kW39ymyhlAKfeA
         /ctLDN+zlrVNsRcKT3fDcBqjo1cXnOaMrqxaUHh8FoxQeYzkDuH3JJ9ojE/N6XVHBZqI
         6N6Rl/9UGsP1tIUJFlzqZhBqffhJvE36UnvL6foVODq6oVvK1aZmcCT5GGwRdmP9AQGo
         ehAiT0Zhe86sx7F2CEb2l8KWNM23SH/G0DTnjhDOixJvy4hRKtriTXW7I8vJp79OTo9Y
         IqkA==
X-Gm-Message-State: AA+aEWYrf2Gv6DDHXE+yeJw48HMmVzyFh7n92yBc/nldQy5CEvv5eNJg
        jRLM7sEoKvTW34R6uQ/OobTlhw==
X-Google-Smtp-Source: AFSGD/VQKrCvzY8BOuBhwoesMN9jNFhNkZxxK2pxDJtBxVAzqf/ZDkdzxgP8xJRXj5NjCt/jcP7OCg==
X-Received: by 2002:a1c:aecb:: with SMTP id x194mr7143502wme.96.1543833151162;
        Mon, 03 Dec 2018 02:32:31 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id o4sm5462368wmo.29.2018.12.03.02.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 02:32:30 -0800 (PST)
Date:   Mon, 3 Dec 2018 10:32:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 1/8] mfd / platform: cros_ec: use devm_mfd_add_devices.
Message-ID: <20181203103228.GC26661@dell>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-2-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181127121849.23975-2-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:

> Use devm_mfd_add_devices() for adding cros-ec core MFD child devices. This
> reduces the need of remove callback from platform/chrome for removing the
> MFD child devices.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Removed cros_ec_remove from include file.
> 
> Changes in v2:
> - Use devm only for the cros-ec core.
> 
>  drivers/mfd/cros_ec.c                 | 14 +++-----------
>  drivers/mfd/cros_ec_dev.c             |  1 +
>  drivers/platform/chrome/cros_ec_i2c.c | 10 ----------
>  drivers/platform/chrome/cros_ec_lpc.c |  4 ----
>  drivers/platform/chrome/cros_ec_spi.c | 11 -----------
>  include/linux/mfd/cros_ec.h           | 10 ----------
>  6 files changed, 4 insertions(+), 46 deletions(-)

Nice patch.

Just one question:

[...]

> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 8f9d6964173e..ff788d3e6d5f 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -493,6 +493,7 @@ static int ec_device_remove(struct platform_device *pdev)
>  
>  	cros_ec_debugfs_remove(ec);
>  
> +	mfd_remove_devices(ec->dev);

Why is this still required?

>  	cdev_del(&ec->cdev);
>  	device_unregister(&ec->class_dev);
>  	return 0;

[...]

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
