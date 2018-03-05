Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeCEKmY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 05:42:24 -0500
Received: from mga07.intel.com ([134.134.136.100]:59973 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934353AbeCEKmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 05:42:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="205564849"
Date: Mon, 5 Mar 2018 12:42:16 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v6] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180305104216.GC25377@linux.intel.com>
References: <20180301210813.21349-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301210813.21349-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 11:08:13PM +0200, Tomas Winkler wrote:
> The correct sequence is to first request locality and only after
> that perform cmd_ready handshake, otherwise the hardware will drop
> the subsequent message as from the device point of view the cmd_ready
> handshake wasn't performed. Symmetrically locality has to be relinquished
> only after going idle handshake has completed, this requires that
> go_idle has to poll for the completion and as well locality
> relinquish has to poll for completion so it is not overridden
> in back to back commands flow.
> 
> Two wrapper functions are added (request_locality relinquish_locality)
> to simplify the error handling.
> 
> The issue is only visible on devices that support multiple localities.
> 
> Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2: 1. Poll for locality relinquish completion.
> V3: 1. Print error message upon locality relinquish failure
>     2. Don't override rc code on error path with locality relinquish
>        return value.
> V4: 1. Don't capture locality relinquish error code in rc, just print
>        the error message.
> V5: 1. Fix a coding style issue.
>     2. Add Fixes: reference.
> V6: 1. Add locality wrappers.
> 
>  drivers/char/tpm/tpm-interface.c |  54 +++++++++++++++-----
>  drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++++++++++++------------
>  drivers/char/tpm/tpm_tis_core.c  |   4 +-
>  include/linux/tpm.h              |   2 +-
>  4 files changed, 120 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 9e80a953d693..b57bf449abfc 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -369,6 +369,36 @@ static int tpm_validate_command(struct tpm_chip *chip,
>  	return -EINVAL;
>  }
>  
> +static int request_locality(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	if (!chip->ops->request_locality)
> +		return 0;
> +
> +	rc = chip->ops->request_locality(chip, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	chip->locality = rc;
> +
> +	return 0;
> +}
> +
> +static void relinquish_locality(struct tpm_chip *chip)

I would require the tpm_ prefix here. It's great with ftrace function
tracer. That is why it was also in the response where I proposed this.
It is so mechanical change I can do it myself if you don't mind so you
don't have send a new version. I'll only do renames, no other changes.

/Jarkko
