Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC26C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1172081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hn5lQ0Um"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1172081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeK1UPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:15:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40676 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbeK1UPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:15:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so1731392wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vASiJ29iDdzzZSAwTyxtgFXmVhCZkejxpsR6NY1/uSs=;
        b=Hn5lQ0Um5ALaPhmxbPI8ksD54bvqp6FTk2GoW5xlD/aXnwS9qQQxKOlxmFd+yb69nf
         kfuX9vQS5kv63g0j0YbbwhRCaVfkU0cpabilu3TfBBrInkcfzvAzOR66SYRMFEJZecjN
         z9UbbWD2jY1tgGSQhbiqpyXEotFFSugOdMlus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vASiJ29iDdzzZSAwTyxtgFXmVhCZkejxpsR6NY1/uSs=;
        b=FHx9qVBORFzV5zIfnB9VPI6eoskVxGsqaP2b4cKTYO0KK1njc1j90XUXtTTMuCHDek
         7u2KVl2zvXcy77EhqvCSkQuw8CzAeaxwXAqMm7PBaIq0lhSQXiAZYoY5decSvwjAZ9QQ
         dUwFv+jl+5S3nsA0hD5RUK33aBi3S6TsbJchtGKYkkKoPBqIq6LI3pENdoNkWsJE2tw9
         0vQC8uOpOTTtVS9ipC8FLUQoOLv6hZffH0CUVjzVIi7NTg/PFGJ0vtvcEHwZj3B9rfTG
         CTOSu8QNc9fVaxC095Q5GttYAXF/BeMAuVMXCzMub897MmjMoOOZdBrPj7wjXvoisf/D
         QgEw==
X-Gm-Message-State: AA+aEWbYhgtJE0auUd3TOEyZlvev7ft7XKYF1jD6eYGnT/OIykrj9tEd
        aKa9kdPNQ+7jVmN5rDtaLJsu+Q==
X-Google-Smtp-Source: AFSGD/UGI7RWZc1Ynx640s9OrKJNLB4rkk7/o1y7hOQD6JUWRltSMqrbscJzWtz5gAfsfwRVF4tWpw==
X-Received: by 2002:a1c:83c8:: with SMTP id f191mr1938054wmd.134.1543396475259;
        Wed, 28 Nov 2018 01:14:35 -0800 (PST)
Received: from dell ([2.31.167.233])
        by smtp.gmail.com with ESMTPSA id n8sm6445513wrw.59.2018.11.28.01.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 01:14:34 -0800 (PST)
Date:   Wed, 28 Nov 2018 09:14:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of
 measurement
Message-ID: <20181128091432.GT4272@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-3-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181119064236.28902-3-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2018, Vignesh R wrote:

> When performing single ended measurements with TSCADC, its recommended
> to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
> corresponding STEP_CONFIGx register.
> Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
> reference voltage for ADC step needs to be set to VREFP and VREFN
> respectively in STEP_CONFIGx register.
> Without these changes, there may be variation of as much as ~2% in the
> ADC's digital output which is bad for precise measurement.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-

>  include/linux/mfd/ti_am335x_tscadc.h | 4 ++++

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
