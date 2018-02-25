Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeBYKhQ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 05:37:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:35342 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751688AbeBYKhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 05:37:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,393,1515484800";
   d="scan'208";a="30508939"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2 v4] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Topic: [PATCH 1/2 v4] tpm: cmd_ready command can be issued only after
 granting locality
Thread-Index: AQHTrYagkPigyJ4us0ezmhdADlpCwqO0vNaAgAAtdZA=
Date: Sun, 25 Feb 2018 10:37:08 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94228C1A@hasmsx108.ger.corp.intel.com>
References: <20180224154316.26607-1-tomas.winkler@intel.com>
 <20180225094045.4zkqbrt5yi3ao562@linux.intel.com>
In-Reply-To: <20180225094045.4zkqbrt5yi3ao562@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTE2NzlmZTktNGQ0Ni00MDY3LWFhNTQtZTM1YWEwOWEyZjllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJwdTlzemJRK2pxVHVsczJLTTdRZkpaSE5oa3Y1eTM2dlNpOFVJNDBHVDNXTlhZVkhmS09wWkMzTHA4VlZjME9EIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.252.0.220]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, Feb 24, 2018 at 05:43:16PM +0200, Tomas Winkler wrote:
> > The correct sequence is to first request locality and only after that
> > perform cmd_ready handshake, otherwise the hardware will drop the
> > subsequent message as from the device point of view the cmd_ready
> > handshake wasn't performed. Symmetrically locality has to be
> > relinquished only after going idle handshake has completed, this
> > requires that go_idle has to poll for the completion and as well
> > locality relinquish has to poll for completion so it is not overridden
> > in back to back commands flow.
> >
> > The issue is only visible on devices that support multiple localities.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> > V2: poll for locality relinquish completion
> > V3: 1. Print error message upon locality relinquish failure
> >     2. Don't override rc code on error path with locality relinquish
> > V4: 3. Don't capture locality relinquish error code in rc, just print
> > 	the error message.
> >
> >        return value.
> >  drivers/char/tpm/tpm-interface.c |  20 +++++---
> >  drivers/char/tpm/tpm_crb.c       | 108 +++++++++++++++++++++++++++------
> ------
> >  drivers/char/tpm/tpm_tis_core.c  |   4 +-
> >  include/linux/tpm.h              |   2 +-
> >  4 files changed, 93 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 9e80a953d693..4d74bacca5a1 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -422,8 +422,6 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct
> tpm_space *space,
> >  	if (!(flags & TPM_TRANSMIT_UNLOCKED))
> >  		mutex_lock(&chip->tpm_mutex);
> >
> > -	if (chip->dev.parent)
> > -		pm_runtime_get_sync(chip->dev.parent);
> >
> >  	if (chip->ops->clk_enable != NULL)
> >  		chip->ops->clk_enable(chip, true);
> > @@ -439,6 +437,9 @@ ssize_t tpm_transmit(struct tpm_chip *chip, struct
> tpm_space *space,
> >  		chip->locality = rc;
> >  	}
> >
> > +	if (chip->dev.parent)
> > +		pm_runtime_get_sync(chip->dev.parent);
> > +
> >  	rc = tpm2_prepare_space(chip, space, ordinal, buf);
> >  	if (rc)
> >  		goto out;
> > @@ -499,17 +500,24 @@ ssize_t tpm_transmit(struct tpm_chip *chip,
> struct tpm_space *space,
> >  	rc = tpm2_commit_space(chip, space, ordinal, buf, &len);
> >
> >  out:
> > +	if (chip->dev.parent)
> > +		pm_runtime_put_sync(chip->dev.parent);
> > +
> >  	if (need_locality && chip->ops->relinquish_locality) {
> > -		chip->ops->relinquish_locality(chip, chip->locality);
> > +		/* this coud be on error path, don't override error code */
> > +		int l_rc = chip->ops->relinquish_locality(chip, chip->locality);
> 
> Declaration should be in the beginning of the function.

No, it shouldn't. I cannot find any reference to this statement, I've already explained my reasoning in a previous mail. 
  
> 
> > +
> > +		if (l_rc) {
> > +			dev_err(&chip->dev, "%s: relinquish_locality: error
> %d\n",
> > +				__func__, l_rc);
> > +		}
> 
> In kernel coding style, this should be w/o curly braces.

Yep, missed that, will resubmit


> I can fix these cosmetic issues
> 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> Doesn't this need
> 
> Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
> And shouldn't this also have
> 
> Cc: stable@vger.kernel.org
> 
> ?
Good points
Thanks
Tomas
