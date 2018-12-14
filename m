Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5C3C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E99F820892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEg5DvF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E99F820892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbeLNMlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:41:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34897 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbeLNMlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:41:31 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so5307258wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=meD+DTstW4U6bSN7eagCMcDynaTH4h+xzkij8CXMx78=;
        b=bEg5DvF16GiUV83EE38gAA2otq4NzZYU69LiBRl+O0iMb40vUIkMG2CNpiShhpUf0S
         /i5n9SxhJnNeQKaBIOafy4nEXc3GZgNvHmnPx9YPlxuojC15dZzm1HoBoIDrc+K3Yqlm
         WXiQSMkS56Hg1pGr+RodZejuskijOT7cmCms8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=meD+DTstW4U6bSN7eagCMcDynaTH4h+xzkij8CXMx78=;
        b=WrKT5Xeyx9nAEBaLrxkdowkQXFpyBK08oGMXRGQvcPZDpAsFGP1L6LzUf1Bh3m1KqE
         9a8wh1azaXgnnDeDYUYrf2QUYvCW3uIR/mFugsZST6ghW3FTJOImzapw6qnw7FVB+1nE
         Tps2igM0VV9VK3mX7rzcT9rtDaREe2YL8SBI9tuItEGRzuFvpRTyN3UzkXWaslNqT6We
         GDgPpepd1XYt0Srw9VboMBkIfQCrWFYNpetKZsRTjEYXK0oMRw+ULaiEyJUeZN5L4Jsw
         nl65gQAxYXSGu4SLzR5sNflvOGQNfs0WWuz31iDVb9H7hTrQcPca0XqWCLUCXYTq4Fts
         X0+g==
X-Gm-Message-State: AA+aEWZ+ftxqbKOr9H/JY06hopOcuNoPA0t8nwwxSkqj7nLXUgc89Pb9
        37rRfvlO8YsvJ1+xwsq42GhYfQ==
X-Google-Smtp-Source: AFSGD/UTdLqEpFOCC7yozyc84jkf2pBDB//Cbed4+yLl9J2O+7kS6AV9YMX/WtJVMdIMuEUyVhOpfA==
X-Received: by 2002:a5d:660e:: with SMTP id n14mr2470484wru.19.1544791289987;
        Fri, 14 Dec 2018 04:41:29 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id k3sm3749163wrm.7.2018.12.14.04.41.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:41:29 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:41:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.reichel@collabora.com,
        t-kristo@ti.com, ladis@linux-mips.org
Subject: Re: [PATCH v3] mfd: tps65218: Use devm_regmap_add_irq_chip and clean
 up  error path in probe
Message-ID: <20181214124127.GY4497@dell>
References: <1544363971-28061-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544363971-28061-1-git-send-email-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Dec 2018, Keerthy wrote:

> Use devm_regmap_add_irq_chip and clean up error path in probe
> and also the remove function.
> 
> Reported-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
> 
> Changes in v2:
> 
>   * Cleaned up remove function as well.
> 
> Changes in v3:
> 
>   * Deleted the remove function which was just returning 0
> 
>  drivers/mfd/tps65218.c | 24 +++---------------------
>  1 file changed, 3 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
