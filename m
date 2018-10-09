Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C69EC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E1321479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRaCmxiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E1321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJIRqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:46:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34819 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeJIRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:46:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id w5-v6so1230320wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P67/6sw+7rBuyeiY9Dyk14ucX3NZs32P4YKGcyT67Kc=;
        b=cRaCmxiJ37u6ey+eHRJJa5vRsY/dVDH+DIxRhu3o7Hv/53/Adn1LcQnmQeRsjwcU81
         AEbDE0TiR4UmrfQCdHOyTmu3NenPVcCWqh0JTz8FV8fkr1aEnCeOIXph2dq51Nfq4eLY
         fUayIE2WK+0kWIhtHoqMyr/fmiCZtvTy0EoX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P67/6sw+7rBuyeiY9Dyk14ucX3NZs32P4YKGcyT67Kc=;
        b=fJT/k0JwSqofLVruBJ5UR1XIJJw8maYif2CFfMvO+mVhbpB5t8vcdXmXPNed8WPZhR
         t6VU8LKPv0dMrK3lr9DVro7k4OywbTvpDW8+CereVrgilQQfpJc3N8Eb0Pfx1ZDhZTX7
         aaBMDsmoEn8yx3LTswcCHE+RHuvl/KH3hGwvw3EDTSoHnuzGslP0dxCNWbzoZbKBr+ZD
         rfALSlkwHjpmqE9pHZbsWXC6o18JYzg2ugWJyDGVUM52M6uy8k0YVSAYzqHL97pyxD2r
         WCl/cWOzalB4ym6L9P1PUEXfFBO7Oeorg8Jpp2lGv8xIZtVJ4klGz2O5hoeaXMYuE5zH
         CMLA==
X-Gm-Message-State: ABuFfoiDv6lvQrDSQTc5Wc+YjPiQPMigFuVzlHgRAkbuKppL8gp2Q+Ze
        82rApKxxM3Rsx2f6b2eOpOJ7eg==
X-Google-Smtp-Source: ACcGV62TSETh9Dza/Lj+68a3j17UwxSS5EOezdyirQm4Zxwiq95AUk0hHS1l6oZrzPTn5XjINAUDWg==
X-Received: by 2002:adf:9464:: with SMTP id 91-v6mr19912737wrq.200.1539081001757;
        Tue, 09 Oct 2018 03:30:01 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 74-v6sm13632911wmi.23.2018.10.09.03.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:30:00 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:29:58 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: ti_am335x_tsc: Mark TSC device as wakeup
 source
Message-ID: <20181009102958.GN4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-3-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Instead of TSCADC MFD device, mark TSC as wakeup source and change all
> wakeup related PM calls to operate on TSC device.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/input/touchscreen/ti_am335x_tsc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
