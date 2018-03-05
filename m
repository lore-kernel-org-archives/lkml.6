Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964823AbeCEM4v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 07:56:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:8279 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934140AbeCEM4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 07:56:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,426,1515484800";
   d="scan'208";a="22140318"
Date: Mon, 5 Mar 2018 14:56:42 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3 RESEND] tpm: add longer timeouts for creation
 commands.
Message-ID: <20180305125642.GA3425@linux.intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180304121205.16934-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2018 at 02:12:03PM +0200, Tomas Winkler wrote:
> TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve generation
> of crypto keys which can be a computationally intensive task.
> The timeout is set to 3min.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Where is the cover letter? Please send separate patches if they are
unrelated *or* add a cover letter that describes what they do as a
whole.

I will not review the next version if it does not have cover letter
describing the high level change and containing the change log.

> ---
>  drivers/char/tpm/tpm-interface.c |  4 ++++
>  drivers/char/tpm/tpm.h           | 27 ++++++++++++++++-----------
>  drivers/char/tpm/tpm2-cmd.c      |  8 +++++---
>  3 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 85bdfa8c3348..c0aa9d11ec7a 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -699,6 +699,10 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>  		    msecs_to_jiffies(TPM2_DURATION_MEDIUM);
>  		chip->duration[TPM_LONG] =
>  		    msecs_to_jiffies(TPM2_DURATION_LONG);
> +		chip->duration[TPM_LONG_LONG] =
> +		    msecs_to_jiffies(TPM2_DURATION_LONG_LONG);
> +		chip->duration[TPM_UNDEFINED] =
> +		    msecs_to_jiffies(TPM2_DURATION_DEFAULT);
>  
>  		chip->flags |= TPM_CHIP_FLAG_HAVE_TIMEOUTS;
>  		return 0;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f895fba4e20d..192ba68b39c2 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -67,7 +67,9 @@ enum tpm_duration {
>  	TPM_SHORT = 0,
>  	TPM_MEDIUM = 1,
>  	TPM_LONG = 2,
> -	TPM_UNDEFINED,
> +	TPM_LONG_LONG = 3,
> +	TPM_UNDEFINED = 4,
> +	TPM_DURATION_MAX,

This is starting to rotten to become unmaintainable.

Here is what I suggest to move forward:

* Have essentially two duration types:
  1. Default
  2. Long
  'default' is the old long duration i.e. two seconds. 'long' is a

We should probably have two durations:

enum tpm_duration {
	TPM_DURATION_DEFAULT = 2000,
	TPM_DURATION_LONG = 300000,
};

These would be both for TPM 1.2 and TPM 2.0. Instead of having
table for every ordinal there should be a small tables describing
commands that require long timeout.

> -		duration = 2 * 60 * HZ;
> +		duration = msecs_to_jiffies(TPM2_DURATION_DEFAULT);

NAK for this change.

/Jarkko
