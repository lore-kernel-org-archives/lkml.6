Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752657AbeBSL1J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:27:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:11257 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbeBSL1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:27:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="202181146"
Date: Mon, 19 Feb 2018 13:27:00 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v3] tpm: cmd_ready command can be issued only after
 granting locality
Message-ID: <20180219112700.yfoywzegqzrpynlk@linux.intel.com>
References: <20180214134319.4400-1-tomas.winkler@intel.com>
 <20180214134319.4400-2-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180214134319.4400-2-tomas.winkler@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 14, 2018 at 03:43:18PM +0200, Tomas Winkler wrote:
>  	if (need_locality && chip->ops->relinquish_locality) {
> -		chip->ops->relinquish_locality(chip, chip->locality);
> +		/* this coud be on error path, don't override error code */
> +		int l_rc = chip->ops->relinquish_locality(chip, chip->locality);

All local variable declarations must be in the beginning of the
function.

> +
> +		if (l_rc) {
> +			dev_err(&chip->dev, "%s: relinquish_locality: error %d\n",
> +				__func__, l_rc);
> +			rc = l_rc;
> +		}

Your comment about not overriding error code is incorrect.

The value of 'rc' should be never overridden, which kind of supports
to "just print" behavior that we had for a locality error.

Is your fix somehow dependent on changing relinquish_locality()
behavior? If not, please remove this change. If you want to contribute
such behavioral change, you should make a separate patch of it.

Now it's like a trojan horse bundled inside a bug fix.

/Jarkko
