Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeDEKMh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:12:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:7322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeDEKMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:12:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,410,1517904000";
   d="scan'208";a="188860631"
Date: Thu, 5 Apr 2018 13:12:10 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH] tpm: moves the delay_msec increment after sleep in
 tpm_transmit()
Message-ID: <20180405101210.GA21636@linux.intel.com>
References: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402162006.5030-1-nayna@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 02, 2018 at 09:50:06PM +0530, Nayna Jain wrote:
> Commit e2fb992d82c6 ("tpm: add retry logic") introduced a new loop to
> handle the TPM2_RC_RETRY error. The loop retries the command after
> sleeping for the specified time, which is incremented exponentially in
> every iteration. This patch fixes the initial sleep to be the default
> sleep time.

I think I understand the code change but do not understand what the
long description.

> 
> Fixes: commit e2fb992d82c6 ("tpm: add retry logic")
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index c43a9e28995e..6201aab374e6 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -587,7 +587,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  		 */
>  		if (rc == TPM2_RC_TESTING && cc == TPM2_CC_SELF_TEST)
>  			break;
> -		delay_msec *= 2;
> +

Extra whitespace

>  		if (delay_msec > TPM2_DURATION_LONG) {
>  			if (rc == TPM2_RC_RETRY)
>  				dev_err(&chip->dev, "in retry loop\n");
> @@ -597,6 +597,7 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct tpm_space *space,
>  			break;
>  		}
>  		tpm_msleep(delay_msec);
> +		delay_msec *= 2;
>  		memcpy(buf, save, save_size);
>  	}
>  	return ret;
> -- 
> 2.13.6
> 

/Jarkko
