Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C0C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4443D20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEhPL8Y6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4443D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeJCFi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:38:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38738 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeJCFi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:38:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so680853pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BgGoSewqAJN4BshfnDnYW4wSgxyI/SxXZoR6BLwqbvk=;
        b=CEhPL8Y6pMiKfyFh8Cb4l1OJKpE/HBRiIzKZxhABd78gSFWwwBSA79Qu7oub88DD9V
         FN/d72rZPu0TvK8eVbI5q0Kzz9fKFiMnlGvTjuZV+k/lpOHoSspfpBVVHtHs/Yb8FU3Q
         40JZHulhcuCamQDcEns5jSZ6T0WjUyc4bbHoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BgGoSewqAJN4BshfnDnYW4wSgxyI/SxXZoR6BLwqbvk=;
        b=G24yLgrvRhm6VzJSEyhF6CEROIdQbTvQQJ+W6sx6ArM54W8NY/Z2kR68LCX0pKRK4R
         x/uVFAJ6mzpoGKOp/BY79kW8TOc8aZAHFNkm6GWsd1DRpqU8G+KvPkjjX212GE+DUIeu
         QGGLSDJs9M993u/orw6juvZenEFrDTDPfNAfCu6wV7yXU8CZLCkP0ZnY2IwNqub5jowh
         7NY1JAjwpSk/0Xu/3laHniE/bp4WBSS+1myih0sKzJSvO8MBv6KAFlT94ljm2CnWG85i
         wVObRuHev2+H8YiztI4Fdd8vUV5jAxEVkvgfbWO+ACfi8qd9n/VxtYh+IEYPcQNRwcNv
         BnLA==
X-Gm-Message-State: ABuFfoiVlzL0/lLDMFbTgxysaOWj7q7CbzialvzXt2bFfNbuOHFPiaZl
        wee9SVKGDfbrrKUNNVShO6I9G3WldreSWw==
X-Google-Smtp-Source: ACcGV63Z87fmlm8+rTpEsj8BZzKySenZ3doagFiTzHVPO7d6REroMCPJnKmV2WXDoYPrwY7GrGkVng==
X-Received: by 2002:a62:1407:: with SMTP id 7-v6mr15099544pfu.28.1538520794987;
        Tue, 02 Oct 2018 15:53:14 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d7-v6sm29482058pfm.23.2018.10.02.15.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 15:53:14 -0700 (PDT)
Date:   Tue, 2 Oct 2018 15:53:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: fix 'const' pointer handling
Message-ID: <20181002225312.GQ2523@minitux>
References: <20181002211555.2779637-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002211555.2779637-1-arnd@arndb.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02 Oct 14:15 PDT 2018, Arnd Bergmann wrote:

> The 'tiles' array is initialized to a constant pointers to constant
> strings, but the declaration is only half as constant:
> 
> drivers/pinctrl/qcom/pinctrl-qcs404.c:1660:11: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> drivers/pinctrl/qcom/pinctrl-sdm660.c:1417:11: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
> 
> Let's make it more constant.
> 
> Fixes: 22eb8301dbc1 ("pinctrl: qcom: Add qcs404 pinctrl driver")
> Fixes: a46d5e98190d ("pinctrl: qcom: Support dispersed tiles")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Not sure why my compiler doesn't complain about this, thanks for the fix
Arnd.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> index 0ad4bc55e2e1..29172fdf5882 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> @@ -119,7 +119,7 @@ struct msm_pinctrl_soc_data {
>  	unsigned ngroups;
>  	unsigned ngpios;
>  	bool pull_no_keeper;
> -	const char **tiles;
> +	const char *const *tiles;
>  	unsigned int ntiles;
>  };
>  
> -- 
> 2.18.0
> 
