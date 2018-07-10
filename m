Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 288F12089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhrI07Cm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288F12089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933302AbeGJJAJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:00:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50430 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeGJJAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:00:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id v25-v6so23841425wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 02:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WIYyJRfyP+2i54rBHI2OnQKGYax6WOy8p0Q7tsazNak=;
        b=QhrI07CmRUMXNInj78WoSAvmO9BVhxSH117SHWPIqBtWLNO8jgOwU1hAVmodnwXyqN
         GH9JwMMj/zlZfuOLOn23W09IQDBZYCEsnkVUK9qqlnKY9rm+qSQBMPe9phWZLRiWtSS7
         U4Tv93kG6+iZOmzjm1Idg+LKxlQDcWwdgcPVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WIYyJRfyP+2i54rBHI2OnQKGYax6WOy8p0Q7tsazNak=;
        b=NZNEQxosYrFoc2U0zG6DNe090Ol5mTKSUdBn41Xqatfaw8KY+Weu7ckM6gGe6SGukl
         TIEK0dPMryJ2xcPj4a5VN2jfE6KG3OsxU9fBwZJD0Hpsb7YDRsaBFpv8cLkIwaMejJo2
         XXDcpHw7/2mXhvto5u7VDpWJsTIobM/vUoaY2aHKmEuUFK8JkyFBUz42kuaWIpD6FncS
         6eggVocRxMzRzHoTdlY9r2G0BTkSAx2cQ7iGMOAc/MeI+dccUHmN0Xl9l8qYoxxx8dwj
         70FBJu8sJOWtcaGMoFzQWdFAmzvZigR6ylcFYvoGfH9TIkZatvrQnRkSa7yun3O6y3B+
         R4sw==
X-Gm-Message-State: APt69E2gsSr3zI10M71Ib8bkJhWaAphbP7VG7R0HESCtTT9xp5/t002g
        JgcPQbI6rsbPnZk+sJbFakdYLg==
X-Google-Smtp-Source: AAOMgpcK1MsysmV/3IUfqsHSPaO6NTf0OG+cNGnLgMzEZdvS241o1mWjvK1etURD2+uAz3qcFAFEWw==
X-Received: by 2002:a1c:8b0d:: with SMTP id n13-v6mr13241695wmd.46.1531213207003;
        Tue, 10 Jul 2018 02:00:07 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q200-v6sm10149620wmg.8.2018.07.10.02.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 02:00:05 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:00:03 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: adp8860: Mark expected switch fall-through
Message-ID: <20180710090003.2flpkbgkakmnefpn@holly.lan>
References: <20180709215156.GA8782@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709215156.GA8782@embeddedor.com>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 04:51:56PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Having checked the datasheets...

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/video/backlight/adp8860_bl.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
> index 16119bd..f1dc41c 100644
> --- a/drivers/video/backlight/adp8860_bl.c
> +++ b/drivers/video/backlight/adp8860_bl.c
> @@ -690,6 +690,7 @@ static int adp8860_probe(struct i2c_client *client,
>  	switch (ADP8860_MANID(reg_val)) {
>  	case ADP8863_MANUFID:
>  		data->gdwn_dis = !!pdata->gdwn_dis;
> +		/* fall through */
>  	case ADP8860_MANUFID:
>  		data->en_ambl_sens = !!pdata->en_ambl_sens;
>  		break;
> -- 
> 2.7.4
> 
