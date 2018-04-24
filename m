Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeDXUEJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:04:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:3051 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750756AbeDXUEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:04:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,324,1520924400";
   d="scan'208";a="45747675"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: "'Jason Gunthorpe'" <jgg@ziepe.ca>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Thread-Topic: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Thread-Index: AQHTzovCXbr+Xqq9jkSj9yBS1IttZ6P4GCYAgAGeicCAAAoXAIAAs/uQgA9COvCABkUzAIAANFFg
Date: Tue, 24 Apr 2018 20:04:01 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B94272F33@hasmsx108.ger.corp.intel.com>
References: <20180407161236.22969-1-tomas.winkler@intel.com>
 <c06b86c0b58888f750e6e00c33be33ab54d39257.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94252660@hasmsx108.ger.corp.intel.com>
 <4984305eae452b7a72b8a13aa20cecec420df580.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B942627FD@hasmsx108.ger.corp.intel.com>
 <20180424160328.GA5119@linux.intel.com>
In-Reply-To: <20180424160328.GA5119@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGViMzVlZDMtM2Q1Zi00NmE4LTlmOTQtYjQ5YzU1MTJmN2MyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJzdlRFdkkzZVUyXC90OGRmR2ZnT3ZzeHh1UGJFdGxiK051UXZNdHJHXC9tem5ibTFuTndNWUxlcEd4M3k5aFNJZEYifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.254.154.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] tpm: tpm_crb: relinquish locality on error path.
> 
> On Fri, Apr 20, 2018 at 01:19:12PM +0000, Winkler, Tomas wrote:
> > > > On Tue, 2018-04-10 at 09:00 +0000, Winkler, Tomas wrote:
> > > > > >
> > > > > > On Sat, 2018-04-07 at 19:12 +0300, Tomas Winkler wrote:
> > > > > > > In crb_map_io() function, __crb_request_locality() is called
> > > > > > > prior to crb_cmd_ready(), but if one of the consecutive
> > > > > > > function fails the flow bails out instead of trying to relinquish
> locality.
> > > > > > > This patch adds goto jump to __crb_relinquish_locality() on
> > > > > > > the error path.
> > > > > > >
> > > > > > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued
> > > > > > > only after granting
> > > > > > > locality)
> > > > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > > > ---
> > > > > > >  drivers/char/tpm/tpm_crb.c | 10 +++++++---
> > > > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/char/tpm/tpm_crb.c
> > > > > > > b/drivers/char/tpm/tpm_crb.c index
> > > > > > > 7f78482cd157..34fbc6cb097b
> > > > > > > 100644
> > > > > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > > > > @@ -511,8 +511,10 @@ static int crb_map_io(struct
> > > > > > > acpi_device *device, struct crb_priv *priv,
> > > > > > >
> > > > > > >  	priv->regs_t = crb_map_res(dev, priv, &io_res, buf-
> > > > > > > >control_address,
> > > > > > >  				   sizeof(struct crb_regs_tail));
> > > > > > > -	if (IS_ERR(priv->regs_t))
> > > > > > > -		return PTR_ERR(priv->regs_t);
> > > > > > > +	if (IS_ERR(priv->regs_t)) {
> > > > > > > +		ret = PTR_ERR(priv->regs_t);
> > > > > > > +		goto out_relinquish_locality;
> > > > > > > +	}
> > > > > > >
> > > > > > >  	/*
> > > > > > >  	 * PTT HW bug w/a: wake up the device to access @@ -520,7
> > > > > > > +522,7
> > > > > >
> > > > > > @@
> > > > > > > static int crb_map_io(struct acpi_device *device, struct
> > > > > > > crb_priv *priv,
> > > > > > >  	 */
> > > > > > >  	ret = crb_cmd_ready(dev, priv);
> > > > > > >  	if (ret)
> > > > > > > -		return ret;
> > > > > > > +		goto out_relinquish_locality;
> > > > > > >
> > > > > > >  	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
> > > > > > >  	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
> > > > > > > @@ -565,6 +567,8 @@ static int crb_map_io(struct acpi_device
> > > > > > > *device, struct crb_priv *priv,
> > > > > > >
> > > > > > >  	crb_go_idle(dev, priv);
> > > > > > >
> > > > > > > +out_relinquish_locality:
> > > > > > > +
> > > > > > >  	__crb_relinquish_locality(dev, priv, 0);
> > > > > > >
> > > > > > >  	return ret;
> > > > > >
> > > > > > Thanks, please just call it before returning in the error path.
> > > > >
> > > > > Can you please elaborate why, isn't the centralized exiting of
> > > > > functions preferred kernel coding style?
> > > > > https://www.kernel.org/doc/html/v4.11/process/coding-style.html#
> > > > > cent
> > > > > ra
> > > > > lized-ex
> > > > > iting-of-functions
> > > >
> > > > You exit only from one location (not multiple) and not from a
> > > > nested context. Here you just add more complexity by doing this.
> > >
> > > Where is the complexity ? I see it as a standard way of undoing on exit.
> > > Tomas
> >
> > Jarkko, can you please respond.
> > Thanks
> > Tomas
> 
> I was away for Mon-Wed last week and did not work on TPM for Thu-Fri.
> 
> My earlier comment was incorrect as there are two locations to exit (not
> sure how I managed to overlook the patch that way).
> 
> Thus, I have only two very  minor requets:
> 
> * Remove the extra newline (the last line addition in the patch).
Okay
> * Use just label named out as we have only one exception handler.
Cannot do that, as the bail out is prior to cmd_ready request so there is no need for go_idle which is under out label.
> 
> I'll move on to testing, and if it it passes, I can do those updates myself.
Thanks,  I prefer to resend myself. 

Tomas
