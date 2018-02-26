Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752756AbeBZMJu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:09:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:25790 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbeBZMJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:09:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="20355639"
Message-ID: <1519646980.12825.4.camel@linux.intel.com>
Subject: Re: [PATCH 1/2 v5] tpm: cmd_ready command can be issued only after
 granting locality
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 26 Feb 2018 14:09:40 +0200
In-Reply-To: <20180225120049.29308-1-tomas.winkler@intel.com>
References: <20180225120049.29308-1-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-25 at 14:00 +0200, Tomas Winkler wrote:
>  	if (need_locality && chip->ops->relinquish_locality) {
> -		chip->ops->relinquish_locality(chip, chip->locality);
> +		/* this coud be on error path, don't override error code */
> +		int l_rc = chip->ops->relinquish_locality(chip, chip-
> >locality);
> +
> +		if (l_rc)
> +			dev_err(&chip->dev, "%s: relinquish_locality: error
> %d\n",
> +				__func__, l_rc);
> +
>  		chip->locality = -1;
>  	}

The 'l_rc' declaration causes NAK as I've stated before.

Why don't you just make a helper function:

static void tpm_relinquish_locality(struct tpm_chip *chip)
{
	int rc;

	if (!chip->ops->relinquish_locality)
		return 0;

	rc = chip->ops->relinquish_locality(chip);
	if (rc)
		dev_err(&chip->dev, "%s: error %d\n", __func__, rc);

	chip->locality = -1;
}

Then the original code would be simply:

if (need_locality)
	tpm_relinquish_locality(chip);

/Jarkko
