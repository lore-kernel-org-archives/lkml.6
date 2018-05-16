Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752698AbeEPIil (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 04:38:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40918 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeEPIii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 04:38:38 -0400
X-Google-Smtp-Source: AB8JxZoC1pX8+lhI+QEdt2iQHk8PTd3FGP7nv0aYAPJDiIh891xKuklPVwaI5nubQ93d3zQNUcCqeg==
Subject: Re: [PATCH] nvmem: Don't let a NULL cell_id for nvmem_cell_get()
 crash us
To: Douglas Anderson <dianders@chromium.org>, kishon@ti.com
Cc: mgautam@codeaurora.org, mka@chromium.org, vivek.gautam@codeaurora.org,
        evgreen@chromium.org, linux-kernel@vger.kernel.org
References: <20180515211622.195140-1-dianders@chromium.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <3e737866-4d59-ac2e-c53f-540912613f12@linaro.org>
Date: Wed, 16 May 2018 09:38:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180515211622.195140-1-dianders@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/05/18 22:16, Douglas Anderson wrote:
> In commit ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on
> Qcom chips") you can see a call like:
> 
>    devm_nvmem_cell_get(dev, NULL);
> 
> Note that the cell ID passed to the function is NULL.  This is because
> the qcom-qusb2 driver is expected to work only on systems where the
> PHY node is hooked up via device-tree and is nameless.
> 
> This works OK for the most part.  The first thing nvmem_cell_get()
> does is to call of_nvmem_cell_get() and there it's documented that a
> NULL name is fine.  The problem happens when the call to
> of_nvmem_cell_get() returns -EINVAL.  In such a case we'll fall back
> to nvmem_cell_get_from_list() and eventually might (if nvmem_cells
> isn't an empty list) crash with something that looks like:
> 
>   strcmp
>   nvmem_find_cell
>   __nvmem_device_get
>   nvmem_cell_get_from_list
>   nvmem_cell_get
>   devm_nvmem_cell_get
>   qusb2_phy_probe
> 
> There are several different ways we could fix this problem:
> 
> One could argue that perhaps the qcom-qusb2 driver should be changed
> to use of_nvmem_cell_get() which is allowed to have a NULL name.  In
> that case, we'd need to add a patche to introduce
> devm_of_nvmem_cell_get() since the qcom-qusb2 driver is using devm
> managed resources.
> 
> One could also argue that perhaps we could just add a name to
> qcom-qusb2.  That would be OK but I believe it effectively changes the
> device tree bindings, so maybe it's a no-go.
> 
> In this patch I have chosen to fix the problem by simply not crashing
> when a NULL cell_id is passed to nvmem_cell_get().
> 
> NOTE: that for the qcom-qusb2 driver the "nvmem-cells" property is
> defined to be optional and thus it's expected to be a common case that
> we would hit this crash and this is more than just a theoretical fix.
> 
> Fixes: ca04d9d3e1b1 ("phy: qcom-qusb2: New driver for QUSB2 PHY on Qcom chips")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>   drivers/nvmem/core.c | 4 ++++
>   1 file changed, 4 insertions(+)

Looks good to me,
Kishon if you want to queue this one from your tree, you can add my

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

If not I can send this via Greg's Char-misc tree.

thanks,
srini

> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index b5b0cdc21d01..514d1dfc5630 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -936,6 +936,10 @@ struct nvmem_cell *nvmem_cell_get(struct device *dev, const char *cell_id)
>   			return cell;
>   	}
>   
> +	/* NULL cell_id only allowed for device tree; invalid otherwise */
> +	if (!cell_id)
> +		return ERR_PTR(-EINVAL);
> +
>   	return nvmem_cell_get_from_list(cell_id);
>   }
>   EXPORT_SYMBOL_GPL(nvmem_cell_get);
> 
