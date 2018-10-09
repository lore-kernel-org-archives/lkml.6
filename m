Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9615CC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDA42077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5JIBYAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CDA42077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeJIRqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:46:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53022 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbeJIRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:46:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id 189-v6so1302559wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eLw9o5+mIjXweHJgrIdq9SD57JVbz2OzTwH+9rloUNI=;
        b=P5JIBYAMYV9fscds6eHH1L1Izdn+u6DuWMfXDV1+sw7lCpOCn4NC0kgPh5zNXkR9cB
         IDeuMDEVWSQEBB484qlS8ZesW2IksQvmo1kxw2WgXq+zd+Eu0KxSKbECKnilf/rNtz4s
         htqXDfvN9V80i9dLsPfNL9/RMWu0QWeXcPhu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eLw9o5+mIjXweHJgrIdq9SD57JVbz2OzTwH+9rloUNI=;
        b=UvHa1i5hqDRb2CPuRzEDOjSVfUiY7OZR5Wb9mfAmGBPSfKDDsh9ZXfkaf5JUsuADUQ
         atDo1LaDNdInwl6CtO/A6SERogVYn+mBnDZ3guHBg0ConMsy9g9LoLpMsYlDlA9L2Lew
         bdW/PlLmC3JIk1k9FBJhXWXX9lGH9vEUDqD03EwjFebcN1R9qvwZu4ZeP71Hg7rwMdZg
         aqqjXEtOMBk5O0epF2JbF725sIr81TFSU/EEmxCRfxjx54Sq9qWb8atFuvH9jIL05MIX
         6FGhHvSX//g/HWiT7xFaPPSCpa5i1sX6ZfNrlwJoiqpQvs1pFcdJm0Drk6g4RANTznRO
         TvdQ==
X-Gm-Message-State: ABuFfojRUYvvnJmAZDnX19Ch3Ok3dTrNFaum6JX/FhvE7HfJYYwpcrmN
        rBbDulnR7yU7T/VUNuHniquShur4CpE=
X-Google-Smtp-Source: ACcGV61aljKX2kYFFaY/cwEDOgVpublQhtZdNs0q7+7FXIlH6kVI2/DCuKnJc7/+9v8jsDnF+Bv9IA==
X-Received: by 2002:a7b:c1d9:: with SMTP id a25-v6mr1432712wmj.55.1539081019942;
        Tue, 09 Oct 2018 03:30:19 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 204-v6sm12452857wmh.25.2018.10.09.03.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:30:19 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:30:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: adc: ti_am335x_adc: Disable ADC during suspend
 unconditionally
Message-ID: <20181009103017.GP4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-5-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-5-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Parent MFD device takes care of enabling ADC interface whenever
> touchscreen is marked wakeup capable. Therefore, unconditionally disable
> ADC interface during system suspend to save power in case of system with
> just ADC and no TSC.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
