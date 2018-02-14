Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030400AbeBNNad (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 08:30:33 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:64223 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967713AbeBNNaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 08:30:30 -0500
Subject: Re: [PATCH 2/2] drm/tilcdc: panel: Use common error handling code in
 of_get_panel_info()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <a7c7cebb-f4c9-04b7-5507-e41f8ebfb5f9@users.sourceforge.net>
 <23b2cf6c-7b69-9ade-d97a-18af0c6eb73f@users.sourceforge.net>
From: Jyri Sarha <jsarha@ti.com>
Message-ID: <8ea87afa-0713-eaac-640f-85085e148832@ti.com>
Date: Wed, 14 Feb 2018 15:30:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <23b2cf6c-7b69-9ade-d97a-18af0c6eb73f@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/18 23:24, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Feb 2018 22:10:11 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Well, it is couple of lines less. If I would just have couple weeks time
to implement proper drm panel support for tilcdc and get rid of this
driver all together...

Picked for the next tilcdc pullrequest.

Thanks,
Jyri


> ---
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> index 0b6aa95aec89..cf9ca16fee81 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> @@ -289,10 +289,8 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
>  	}
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
> -	if (!info) {
> -		of_node_put(info_np);
> -		return NULL;
> -	}
> +	if (!info)
> +		goto put_node;
>  
>  	ret |= of_property_read_u32(info_np, "ac-bias", &info->ac_bias);
>  	ret |= of_property_read_u32(info_np, "ac-bias-intrpt", &info->ac_bias_intrpt);
> @@ -311,11 +309,11 @@ static struct tilcdc_panel_info *of_get_panel_info(struct device_node *np)
>  	if (ret) {
>  		pr_err("%s: error reading panel-info properties\n", __func__);
>  		kfree(info);
> -		of_node_put(info_np);
> -		return NULL;
> +		info = NULL;
>  	}
> -	of_node_put(info_np);
>  
> +put_node:
> +	of_node_put(info_np);
>  	return info;
>  }
>  
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
