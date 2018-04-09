Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeDILN2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:13:28 -0400
Received: from mga06.intel.com ([134.134.136.31]:27590 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751609AbeDILN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:13:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="45365290"
Message-ID: <c06b86c0b58888f750e6e00c33be33ab54d39257.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 09 Apr 2018 14:13:20 +0300
In-Reply-To: <20180407161236.22969-1-tomas.winkler@intel.com>
References: <20180407161236.22969-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-04-07 at 19:12 +0300, Tomas Winkler wrote:
> In crb_map_io() function, __crb_request_locality() is called prior
> to crb_cmd_ready(), but if one of the consecutive function fails
> the flow bails out instead of trying to relinquish locality.
> This patch adds goto jump to __crb_relinquish_locality() on the error path.
> 
> Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after granting
> locality)
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/char/tpm/tpm_crb.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 7f78482cd157..34fbc6cb097b 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -511,8 +511,10 @@ static int crb_map_io(struct acpi_device *device, struct
> crb_priv *priv,
>  
>  	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
>  				   sizeof(struct crb_regs_tail));
> -	if (IS_ERR(priv->regs_t))
> -		return PTR_ERR(priv->regs_t);
> +	if (IS_ERR(priv->regs_t)) {
> +		ret = PTR_ERR(priv->regs_t);
> +		goto out_relinquish_locality;
> +	}
>  
>  	/*
>  	 * PTT HW bug w/a: wake up the device to access
> @@ -520,7 +522,7 @@ static int crb_map_io(struct acpi_device *device, struct
> crb_priv *priv,
>  	 */
>  	ret = crb_cmd_ready(dev, priv);
>  	if (ret)
> -		return ret;
> +		goto out_relinquish_locality;
>  
>  	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
>  	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
> @@ -565,6 +567,8 @@ static int crb_map_io(struct acpi_device *device, struct
> crb_priv *priv,
>  
>  	crb_go_idle(dev, priv);
>  
> +out_relinquish_locality:
> +
>  	__crb_relinquish_locality(dev, priv, 0);
>  
>  	return ret;

Thanks, please just call it before returning in the error path.

/Jarkko
