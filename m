Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753262AbeDJMdU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:33:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:23314 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753203AbeDJMdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:33:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,432,1517904000";
   d="scan'208";a="32244242"
Message-ID: <4984305eae452b7a72b8a13aa20cecec420df580.camel@linux.intel.com>
Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 15:33:08 +0300
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94252660@hasmsx108.ger.corp.intel.com>
References: <20180407161236.22969-1-tomas.winkler@intel.com>
         <c06b86c0b58888f750e6e00c33be33ab54d39257.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B94252660@hasmsx108.ger.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.0-4 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 09:00 +0000, Winkler, Tomas wrote:
> > 
> > On Sat, 2018-04-07 at 19:12 +0300, Tomas Winkler wrote:
> > > In crb_map_io() function, __crb_request_locality() is called prior to
> > > crb_cmd_ready(), but if one of the consecutive function fails the flow
> > > bails out instead of trying to relinquish locality.
> > > This patch adds goto jump to __crb_relinquish_locality() on the error
> > > path.
> > > 
> > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only after
> > > granting
> > > locality)
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > ---
> > >  drivers/char/tpm/tpm_crb.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> > > index 7f78482cd157..34fbc6cb097b 100644
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -511,8 +511,10 @@ static int crb_map_io(struct acpi_device *device,
> > > struct crb_priv *priv,
> > > 
> > >  	priv->regs_t = crb_map_res(dev, priv, &io_res, buf-
> > > >control_address,
> > >  				   sizeof(struct crb_regs_tail));
> > > -	if (IS_ERR(priv->regs_t))
> > > -		return PTR_ERR(priv->regs_t);
> > > +	if (IS_ERR(priv->regs_t)) {
> > > +		ret = PTR_ERR(priv->regs_t);
> > > +		goto out_relinquish_locality;
> > > +	}
> > > 
> > >  	/*
> > >  	 * PTT HW bug w/a: wake up the device to access @@ -520,7 +522,7
> > 
> > @@
> > > static int crb_map_io(struct acpi_device *device, struct crb_priv
> > > *priv,
> > >  	 */
> > >  	ret = crb_cmd_ready(dev, priv);
> > >  	if (ret)
> > > -		return ret;
> > > +		goto out_relinquish_locality;
> > > 
> > >  	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
> > >  	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
> > > @@ -565,6 +567,8 @@ static int crb_map_io(struct acpi_device *device,
> > > struct crb_priv *priv,
> > > 
> > >  	crb_go_idle(dev, priv);
> > > 
> > > +out_relinquish_locality:
> > > +
> > >  	__crb_relinquish_locality(dev, priv, 0);
> > > 
> > >  	return ret;
> > 
> > Thanks, please just call it before returning in the error path.
> 
> Can you please elaborate why, isn't the centralized exiting of functions
> preferred kernel coding style? 
> https://www.kernel.org/doc/html/v4.11/process/coding-style.html#centralized-ex
> iting-of-functions 

You exit only from one location (not multiple) and not from a
nested context. Here you just add more complexity by doing
this.

/Jarkko
