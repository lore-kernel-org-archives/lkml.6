Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39174C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027C92243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 08:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cysATcFH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027C92243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbeKMSBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 13:01:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbeKMSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 13:01:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so10405156wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 00:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kzl1PNYFQIjixw07Qbwxj8uquog8T2ughKPzh63xrfI=;
        b=cysATcFHku7JpVpF5YqJ+IqI0r7x41pDfjNo3RANkb0lsS3onHw9KzE/unzQuk+hXN
         MshIAC4EENlkDSozSwoIjlF4eilV4WYxd6aB1P0Dal3R/FbBzLqO45TVIXMRzfsOPX8w
         4H2dC9wA9mGl07yjTF/EYppE4LNIZM9PiW2Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kzl1PNYFQIjixw07Qbwxj8uquog8T2ughKPzh63xrfI=;
        b=fAaNlKXDQC2ra04YwCu9d2mv3wIq8dMd7FYwOccffa6o75cVgAAtj3jgsbRzq400EG
         NYeqtqhqCXAP9XBKCVkGT8MH7U7R/QYsr+jU5PXL/IVR0ScYm7wBJNWnLFnnbJtCkYXw
         fx351F08z88Lcb8JSh9WrHYPYNy6T3RQXWGMwpn3mMch3iIkc7GOYxWuuh0O14jCXPUF
         eXxkm5nZnm5GzML6ukjhVKWVe2PVXoARchRRru3Sz5xciqWFWxcHyWTeFmnCehz2rUHq
         58XdoY0iE2RMfow0G1suLfC3/TVUMYiXxqWtaPYzH1xkqCwDQ3RkgWFikVCkmeuBmscP
         3URA==
X-Gm-Message-State: AGRZ1gI6blQLX9AbYdiYT5UrRaaI6lPTq2Rp+B4wHYOhojIADVx+b87R
        VhX5bHBqldlAwfGW70TYwRUoTQ==
X-Google-Smtp-Source: AJdET5cNGi+4kcsP9VDstD0RMw+w2ZtCHcZsENMQTZW5Gww2rrk5duUFkkINu3Pz9KObKpWSUsKjgQ==
X-Received: by 2002:a1c:6a01:: with SMTP id f1-v6mr2202489wmc.85.1542096247057;
        Tue, 13 Nov 2018 00:04:07 -0800 (PST)
Received: from dell ([2.31.167.205])
        by smtp.gmail.com with ESMTPSA id t82-v6sm13602483wme.30.2018.11.13.00.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 00:04:06 -0800 (PST)
Date:   Tue, 13 Nov 2018 08:04:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: Re: [PATCH] mfd: at91-usart: Add platform dependency
Message-ID: <20181113080404.GH29388@dell>
References: <20181112104942.765456f7@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181112104942.765456f7@endymion>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2018, Jean Delvare wrote:

> It doesn't make sense to present option MFD_AT91_USART by default if
> not building an AT91 kernel, as the drivers which depend on it are
> not available.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: 7d3aa342cef7 ("mfd: at91-usart: Add MFD driver for USART")
> Cc: Radu Pirea <radu.pirea@microchip.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
> As a side note, maybe it would make sense to have SPI_AT91_USART
> select MFD_AT91_USART instead of depend on it, so that
> MFD_AT91_USART could be hidden?
> 
>  drivers/mfd/Kconfig |    1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
