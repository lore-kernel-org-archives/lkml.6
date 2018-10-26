Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75067C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294662082E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BNngtLkO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294662082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbeJZRKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:10:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33206 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeJZRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:10:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so3664782wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 01:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nMEmAU+Ox08PXH8LOVSe/UVAKdTqBciER3TKUx4F/vc=;
        b=BNngtLkOEEk9Vvci6FopNqIsvkIaD3z7kiRMShgOdscqjn65nyOfh8pIDhO2WmNK0n
         o3tfga3E5a4TrdlTLA7svIW2eU+SGerkfHcmrb+FwXk6bLNh3WnUcB9jHVt1xS1Krtcx
         6JfDMRO2TxQTtjvP8VYrLzDbUqrj2S4S3ngus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nMEmAU+Ox08PXH8LOVSe/UVAKdTqBciER3TKUx4F/vc=;
        b=PygaNsjMjL29UruHOSI9lVzEQfRLUAEUTBT1YvVw02iWUvobsIaGbXnzKLiNisHO9x
         iebEXUrv+V7gIM++bqYSP+agNMmh8WHVsFrWgX5P+0sernXevaksXwvx2D3P6uqNKoJN
         rk4ACYnmU++vLfzKyXVVxHSYtepHwFodiejbXrdTBNh1AZ2MepecwIxrJV075oroG0QK
         TwhiEX756XgoGvpL3cQSCQfantr+f9yO0sXSKB59aboXcUZenSwwlA6gJsrDUYyahWcs
         t10Udc8S2hRLi8rTFie6iqGKVy+tqB4nnNKeOYJI9gvX4K2dme8D7GNzzuBlNVL9sP1P
         ZEew==
X-Gm-Message-State: AGRZ1gJFz2KWwUIGK35VLufI49lA72Dje0kXlHnXwLmbS9ejzUwX1vCe
        qTyYadJ/T9ZjVCSizojQRwbGjw==
X-Google-Smtp-Source: AJdET5c1d11MazdmH37Lma5Nn+aTXPvxkwgoA/W4TS8lzmMhBuWk0OE3gAW3IU8tUGJ1QYzSoYWoUg==
X-Received: by 2002:a1c:8dcd:: with SMTP id p196-v6mr4714866wmd.49.1540542853539;
        Fri, 26 Oct 2018 01:34:13 -0700 (PDT)
Received: from dell ([2.31.167.182])
        by smtp.gmail.com with ESMTPSA id u76-v6sm4880449wmd.10.2018.10.26.01.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 01:34:12 -0700 (PDT)
Date:   Fri, 26 Oct 2018 09:34:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sven Van Asbroeck <svendev@arcx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v1 1/4] mfd: support the Arcx anybus bridge.
Message-ID: <20181026083410.GO4870@dell>
References: <20181024142456.10084-1-svendev@arcx.com>
 <20181024142456.10084-2-svendev@arcx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181024142456.10084-2-svendev@arcx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2018, Sven Van Asbroeck wrote:

> Add a driver for the Arcx anybus bridge.
> 
> This chip embeds up to two Anybus-S application connectors
> (slots), and connects to the SoC via the i.MX parallel WEIM bus.
> There is also a CAN power readout, unrelated to the anybus.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  drivers/mfd/Kconfig          |  11 +
>  drivers/mfd/Makefile         |   1 +
>  drivers/mfd/anybus-bridge.c  | 441 +++++++++++++++++++++++++++++++++++
>  include/linux/anybuss-host.h |  28 +++
>  4 files changed, 481 insertions(+)
>  create mode 100644 drivers/mfd/anybus-bridge.c
>  create mode 100644 include/linux/anybuss-host.h

Wow, this driver is going to need a lot of work.

But before we get going, how many sub-devices does this have?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
