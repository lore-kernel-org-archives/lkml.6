Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3328C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9761120834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c+fOoFWA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9761120834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeLCLfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:35:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43997 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbeLCLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:35:45 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so11748263wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 03:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Vf5f8bmHhuzcGQtxrTxvksMf2bOwXAFvVm+pmP3j8Wg=;
        b=c+fOoFWAQh7KLSl2r30SjrGqnVasrllWhVetRPjTaB/NWcC8iSeTiUTiZr7I9zKQrf
         spgipLPHfSlJoVJMCm8M4WKHYyZ6vONGgf98FdlKtkvnZWkU0jHFgtltrc2xSkbIP6Dl
         EKb/gnd47Zy3jXXDZBclxe9WKVM2J32RVbQB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Vf5f8bmHhuzcGQtxrTxvksMf2bOwXAFvVm+pmP3j8Wg=;
        b=qUMQeWBG+bdJiv+mKhTZjYXmPzra2VT54qU73HF6Tn9eS4GDZLPYL4MOX8iirYQfXv
         VVru7B6xoIjJGTmmnrwkTFStUfSna3b1vQ+RqWdNMf/VTR64BExpok/Fuy314VRWyDCA
         i0bz5jJY/QmYtEDcENiNlUl+pE6L+ngxKXezpwre16nBdX1p3hM3sXBNt2obUHbDNGuC
         1Xp4MExHSHbJf44koijX7WspK4OeZfDmBuMrpBdDPUuZlBXcPeoJPBD45yzxnX3iGF+A
         LBiO29Qf2IAqZneDOAtwv+PC9dJOCq1XJ84/dO0r7Hpyz70AWL2Le+gxLUUVjGxgEnn+
         1lzA==
X-Gm-Message-State: AA+aEWY7HthxRSqi+vF94m3tL+tZNi2IJIbDIY1tCAME2Ip8Wgn4WQb+
        KouiC2zzvBdcXeYjclIOwUOM5Q==
X-Google-Smtp-Source: AFSGD/VUY+aMWCG1ShmeEoibTQvyliSXGXB+MA5pz8/S62R7nbkFML5RC0SWy8Ebo8dMKBUg6KBIUQ==
X-Received: by 2002:adf:f149:: with SMTP id y9mr14828780wro.284.1543836903439;
        Mon, 03 Dec 2018 03:35:03 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id h62sm5469915wmf.11.2018.12.03.03.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 03:35:02 -0800 (PST)
Date:   Mon, 3 Dec 2018 11:35:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: ti_am335x_tscadc: Use PLATFORM_DEVID_AUTO
 while registering mfd cells
Message-ID: <20181203113501.GN26661@dell>
References: <20181203080118.17504-1-vigneshr@ti.com>
 <20181203080118.17504-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181203080118.17504-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018, Vignesh R wrote:

> Use PLATFORM_DEVID_AUTO to number mfd cells while registering, so that
> different instances are uniquely identified. This is required in order
> to support registering of multiple instances of same ti_am335x_tscadc IP.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> v2: use PLATFORM_DEVID_AUTO as suggested by Lee Jones
> 
>  drivers/mfd/ti_am335x_tscadc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
