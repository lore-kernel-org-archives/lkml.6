Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463CEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96162073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HzYmmhqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D96162073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbeIFEKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:10:30 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41064 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbeIFEK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:10:29 -0400
Received: by mail-vk0-f68.google.com with SMTP id j14-v6so3370730vke.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 16:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o9r/p6hfkSx+S1Dtvatv8LNTyNf3Rj1AxnsmDSWsH6E=;
        b=HzYmmhqB8Ks6+XXp0unH+wXsM0G1Kvo2EfyVW+iZY3Eq8ppCZC17WazdJf4nSZZnUO
         ZrFuLL5ZlUSjQK6ZVtHkeo/4DoobbCNamp3bsFv/nXLzNEWzEMMlOKFwEWdoeCNK1YKf
         us27EyKkSu2pwoptQ06uneZGldLYqVMKpriU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o9r/p6hfkSx+S1Dtvatv8LNTyNf3Rj1AxnsmDSWsH6E=;
        b=N3OtBLtfnd2/RaHBTHsdlejPVXUVcEzsxIX11VOxXpETEb7UhcDq/o1wcyK7iGQUHF
         DpC8Tzqb0T7hsoOQCi0WM7kiG37lSDrqmdQAfL1/EFYm7kA5k833ba81WQkDH/5653Zg
         G1j08AqBo2ZJCi33982RHoTui+Bj5tvf58RyjT4xxJWveAmW+6LCNiNza0XdNdnju60v
         4pGTZ34+ZD5yp8uthaM7r86GJk8Q4wNxjxNzBXuVxE+6H6IYc2wyjm7aX/SB/eIo7VmC
         GhhqNuIVZ1TopmNMlLnghBBZf/ByjwZINHGXGNk10eWoI1znV5u+OXikYzap/bChFGng
         xi5Q==
X-Gm-Message-State: APzg51BY0QO/AyoPCGGCOAboZp5fcoGKBjRDrq+C/vfjfHXPkrTQDwfv
        3kYgaWLQWteVX3IsZlVEkf62Uw==
X-Google-Smtp-Source: ANB0VdatWIUQrnLT2hZNJAZrc7PmNofHy7Ff3Rl+c2BVZxeKFbfssmpmDa3n+1PMj8FcC+njiUAL9g==
X-Received: by 2002:a1f:11c4:: with SMTP id 187-v6mr26812vkr.150.1536190679075;
        Wed, 05 Sep 2018 16:37:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id v14-v6sm1009041uav.2.2018.09.05.16.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 16:37:58 -0700 (PDT)
Date:   Wed, 5 Sep 2018 16:37:57 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        girishm@codeaurora.org, dkota@codeaurora.org, evgreen@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] soc: qcom: geni: Don't ignore clk_round_rate()
 errors in geni_se_clk_tbl_get()
Message-ID: <20180905233757.GB22824@google.com>
References: <20180830183612.169572-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830183612.169572-1-dianders@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:36:11AM -0700, Douglas Anderson wrote:
> The function clk_round_rate() is defined to return a "long", not an
> "unsigned long".  That's because it might return a negative error
> code.  Change the call in geni_se_clk_tbl_get() to check for errors.
> 
> NOTE: overall the idea that we should iterate over clk_round_rate() to
> try to reconstruct a table already present in the clock driver is
> questionable.  Specifically:
> - This method relies on "clk_round_rate()" rounding up.
> - This method only works if the table is sorted and has no duplicates.
> ...this patch doesn't try to fix those problems, it just makes the
> error handling more correct.
> 
> Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/soc/qcom/qcom-geni-se.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index feed3db21c10..1b19b8428c4a 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -513,7 +513,7 @@ EXPORT_SYMBOL(geni_se_resources_on);
>   */
>  int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
>  {
> -	unsigned long freq = 0;
> +	long freq = 0;

nit: Since you are already touching this you could also remove the
pointless initialization, 'freq' is always assigned before it is used.

>  	int i;
>  
>  	if (se->clk_perf_tbl) {
> @@ -529,7 +529,7 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
>  
>  	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
>  		freq = clk_round_rate(se->clk, freq + 1);
> -		if (!freq || freq == se->clk_perf_tbl[i - 1])
> +		if (freq <= 0 || freq == se->clk_perf_tbl[i - 1])
>  			break;
>  		se->clk_perf_tbl[i] = freq;
>  	}

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
