Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465E5C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19AD21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdPazbIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19AD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeJIRqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:46:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54483 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeJIRqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:46:09 -0400
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so1303434wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UJMOOhFN0S4YWVDPOVXRjr+oJBPFmp0TcT0CMDKFP5c=;
        b=LdPazbIjIzf9+s4LzxsblcMrDZKrbMYPWVndzoddT50kQS/S8wyTwNLq6MPhJBYUeL
         KzGGYjFzjMN8G+EDDmoUq2u+np/ZJCACC0tdukDxP6fyKqpgVKrjkW+LEFrph9JMfO7l
         zcnV9iOoXlKJd1qnOUPg/7dq0O2cmskjaHzWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UJMOOhFN0S4YWVDPOVXRjr+oJBPFmp0TcT0CMDKFP5c=;
        b=X/002QuI2+X/gcKFcb65FNNd1aBHnC+fwbx4QAwntfVWz2GuymqU1EdojoTj3U72g3
         w9Qnzt8TWgKSK9IK3qN41SlZL7nOGo4OOTfTgkSZjPBZirawvxlGc5EU4Nr8G7yaurjs
         Pe/z+Mvfv7d0m7V3UwshXmNGdMURSrskJ927k3auOYb2U+bCSW+sTqfcnaNoziYPR+Og
         5X5AN6FrJWtmesH6sD+RjP7w64ktTD0GjllrSIeeOm9IyPMk/8IOa2GdgkVwH+wHU+TY
         BYeZUJvLkXkkmksD3x0Q6A4SCSv5nd7BS7GiCu58uL42blLcEeYZcargNZVDaLoDs1vj
         u5Vg==
X-Gm-Message-State: ABuFfohKNlQAzwMkg2HHcFgjKZ7my25aeScVFT7XBjnCccmBTX78TAjD
        G2Lk090E4dJJ+XijhQjvgnWjfQ==
X-Google-Smtp-Source: ACcGV634G4dARrJ15mWonW0v/rLNB8ziqqnR3md9UjjN1SmLoxkOqm6gF1W7mf19Oo7SAXICikZ3IA==
X-Received: by 2002:a1c:1d6:: with SMTP id 205-v6mr1502028wmb.0.1539080992465;
        Tue, 09 Oct 2018 03:29:52 -0700 (PDT)
Received: from dell ([2.27.167.111])
        by smtp.gmail.com with ESMTPSA id 126-v6sm15832485wme.48.2018.10.09.03.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 03:29:51 -0700 (PDT)
Date:   Tue, 9 Oct 2018 11:29:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/5] mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as
 wakeup capable
Message-ID: <20181009102949.GM4939@dell>
References: <20180630103318.25355-1-vigneshr@ti.com>
 <20180630103318.25355-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180630103318.25355-2-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2018, Vignesh R wrote:

> Currently tscadc MFD is marked as wakeup capable which incorrect
> because, its actually touch event by child TSC device that wakes up the
> system. Therefore, remove device_init_wakeup() call that marks TSCADC
> device as wakeup capable in favor of moving to mark TSC input device as
> wakeup capable later.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
