Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751634AbeBYJkx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 04:40:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:51286 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeBYJku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 04:40:50 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,392,1515484800";
   d="scan'208";a="20905790"
Date: Sun, 25 Feb 2018 11:40:45 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v4] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180225094045.4zkqbrt5yi3ao562@linux.intel.com>
References: <20180224154316.26607-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180224154316.26607-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 05:43:16PM +0200, Tomas Winkler wrote:
> The correct sequence is to first request locality and only after
> that perform cmd_ready handshake, otherwise the hardware will drop
> the subsequent message as from the device point of view the cmd_ready
> handshake wasn't performed. Symmetrically locality has to be relinquished
> only after going idle handshake has completed, this requires that
> go_idle has to poll for the completion and as well locality
> relinquish has to poll for completion so it is not overridden
> in back to back commands flow.
> 
> The issue is only visible on devices that support multiple localities.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> V2: poll for locality relinquish completion
> V3: 1. Print error message upon locality relinquish failure
>     2. Don't override rc code on error path with locality relinquish
> V4: 3. Don't capture locality relinquish error code in rc, just print
> 	the error message.
> 
>        return value.
>  drivers/char/tpm/tpm-interface.c |  20 +++++---
>  drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++++++++++++------------
>  drivers/char/tpm/tpm_tis_core.c  |   4 +-
>  include/linux/tpm.h              |   2 +-
>  4 files changed, 93 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 9e80a953d693..4d74bacca5a1 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -422,8 +422,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	if (!(flags & TPM_TRANSMIT_UNLOCKED))
>  		mutex_lock(&chip->tpm_mutex);
>  
> -	if (chip->dev.parent)
> -		pm_runtime_get_sync(chip->dev.parent);
>  
>  	if (chip->ops->clk_enable != NULL)
>  		chip->ops->clk_enable(chip, true);
> @@ -439,6 +437,9 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  		chip->locality = rc;
>  	}
>  
> +	if (chip->dev.parent)
> +		pm_runtime_get_sync(chip->dev.parent);
> +
>  	rc = tpm2_prepare_space(chip, space, ordinal, buf);
>  	if (rc)
>  		goto out;
> @@ -499,17 +500,24 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
>  
>  out:
> +	if (chip->dev.parent)
> +		pm_runtime_put_sync(chip->dev.parent);
> +
>  	if (need_locality && chip->ops->relinquish_locality) {
> -		chip->ops->relinquish_locality(chip, chip->locality);
> +		/* this coud be on error path, don't override error code */
> +		int l_rc = chip->ops->relinquish_locality(chip, chip->locality);

Declaration should be in the beginning of the function.

> +
> +		if (l_rc) {
> +			dev_err(&chip->dev, "%s: relinquish_locality: error %d\n",
> +				__func__, l_rc);
> +		}

In kernel coding style, this should be w/o curly braces.

I can fix these cosmetic issues

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Doesn't this need

Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")

And shouldn't this also have

Cc: stable@vger.kernel.org

?

/Jarkko
