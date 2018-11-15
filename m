Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B86C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DA120825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cnfgSvba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DA120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387829AbeKOTtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:49:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34048 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeKOTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:49:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id f1-v6so15380080wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iZdZ1tbxZ2jgm+Fw5ofbviFGs4w9c8ZCB3/+iX/YKWs=;
        b=cnfgSvbatP24qb0t5HWnSa1D1mgJ2Xbizaw+L2In7Z3NxpJ/+HM3ERzY5dS7Cz6k+E
         KQdB4fPBogauGnzN3fxQ5SuyJ2DYFe8PVOAYsYsDQy6jgDGvs39v1fJYoQIVUSYpqb9Y
         /79qNBtX5yRfHPz9PigApwvST1U9caZm3GGVg1/11kpx4z5i6mFpzqGNbiL3ce7qABZV
         QtDW1bpy/nD/3b6jPnIARCMquxHY6b6V8TiXTxrA7EN662hkFbMzwNr3lXWyWPbvVISF
         ObdRZHzOKeqc1YByU3aGEU0ek1JtD4me7vcwWrVy3x6TKfLpcSrzp9lPcivOcV5r5nlM
         Vp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iZdZ1tbxZ2jgm+Fw5ofbviFGs4w9c8ZCB3/+iX/YKWs=;
        b=MOPGNDuTwKcESPVr8yAHcT6hTz0hQEI6bdFK9iKp0nKozMcs1rD1M2zen+wE5/SrTp
         soVSkwiKBmEi2M9S/iigk+tKg02b9nmdia2GWfeOGQCaB3wRs3k+ecaQy7cBML8gWqBv
         yCSCxstwy0wbWavSyCwcwASZT2TNe4S21rfeh+rLRpYXlgB+zTByD0Tq7GgenNHVeRfS
         WFNzwWGnuBYRqhuGGd4E+bEqtiLSXf5QPjV2lXz1ngSmg5QN8f8dzHWXhKbBAb3LxWLa
         iyXoW54GgyLycBHkneYsBsXivnSpcizTnUGu27Yzndh7KjMGxAvLXUB1DMAhMClY5TD/
         XMpA==
X-Gm-Message-State: AGRZ1gLbrWDriNbdgtAyGag4heJ6qTVUn/KwbkZz80mC2GhUgzCLrK0n
        b9x0y7KbxEVxgyf4y7Q6rJp30w==
X-Google-Smtp-Source: AJdET5fzQvns4AKdOpXfOPwdJnMeflKLURXsDhAAeOR7qzQfQhqyzviRRlkRlLisUCu/gad8lG3L4A==
X-Received: by 2002:a1c:e03:: with SMTP id 3-v6mr4604164wmo.13.1542274918064;
        Thu, 15 Nov 2018 01:41:58 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id x8-v6sm60737870wrd.54.2018.11.15.01.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 01:41:57 -0800 (PST)
Message-ID: <4afb7269e3dbb6ac376643a70719736e336ad739.camel@baylibre.com>
Subject: Re: [RFC v1 6/7] clk: meson: meson8b: add support for more M/N
 values in sys_pll
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Date:   Thu, 15 Nov 2018 10:41:55 +0100
In-Reply-To: <20181114225725.2821-7-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
         <20181114225725.2821-7-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> The sys_pll on the EC-100 board is configured to 1584MHz at boot
> (either by u-boot, firmware or chip defaults). This is achieved by using
> M = 66, N = 1 (24MHz * 66 / 1).
> At boot the CPU clock is running off sys_pll divided by 2 which results
> in 792MHz. Thus M = 66 is considered to be a "safe" value for Meson8b.
> 
> To achieve 1608MHz (one of the CPU OPPs on Meson8 and Meson8m2) we need
> M = 67, N = 1. I ran "stress --cpu 4" while infinitely cycling through
> all available frequencies on my Meson8m2 board and could not spot any
> issues with this setting (after ~12 hours of running this).
> 
> On Meson8, Meson8b and Meson8m2 we also want to be able to use 408MHz
> and 816MHz CPU frequencies. These can be achieved by dividing sys_pll by
> 4 (for 408MHz) or 2 (for 816MHz). That means that sys_pll has to run at
> 1632MHz which can be generated using M = 68, N = 1.
> Similarily we also want to be able to use 1008MHz as CPU frequency. This
> means that sys_pll has to run either at 1008MHz or 2016MHz. The former
> would result in an M value of 42, which is lower than the smallest value
> used by the 3.10 GPL kernel sources from Amlogic (50 is the lower limit
> there). Thus we need to run sys_pll at 2016MHz which can ge generated
> using M = 84, N = 1.
> I tested M = 68 and M = 84 on my Meson8b Odroid-C1 and my Meson8m2 board
> by running "stress --cpu 4" while infinitely cycling thorugh all
> available frequencies. I could not spot any issues after ~12 hours of
> running this.
> 
> Amlogic's 3.10 GPL kernel sources have more M/N combinations. I did not
> add them yet because M = 74 (to achieve close to 1800MHz on Meson8) and
> M = 82 (to achieve close to 1992MHz on Meson8 as well) caused my
> Meson8m2 board to hang randomly. It's not clear why this is (for example
> because the board's voltage regulator design is bad, some missing bits
> for these values in our clk-pll driver, etc.). Thus the following M
> values from the Amlogic 3.10 GPL kernel sources are skipped as of now:
> 69, 70, 71, 72, 73, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index d566dd5bc567..c06a1a7faa4c 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -43,6 +43,11 @@ static const struct pll_params_table
> sys_pll_params_table[] = {
>  	PLL_PARAMS(62, 1),
>  	PLL_PARAMS(63, 1),
>  	PLL_PARAMS(64, 1),
> +	PLL_PARAMS(65, 1),
> +	PLL_PARAMS(66, 1),
> +	PLL_PARAMS(67, 1),
> +	PLL_PARAMS(68, 1),
> +	PLL_PARAMS(84, 1),
>  	{ /* sentinel */ },
>  };
>  

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

