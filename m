Return-Path: <elder@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524831479; cv=none;
        d=google.com; s=arc-20160816;
        b=xfouc6xRGvuZUHTFn/+HP1ksF7a6KlahssePnRLdVQxHsH4/ign9D7axDmA2lG4CbJ
         Rq+Kp408NraDufjmM0+PkxGNWFwVF1KrM5rRDtEX/A6Y1QdnZ1qLeR0lCOhhubWG1Lmc
         niTY/KPNkNmpqMV1J+i+TUPAxo1CswzT0QJIa62c32XTlcVJqgnL8o/KlQPzwBI3KQa2
         d6jsnqvSBeIvPTsY2dMvuZi9mOuDJxHG06qlT0OIJx07Y/4d3ntAnBkUF7dK4qIn0qMA
         3kjVQYsaUIyAIzhgGPJo9PulDAvHrksmAY3fbyjSMKMHNknAwd8zX7EOACYXLLTIhG1+
         97oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=MZb0AFKsH3MOS7HKFWAAxs3uFTmbRidKmINrDjIbndw=;
        b=UJ+WB1TtBLL14cLdzQ4RjlU39XbTN5vNeA8lfu42acqNVuP6YNkHaApzYqbq/Nx0d3
         izjgRi5eUI/AVvkHjDWpB6Utv1HyaKwUJkC8604a5Txh+UFR16dw1/4IQbhBoLI+4/rP
         JuVRvyvzAn8ELEu9/ztAe7YnzP4Bkv3PNhgAF0DRGG90TrE9esaWXH95n5zq8Sb3Jyul
         VfzClDPHMJJ9X8qRnxKz3hi3iTtnNA6cxWYpML+5j6PXF79LQ1GFbrNbXtbL1aLzhMow
         UpF97OzYbhXH5GnK2TXXBOadExFy8MEORule4r6O8rTOMFS+Fdvq0GViyxW6Vkw4xHYN
         oTTA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GVJjILH0;
       spf=pass (google.com: domain of elder@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=elder@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GVJjILH0;
       spf=pass (google.com: domain of elder@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=elder@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq4vpaLHKLOSFKhfKxxYJpZkPlz0OHbxqUi8FhYlbkz8kF243nWtp6UNUwgHBeiFBKNig1Bdg==
Subject: Re: [greybus-dev] [PATCH] staging: greybus: Use gpio_is_valid()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, hvaibhav.linux@gmail.com,
 johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
 linux-kernel@vger.kernel.org
References: <785eda4d65f396b353393e9538eba21095ce876e.1524825902.git.arvind.yadav.cs@gmail.com>
From: Alex Elder <elder@linaro.org>
Message-ID: <7ebee672-6413-6f1d-fe57-2e278c90cf9e@linaro.org>
Date: Fri, 27 Apr 2018 07:17:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <785eda4d65f396b353393e9538eba21095ce876e.1524825902.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598896358310387815?=
X-GMAIL-MSGID: =?utf-8?q?1598901693061374103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 05:52 AM, Arvind Yadav wrote:
> Replace the manual validity checks for the GPIO with the
> gpio_is_valid().

I haven't looked through the code paths very closely, but I
think that get_named_gpio() might return -EPROBE_DEFER, which
would be something we want to pass to the caller.

So rather than returning -ENODEV and hiding the reason the
call to of_get_named_gpio() failed, you should continue
returning the errno it supplies (if not a valid gpio number).

					-Alex

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/staging/greybus/arche-platform.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 83254a7..fc6bf60 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -448,9 +448,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
>  							"svc,reset-gpio",
>  							0);
> -	if (arche_pdata->svc_reset_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
>  		dev_err(dev, "failed to get reset-gpio\n");
> -		return arche_pdata->svc_reset_gpio;
> +		return -ENODEV;
>  	}
>  	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
>  	if (ret) {
> @@ -468,9 +468,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
>  							  "svc,sysboot-gpio",
>  							  0);
> -	if (arche_pdata->svc_sysboot_gpio < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
>  		dev_err(dev, "failed to get sysboot gpio\n");
> -		return arche_pdata->svc_sysboot_gpio;
> +		return -ENODEV;
>  	}
>  	ret = devm_gpio_request(dev, arche_pdata->svc_sysboot_gpio, "sysboot0");
>  	if (ret) {
> @@ -487,9 +487,9 @@ static int arche_platform_probe(struct platform_device *pdev)
>  	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
>  							"svc,refclk-req-gpio",
>  							0);
> -	if (arche_pdata->svc_refclk_req < 0) {
> +	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
>  		dev_err(dev, "failed to get svc clock-req gpio\n");
> -		return arche_pdata->svc_refclk_req;
> +		return -ENODEV;
>  	}
>  	ret = devm_gpio_request(dev, arche_pdata->svc_refclk_req,
>  				"svc-clk-req");
> 
