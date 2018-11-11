Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EF4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98BC208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd492yOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98BC208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbeKLCXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 21:23:04 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34023 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbeKLCXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 21:23:04 -0500
Received: by mail-pg1-f193.google.com with SMTP id 17so2682932pgg.1;
        Sun, 11 Nov 2018 08:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wWYLPQcHggiQSDqWdRca3YZneGsfrnXudHSsBiBkBIc=;
        b=Cd492yOGZFFKfASkv/K8QxGW1jdlCRATOPUgxPIJjsw9eLiUbYp+lxA1TcTeB92n7t
         ySC77Yf6p7Cxv80HBcrrxy8SleA3s6ap7yXs3S7YE9W2rIDws4+ohDym0MeXCkBBlmB+
         YhSOobZX+37XDjjE0+6UiDKhS1Uef/1f2acw3Fhtzs8r/P3txQ60yTXUtWsbkZW+rl7N
         sXHlYrxGGzGlkMO0L67dFVkfzo7aCXVGjghqPB1vPq9RKj4zZhbJPkfT+prsPJobmKGX
         JHGDKubipMIqHn/qrhpMfXO7qMUqHbuLp6YfbOlJBVQHpTbr5UeHR23JXS2Xt2qa8DlY
         w0/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wWYLPQcHggiQSDqWdRca3YZneGsfrnXudHSsBiBkBIc=;
        b=XR5ofFZw9GCOmbsQyyc9PRo5JeCqYPsvOp5lfYb1Bp6xip4zMdq1JRJnlhcwaNf3kC
         gU+yagFEzy8xUeGDN7E8Cgr2vXkInAEPte/fjnRtbQxWhlWRi9fODAfg5wKF07Gqs3UY
         RkOqrsZ+Hn7xYEVfjuZvGwi1+KJv4l8hKRfTPrULG3rlLTKPVniLtG7fTVI3TJJt1QZD
         r5rwmFXgAZj/ddZVkOiIM3je2+FCXkVHntXTgoVC9bpoa/ZVT0d/XC0E7SS9x6oqjta8
         9Hop96k0rTck+l0zVmiZIErwOMGjukxvRlyxVVQXR0B6xoK9VsYv5eN/BpQ3HKQ0LdVX
         i9lg==
X-Gm-Message-State: AGRZ1gJjrASuvvHBaUogQv8C2KA7WVCOkMvuIMiW2ofkDrK8qCYPMoHj
        BIl1jazGUNK9sb8AYPXQIqk=
X-Google-Smtp-Source: AJdET5ep6odf/RQwa4icuI287FNfsjqm9XDupivHuczZckNisI/pq3QMfG7Q5HFzBCJ1AZOrtJrT3Q==
X-Received: by 2002:a63:4187:: with SMTP id o129mr3102566pga.370.1541954044537;
        Sun, 11 Nov 2018 08:34:04 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x3sm1955380pgt.45.2018.11.11.08.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 08:34:03 -0800 (PST)
Date:   Sun, 11 Nov 2018 08:34:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rpi-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: rpi: Fix initial notify
Message-ID: <20181111163402.GA17038@roeck-us.net>
References: <1541937671-26385-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1541937671-26385-1-git-send-email-stefan.wahren@i2se.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 01:01:11PM +0100, Stefan Wahren wrote:
> In case an under-voltage happens before probing the driver wont
> write the critical warning into the kernel log. So don't init
> of last_throttled during probe and fix this issue.
> 
> Fixes: 74d1e007915f ("hwmon: Add support for RPi voltage sensor")
> Reported-by: "Noralf Trønnes" <noralf@tronnes.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/raspberrypi-hwmon.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hwmon/raspberrypi-hwmon.c b/drivers/hwmon/raspberrypi-hwmon.c
> index be5ba46..0d04572 100644
> --- a/drivers/hwmon/raspberrypi-hwmon.c
> +++ b/drivers/hwmon/raspberrypi-hwmon.c
> @@ -115,7 +115,6 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct rpi_hwmon_data *data;
> -	int ret;
>  
>  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -124,11 +123,6 @@ static int rpi_hwmon_probe(struct platform_device *pdev)
>  	/* Parent driver assure that firmware is correct */
>  	data->fw = dev_get_drvdata(dev->parent);
>  
> -	/* Init throttled */
> -	ret = rpi_firmware_property(data->fw, RPI_FIRMWARE_GET_THROTTLED,
> -				    &data->last_throttled,
> -				    sizeof(data->last_throttled));
> -
>  	data->hwmon_dev = devm_hwmon_device_register_with_info(dev, "rpi_volt",
>  							       data,
>  							       &rpi_chip_info,
> -- 
> 2.7.4
> 
