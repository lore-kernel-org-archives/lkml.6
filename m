Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752712AbeBSOPI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 09:15:08 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34315 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBSOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 09:15:07 -0500
Message-ID: <1519049704.3408.17.camel@pengutronix.de>
Subject: Re: [PATCH] gpu: ipu-v3: prg: fix device node leak in
 ipu_prg_lookup_by_phandle
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: sil2review@lists.osadl.org
Date: Mon, 19 Feb 2018 15:15:04 +0100
In-Reply-To: <20180215143530.e3qxat3rxcudqcsl@agrajag.zerfleddert.de>
References: <20180215143530.e3qxat3rxcudqcsl@agrajag.zerfleddert.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tobias,

On Thu, 2018-02-15 at 15:35 +0100, Tobias Jordan wrote:
> Before returning, call of_node_put() for the device node returned by
> of_parse_phandle().
> 
> Fixes: ea9c260514c1 ("gpu: ipu-v3: add driver for Prefetch Resolve Gasket")
> Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
> ---
>  drivers/gpu/ipu-v3/ipu-prg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
> index 067365c733c6..97b99500153d 100644
> --- a/drivers/gpu/ipu-v3/ipu-prg.c
> +++ b/drivers/gpu/ipu-v3/ipu-prg.c
> @@ -102,11 +102,14 @@ ipu_prg_lookup_by_phandle(struct device *dev, const char *name, int ipu_id)
>  			mutex_unlock(&ipu_prg_list_mutex);
>  			device_link_add(dev, prg->dev, DL_FLAG_AUTOREMOVE);
>  			prg->id = ipu_id;
> +			of_node_put(prg_node);
>  			return prg;
>  		}
>  	}
>  	mutex_unlock(&ipu_prg_list_mutex);
>  
> +	of_node_put(prg_node);
> +
>  	return NULL;
>  }
>  

Applied both to imx-drm/next, thank you.

regards
Philipp
