Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A60C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC652082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TRgfy11M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC652082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbeLKGMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:12:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeLKGMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:12:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so12770106wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 22:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZDyVsTCjD6cUjPtLRmbsViHBeMSMpqQ23PS+zBehiEU=;
        b=TRgfy11M5JpuBH5UY6kVM8zlgirJ5GjgRzzR64dlpQXXD3cvDy2oexSQ9+UDCU+SP5
         cT+5A7PQ/YlJQThu5E1YjDZd8biFx/wF24PV7RIxBfmvDyi+k88WlaUALNyb/4NKagaK
         Me8kOl6oKLu8FWKDJCCYcu7IGXJ6yblIPTCZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZDyVsTCjD6cUjPtLRmbsViHBeMSMpqQ23PS+zBehiEU=;
        b=nhp86v4y85VbPgqH2GNYdxpPHS2tuYN6LeaWkcKOFEo4yDHxj5I5V2dIUib/PmYHyU
         tXAULgWqEDGYnxI/JkTFtwwArRwhNQdM/zVt6mkxpJ778eieEzxiyv+N0q6o1K3Hah3M
         7bJTxPHbxBGB+SPsgl/uKGJQZKw2HPb41xk4/RJrxLjWEnpOjsc/p7ZKSmSa7dT2iHpP
         Et6cH/ILSkwKv/MbQnZ5xodAYR62aFym6RyZRIMAdTbJ4Cz0m2bluU/c0tpXp7jHD3R7
         Ix31SoKFly8MZ1mN9rMC8DQ2b6W5jrqM62PDxP58UHEa5yH+4DcjpDlT6YMgxW6gz7YG
         7YOA==
X-Gm-Message-State: AA+aEWYl91IgaNIosSfFWirb+B7Xyv0KJKo1omkaOXmW5qJawozCk3Z5
        TFPQqqI9Oy8HeKjfqR8s8R+8hA==
X-Google-Smtp-Source: AFSGD/UaB7bIDLi4eHeKztzQyzC5FYsRmGJnGtQYvjtF5DomADxRE6XN8m5BsjrqFuwDVEA6rXWaZQ==
X-Received: by 2002:adf:fb0d:: with SMTP id c13mr13302787wrr.285.1544508730335;
        Mon, 10 Dec 2018 22:12:10 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id l78sm21636131wma.0.2018.12.10.22.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 22:12:09 -0800 (PST)
Date:   Tue, 11 Dec 2018 06:12:07 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec_dev: Add missing mfd_remove_devices() call
 in remove
Message-ID: <20181211061207.GE4497@dell>
References: <20181210180002.4440-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181210180002.4440-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018, Enric Balletbo i Serra wrote:

> The driver adds different MFD child devices via mfd_add_devices() and
> hence it is required to call mfd_remove_devices() to remove MFD child
> devices.
> 
> Fixes: 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Hi Lee,
> 
> I saw that you send a mfd-fixes pull request this morning, so sorry in
> advance for sending this too late. This was broken since the driver
> moved from platform/chrome to mfd (and probably before that), so
> it's an old problem. Note that I plan to send a patch series that depends
> on this to apply cleanly. If the patch is fine with you and there is any
> possibility to go in this version that will be good, if not, let me know
> if you prefer queue this in your for-next branch or if you prefer I
> include the patch on the series I plan to send on top of it to not mess
> things.

It wouldn't have made the v4.20-rcs anyway.  Even if you did send it
earlier.  I only send fixes to that -rcs which fix issues introduced
during the current release cycle.

If memory serves, doesn't this driver now (or will in the very near
future) use devm_* for device creation?  That would make this patch
either incorrect (should be devm_mfd_remove_devices() if really
required) or moot?

>  drivers/mfd/cros_ec_dev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index b99a194ce5a4..2d0fee488c5a 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -499,6 +499,7 @@ static int ec_device_remove(struct platform_device *pdev)
>  
>  	cros_ec_debugfs_remove(ec);
>  
> +	mfd_remove_devices(ec->dev);
>  	cdev_del(&ec->cdev);
>  	device_unregister(&ec->class_dev);
>  	return 0;

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
