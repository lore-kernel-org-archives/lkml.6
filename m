Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B7EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA9A20874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 07:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMRSUImm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA9A20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932939AbeFRHU0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 03:20:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51557 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932510AbeFRHUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 03:20:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so12242672wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 00:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=5yK/k/mK1K43wauvyEB2e3ytn8Vhhshd9oDdmq79dNY=;
        b=HMRSUImmCle0yFZrgS4yACA300+YASs7FxSePlDZJqclrUPC60PonmO95sdnGietQh
         R9XUZUyUptJZNJb3OzLii0Qbp22l3P7cBMJPezdjZ1BjP82VMMzD2fjYeXPnYoShSJL5
         Y2vzbQ5uDtopVu/1pqkMTeo/ajruPsTU4QqJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5yK/k/mK1K43wauvyEB2e3ytn8Vhhshd9oDdmq79dNY=;
        b=owSVGM4QX0dcNEjsbWW8BzcrKmQGcv+l46ZjcZoRtgF/oZybpISeT6Q6qS4IUoHId5
         y/yKDbxMIpRNpOribhO916lk3MGwKTJpJn76xjgLfMe+wyZdUcgHqf7g+PJZZzQ5a9Vr
         0cJ3Qyx0kvLe1EEck57r+L89FOjEP1qsT9bK67OI7pH0Esn4I/U9hsjTEco7s5nOp5k1
         lXZ0KKEc3RSLjxGHxvSLae69I5izl+CL8eYnGypmyr8r7LZ7Aa1ucJ0h06DwN+lNyG5r
         6hL5fC5RVuhDZQP6RttW3VUQguug3jkifN43EjkZoeYqRZB88jkwGZ+jsODDRW3rQ3Lu
         REQg==
X-Gm-Message-State: APt69E1gbu1b9TFXeO4FnrufvktqcHw0lr4/gzO6uvCTL+rZdh83ljcf
        +C8p7Rz17+INeEewABWmkKsCVw==
X-Google-Smtp-Source: ADUXVKJbUP8lrcop4qOeYBnp8h9UyIz3bT5kWzz7Efei6d0z2qtiko19oiZjLL24IdVxrl4dDW49TQ==
X-Received: by 2002:a1c:454f:: with SMTP id s76-v6mr7377317wma.16.1529306424091;
        Mon, 18 Jun 2018 00:20:24 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id b16-v6sm16328913wrm.15.2018.06.18.00.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 00:20:23 -0700 (PDT)
Date:   Mon, 18 Jun 2018 08:20:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 03/12] mfd: cros_ec: Make license text and module
 license match.
Message-ID: <20180618072021.GJ31141@dell>
References: <20180606150900.8342-1-enric.balletbo@collabora.com>
 <20180606150900.8342-4-enric.balletbo@collabora.com>
 <20180618071801.GI31141@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180618071801.GI31141@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018, Lee Jones wrote:

> On Wed, 06 Jun 2018, Enric Balletbo i Serra wrote:
> 
> > The license text is specifying "GPLv2" but the MODULE_LICENSE is set to
> > GPL which means GNU Public License v2 or later. When MODULE_LICENSE and
> > boiler plate does not match, go for boiler plate license.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > ---
> > 
> > Changes in v3: None
> > Changes in v2: None
> > 
> >  drivers/mfd/cros_ec.c     | 2 +-
> >  drivers/mfd/cros_ec_i2c.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Applied, thanks.

I've just seen Joe's comment.

Unapplied, for now.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
