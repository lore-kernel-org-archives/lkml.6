Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCFFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 439AB205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 06:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WxEVFG08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439AB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLJGcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 01:32:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33782 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeLJGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 01:32:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id c14so9240447wrr.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 22:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Ko7uvZXx5mhntgG1ppKEDQEUPsSyBBgzsVpPPAkBXB0=;
        b=WxEVFG08TqZd7t5Ujq2Tf1Awvn8mOBH7Bb5dANi4gVw3CTmtEXY4P0/gq1e5eylAHd
         Ek22/uZIt2C99utgYYmiZOG4SxAd0z6tbXKjoRdnfDdYa7Wo4S9xdASW2F889WOzjObb
         xvR41XrzmB6HiDPHdaOM0CNaPyHv5ERJ2pcrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Ko7uvZXx5mhntgG1ppKEDQEUPsSyBBgzsVpPPAkBXB0=;
        b=YTh9pwonk4Q2PjUoWkbt613ypZMWyu0/8D/1KFRp7o6iYCIwnzGMhSEM4Rui/T6MEf
         qBqH+GEtp5QxQMkkXVuDjkwDuI42krgsPK8WQn2KDLd+MnDiADifJhX1tuQSz27ZU197
         EyzWSm03BgPGsile0P9mfGBHKiIP9AghEFKhJyblhizvgkFfZylj/csyqNfjj2FunMng
         KgAjIRfcqkz9oPcSi1Relpnq9hmRU0Ht2VfOsa3PCurPG5Ntp6EYQjQHeGvxjkgEjclx
         L9IfPq6jXipaBVcRCSnmFy5MMjhrvjfh6nRsslXuRtvGV+gkofYWV2nV1CJI1QpAF+2v
         pIdw==
X-Gm-Message-State: AA+aEWZto+tSPAFNKS0DUwXeeWTQyAIpwrrUOaJOO7xsQsRHlRIGr7cp
        qK+SbKIbtvRKhymZmmGTaXOJuY3zsBI=
X-Google-Smtp-Source: AFSGD/Xossa9lYs3LRVlXSVPD9Ymk73yq4cClGSBdhtthGb4eBzb7ut0HRFnfA41gz7EhdQ2uWHIyQ==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr8257607wrv.308.1544423558903;
        Sun, 09 Dec 2018 22:32:38 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id n15sm19868594wrt.21.2018.12.09.22.32.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 22:32:38 -0800 (PST)
Date:   Mon, 10 Dec 2018 06:32:36 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] mfd: axp20x: Add supported cells for AXP803
Message-ID: <20181210063236.GR26661@dell>
References: <20181208175847.32068-1-oskari@lemmela.net>
 <20181208175847.32068-3-oskari@lemmela.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181208175847.32068-3-oskari@lemmela.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Dec 2018, Oskari Lemmela wrote:

> Parts of the AXP803 are compatible with their counterparts on the AXP813.
> These include the GPIO, ADC, AC and battery power supplies.
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> Tested-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/mfd/axp20x.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
