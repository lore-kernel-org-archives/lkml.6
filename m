Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0563FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5964206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 06:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWArHWkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5964206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeJLNfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 09:35:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44277 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727506AbeJLNft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 09:35:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so12054108wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TuP51B5P63UZYqWC7D8rRKHOCS5efHqx7UlAWy/58/Y=;
        b=VWArHWkB59PtDuAj3Dhzep9UtBV/96qS03BCa1Kqm6ILnz9DyNgGeAt0sW3XuNKeP+
         FwIHNJ8uMfd17PH74bS9lNNz25wza9I0fzNXndqAXd8wfi0lHufiPnlaW3Btxe6oDec7
         NjIoB6a+jVtjM03alXFbbDZIKkJyrG/ccpu6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TuP51B5P63UZYqWC7D8rRKHOCS5efHqx7UlAWy/58/Y=;
        b=YoorBS6xk9648tdWkgM/QUBRJQ/3WYCAd5hkjvCCQbPOrDoP8fyMBhAwAWW8QflueX
         6eNpXF9YOZ5NpSG+XtsojdYXpxR+LTkmMACJIMvyUiYdf0PxG7R+XybpXsUzOCesy+Ul
         3181LFSmfRPSWq+QNBHqJPkeI6E159N0EUQX9w9TzXD1LTM5aLSxRIJW1wGBRC0OaKQf
         VT9n79zGnMK595TlvVts1S5X0YnVKkKRDqrGZua3ePoicbYYwrT14RaCDuLCpliPTU21
         biTVbS3DwWbe/+0yy7ZS8XD48f43sdJVP4gvLWsOJiJyjqtX9gjDZ2XhTudYboQ4qqPA
         g0Fw==
X-Gm-Message-State: ABuFfoiaf8CWHkqC6XhFYOlFw/XXNLVg9I66KYZ4wJvMfmE9VTLH1lnU
        //HXlGhQZDgig8Wl4ekdOu8n4A==
X-Google-Smtp-Source: ACcGV60Yf0BKwJbDus3/nni18ZRmFyGC3zNaUU2Mjc94Z4FzzqokgzDtgBqBG/oHkv4YDFB/tsQ7aQ==
X-Received: by 2002:adf:8425:: with SMTP id 34-v6mr3633380wrf.153.1539324298279;
        Thu, 11 Oct 2018 23:04:58 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id w192-v6sm393442wmf.33.2018.10.11.23.04.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 23:04:57 -0700 (PDT)
Date:   Fri, 12 Oct 2018 07:04:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vladimir Zapolskiy <vz@mleia.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH 5/7] mfd: ds90ux9xx: add I2C bridge/alias and link
 connection driver
Message-ID: <20181012060455.GV4939@dell>
References: <20181008211205.2900-1-vz@mleia.com>
 <20181008211205.2900-6-vz@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181008211205.2900-6-vz@mleia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:

> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> 
> The change adds TI DS90Ux9xx I2C bridge/alias subdevice driver and
> FPD Link connection handling mechanism.
> 
> Access to I2C devices connected to a remote de-/serializer is done in
> a transparent way, on established link detection event such devices
> are registered on an I2C bus, which serves a local de-/serializer IC.
> 
> The development of the driver was a collaborative work, the
> contribution done by Balasubramani Vivekanandan includes:
> * original simplistic implementation of the driver,
> * support of implicitly specified devices in device tree,
> * support of multiple FPD links for TI DS90Ux9xx,
> * other kind of valuable review comments, clean-ups and fixes.
> 
> Also Steve Longerbeam made the following changes:
> * clear address maps after linked device removal,
> * disable pass-through in disconnection,
> * qualify locked status with non-zero remote address.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
>  drivers/mfd/Kconfig                |   8 +
>  drivers/mfd/Makefile               |   1 +
>  drivers/mfd/ds90ux9xx-i2c-bridge.c | 764 +++++++++++++++++++++++++++++
>  3 files changed, 773 insertions(+)
>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c

Shouldn't this live in drivers/i2c?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
