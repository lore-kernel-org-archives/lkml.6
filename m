Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeEFX1K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 19:27:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46632 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeEFX1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 19:27:07 -0400
X-Google-Smtp-Source: AB8JxZq9gG7k1KO4z66RrVyKVdKJ7S8cA/YY3v77RMrT6vuC95aTf0bbVxxHhaUX55Ow//+uMYvfyA==
Date: Sun, 6 May 2018 16:27:04 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/18] thermal: exynos: move IRQs clearing to
 exynos_tmu_initialize()
Message-ID: <20180506232703.GB25956@localhost.localdomain>
References: <1524743493-28113-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180426115224epcas1p3dde7044de7d11c7ec7a7411df1123552@epcas1p3.samsung.com>
 <1524743493-28113-11-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524743493-28113-11-git-send-email-b.zolnierkie@samsung.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Thu, Apr 26, 2018 at 01:51:25PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Move ->tmu_clear_irqs call from ->tmu_initialize method to
> exynos_tmu_initialize().
> 
> There should be no functional changes caused by this patch.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 1664d37..82484c5 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -368,8 +368,10 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>  	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
>  	if (!status)
>  		ret = -EBUSY;
> -	else
> +	else {
>  		data->tmu_initialize(pdev);
> +		data->tmu_clear_irqs(data);
> +	}

You should actually enclose the if statement also in curls here:
	if (!status) {
		ret = -EBUSY;
	} else {
		data->tmu_initialize(pdev);
		data->tmu_clear_irqs(data);
	}


Fixing myself, but next time pay attention to kernel coding style
CHECK: Unbalanced braces around else statement
#35: FILE: drivers/thermal/samsung/exynos_tmu.c:371:
+	else {

total: 0 errors, 0 warnings, 1 checks, 43 lines checked

> 
