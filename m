Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDSMJs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 08:09:48 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:41064 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbeDSMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 08:09:46 -0400
Subject: Re: [PATCH 2/2] memory: aemif: add support for board files
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kevin Hilman <khilman@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180418153552.14632-1-brgl@bgdev.pl>
 <20180418153552.14632-3-brgl@bgdev.pl>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <15d56b6d-6546-0655-563e-4492982c8d78@ti.com>
Date: Thu, 19 Apr 2018 17:39:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418153552.14632-3-brgl@bgdev.pl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 April 2018 09:05 PM, Bartosz Golaszewski wrote:
> @@ -373,15 +372,23 @@ static int aemif_probe(struct platform_device *pdev)
>  		goto error;
>  	}
>  
> -	/*
> -	 * For every controller device node, there is a cs device node that
> -	 * describe the bus configuration parameters. This functions iterate
> -	 * over these nodes and update the cs data array.
> -	 */
> -	for_each_available_child_of_node(np, child_np) {
> -		ret = of_aemif_parse_abus_config(pdev, child_np);
> -		if (ret < 0)
> -			goto error;
> +	if (np) {
> +		/*
> +		 * For every controller device node, there is a cs device node
> +		 * that describe the bus configuration parameters. This
> +		 * functions iterate over these nodes and update the cs data
> +		 * array.
> +		 */
> +		for_each_available_child_of_node(np, child_np) {
> +			ret = of_aemif_parse_abus_config(pdev, child_np);
> +			if (ret < 0)
> +				goto error;
> +		}
> +	} else if (pdata && pdata->num_abus_data > 0) {
> +		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
> +			aemif->cs_data[i].cs = pdata->abus_data->cs;

Since abus_data is an array, shouldn't it be pdata->abus_data[i].cs ?

Thanks,
Sekhar
