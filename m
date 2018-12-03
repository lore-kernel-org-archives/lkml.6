Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382DCC65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0067020848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 07:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kIl6z/N2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0067020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeLCHB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 02:01:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38007 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbeLCHB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 02:01:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so4442188wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 23:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dxq6pfqZv+ZSAFbHOJCu2yH1qd4VEYhBxzMkifDOfhQ=;
        b=kIl6z/N27ooJ4YAA1LJQFWlQiGcBRNK0Tjcd/ZkaAQclthulb8+Fo5/FomWC8lKbU+
         iLX0Fu6Lnz67qKJLnHb6eVwWUQPV/2x1egfqlAJGXM/tb5y0b17Yk6rW1cWvbFq5sv93
         Qh3yVo0lxWkV9hBtIor+xzPeQU8F2aEd7sQbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dxq6pfqZv+ZSAFbHOJCu2yH1qd4VEYhBxzMkifDOfhQ=;
        b=co5AP2cLCqx5o+qem8Ad+xj1XGHSg+ll+vdV7d7KSx0IYkdL00ezbl6cTUG6m5N3v/
         EA4Te1Z5jZT1TAy5sh2C6oGbkWpUqmtXJMg1FhK8bjPJzqO8REDzCFKp68DTO165IJmz
         qYelWvO743tXUC/ptMeS3ek//Dq6n/EnJ9ThSI7/JmuOOydFJ6pYPRCklaC9IMYEndzF
         o2H8TWQpSmXYCOWU4hzBizXgS7J14lnonL43e437+Gu0fF5iccmZQPU+O8D4fQB3tYHO
         JXQu9VydecYdT94RpwBJl0Jixs2meZz3e9GSPgt/VHSA7sNKX4xyLKj4sMuzjbU68QMp
         WPbg==
X-Gm-Message-State: AA+aEWZhQ86anDdoeg1VvHmSeQN6U1QWhoJOh25TuHEXuvFbN0fdHbFW
        oGfi++AvjAZETAQV9uGoZ1ePeA==
X-Google-Smtp-Source: AFSGD/X/csQb8umdrmegoU5h/RRHHfrAVvW3jJU7QNayYHclBnIKH+IDHlKBETB0Hs9Kjpwl2tUTJA==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr6880964wmf.59.1543820480686;
        Sun, 02 Dec 2018 23:01:20 -0800 (PST)
Received: from dell ([2.31.167.218])
        by smtp.gmail.com with ESMTPSA id 80sm6276422wmv.6.2018.12.02.23.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 23:01:19 -0800 (PST)
Date:   Mon, 3 Dec 2018 07:01:17 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Vignesh R <vigneshr@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_tscadc: Improve accuracy of
 measurement
Message-ID: <20181203070117.GI6009@dell>
References: <20181119064236.28902-1-vigneshr@ti.com>
 <20181119064236.28902-3-vigneshr@ti.com>
 <20181128091432.GT4272@dell>
 <20181201150400.09706f47@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181201150400.09706f47@archlinux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 01 Dec 2018, Jonathan Cameron wrote:

> On Wed, 28 Nov 2018 09:14:32 +0000
> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > On Mon, 19 Nov 2018, Vignesh R wrote:
> > 
> > > When performing single ended measurements with TSCADC, its recommended
> > > to set negative input (SEL_INM_SWC_3_0) of ADC step to ADC's VREFN in the
> > > corresponding STEP_CONFIGx register.
> > > Also, the positive(SEL_RFP_SWC_2_0) and negative(SEL_RFM_SWC_1_0)
> > > reference voltage for ADC step needs to be set to VREFP and VREFN
> > > respectively in STEP_CONFIGx register.
> > > Without these changes, there may be variation of as much as ~2% in the
> > > ADC's digital output which is bad for precise measurement.
> > > 
> > > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > > ---
> > >  drivers/iio/adc/ti_am335x_adc.c      | 5 ++++-  
> > 
> > >  include/linux/mfd/ti_am335x_tscadc.h | 4 ++++  
> > 
> > Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> I'll leave this for v2 given changes in the first patch.
> 
> My assumption is at the moment that both will go through mfd.
> Shout Lee if you have other plans.

I'm fine with that.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
