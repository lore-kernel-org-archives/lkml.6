Return-Path: <viresh.kumar@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525239851; cv=none;
        d=google.com; s=arc-20160816;
        b=ILN0qv0MqMGlWYF5kNcxGYyDQjl1TDFfUPneMa6zxwed80xFxD9rJ+fBqjwPb3nVTL
         6SEDdxcG+zB9H1/Ef+7ROUOvNN5qcX7oZbjoY0wGVBE2ytPvQKTdyQvkNZ4sI+Q25G7x
         fM5h6epcC+36tAlCfdO/kvzdpeJRWq8HinCGhe60xVhFJb6s/jQ5saLEp1wQ5qz3F+qi
         ymCcxOx/52Bgziin84qJF8llqnMN4AGVCAuniMtaR0YxKBoPEsevxaV5lB54gfUBHJKK
         k2xnox94iBFu4UK06IHYQiulEitHOPwnHKTLt5mJsTHypSHxJkPwcHBxVWKKJ9KqkIFf
         NZRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=PJDt5BmizT3nq0hJN/uT3VxAM6Zg81oawVOF06dvzWI=;
        b=cRz2uzDvOHebA8qiBkEONNxDwJz1E6I16BqDaQOeStKolB1qn6qIHhfDu4a2T9CRiM
         NdKpJ+xYzZmLBcKqxJ8jow0Znhw0AKtGgu2Ity3XpWj/hu5AfRkBHbMYY59Ujp39GOAH
         jaKxUc614xPmLFXf0jcdLVEKeCAneDGpvg1/gZPHyv1EiHEFk5hDQmELUT8p276HKpuH
         7iL5RmKj8Smki+ZeHjuCZsj5ugj4qbf3NqRfjXStJqkCsKAw/uwDHuAeFttI7P5Plkz/
         TTsQRMU42BBFTlMDHaDYr6fpNVCro7zBkCUhkSQULZRD1RIfsBRndiwi37zdVSP9cfLP
         NDeA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Xo7fMESB;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Xo7fMESB;
       spf=pass (google.com: domain of viresh.kumar@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=viresh.kumar@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpbRRlraE0s8U+gvaG9pl1USb3yjn+lJFUdnd6nCzVTyFbADaAnLih5Nnw8O6HKRlgWb90Mgg==
Date: Wed, 2 May 2018 11:14:08 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: hvaibhav.linux@gmail.com, johan@kernel.org, elder@kernel.org,
	gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
	greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH v2] staging: greybus: Use gpio_is_valid()
Message-ID: <20180502054408.db3pezsary2qjf2o@vireshk-i7>
References: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c8c96b1971bc09a2a2bfa62c343973ab986aec8.1524889296.git.arvind.yadav.cs@gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598896358310387815?=
X-GMAIL-MSGID: =?utf-8?q?1599329902305260194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28-04-18, 10:05, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
> chnage in v2 :
>              Returning invalid gpio as error instead of -ENODEV.
> 
>  drivers/staging/greybus/arche-platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 83254a7..c3a7da5 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -448,7 +448,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>  							"svc,reset-gpio",
>  							0);
> -	if (arche_pdata->svc_reset_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>  		dev_err(dev, "failed to get reset-gpio\n");
>  		return arche_pdata->svc_reset_gpio;
>  	}
> @@ -468,7 +468,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>  							  "svc,sysboot-gpio",
>  							  0);
> -	if (arche_pdata->svc_sysboot_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>  		dev_err(dev, "failed to get sysboot gpio\n");
>  		return arche_pdata->svc_sysboot_gpio;
>  	}
> @@ -487,7 +487,7 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>  							"svc,refclk-req-gpio",
>  							0);
> -	if (arche_pdata->svc_refclk_req < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>  		dev_err(dev, "failed to get svc clock-req gpio\n");
>  		return arche_pdata->svc_refclk_req;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
