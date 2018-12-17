Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07997C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C09DF2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="p03OkzZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733121AbeLQOsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:48:40 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42939 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732690AbeLQOsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:48:40 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so9622669lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 06:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3g/fsF0Ac7fJftbcfBihqbk+RLYMzWHjD7fXaDdPjRE=;
        b=p03OkzZW7r3Myy/Xs6jnBtIFIdyVsFwqM+7rH0grPnIo3yt1L6HB31fMWEDOLS1oe0
         IbMq3HPisWHsmiW25cAs1pzS2pZtrHUsDJKy2U2WNTI6PRLmJgIZFKuNaqYLoGH05Sbc
         z0bwB32vZ0V77Q6kalZ73DROS5+b7jBNvIahhSsjlGgb1WDAXLnHKCLuLLMYRax/8HFv
         kBl4wfBCUO17q8EgkazbqhigG8e/RCarPt6kzgg6gT+7yIrzRQmrieNwNV/nJtdO/a6F
         GSFI/0PrAHmdzzDZUkd4Zjyol2WLK0GA6QzcfDbmdDfx65l4+8YiCtbbScM3Z5LWBMri
         zOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3g/fsF0Ac7fJftbcfBihqbk+RLYMzWHjD7fXaDdPjRE=;
        b=F/TroifupG8JFgCbFyESu3xkmBke3g/Z5sNBmY2cAYvh7wQnf14mAvqjfmvmp2KUGR
         c4CqyJ2r51eNpi2L1L98L3dgI9MfX68X5KEJIyR17QVbBkm2zAg2adBfM/6Qp0qKFeRA
         A0bJxQqv0FfaWM4RKpxeK3uvoLKGVXtNk3Ij2h2MZ76vC1HcSeClgTNni519VS8u+eUs
         2q60ucjkO70pQnRdAZrfvgR0D5VNtWHPCk7FpHIqaMcM2kvnKaevSQqtq06r+7dRNcHU
         WaM65rcSzKcA7q+Q2trqtwtkWzac1GACM80cjdiuCfEJjlolBldOrkgfPRF2TIxsRcpn
         V9xw==
X-Gm-Message-State: AA+aEWYT25vSxrjrnGH885R9wHK0Mxe0ZkD5iP554oAJCLCFI8YF/ayZ
        3vkx2D1U0fxwEWY8jTk+5yThNQ==
X-Google-Smtp-Source: AFSGD/W7QMkKZUYgJPkGZ8uyrf3wr0p6/rpqiGfZJ5IlfubHqZrn8LM22o2IJdTp+Pd5fcJFaEWElg==
X-Received: by 2002:a19:f204:: with SMTP id q4mr7971963lfh.133.1545058116944;
        Mon, 17 Dec 2018 06:48:36 -0800 (PST)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id c2-v6sm2568485ljj.41.2018.12.17.06.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 06:48:36 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:48:35 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: Re: [PATCH] media: rcar-csi2: Add support for RZ/G2E
Message-ID: <20181217144835.GT17972@bigcity.dyn.berto.se>
References: <1544732652-7459-1-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1544732652-7459-1-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio,

Thanks.

On 2018-12-13 20:24:12 +0000, Fabrizio Castro wrote:
> According to the RZ/G2 User's manual, RZ/G2E and R-Car E3 CSI-2
> blocks are identical, therefore use R-Car E3 definitions to add
> RZ/G2E support.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
> index 80ad906..be7508b 100644
> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
> @@ -979,6 +979,10 @@ static const struct rcar_csi2_info rcar_csi2_info_r8a77990 = {
>  
>  static const struct of_device_id rcar_csi2_of_table[] = {
>  	{
> +		.compatible = "renesas,r8a774c0-csi2",
> +		.data = &rcar_csi2_info_r8a77990,
> +	},
> +	{
>  		.compatible = "renesas,r8a7795-csi2",
>  		.data = &rcar_csi2_info_r8a7795,
>  	},
> -- 
> 2.7.4
> 

-- 
Regards,
Niklas Söderlund
