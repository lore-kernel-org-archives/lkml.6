Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965748AbeCAIht (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 03:37:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:9136 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964923AbeCAIhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 03:37:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,407,1515484800";
   d="scan'208";a="30636858"
Date: Thu, 1 Mar 2018 10:37:40 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com,
        patrickc@us.ibm.com
Subject: Re: [PATCH 1/3] tpm: move TPM_POLL_SLEEP from tpm_tis_core.c to tpm.h
Message-ID: <20180301083740.GB29420@linux.intel.com>
References: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228191828.20056-1-nayna@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Wed, Feb 28, 2018 at 02:18:26PM -0500, Nayna Jain wrote:
> This patch moves TPM_POLL_SLEEP from tpm_tis_core.c to tpm.h, renaming
> it to TPM_TIMEOUT_POLL, to follow the existing enum naming
> conventions.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

The cover letter is missing. Are this meant to be a patch set or
individual patches? I'll check these anyway.

> ---
>  drivers/char/tpm/tpm.h          |  3 ++-
>  drivers/char/tpm/tpm_tis_core.c | 10 ++--------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f895fba4e20d..7e797377e1eb 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -53,7 +53,8 @@ enum tpm_const {
>  enum tpm_timeout {
>  	TPM_TIMEOUT = 5,	/* msecs */
>  	TPM_TIMEOUT_RETRY = 100, /* msecs */
> -	TPM_TIMEOUT_RANGE_US = 300	/* usecs */
> +	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */

What is happening here?

> +	TPM_TIMEOUT_POLL = 1	/* msecs */
>  };
>  
>  /* TPM addresses */
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 183a5f54d875..dc474e7244a6 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -31,12 +31,6 @@
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
>  
> -/* This is a polling delay to check for status and burstcount.
> - * As per ddwg input, expectation is that status check and burstcount
> - * check should return within few usecs.
> - */
> -#define TPM_POLL_SLEEP	1  /* msec */
> -
>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>  
>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
> @@ -90,7 +84,7 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		}
>  	} else {
>  		do {
> -			tpm_msleep(TPM_POLL_SLEEP);
> +			tpm_msleep(TPM_TIMEOUT_POLL);
>  			status = chip->ops->status(chip);
>  			if ((status & mask) == mask)
>  				return 0;
> @@ -232,7 +226,7 @@ static int get_burstcount(struct tpm_chip *chip)
>  		burstcnt = (value >> 8) & 0xFFFF;
>  		if (burstcnt)
>  			return burstcnt;
> -		tpm_msleep(TPM_POLL_SLEEP);
> +		tpm_msleep(TPM_TIMEOUT_POLL);
>  	} while (time_before(jiffies, stop));
>  	return -EBUSY;
>  }
> -- 
> 2.13.3
> 

Otherwise, looks fine.

/Jarkko
