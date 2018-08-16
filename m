Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A57DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1398214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Datm5tD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1398214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390268AbeHPMDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:03:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51108 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbeHPMDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:03:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so3740718wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Mvl8Nb6kkrtBmN+NTyQBfX31oE5Zrxvznr1HKNpmGZ8=;
        b=Datm5tD+SbxJZK9Y3DpDuizpbMmDxfb788jFNliWGX5DlW/U+gw3N/VgmaUvYoJrYv
         VK7QcTsQ852dkN5T6El1mEvJ39vGxapknqxKAC59cR2dv8i3c5NpaleKRCAFDLfzrLBx
         lKplsgxT7oJLdPpUCYSCZXb4L55OEc3rJZEZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Mvl8Nb6kkrtBmN+NTyQBfX31oE5Zrxvznr1HKNpmGZ8=;
        b=WjA7DXQmbLQj+5c8zKy8ShubGufjvJZGWREvXkZQ8sG8N9ghfkRMtYmkysSNQvfL9J
         F+pegtWpRSXXp+QeGiakTwJoSDpoAAKbmr+n2r/VZWbyQlRuBQiuhYviJiRmHhtUVf/L
         J+E4+4rIrnx4kwzgFqLS7SjJ/e3/YIqclItbOZF26b+PH8b3OfWZcBcaZLwNgBNAnhw1
         yn3NKt1f2SK7MA1GCKgPYfYzVNyAL7FyTeApzsb5vhydxmR+Pw1Z9nwpZKqY3SPWdLGc
         UJnRi1QYYnu0sJOlO8pg4Xsz6ZmJfKkihk6+spFuupCFpkX3tcRb2lRbDkUNqWaAX8Sx
         ii7w==
X-Gm-Message-State: AOUpUlHuXdAnP512k8c+oUhoJOVHkLO7tJC8tJscCYiRFB0cfKI/KtKz
        VA6tCJ4twM2xNme16b2Coec5Pg==
X-Google-Smtp-Source: AA+uWPxk9BGB42tPpZmK3i5WdJnRha5RRKU13JGF8RgKHOXS3HMK/5hVpOdBJEKlepxReqcrEMS/Ag==
X-Received: by 2002:a1c:4489:: with SMTP id r131-v6mr14808963wma.128.1534410373439;
        Thu, 16 Aug 2018 02:06:13 -0700 (PDT)
Received: from dell ([2.31.163.71])
        by smtp.gmail.com with ESMTPSA id d33-v6sm1261444wma.16.2018.08.16.02.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:06:12 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:06:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, eballetbo@gmail.com,
        linus.walleij@linaro.org, mazziesaccount@gmail.com,
        dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, broonie@kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v12 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Message-ID: <20180816090610.GC10054@dell>
References: <cover.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
 <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4f49022ed8e4fa357bf5d213c57ad57752e72aa4.1533292711.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Aug 2018, Matti Vaittinen wrote:

> ROHM BD71837 PMIC MFD driver providing interrupts and support
> for three subsystems:
> - clk
> - Regulators
> - input/power-key
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  drivers/mfd/Kconfig              |  13 ++
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/rohm-bd718x7.c       | 211 +++++++++++++++++++++++++
>  include/linux/mfd/rohm-bd718x7.h | 332 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 557 insertions(+)
>  create mode 100644 drivers/mfd/rohm-bd718x7.c
>  create mode 100644 include/linux/mfd/rohm-bd718x7.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
