Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754677AbeD3Peh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:34:37 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42699 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753480AbeD3Pef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:34:35 -0400
X-Google-Smtp-Source: AB8JxZrV364Zc5KnMBIGJhMsZzPDJ4kLxsNBIUV2uEakztmXaUylU23XULwZkN9I1dpN40tFVgdsaQ==
Date: Mon, 30 Apr 2018 17:34:31 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/18] thermal: exynos: fix trips limit checking in
 get_th_reg()
Message-ID: <20180430153431.GB27619@mai>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115214epcas2p33003bbbe84310405c6871853f0df40e3@epcas2p3.samsung.com>
 <1524743493-28113-7-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524743493-28113-7-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 01:51:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> of_thermal_get_ntrips() may return value bigger than supported
> by a given SoC (i.e. on Exynos5422/5800) 

Can you elaborate a bit ?

> so fix the code to not
> iterate the loop for i values >= data->ntrip.
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 5a64879..58cd68e 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -311,9 +311,9 @@ static u32 get_th_reg(struct exynos_tmu_data *data, u32 threshold, bool falling)
>  	const struct thermal_trip * const trips =
>  		of_thermal_get_trip_points(tz);
>  	unsigned long temp;
> -	int i;
> +	int i, ntrips = min_t(int, of_thermal_get_ntrips(tz), data->ntrip);
>  
> -	for (i = 0; i < of_thermal_get_ntrips(tz); i++) {
> +	for (i = 0; i < ntrips; i++) {
>  		if (trips[i].type == THERMAL_TRIP_CRITICAL)
>  			continue;
>  
> -- 
> 1.9.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
