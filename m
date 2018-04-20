Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754989AbeDTNTW (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:19:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:60647 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754966AbeDTNTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:19:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,301,1520924400";
   d="scan'208";a="52318329"
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: "'Jarkko Sakkinen'" <jarkko.sakkinen@linux.intel.com>,
        "'Jason Gunthorpe'" <jgg@ziepe.ca>
CC: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "'linux-integrity@vger.kernel.org'" <linux-integrity@vger.kernel.org>,
        "'linux-security-module@vger.kernel.org'"
        <linux-security-module@vger.kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Thread-Topic: [PATCH] tpm: tpm_crb: relinquish locality on error path.
Thread-Index: AQHTzovCXbr+Xqq9jkSj9yBS1IttZ6P4GCYAgAGeicCAAAoXAIAAs/uQgA9COvA=
Date: Fri, 20 Apr 2018 13:19:12 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B942627FD@hasmsx108.ger.corp.intel.com>
References: <20180407161236.22969-1-tomas.winkler@intel.com>
         <c06b86c0b58888f750e6e00c33be33ab54d39257.camel@linux.intel.com>
         <5B8DA87D05A7694D9FA63FD143655C1B94252660@hasmsx108.ger.corp.intel.com>
 <4984305eae452b7a72b8a13aa20cecec420df580.camel@linux.intel.com>
 <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94252945@hasmsx108.ger.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTYxMDJlNTAtYTI3OS00ZjI5LThlYjEtOTE0MzRkOGQ1ZWVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiI2aGZGMWEwOVl4UXpuZlN5N0JCRVRHRGh0d2FhZnpxVXJsRnpqU1M3cFBndkxpQ05UODJZVEVYS2c0TEk2ckhZIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.254.150.163]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KDJOHA024548

> > On Tue, 2018-04-10 at 09:00 +0000, Winkler, Tomas wrote:
> > > >
> > > > On Sat, 2018-04-07 at 19:12 +0300, Tomas Winkler wrote:
> > > > > In crb_map_io() function, __crb_request_locality() is called
> > > > > prior to crb_cmd_ready(), but if one of the consecutive function
> > > > > fails the flow bails out instead of trying to relinquish locality.
> > > > > This patch adds goto jump to __crb_relinquish_locality() on the
> > > > > error path.
> > > > >
> > > > > Fixes: 888d867df441 (tpm: cmd_ready command can be issued only
> > > > > after granting
> > > > > locality)
> > > > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > > > > ---
> > > > >  drivers/char/tpm/tpm_crb.c | 10 +++++++---
> > > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/drivers/char/tpm/tpm_crb.c
> > > > > b/drivers/char/tpm/tpm_crb.c index 7f78482cd157..34fbc6cb097b
> > > > > 100644
> > > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > > @@ -511,8 +511,10 @@ static int crb_map_io(struct acpi_device
> > > > > *device, struct crb_priv *priv,
> > > > >
> > > > >  	priv->regs_t = crb_map_res(dev, priv, &io_res, buf-
> > > > > >control_address,
> > > > >  				   sizeof(struct crb_regs_tail));
> > > > > -	if (IS_ERR(priv->regs_t))
> > > > > -		return PTR_ERR(priv->regs_t);
> > > > > +	if (IS_ERR(priv->regs_t)) {
> > > > > +		ret = PTR_ERR(priv->regs_t);
> > > > > +		goto out_relinquish_locality;
> > > > > +	}
> > > > >
> > > > >  	/*
> > > > >  	 * PTT HW bug w/a: wake up the device to access @@ -520,7
> > > > > +522,7
> > > >
> > > > @@
> > > > > static int crb_map_io(struct acpi_device *device, struct
> > > > > crb_priv *priv,
> > > > >  	 */
> > > > >  	ret = crb_cmd_ready(dev, priv);
> > > > >  	if (ret)
> > > > > -		return ret;
> > > > > +		goto out_relinquish_locality;
> > > > >
> > > > >  	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
> > > > >  	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
> > > > > @@ -565,6 +567,8 @@ static int crb_map_io(struct acpi_device
> > > > > *device, struct crb_priv *priv,
> > > > >
> > > > >  	crb_go_idle(dev, priv);
> > > > >
> > > > > +out_relinquish_locality:
> > > > > +
> > > > >  	__crb_relinquish_locality(dev, priv, 0);
> > > > >
> > > > >  	return ret;
> > > >
> > > > Thanks, please just call it before returning in the error path.
> > >
> > > Can you please elaborate why, isn't the centralized exiting of
> > > functions preferred kernel coding style?
> > > https://www.kernel.org/doc/html/v4.11/process/coding-style.html#cent
> > > ra
> > > lized-ex
> > > iting-of-functions
> >
> > You exit only from one location (not multiple) and not from a nested
> > context. Here you just add more complexity by doing this.
> 
> Where is the complexity ? I see it as a standard way of undoing on exit.
> Tomas

Jarkko, can you please respond.
Thanks
Tomas
