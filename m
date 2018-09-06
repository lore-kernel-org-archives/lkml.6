Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6048C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435F5206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 00:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oVzo74xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435F5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeIFExi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:53:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42950 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeIFExi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:53:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so4233720pgp.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 17:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SlwVe0qylebZopt4PkofY+zAg/wdReYfOQa1UXrJdes=;
        b=oVzo74xsTJPVqRGgAgNUfHyynOpVyTKfcGjrnQSZ67+aJzmVQZ2CfUE3eAuPSxZje7
         CI5J2Wa3FxRCz2d8DbqDxB8EWAWC0Jvj5mlSSO2PMwTiSkmQgBHPJKzuvJ6ydgg03ilS
         Vmyad5M3GawB36GtFCUAX/5fTFcp8hzy+m9X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SlwVe0qylebZopt4PkofY+zAg/wdReYfOQa1UXrJdes=;
        b=r7SBIZPWWj2bIXW/Dsue3L6cICrnIRAGWNm7wDrPt6+s7nzKid3rjntAoqLLO7mGRv
         QWUKzJ+t6qq3fWR9Wz4NtOyduR1Hc3t5c6YVS4ota/tINtk8YYJFnxBVcKGP7tUeiUQp
         zWI4c3rsenSevOs0BnhE9WM+IDWatabHYfBObmiW5P1ULV29qZsW+wRlQif4UXq08cTp
         kEw3yi8xg7GDK7RQiX9gVyStO1wbxvDI1iNlgkQj11tOUZFCYYGxUdCuATFkDhMkb5dX
         3IMnwNKNMf1HAoXgpsn0A3clim1AsAu2ZJL8R4CJ+vnQfoTrFWqvjR/3Mbuhp4OXJlvE
         NasQ==
X-Gm-Message-State: APzg51Dou07r7mpoMlSEIBj0QumZvOdT0oCpb2ntNYHp1Zb2dVwBBbk/
        ks6+AQpY9aFC3g35nFRPeluMZQ==
X-Google-Smtp-Source: ANB0VdbjN5Zi53WHaIpUumiRHTtKrLzwKwBmGzS8P5zSMabSPHRGWi8+D++cOarB60cqQTyWmSvXFQ==
X-Received: by 2002:aa7:860b:: with SMTP id p11-v6mr182062pfn.247.1536193259720;
        Wed, 05 Sep 2018 17:20:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id x4-v6sm4052603pfm.119.2018.09.05.17.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 17:20:59 -0700 (PDT)
Date:   Wed, 5 Sep 2018 17:20:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        girishm@codeaurora.org, dkota@codeaurora.org, evgreen@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] soc: qcom: geni: geni_se_clk_freq_match() should
 always accept multiples
Message-ID: <20180906002058.GC22824@google.com>
References: <20180830183612.169572-1-dianders@chromium.org>
 <20180830183612.169572-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180830183612.169572-2-dianders@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 11:36:12AM -0700, Douglas Anderson wrote:
> The geni_se_clk_freq_match() has some strange semantics.  Specifically
> it is defined with two modes:
> 1. It can find a clock that's an exact multiple of the requested rate
> 2. If can find a non-exact match but it can't handle multiples then

nit: s/If/It/

> 
> ...but callers should always be able to handle a clock that is a
> multiple of the requested clock so mode #2 doesn't really make sense.
> Let's change the semantics so that the non-exact match can also accept
> multiples and then change the code to handle that.
> 
> The only caller of this code is the unlanded SPI driver [1] which
> currently passes "exact = True", thus it should be safe to change the
> semantics in this way.  ...and, in fact, the SPI driver should likely
> be modified to pass "exact = False" (with the new semantics) since
> that will allow it to work with SPI devices that request a clock rate
> that doesn't exactly match a rate we can make.
> 
> [1] https://lkml.kernel.org/r/1535107336-2214-1-git-send-email-dkota@codeaurora.org
> 
> Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/soc/qcom/qcom-geni-se.c | 37 ++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 1b19b8428c4a..092b32a315c3 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -544,16 +544,17 @@ EXPORT_SYMBOL(geni_se_clk_tbl_get);
>   * @se:		Pointer to the concerned serial engine.
>   * @req_freq:	Requested clock frequency.
>   * @index:	Index of the resultant frequency in the table.
> - * @res_freq:	Resultant frequency which matches or is closer to the
> - *		requested frequency.
> + * @res_freq:	Resultant frequency of the source clock.
>   * @exact:	Flag to indicate exact multiple requirement of the requested
>   *		frequency.
>   *
> - * This function is called by the protocol drivers to determine the matching
> - * or exact multiple of the requested frequency, as provided by the serial
> - * engine clock in order to meet the performance requirements. If there is
> - * no matching or exact multiple of the requested frequency found, then it
> - * selects the closest floor frequency, if exact flag is not set.
> + * This function is called by the protocol drivers to determine the best match
> + * of the requested frequency as provided by the serial engine clock in order
> + * to meet the performance requirements.
> + *
> + * If we return success:
> + * - if @exact is true  then @res_freq / <an_integer> == @req_freq
> + * - if @exact is false then @res_freq / <an_integer> <= @req_freq
>   *
>   * Return: 0 on success, standard Linux error codes on failure.
>   */
> @@ -564,6 +565,9 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
>  	unsigned long *tbl;
>  	int num_clk_levels;
>  	int i;
> +	unsigned long best_delta;
> +	unsigned long new_delta;
> +	unsigned int divider;
>  
>  	num_clk_levels = geni_se_clk_tbl_get(se, &tbl);
>  	if (num_clk_levels < 0)
> @@ -572,18 +576,21 @@ int geni_se_clk_freq_match(struct geni_se *se, unsigned long req_freq,
>  	if (num_clk_levels == 0)
>  		return -EINVAL;
>  
> -	*res_freq = 0;
> +	best_delta = 0;
>  	for (i = 0; i < num_clk_levels; i++) {
> -		if (!(tbl[i] % req_freq)) {
> +		divider = DIV_ROUND_UP(tbl[i], req_freq);
> +		new_delta = req_freq - tbl[i] / divider;
> +		if (!best_delta || new_delta < best_delta) {

nit: if you assigned best_delta to ULONG_MAX above you could omit the
check for !best_delta here, better to read IMO.

> +			/* We have a new best! */
>  			*index = i;
>  			*res_freq = tbl[i];
> -			return 0;
> -		}
>  
> -		if (!(*res_freq) || ((tbl[i] > *res_freq) &&
> -				     (tbl[i] < req_freq))) {
> -			*index = i;
> -			*res_freq = tbl[i];
> +			/* If the new best is exact then we're done */
> +			if (new_delta == 0)
> +				return 0;
> +
> +			/* Record how close we got */
> +			best_delta = new_delta;
>  		}
>  	}
>  

Looks good to me assuming that the statement "callers should always be
able to handle a clock that is a multiple of the requested clock" is
correct.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
